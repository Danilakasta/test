package com.roofapp.backend.dao.roofdb.repositories;

import com.roofapp.backend.dao.roofdb.OrderState;
import com.roofapp.backend.dao.roofdb.OrderType;
import com.roofapp.backend.dao.roofdb.entity.Order;
import com.roofapp.backend.dao.roofdb.entity.OrderItem;
import com.roofapp.backend.dao.roofdb.entity.OrderSummary;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.EntityGraph.EntityGraphType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.Collection;
import java.util.List;
import java.util.Optional;

public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {


    Page<OrderItem> findBy(Pageable page);


    @Query("select e from order_item e " +
            "left join order_info oi on oi.id  = e.orderId  "+
            " where e.orderType = :orderType and oi.state = 3 and oi.orderType = :orderType order by e.materialColor, e.height, e.materialClass, e.materialCover ")
    List<OrderItem> findByByPriority(
            @Param("orderType")
                    OrderType orderType);



}
