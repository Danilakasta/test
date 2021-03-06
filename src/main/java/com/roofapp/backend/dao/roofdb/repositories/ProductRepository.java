package com.roofapp.backend.dao.roofdb.repositories;

import com.roofapp.backend.dao.roofdb.ProductType;
import com.roofapp.backend.dao.roofdb.entity.Product;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Long> {

    Page<Product> findBy(Pageable page);

    Page<Product> findByNameLikeIgnoreCase(String name, Pageable page);

    int countByNameLikeIgnoreCase(String name);

    List<Product> findByTypeIn(List<ProductType> productTypes);


    List<Product> findAllByOrderByName();

    Product findByName(String name);

    @Query("select e from Product e order by e.type,e.name")
    @Cacheable("products")
    List<Product> findAllByOrderByTypeAndName();


}
