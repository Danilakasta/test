package com.roofapp.backend.dao.roofdb.repositories;


import com.roofapp.backend.dao.roofdb.ProductType;
import com.roofapp.backend.dao.roofdb.entity.OrderItem;
import com.roofapp.backend.dao.roofdb.entity.Product;
import com.roofapp.backend.dao.roofdb.entity.WarehouseItem;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface WarehouseItemsRepository extends JpaRepository<WarehouseItem, Long> {
    Page<WarehouseItem> findBy(Pageable page);

   WarehouseItem findByOrderItem(OrderItem orderItem);


    // Page<WarehouseItem> findByNameLikeIgnoreCase(String name, Pageable page);

   // int countByNameLikeIgnoreCase(String name);

 //   List<WarehouseItem> findByTypeIn(List<ProductType> productTypes);

}
