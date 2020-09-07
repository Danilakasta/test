package com.roofapp.backend.dao.roofdb.repositories;

import com.roofapp.backend.dao.roofdb.ProductType;
import com.roofapp.backend.dao.roofdb.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Long> {

    Page<Product> findBy(Pageable page);

    Page<Product> findByNameLikeIgnoreCase(String name, Pageable page);

    int countByNameLikeIgnoreCase(String name);

    @Query(value = "select row_number() over() as id,\n" +
            "concat(concat(concat('Заказ # ', oi.items_id),' '),p.name) as name,\n" +
            "p.*" +
            "from order_item oi \n" +
            "right join product p on oi.product_id  = p.id \n" +
            "order by material_color, width desc", nativeQuery = true)
    List<Product> findOrdersOrder();

    List<Product> findByTypeIn(List<ProductType> productTypes);
}
