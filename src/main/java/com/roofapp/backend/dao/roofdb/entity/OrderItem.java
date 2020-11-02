package com.roofapp.backend.dao.roofdb.entity;

import com.roofapp.backend.dao.roofdb.*;
import com.roofapp.backend.dao.roofdb.entity.guides.Width;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Date;
import java.util.Objects;

@Entity(name = "order_item")
//@Data
//@EqualsAndHashCode
@Getter
@Setter
public class OrderItem extends AbstractEntity {

    @ManyToOne
    // @NotNull(message = "Продукт не выбран")
    private Product product;

    @Column(name = "order_id")
    private Long orderId;


    @Min(1)
    private Double quantity = 1d;

    @Size(max = 255)
    private String comment;

    @ManyToOne(fetch = FetchType.EAGER, cascade = {CascadeType.MERGE})
    private Width width;

    @Column(name = "material_class")
    private MaterialClass materialClass;

    @Column(name = "material_cover")
    private MaterialCover materialCover;

    @Column(name = "material_color")
    private MaterialColor materialColor;


    //  @Min(1)
    @Max(12)
    private Double height = 0D;

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


    public Double getTotalPrice() {
        if (product.getPrice() != null && product.getPrice() != 0) {
            return quantity == null || product == null ? Double.valueOf(0) : quantity * product.getPrice();
        }
        return quantity == null || product == null ? Double.valueOf(0) : quantity * price;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        OrderItem orderItem = (OrderItem) o;
        return Objects.equals(product, orderItem.product) &&
                Objects.equals(orderId, orderItem.orderId) &&
                Objects.equals(quantity, orderItem.quantity) &&
                Objects.equals(comment, orderItem.comment) &&
                Objects.equals(width, orderItem.width) &&
                materialClass == orderItem.materialClass &&
                materialCover == orderItem.materialCover &&
                materialColor == orderItem.materialColor &&
                Objects.equals(height, orderItem.height) &&
                Objects.equals(size, orderItem.size) &&
                Objects.equals(price, orderItem.price) &&
                orderType == orderItem.orderType;
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), product, orderId, quantity, comment, width, materialClass, materialCover, materialColor, height, size, price, orderType);
    }

    @Override
    public String toString() {
        return " Продукт- " + product +
                " Кол-во- " + quantity +
                " Толшина- " + width +
                " Класс- " + materialClass +
                " Покрытие- " + materialCover +
                " Цвет- " + materialColor +
                " Длинна- " + height +
                " Размер- " + size +
                " Цена- " + price;
    }
}
