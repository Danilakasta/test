package com.roofapp.backend.dao.roofdb.repositories;

import com.roofapp.backend.dao.roofdb.entity.Manufacturers;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ManufacturerRepository extends JpaRepository<Manufacturers, Long> {

    Page<Manufacturers> findBy(Pageable page);

    Page<Manufacturers> findByNameLikeIgnoreCase(String name, Pageable page);

    int countByNameLikeIgnoreCase(String name);

    @Query(value = "select row_number() over() as id,\n" +
            "concat(concat(concat('Заказ # ', oi.items_id),' '),p.name) as name,\n" +
            "p.name ,\n" +
            "p.type ,\n" +
            "oi.*\n" +
            "from order_item oi \n" +
            "left join product p on oi.product_id  = p.id\n " +
            "where p.type in (0,1,2)\n" +
            "order by material_color, width desc",nativeQuery = true)
    List<Manufacturers> findOrdersOrder();

}
