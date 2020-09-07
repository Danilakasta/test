package com.roofapp.backend.dao.roofdb.entity;

import com.roofapp.backend.dao.roofdb.MaterialClass;
import com.roofapp.backend.dao.roofdb.MaterialColor;
import com.roofapp.backend.dao.roofdb.MaterialCover;
import com.roofapp.backend.dao.roofdb.Width;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.validation.constraints.Min;
import javax.validation.constraints.Size;

@Entity(name = "order_item ")
@Data
public class OrderItem extends AbstractEntity {

	@ManyToOne
	//@NotNull(message = "{bakery.pickup.product.required}")
	private Product product;

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
}
