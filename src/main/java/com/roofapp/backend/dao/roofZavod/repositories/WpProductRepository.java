package com.roofapp.backend.dao.roofZavod.repositories;

import com.roofapp.backend.dao.roofZavod.entity.WpProduct;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;


public interface WpProductRepository extends JpaRepository<WpProduct, Long> {

    @Query(value = "select wp.ID, \n" +
            "wp.post_title as name, \n" +
            "wp.post_content as title, \n" +
            "wp.post_excerpt as second_title, \n" +
            " (SELECT meta_value FROM wp_postmeta WHERE post_id = wp.ID and meta_key = '_price' limit 1) as price,\n" +
            " (SELECT name FROM wp_term_relationships wtr \n" +
            "    left join  wp_term_taxonomy wtt on  wtt.term_id = wtr.term_taxonomy_id \n" +
            "    left join wp_terms wt on wt.term_id =  wtt.term_taxonomy_id \n" +
            "  where object_id =wp.ID  and taxonomy like 'product_cat' limit 1) as category\n" +
            "from wp_posts wp \n" +
            "where wp.post_type like 'product' \n" +
            " or  wp.post_type like 'product_variation' \n" +
            " ", nativeQuery = true)
    List<WpProduct> getAllProduct();

}
