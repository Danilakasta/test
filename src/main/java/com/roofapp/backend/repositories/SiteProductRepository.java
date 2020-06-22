package com.roofapp.backend.repositories;

import com.roofapp.backend.data.entity.Product;
import com.roofapp.backend.data.entity.parser.SiteProduct;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;


public interface SiteProductRepository extends JpaRepository<SiteProduct, Long> {

    Page<SiteProduct> findBy(Pageable page);

    Page<SiteProduct> findByTitleLikeIgnoreCase(String name, Pageable page);

    int countByTitleLikeIgnoreCase(String name);
}
