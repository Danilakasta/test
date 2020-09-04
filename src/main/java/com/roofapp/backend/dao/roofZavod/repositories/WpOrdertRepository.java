package com.roofapp.backend.dao.roofZavod.repositories;

import com.roofapp.backend.dao.roofZavod.entity.WpOrder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;


public interface WpOrdertRepository extends JpaRepository<WpOrder, Long> {

    @Query(value = "select \n" +
            "\tp.id,\n" +
            "\tp.post_author as author,\n" +
            "\tp.post_date as date,\n" +
            "\tp.post_status as status,\n" +
            "\t(select meta_value from  wp_postmeta pm where pm.post_id = p.ID and pm.meta_key  = '_billing_address_index') as details,\n" +
            "\tconcat(concat((select meta_value from  wp_postmeta pm where pm.post_id = p.ID and pm.meta_key  = '_billing_first_name') ,' '),\n" +
            "\t(select meta_value from  wp_postmeta pm where pm.post_id = p.ID and pm.meta_key  = '_billing_last_name') ) as full_name,\n" +
            "\t(select meta_value from  wp_postmeta pm where pm.post_id = p.ID and pm.meta_key  = '_billing_phone') as phone_numbers\n" +
            "from wp_posts p where post_type =\"shop_order\" and post_date > CURDATE() - INTERVAL 1 DAY", nativeQuery = true)
    List<WpOrder> getAllOrders();
}
