package com.roofapp.backend.service;

import com.roofapp.backend.data.entity.Product;

import java.util.List;

public interface ProductService {
    void save(Product product);

    List<Product> findAll();

    Product findById(Long id);

    void delete(Product product);
}
