package com.roofapp.backend.service;

//import com.roofapp.backend.data.DashboardData;
//import com.roofapp.backend.data.DeliveryStats;

import com.roofapp.backend.dao.roofdb.*;
import com.roofapp.backend.dao.roofdb.entity.*;
import com.roofapp.backend.dao.roofdb.repositories.OrderRepository;
import com.roofapp.backend.utils.Helper;
import org.apache.commons.lang3.SerializationUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

//import javax.transaction.Transactional;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.YearMonth;
import java.util.*;
import java.util.function.BiConsumer;

@Service
public class OrderService implements CrudService<Order> {

    private final OrderRepository orderRepository;
    private final PickupLocationService pickupLocationService;
    private final ProductService productService;

    @Autowired
    public OrderService(OrderRepository orderRepository, PickupLocationService pickupLocationService, ProductService productService) {
        super();
        this.orderRepository = orderRepository;
        this.pickupLocationService = pickupLocationService;
		this.productService = productService;
	}

    private static final Set<OrderState> notAvailableStates = Collections.unmodifiableSet(
            EnumSet.complementOf(EnumSet.of(OrderState.DELIVERED, OrderState.READY, OrderState.CANCELLED)));

    //	@Transactional(rollbackOn = Exception.class)
    public Order saveOrder(User currentUser, Long id, BiConsumer<User, Order> orderFiller) {
        Order order;
        if (id == null) {
            order = new Order(currentUser);
        } else {
            order = load(id);
        }
        orderFiller.accept(currentUser, order);
        return orderRepository.save(order);
    }

    //@Transactional(rollbackOn = Exception.class)
    public Order saveOrder(Order order) {
        return orderRepository.save(order);
    }

    //	@Transactional(rollbackOn = Exception.class)
    public Order addComment(User currentUser, Order order, String comment) {
        order.addHistoryItem(currentUser, comment);
        return orderRepository.save(order);
    }

    @Transactional
    public Page<Order> findAnyMatchingAfterDueDate(Optional<String> optionalFilter,
                                                   Optional<LocalDate> optionalFilterDate, Pageable pageable) {
        if (optionalFilter.isPresent() && !optionalFilter.get().isEmpty()) {
            if (optionalFilterDate.isPresent()) {
                return orderRepository.findByCustomerNameContainingIgnoreCaseAndDueDateAfterOrderByParentId(
                        optionalFilter.get(), optionalFilterDate.get(), pageable);
            } else {
                return orderRepository.findByCustomerNameContainingIgnoreCaseOrderByParentId(optionalFilter.get(), pageable);
            }
        } else {
            if (optionalFilterDate.isPresent()) {
                return orderRepository.findByDueDateAfterOrderByParentId(optionalFilterDate.get(), pageable);
            } else {
                return orderRepository.findAllByOrderByParentId(pageable);
            }
        }
    }

    //@Transactional
    public List<OrderSummary> findAnyMatchingStartingToday() {
        return orderRepository.findByDueDateGreaterThanEqual(LocalDate.now());
    }

    @Transactional
    public long countAnyMatchingAfterDueDate(Optional<String> optionalFilter, Optional<LocalDate> optionalFilterDate) {
        if (optionalFilter.isPresent() && optionalFilterDate.isPresent()) {
            return orderRepository.countByCustomerNameContainingIgnoreCaseAndDueDateAfter(optionalFilter.get(),
                    optionalFilterDate.get());
        } else if (optionalFilter.isPresent()) {
            return orderRepository.countByCustomerNameContainingIgnoreCase(optionalFilter.get());
        } else if (optionalFilterDate.isPresent()) {
            return orderRepository.countByDueDateAfter(optionalFilterDate.get());
        } else {
            return orderRepository.count();
        }
    }

	/*
	private DeliveryStats getDeliveryStats() {
		DeliveryStats stats = new DeliveryStats();
		LocalDate today = LocalDate.now();
		stats.setDueToday((int) orderRepository.countByDueDate(today));
		stats.setDueTomorrow((int) orderRepository.countByDueDate(today.plusDays(1)));
		stats.setDeliveredToday((int) orderRepository.countByDueDateAndStateIn(today,
				Collections.singleton(OrderState.DELIVERED)));

		stats.setNotAvailableToday((int) orderRepository.countByDueDateAndStateIn(today, notAvailableStates));
		stats.setNewOrders((int) orderRepository.countByState(OrderState.NEW));

		return stats;
	}

	public DashboardData getDashboardData(int month, int year) {
		DashboardData data = new DashboardData();
		data.setDeliveryStats(getDeliveryStats());
		data.setDeliveriesThisMonth(getDeliveriesPerDay(month, year));
		data.setDeliveriesThisYear(getDeliveriesPerMonth(year));

		Number[][] salesPerMonth = new Number[3][12];
		data.setSalesPerMonth(salesPerMonth);
		List<Object[]> sales = orderRepository.sumPerMonthLastThreeYears(OrderState.DELIVERED, year);

		for (Object[] salesData : sales) {
			// year, month, deliveries
			int y = year - (int) salesData[0];
			int m = (int) salesData[1] - 1;
			if (y == 0 && m == month - 1) {
				// skip current month as it contains incomplete data
				continue;
			}
			long count = (long) salesData[2];
			salesPerMonth[y][m] = count;
		}

		LinkedHashMap<Product, Integer> productDeliveries = new LinkedHashMap<>();
		data.setProductDeliveries(productDeliveries);
		for (Object[] result : orderRepository.countPerProduct(OrderState.DELIVERED, year, month)) {
			int sum = ((Long) result[0]).intValue();
			Product p = (Product) result[1];
			productDeliveries.put(p, sum);
		}

		return data;
	}*/

    private List<Number> getDeliveriesPerDay(int month, int year) {
        int daysInMonth = YearMonth.of(year, month).lengthOfMonth();
        return flattenAndReplaceMissingWithNull(daysInMonth,
                orderRepository.countPerDay(OrderState.DELIVERED, year, month));
    }

    private List<Number> getDeliveriesPerMonth(int year) {
        return flattenAndReplaceMissingWithNull(12, orderRepository.countPerMonth(OrderState.DELIVERED, year));
    }

    private List<Number> flattenAndReplaceMissingWithNull(int length, List<Object[]> list) {
        List<Number> counts = new ArrayList<>();
        for (int i = 0; i < length; i++) {
            counts.add(null);
        }

        for (Object[] result : list) {
            counts.set((Integer) result[0] - 1, (Number) result[1]);
        }
        return counts;
    }

    @Override
    public JpaRepository<Order, Long> getRepository() {
        return orderRepository;
    }

    @Override
//	@Transactional
    public Order createNew(User currentUser) {
        Order order = new Order(currentUser);
        order.setDueTime(LocalTime.of(16, 0));
        order.setDueDate(LocalDate.now());
        return order;
    }


    //@Transactional
    public void createNewManufactureOrder(Order order) {

        if (order.getState().equals(OrderState.NEW)) {
            Order manufactureOrder = new Order(null);
            manufactureOrder.setDueDate(order.getDueDate());
            manufactureOrder.setDueTime(order.getDueTime());
            manufactureOrder.setCustomer(order.getCustomer());
            manufactureOrder.setState(OrderState.MANUFACTURE);
            manufactureOrder.setParentId(order.getId());
            manufactureOrder.setPickupLocation(pickupLocationService.findById(3L).get());
            manufactureOrder.setOrderType(OrderType.MANUFACTURED);

            //создание позиций производства
            List<OrderItem> orderItems = new ArrayList<>();
            order.getItems().forEach(item -> {
                if (item.getProduct().getCargoType().equals(CargoType.MANUFACTURED)) {
                	//ПРофиль и черепица

					if (item.getProduct().getType().equals(ProductType.PROFILED)
                            || item.getProduct().getType().equals(ProductType.METAL_TILE)) {
						OrderItem  orderItem = SerializationUtils.clone(item);
						orderItem.setId(null);
                        orderItem.setOrderType(OrderType.MANUFACTURED);
                        orderItem.setState(ItemState.MANUFACTURE);
						orderItems.add(orderItem);
                    }else if (item.getProduct().getType().equals(ProductType.ADDITIONAL_ELEMENTS)){
						//Заказ на гибочный станок
						OrderItem orderItem2 = SerializationUtils.clone(item);
						orderItem2.setId(null);
						orderItem2.setOrderType(OrderType.MANUFACTURED);
						orderItem2.setState(ItemState.MANUFACTURE);
						orderItems.add(orderItem2);


						//Заказ на гладкий лист
						OrderItem  orderItem = SerializationUtils.clone(item);
						orderItem.setId(null);
						Product product = productService.findByName("Гладкий лист");
						orderItem.setProduct(product);

						//Расчет требуемого количества гладких листов

						Double size = productService.calculateAdditionalWidth(orderItem.getSize()) * orderItem.getQuantity();
						Double count =  size / (orderItem.getProduct().getWidth() * 1000);

						orderItem.setQuantity(Helper.aroundToTheWhole(count));


								orderItem.setOrderType(OrderType.MANUFACTURED);
						orderItem.setState(ItemState.MANUFACTURE);
						orderItems.add(orderItem);

					}


                }
            });
            manufactureOrder.setItems(orderItems);

            if (manufactureOrder.getItems().size() > 0) {
                order.setParentId(order.getId());
                order.setState(OrderState.TRANSFERED);
                orderRepository.save(order);
                orderRepository.save(manufactureOrder);
            }
        }

    }


    @Override
    @Transactional
    public List<Order> findAll() {
        return orderRepository.findAll();
    }

    public Optional<Order> findById(Long id) {
        return orderRepository.findById(id);
    }

}
