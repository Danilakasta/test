package com.roofapp.backend.dao.roofdb.entity;


import com.roofapp.backend.dao.roofdb.MaterialClass;
import com.roofapp.backend.dao.roofdb.MaterialColor;
import com.roofapp.backend.dao.roofdb.MaterialCover;
import com.roofapp.backend.dao.roofdb.OrderType;
import com.roofapp.backend.dao.roofdb.entity.guides.Width;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Date;
import java.util.Objects;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class OrderItemManufacture extends AbstractEntity{


    @OneToOne(fetch = FetchType.EAGER,cascade = CascadeType.MERGE)
    @JoinColumn(name = "order_id", referencedColumnName = "id")
    private Order order;

    @ManyToOne
    //@NotNull(message = "{bakery.pickup.product.required}")
    private Product product;


    @Min(1)
    //@NotNull
    private Double quantity = 1d;

    @Size(max = 255)
    private String comment;

    public Double getTotalPrice() {
        return quantity == null || product == null ? Double.valueOf(0) : quantity * product.getPrice();
    }

    @ManyToOne(fetch = FetchType.EAGER, cascade = {CascadeType.MERGE})
    private Width width;

    @Column(name = "material_class")
    private MaterialClass materialClass;

    @Column(name = "material_cover")
    private MaterialCover materialCover;

    @Column(name = "material_color")
    private MaterialColor materialColor;

    private Double height;


    private String size;

    @NotNull
    @Column(name = "total_price")
    private Double price;

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


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        OrderItemManufacture that = (OrderItemManufacture) o;
        return Objects.equals(order, that.order);
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), order);
    }
}
