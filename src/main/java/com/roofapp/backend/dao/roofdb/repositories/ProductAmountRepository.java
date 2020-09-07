package com.roofapp.backend.dao.roofdb.repositories;

import com.roofapp.backend.dao.roofdb.MaterialClass;
import com.roofapp.backend.dao.roofdb.MaterialCover;
import com.roofapp.backend.dao.roofdb.Width;
import com.roofapp.backend.dao.roofdb.entity.Product;
import com.roofapp.backend.dao.roofdb.entity.ProductAmount;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ProductAmountRepository extends JpaRepository<ProductAmount, Long> {

    Page<ProductAmount> findBy(Pageable page);

  //  Page<ProductAmount> findByNameLikeIgnoreCase(String name, Pageable page);

 //   int countByNameLikeIgnoreCase(String name);


    ProductAmount findByProductAndWidthAndMaterialClassAndMaterialCover(Product product, Width width, MaterialClass materialClass, MaterialCover materialCover);
}
