package com.roofapp.backend.task;

import com.roofapp.backend.dao.roofdb.entity.Material;
import com.roofapp.backend.dao.roofdb.entity.ProductAmount;
import com.roofapp.backend.service.MaterialService;
import com.roofapp.backend.service.ProductAmountService;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;

@Component
@Log
public class RecalculateSelfPriceFromMaterialTask {

    private final ProductAmountService productAmountService;
    private final MaterialService materialService;


    @Autowired
    public RecalculateSelfPriceFromMaterialTask(ProductAmountService productAmountService, MaterialService materialService) {

        this.productAmountService = productAmountService;
        this.materialService = materialService;
    }


    @ConditionalOnProperty(value = "scheduling.enabled")
  //  @Scheduled(fixedDelay = 6000)
    public void calculate() {
     //   List<Material> materials = materialService.findAllByCreatedAfter(new Date(System.currentTimeMillis() - 60000 * 10*10000));

        List<Material> materials = materialService.findAll();

        materials.forEach(material -> {
            Double selfPrice = productAmountService.calculateSelfPrice(material.getWidth(), material.getCover(), material.getMaterialClass());
            if(selfPrice !=0D) {
                ProductAmount productAmount = productAmountService.findProductAmount(material.getWidth(), material.getCover(), material.getMaterialClass());
                if(productAmount!= null) {
                    productAmount.setSelfPrice(selfPrice.doubleValue());
                }else {
                    productAmount  = new ProductAmount();
                    productAmount.setWidth(material.getWidth());
                    productAmount.setMaterialCover(material.getCover());
                    productAmount.setMaterialClass(material.getMaterialClass());
                    productAmount.setPrice(20D);
                    productAmount.setSelfPrice(selfPrice);

                }
                productAmountService.save(productAmount);

            }
        });
    }


}
