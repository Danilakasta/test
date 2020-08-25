package com.roofapp.backend.dao.roofdb.entity;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.validation.constraints.Min;
import javax.validation.constraints.Size;

@Entity
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
}
