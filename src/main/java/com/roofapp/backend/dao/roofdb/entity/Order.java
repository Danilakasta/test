package com.roofapp.backend.dao.roofdb.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.roofapp.backend.dao.roofdb.Discount;
import com.roofapp.backend.dao.roofdb.OrderState;
import com.roofapp.backend.dao.roofdb.OrderType;
import lombok.EqualsAndHashCode;
import org.hibernate.annotations.BatchSize;

import javax.persistence.*;
import javax.validation.Valid;
import javax.validation.constraints.NotEmpty;
import java.awt.*;
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
@EqualsAndHashCode
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
    @OneToOne(cascade = CascadeType.MERGE,fetch= FetchType.EAGER)
    private Contractor customer;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, orphanRemoval = true)
   // @OrderColumn
    @JoinColumn(name="order_id")
    @BatchSize(size = 1000)
    @NotEmpty
    @Valid
    @JsonManagedReference
    private List<OrderItem> items;

    //@NotNull(message = "{bakery.status.required}")
    private OrderState state;

    @Column(name = "discount")
    private Discount discount = Discount.NULL_PERCENT;


    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "id")
    @OrderColumn
    private List<HistoryItem> history;


    @Column(name = "order_type")
    private OrderType orderType = OrderType.CONTRACTOR_ORDER;


    @Column(name = "parent_id")
    private Long parentId;

    public Order(User createdBy) {
        this.state = OrderState.NEW;
      //  setCustomer(new Contractor());
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
    public Contractor getCustomer() {
        return customer;
    }

    public void setCustomer(Contractor customer) {
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

    @Override
    public OrderType getOrderType() {
        return orderType;
    }


    public void setOrderType(OrderType orderType) {
        this.orderType = orderType;
    }


    public void setState(OrderState state) {
        this.state = state;
    }

    @Override
    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }


    public Discount getDiscount() {
        return discount;
    }

    public void setDiscount(Discount discount) {
        this.discount = discount;
    }

}
