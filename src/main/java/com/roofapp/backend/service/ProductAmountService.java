package com.roofapp.backend.service;

import com.roofapp.backend.dao.roofdb.MaterialClass;
import com.roofapp.backend.dao.roofdb.MaterialCover;
import com.roofapp.backend.dao.roofdb.Width;
import com.roofapp.backend.dao.roofdb.entity.Material;
import com.roofapp.backend.dao.roofdb.entity.ProductAmount;
import com.roofapp.backend.dao.roofdb.entity.User;
import com.roofapp.backend.dao.roofdb.repositories.ProductAmountRepository;
import com.roofapp.backend.utils.Helper;
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


    private final ProductAmountRepository productAmountRepository;
    private final MaterialService materialService;

    @Autowired
    public ProductAmountService(ProductAmountRepository productRepository, MaterialService materialService) {
        this.productAmountRepository = productRepository;
        this.materialService = materialService;
    }

    public void save(ProductAmount product) {
        productAmountRepository.save(product);
    }


    public List<ProductAmount> findAll() {
        return productAmountRepository.findAll();
    }

    public ProductAmount findProductAmount(Width width, MaterialCover materialCover, MaterialClass materialClass) {
        ProductAmount productAmount = productAmountRepository.findByWidthAndMaterialClassAndMaterialCover(width, materialClass, materialCover);

        return productAmount;
    }

    public Double findProductPrice(Width width, MaterialClass materialClass, MaterialCover materialCover) {

        ProductAmount productAmount = findProductAmount(width, materialCover, materialClass);
        if (productAmount != null)
            return (productAmount.getPrice() / 100 * productAmount.getSelfPrice()) + productAmount.getSelfPrice();
        return 0D;
    }

    public ProductAmount findById(Long id) {
        try {
            return productAmountRepository.findById(id).get();
        } catch (Exception e) {
            return null;
        }
    }

    public void delete(ProductAmount product) {
        productAmountRepository.delete(product);
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
        return productAmountRepository.findBy(pageable);
    }

    @Override
    public JpaRepository<ProductAmount, Long> getRepository() {
        return productAmountRepository;
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


    /**
     * Расчет себестоймости
     */
    public Double calculateSelfPrice(Width width, MaterialCover materialCover, MaterialClass materialClass) {
        Double selfPriceDouble = new Double(0D);
        if (width != null && materialCover != null && materialClass != null) {
            List<Material> materials = materialService.findByWidthEqualsAndCoverEqualsAndMaterialClassEquals(width, materialCover, materialClass);
            Double allPrice = materials.stream().mapToDouble(f -> f.getPriceOneTone() * f.getWeightOfBay()).sum();
            Double allLength = materials.stream().mapToDouble(f -> f.getLength()).sum();
            selfPriceDouble = allPrice / allLength;
        }
        return Helper.aroundDouble(selfPriceDouble);
    }


}
