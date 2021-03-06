package com.roofapp.backend.service;

import com.roofapp.backend.dao.roofdb.ProductType;
import com.roofapp.backend.dao.roofdb.entity.Product;
import com.roofapp.backend.dao.roofdb.entity.User;
import com.roofapp.backend.dao.roofdb.repositories.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import java.util.List;
import java.util.Optional;


@Service
public class ProductService implements FilterableCrudService<Product>  {


    private final ProductRepository productRepository;

    @Autowired
    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public void save(Product product) {
        productRepository.save(product);
    }


    public List<Product> findAll() {
        return productRepository.findAll();
    }

    public List<Product> findByType(List<ProductType> productType) {
        return productRepository.findByTypeIn(productType);
    }




    public Product findById(Long id) {
        try {
            return productRepository.findById(id).get();
        }catch (Exception e){
            return null;
        }
    }

    public void delete(Product product) {
       productRepository.delete(product);
    }


    @Override
    public Page<Product> findAnyMatching(Optional<String> filter, Pageable pageable) {
        if (filter.isPresent()) {
            String repositoryFilter = "%" + filter.get() + "%";
            return productRepository.findByNameLikeIgnoreCase(repositoryFilter, pageable);
        } else {
            return find(pageable);
        }
    }

    @Override
    public long countAnyMatching(Optional<String> filter) {
        if (filter.isPresent()) {
            String repositoryFilter = "%" + filter.get() + "%";
            return productRepository.countByNameLikeIgnoreCase(repositoryFilter);
        } else {
            return count();
        }
    }



    public Page<Product> find(Pageable pageable) {
        return productRepository.findBy(pageable);
    }

    @Override
    public JpaRepository<Product, Long> getRepository() {
        return productRepository;
    }

    @Override
    public Product createNew(User currentUser) {
        return new Product();
    }

    @Override
    public Product save(User currentUser, Product entity) {
        try {
            return FilterableCrudService.super.save(currentUser, entity);
        } catch (DataIntegrityViolationException e) {
            throw new UserFriendlyDataException(
                    "There is already a product with that name. Please select a unique name for the product.");
        }

    }


    public List<Product> findAllOrderTypeAndName() {
        return productRepository.findAllByOrderByTypeAndName();
    }

    public Product findByName(String name) {
        return productRepository.findByName( name);
    }

    /**
     * Расчет размера из строки 100+100+100
     * @param size
     * @return
     */
    public Double calculateAdditionalWidth(String size) {
        ScriptEngine engine = new ScriptEngineManager().getEngineByName("JavaScript");
        if (size != null ) {
            try {
                return Double.valueOf(engine.eval(size).toString());
            } catch (Exception e) {
                //  log.warning("Calculator mScriptEngine error: " + e.getMessage());
            }
        }
        return 0D;
    }
}
