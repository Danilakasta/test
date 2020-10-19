package com.roofapp.backend.task;


import com.roofapp.backend.dao.roofdb.entity.Order;
import com.roofapp.backend.service.OrderService;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@Log
public class CreateSubOrderTask {

    private final OrderService orderService;


    @Autowired
    public CreateSubOrderTask(OrderService orderService) {

        this.orderService = orderService;
    }


    @ConditionalOnProperty(value = "scheduling.enabled")
   // @Scheduled(fixedDelay = 6000)
    public void craate() {
        orderService.findAll().forEach(orderService::createNewManufactureOrder);
    }


}
