package com.roofapp.backend.dao.roofdb.repositories;

import com.roofapp.backend.dao.roofdb.OrderState;
import com.roofapp.backend.dao.roofdb.entity.Order;
import com.roofapp.backend.dao.roofdb.entity.OrderSummary;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.EntityGraph.EntityGraphType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDate;
import java.util.Collection;
import java.util.List;
import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order, Long> {

	@EntityGraph(value = Order.ENTITY_GRAPTH_BRIEF, type = EntityGraphType.LOAD)
    Page<Order> findByDueDateAfterOrderByParentId(LocalDate filterDate, Pageable pageable);

	@EntityGraph(value = Order.ENTITY_GRAPTH_BRIEF, type = EntityGraphType.LOAD)
    Page<Order> findByCustomerNameContainingIgnoreCaseOrderByParentId(String searchQuery, Pageable pageable);

	@EntityGraph(value = Order.ENTITY_GRAPTH_BRIEF, type = EntityGraphType.LOAD)
    Page<Order> findByCustomerNameContainingIgnoreCaseAndDueDateAfterOrderByParentId(String searchQuery, LocalDate dueDate, Pageable pageable);

	@Override
	@EntityGraph(value = Order.ENTITY_GRAPTH_BRIEF, type = EntityGraphType.LOAD)
	List<Order> findAll();

	//@Override
	@EntityGraph(value = Order.ENTITY_GRAPTH_BRIEF, type = EntityGraphType.LOAD)
    Page<Order> findAllByOrderByParentId(Pageable pageable);

	@EntityGraph(value = Order.ENTITY_GRAPTH_BRIEF, type = EntityGraphType.LOAD)
	List<OrderSummary> findByDueDateGreaterThanEqual(LocalDate dueDate);

	@Override
	@EntityGraph(value = Order.ENTITY_GRAPTH_FULL, type = EntityGraphType.LOAD)
	Optional<Order> findById(Long id);

	long countByDueDateAfter(LocalDate dueDate);

	long countByCustomerNameContainingIgnoreCase(String searchQuery);

	long countByCustomerNameContainingIgnoreCaseAndDueDateAfter(String searchQuery, LocalDate dueDate);

	long countByDueDate(LocalDate dueDate);

	long countByDueDateAndStateIn(LocalDate dueDate, Collection<OrderState> state);

	long countByState(OrderState state);

	@Query("SELECT month(dueDate) as month, count(*) as deliveries FROM order_info o where o.state=?1 and year(dueDate)=?2 group by month(dueDate)")
	List<Object[]> countPerMonth(OrderState orderState, int year);

	@Query("SELECT year(o.dueDate) as y, month(o.dueDate) as m, sum(oi.quantity*p.price) as deliveries FROM order_info o JOIN o.items oi JOIN oi.product p where o.state=?1 and year(o.dueDate)<=?2 AND year(o.dueDate)>=(?2-3) group by year(o.dueDate), month(o.dueDate) order by y desc, month(o.dueDate)")
	List<Object[]> sumPerMonthLastThreeYears(OrderState orderState, int year);

	@Query("SELECT day(dueDate) as day, count(*) as deliveries FROM order_info o where o.state=?1 and year(dueDate)=?2 and month(dueDate)=?3 group by day(dueDate)")
	List<Object[]> countPerDay(OrderState orderState, int year, int month);

	@Query("SELECT sum(oi.quantity), p FROM order_info o JOIN o.items oi JOIN oi.product p WHERE o.state=?1 AND year(o.dueDate)=?2 AND month(o.dueDate)=?3 GROUP BY p.id ORDER BY p.id")
	List<Object[]> countPerProduct(OrderState orderState, int year, int month);

	Order findByWpOrderId(Long orderId);

}
