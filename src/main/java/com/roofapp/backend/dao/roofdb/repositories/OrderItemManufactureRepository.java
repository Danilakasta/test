package com.roofapp.backend.dao.roofdb.repositories;

import com.roofapp.backend.dao.roofdb.OrderType;
import com.roofapp.backend.dao.roofdb.entity.OrderItemManufacture;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface OrderItemManufactureRepository extends JpaRepository<OrderItemManufacture, Long> {


    Page<OrderItemManufacture> findBy(Pageable page);


 /*   @Query("select e from order_item e " +
            "left join order_info oi on oi.id  = e.orderId  "+
            " where e.orderType = :orderType and oi.state = 3 and oi.orderType = :orderType order by e.materialColor, e.height, e.materialClass, e.materialCover ")
    List<OrderItemManufacture> findByByPriority(@Param("orderType") OrderType orderType);
*/

    @Query(value = "select e.* from order_item e " +
            "left join order_info oi on oi.id  = e.order_Id  "+
            " where e.order_Type = :orderType and oi.state = 3 and oi.order_Type = :orderType order by e.material_Color, e.height, e.material_Class, e.material_Cover ",nativeQuery = true
    )
    List<OrderItemManufacture> findByByPriority(@Param("orderType") Integer orderType);

}
