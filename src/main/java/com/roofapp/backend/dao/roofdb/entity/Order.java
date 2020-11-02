package com.roofapp.backend.dao.roofdb.entity;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.roofapp.backend.dao.roofdb.Discount;
import com.roofapp.backend.dao.roofdb.OrderState;
import com.roofapp.backend.dao.roofdb.OrderType;
import lombok.ToString;
import org.hibernate.annotations.BatchSize;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import javax.validation.Valid;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;
import java.util.List;
//https://ru.stackoverflow.com/questions/993198/%D0%9F%D1%80%D0%B8%D0%BC%D0%B5%D1%80%D1%8B-%D0%B7%D0%B0%D0%BF%D0%B8%D1%81%D0%B8-%D0%B0%D0%BD%D0%BD%D0%BE%D1%82%D0%B0%D1%86%D0%B8%D0%B9-onetomany-onetoone-manytomany-manytoone-hibernate

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
//@EqualsAndHashCode
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

    @NotNull(message = "Дата не выбрана")
    @Column(name = "due_date")
    private LocalDate dueDate;

    //	@NotNull(message = "{bakery.due.time.required}")
    @NotNull(message = "Время не выбрано")
    @Column(name = "due_time")
    private LocalTime dueTime;

    //	@NotNull(message = "{bakery.pickup.location.required}")
    @ManyToOne
    @JoinColumn(name="pickup_location_id",referencedColumnName = "id")
    @NotNull(message = "Не выбрано")
    private PickupLocation pickupLocation;

    //@NotNull
    @OneToOne(cascade = CascadeType.MERGE,fetch= FetchType.EAGER)
    @NotNull(message = "Клиент не выбран")
    private Contractor customer;

  //  @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, orphanRemoval = true)
   // @OrderColumn
    @JoinColumn(name="order_id")
    @OneToMany( fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true)
    @BatchSize(size = 1000)
    @NotEmpty
    @Valid
  //  @JsonIgnoreProperties(value = "order", allowSetters = true)
 //   @JsonManagedReference
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



    @Column(name = "created")
    @CreationTimestamp
    @Temporal(TemporalType.TIMESTAMP)
    private Date created;

    @Column(name = "modified")
    @UpdateTimestamp
    @Temporal(TemporalType.TIMESTAMP)
    private Date modified;

    @Column(name = "done")
    private Date done;

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
    public Date getCreated() {
        return created;
    }


    public Date getModified() {
        return modified;
    }

    public Date getDone() {
        return done;
    }
    public void setCreated(Date created) {
        this.created = created;
    }

    public void setModified(Date modified) {
        this.modified = modified;
    }

    public void setDone(Date done) {
        this.done = done;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        Order order = (Order) o;
        return Objects.equals(wpOrderId, order.wpOrderId) &&
                Objects.equals(dueDate, order.dueDate) &&
                Objects.equals(dueTime, order.dueTime) &&
                Objects.equals(pickupLocation, order.pickupLocation) &&
                Objects.equals(customer, order.customer) &&
                Objects.equals(items, order.items) &&
                state == order.state &&
                discount == order.discount &&
                Objects.equals(history, order.history) &&
                orderType == order.orderType &&
                Objects.equals(parentId, order.parentId) &&
                Objects.equals(created, order.created) &&
                Objects.equals(modified, order.modified) &&
                Objects.equals(done, order.done);
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), wpOrderId, dueDate, dueTime, pickupLocation, customer, items, state, discount, history, orderType, parentId, created, modified, done);
    }

    @Override
    public String toString() {
        return  " Дата- " + dueDate +
                " Время- " + dueTime +
                " Место- " + pickupLocation +
                " Покупвтель- " + customer +
                " Статус- " + state;
    }
}
