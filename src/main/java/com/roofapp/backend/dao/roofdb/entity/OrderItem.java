package com.roofapp.backend.dao.roofdb.entity;

import com.roofapp.backend.dao.roofdb.*;
import com.roofapp.backend.dao.roofdb.entity.guides.Width;
import lombok.*;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Objects;

@Entity(name = "order_item")
//@Data
//@EqualsAndHashCode
@Getter
@Setter
@ToString
public class OrderItem extends AbstractEntity {

    @ManyToOne
    @NotNull(message = "Продукт не выбран")
    private Product product;

   /* @ManyToOne(fetch = FetchType.EAGER)//(cascade = CascadeType.ALL,fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id")
	@JsonIgnoreProperties(value = "items", allowSetters = true)
    @JsonBackReference
    private Order order;
*/
    @Column(name = "order_id")
    private Long orderId;


   // @Min(1)
    //@NotNull
    @NotNull(message = "Кол-во не выбрано")
    private Double quantity = 1d;

    @Size(max = 255)
    private String comment;

    public Double getTotalPrice() {
        return quantity == null || product == null ? Double.valueOf(0) : quantity * price;
    }
    @NotNull(message = "Толщина не выбрана")
    @ManyToOne(fetch = FetchType.EAGER, cascade = {CascadeType.MERGE})
    private Width width ;

    @NotNull(message = "Класс не выбран")
    @Column(name = "material_class")
    private MaterialClass materialClass = MaterialClass.NO_ENTER;

    @NotNull(message = "Покрытие не выбрано")
    @Column(name = "material_cover")
    private MaterialCover materialCover = MaterialCover.NO_ENTER;

    @NotNull(message = "Цвет не выбран")
    @Column(name = "material_color")
    private MaterialColor materialColor = MaterialColor.NO_ENTER;

    @NotNull(message = "Длинна не выбрана")
    private Double height = 0D;

    private String size;

    @NotNull
    @Column(name = "total_price")
    private Double price;

    @Column(name = "order_type")
    private OrderType orderType = OrderType.CONTRACTOR_ORDER;

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

}
