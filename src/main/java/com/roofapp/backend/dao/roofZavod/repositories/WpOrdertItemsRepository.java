package com.roofapp.backend.dao.roofZavod.repositories;

import com.roofapp.backend.dao.roofZavod.entity.WpOrder;
import com.roofapp.backend.dao.roofZavod.entity.WpOrderItems;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;


public interface WpOrdertItemsRepository extends JpaRepository<WpOrderItems, Long> {

    @Query(value = "\n" +
            "select oi.order_item_id as id,\n" +
            "(select oit.meta_value  from wp_woocommerce_order_itemmeta oit where  oit.order_item_id = oi.order_item_id and meta_key = '_product_id') as product_id,\n" +
            "(select oit.meta_value  from wp_woocommerce_order_itemmeta oit where  oit.order_item_id=oi.order_item_id and meta_key = '_qty') as quantity\n" +
            "from wp_woocommerce_order_items oi\n" +
            "where order_id = :orderId", nativeQuery = true)
    List<WpOrderItems> getAllOrderItems(Long orderId);
}
