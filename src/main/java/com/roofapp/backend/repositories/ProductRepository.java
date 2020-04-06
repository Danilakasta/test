package com.roofapp.backend.repositories;

import com.roofapp.backend.data.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<Product, Long> {
}
