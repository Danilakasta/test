package com.roofapp.backend.task;


import com.roofapp.backend.dao.roofZavod.entity.WpOrder;
import com.roofapp.backend.dao.roofZavod.entity.WpOrderItems;
import com.roofapp.backend.dao.roofZavod.entity.WpProduct;
import com.roofapp.backend.dao.roofZavod.repositories.WpOrdertItemsRepository;
import com.roofapp.backend.dao.roofZavod.repositories.WpOrdertRepository;
import com.roofapp.backend.dao.roofZavod.repositories.WpProductRepository;
import com.roofapp.backend.dao.roofdb.OrderState;
import com.roofapp.backend.dao.roofdb.entity.*;
import com.roofapp.backend.dao.roofdb.repositories.OrderRepository;
import com.roofapp.backend.dao.roofdb.repositories.PickupLocationRepository;
import com.roofapp.backend.dao.roofdb.repositories.ProductRepository;
import com.roofapp.backend.service.ProductService;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Component
@Log
public class WpLoadTask {

    private final WpProductRepository wpProductRepository;
    private final WpOrdertRepository wpOrdertRepository;
    private final WpOrdertItemsRepository wpOrdertItemsRepository;
    private final ProductService productService;
    private final PickupLocationRepository pickupLocationRepository;
    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;

    @Autowired
    public WpLoadTask(WpProductRepository wpProductRepository,
                      WpOrdertRepository wpOrdertRepository,
                      WpOrdertItemsRepository wpOrdertItemsRepository, ProductService productService,
                      PickupLocationRepository pickupLocationRepository, OrderRepository orderRepository, ProductRepository productRepository) {

        this.wpProductRepository = wpProductRepository;
        this.wpOrdertRepository = wpOrdertRepository;
        this.wpOrdertItemsRepository = wpOrdertItemsRepository;
        this.productService = productService;
        this.pickupLocationRepository = pickupLocationRepository;
        this.orderRepository = orderRepository;
        this.productRepository = productRepository;
    }


    @ConditionalOnProperty(value = "scheduling.enabled")
 //   @Scheduled(fixedDelay = 60000)
    public void syncProductFromWP() throws Exception {
        List<WpProduct> wpProducts = wpProductRepository.getAllProduct();
        wpProducts.forEach(items -> {
            try {
                //Сиквенс будет мешать нужно закоментировать чтобы id пролились как есть
                String pricestr = items.getPrice() != null ? items.getPrice() : "";
                Double price =  Double.valueOf(pricestr);
                Product product = new Product(items.getId(),
                        items.getName(),
                        price ,
                        items.getTitle(),
                        items.getSecondTitle(),
                        items.getCategory());
                productService.save(product);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        });
    }

    @ConditionalOnProperty(value = "scheduling.enabled")
   // @Scheduled(fixedDelay = 15000)
    public void syncOrdersFromWP() throws Exception {
        List<WpOrder> wpProducts = wpOrdertRepository.getAllOrders();

        Optional<PickupLocation> pickupLocation = pickupLocationRepository.findById(2L);
        wpProducts.forEach(wpOrder -> {
            try {
                Order order = orderRepository.findByWpOrderId(wpOrder.getId());
                if (order == null) {
                    order = new Order(null);
                }
             /*   Customer customer = new Customer();
                customer.setDetails(wpOrder.getDetails());
                customer.setFullName(wpOrder.getFullName());
                customer.setPhoneNumber(wpOrder.getPhoneNumbers());*/
                order.setWpOrderId(wpOrder.getId());
              //  order.setCustomer(customer);
                order.setDueDate(wpOrder.getDate().toLocalDateTime().toLocalDate());
                order.setDueTime(wpOrder.getDate().toLocalDateTime().toLocalTime());
                order.setPickupLocation(pickupLocation.get());

                OrderState orderState = null;

                switch (wpOrder.getStatus()) {
                    case "wc-pending"  /*'в ожидании оплаты'*/:
                        orderState = OrderState.NEW;
                        break;
                    case "wc-processing" /*'обработка'*/:
                        orderState = OrderState.CONFIRMED;
                        break;
                    case "wc-completed" /*'выполнен'*/:
                        orderState = OrderState.READY;
                        break;
                    case "wc-cancelled" /*'отменен'*/:
                        orderState = OrderState.CANCELLED;
                        break;
                    case "wc-failed" /*'Не удался'*/:
                        orderState = OrderState.PROBLEM;
                        break;
                }
                order.changeState(null, orderState);

                //add items
                List<WpOrderItems> wpOrderItems = wpOrdertItemsRepository.getAllOrderItems(wpOrder.getId());
                List<OrderItem> orderItems = new ArrayList<>();
                wpOrderItems.forEach(wpOrderItem -> {


                    Optional<Product> product = productRepository.findById(wpOrderItem.getProductId());
                    OrderItem orderItem = new OrderItem();
                    orderItem.setProduct(product.isPresent() ? product.get() : null);
                    orderItem.setQuantity(wpOrderItem.getQuantity().intValue());
                    orderItem.setPrice(wpOrderItem.getPrice());
                    orderItems.add(orderItem);
                });

                order.setItems(orderItems);
                orderRepository.save(order);
            }catch (Exception e){
                e.printStackTrace();
            }
        });

    }

}
