package com.roofapp.backend.dao.roofdb.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.roofapp.backend.dao.roofdb.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

import javax.persistence.*;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity(name = "order_item")
@Data
@EqualsAndHashCode
public class OrderItem extends AbstractEntity {

	@ManyToOne
	//@NotNull(message = "{bakery.pickup.product.required}")
	private Product product;

	/*@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="order_id")
	@JsonBackReference
	//@JsonIgnore
	@JsonIgnore*/

	@Column(name = "order_id")
	private Long orderId;

	@Min(1)
	//@NotNull
	private Double quantity = 1d ;

	@Size(max = 255)
	private String comment;

	public Double getTotalPrice() {
		return quantity == null || product == null ? Double.valueOf(0) : quantity * product.getPrice();
	}


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

	@Override
	public String toString() {
		return "OrderItem{" +
				"product=" + product +
				", quantity=" + quantity +
				", comment='" + comment + '\'' +
				", width=" + width +
				", materialClass=" + materialClass +
				", materialCover=" + materialCover +
				", materialColor=" + materialColor +
				", height=" + height +
				", price=" + price +
				'}';
	}
}
