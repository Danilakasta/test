package com.roofapp.backend.dao.roofdb.entity;

import com.roofapp.backend.dao.roofdb.OrderState;
import org.hibernate.annotations.BatchSize;

import javax.persistence.*;
import javax.validation.Valid;
import javax.validation.constraints.NotEmpty;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

@Entity(name = "order_info") // "Order" is a reserved word
@NamedEntityGraphs({@NamedEntityGraph(name = Order.ENTITY_GRAPTH_BRIEF, attributeNodes = {
        @NamedAttributeNode("customer"),
        @NamedAttributeNode("pickupLocation")
}), @NamedEntityGraph(name = Order.ENTITY_GRAPTH_FULL, attributeNodes = {
        @NamedAttributeNode("customer"),
        @NamedAttributeNode("pickupLocation"),
        @NamedAttributeNode("items"),
        @NamedAttributeNode("history")
})})
@Table(indexes = @Index(columnList = "due_date"))
public class Order extends AbstractEntity implements OrderSummary {

    @Column(name = "wp_order_id")
    public Long wpOrderId;

    public Long getWpOrderId() {
        return wpOrderId;
    }

    public void setWpOrderId(Long wpOrderId) {
        this.wpOrderId = wpOrderId;
    }

    public static final String ENTITY_GRAPTH_BRIEF = "Order.brief";
    public static final String ENTITY_GRAPTH_FULL = "Order.full";

    //@NotNull(message = "{bakery.due.date.required}")
    @Column(name = "due_date")
    private LocalDate dueDate;

    //	@NotNull(message = "{bakery.due.time.required}")
    @Column(name = "due_time")
    private LocalTime dueTime;

    //	@NotNull(message = "{bakery.pickup.location.required}")
    @ManyToOne
    @JoinColumn(name="pickup_location_id",referencedColumnName = "id")
    private PickupLocation pickupLocation;

    //@NotNull
    @OneToOne(cascade = CascadeType.ALL)
    private Customer customer;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, orphanRemoval = true)
    @OrderColumn
    @JoinColumn
    @BatchSize(size = 1000)
    @NotEmpty
    @Valid
    private List<OrderItem> items;
    //@NotNull(message = "{bakery.status.required}")
    private OrderState state;


    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "id")
    @OrderColumn
    private List<HistoryItem> history;

    public Order(User createdBy) {
        this.state = OrderState.NEW;
        setCustomer(new Customer());
        addHistoryItem(createdBy, "Order placed");
        this.items = new ArrayList<>();
    }

    Order() {
        // Empty constructor is needed by Spring Data / JPA
    }

    public void addHistoryItem(User createdBy, String comment) {
        HistoryItem item = new HistoryItem(createdBy, comment);
        item.setNewState(state);
        if (history == null) {
            history = new LinkedList<>();
        }
        history.add(item);
    }

    @Override
    public LocalDate getDueDate() {
        return dueDate;
    }

    public void setDueDate(LocalDate dueDate) {
        this.dueDate = dueDate;
    }

    @Override
    public LocalTime getDueTime() {
        return dueTime;
    }

    public void setDueTime(LocalTime dueTime) {
        this.dueTime = dueTime;
    }

    @Override
    public PickupLocation getPickupLocation() {
        return pickupLocation;
    }

    public void setPickupLocation(PickupLocation pickupLocation) {
        this.pickupLocation = pickupLocation;
    }

    @Override
    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    @Override
    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }

    public List<HistoryItem> getHistory() {
        return history;
    }

    public void setHistory(List<HistoryItem> history) {
        this.history = history;
    }

    @Override
    public OrderState getState() {
        return state;
    }

    public void changeState(User user, OrderState state) {
        boolean createHistory = this.state != state && this.state != null && state != null;
        this.state = state;
        if (createHistory) {
            addHistoryItem(user, "Order " + state);
        }
    }

    @Override
    public String toString() {
        return "Order{" + "dueDate=" + dueDate + ", dueTime=" + dueTime + ", pickupLocation=" + pickupLocation
                + ", customer=" + customer + ", items=" + items + ", state=" + state + '}';
    }

    @Override
    public Double getTotalPrice() {
        return items.stream().map(i -> i.getTotalPrice()).reduce(Double.valueOf(0), Double::sum);
    }
}
