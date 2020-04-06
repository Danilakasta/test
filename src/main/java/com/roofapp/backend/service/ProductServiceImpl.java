package com.roofapp.backend.service;

import com.roofapp.backend.data.entity.Product;
import com.roofapp.backend.repositories.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class ProductServiceImpl implements ProductService {


    private final ProductRepository productRepository;

    @Autowired
    public ProductServiceImpl(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    @Override
    public void save(Product product) {
        productRepository.save(product);
    }

    @Override
    public List<Product> findAll() {
        return productRepository.findAll();
    }

    @Override
    public Product findById(Long id) {
        try {
            return productRepository.findById(id).get();
        }catch (Exception e){
            return null;
        }
    }

    @Override
    public void delete(Product product) {
       productRepository.delete(product);
    }
}
