package com.roofapp.backend.service;

import com.roofapp.backend.dao.roofdb.MaterialClass;
import com.roofapp.backend.dao.roofdb.MaterialCover;
import com.roofapp.backend.dao.roofdb.Width;
import com.roofapp.backend.dao.roofdb.entity.Product;
import com.roofapp.backend.dao.roofdb.entity.ProductAmount;
import com.roofapp.backend.dao.roofdb.entity.User;
import com.roofapp.backend.dao.roofdb.repositories.ProductAmountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;

import java.util.List;
import java.util.Optional;


@Service
public class ProductAmountService implements FilterableCrudService<ProductAmount> {


    private final ProductAmountRepository productRepository;

    @Autowired
    public ProductAmountService(ProductAmountRepository productRepository) {
        this.productRepository = productRepository;
    }

    public void save(ProductAmount product) {
        productRepository.save(product);
    }


    public List<ProductAmount> findAll() {
        return productRepository.findAll();
    }

    public ProductAmount findProductAmount(Product product, Width width, MaterialClass materialClass, MaterialCover materialCover) {
        ProductAmount productAmount = productRepository.findByProductAndWidthAndMaterialClassAndMaterialCover(product, width, materialClass, materialCover);

        return !ObjectUtils.isEmpty(productAmount) ? productAmount : ProductAmount.builder().price(0D).build();
    }


    public ProductAmount findById(Long id) {
        try {
            return productRepository.findById(id).get();
        } catch (Exception e) {
            return null;
        }
    }

    public void delete(ProductAmount product) {
        productRepository.delete(product);
    }


    @Override
    public Page<ProductAmount> findAnyMatching(Optional<String> filter, Pageable pageable) {
        if (filter.isPresent()) {
            String repositoryFilter = "%" + filter.get() + "%";
            //   return productRepository.findByNameLikeIgnoreCase(repositoryFilter, pageable);
        } else {
            return find(pageable);
        }
        return null;
    }

    @Override
    public long countAnyMatching(Optional<String> filter) {
        if (filter.isPresent()) {
            String repositoryFilter = "%" + filter.get() + "%";
            //    return productRepository.countByNameLikeIgnoreCase(repositoryFilter);
        } else {
            return count();
        }
        return 0L;
    }


    public Page<ProductAmount> find(Pageable pageable) {
        return productRepository.findBy(pageable);
    }

    @Override
    public JpaRepository<ProductAmount, Long> getRepository() {
        return productRepository;
    }

    @Override
    public ProductAmount createNew(User currentUser) {
        return ProductAmount.builder().build();
    }

    @Override
    public ProductAmount save(User currentUser, ProductAmount entity) {
        try {
            return FilterableCrudService.super.save(currentUser, entity);
        } catch (DataIntegrityViolationException e) {
            throw new UserFriendlyDataException(
                    "There is already a product with that name. Please select a unique name for the product.");
        }

    }

}
