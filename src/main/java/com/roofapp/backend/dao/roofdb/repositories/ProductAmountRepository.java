package com.roofapp.backend.dao.roofdb.repositories;

import com.roofapp.backend.dao.roofdb.MaterialClass;
import com.roofapp.backend.dao.roofdb.MaterialCover;
import com.roofapp.backend.dao.roofdb.entity.ProductAmount;
import com.roofapp.backend.dao.roofdb.entity.guides.Width;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductAmountRepository extends JpaRepository<ProductAmount, Long> {

    Page<ProductAmount> findBy(Pageable page);

    ProductAmount findByWidthAndMaterialClassAndMaterialCover(Width width, MaterialClass materialClass, MaterialCover materialCover);
}
