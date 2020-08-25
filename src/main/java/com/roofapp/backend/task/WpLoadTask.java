package com.roofapp.backend.task;


import com.roofapp.backend.dao.roofZavod.entity.WpProduct;
import com.roofapp.backend.dao.roofZavod.repositories.WpProductRepository;
import com.roofapp.backend.dao.roofdb.entity.Product;
import com.roofapp.backend.service.ProductService;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@Log
public class WpLoadTask {

    private final WpProductRepository wpProductRepository;
    private final ProductService productService;

    @Autowired
    public WpLoadTask(WpProductRepository wpProductRepository, ProductService productService) {

        this.wpProductRepository = wpProductRepository;
        this.productService = productService;
    }


    @ConditionalOnProperty(value = "scheduling.enabled")
 //   @Scheduled(fixedDelay = 60000)
    public void parseSite() throws Exception {
        List<WpProduct> wpProducts = wpProductRepository.getAllProduct();
        wpProducts.forEach(items->{
            try {
                Product product= Product.builder()
                         .name(items.getName())
                         .price(Double.valueOf(items.getPrice()))
                         .title(items.getTitle())
                         .secondTitle(items.getSecondTitle())
                         .category(items.getCategory()).build();
                productService.save(product);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        });
    }


}
