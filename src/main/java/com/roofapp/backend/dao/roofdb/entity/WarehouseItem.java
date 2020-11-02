package com.roofapp.backend.dao.roofdb.entity;

import com.roofapp.backend.dao.roofdb.*;
import com.vaadin.flow.component.textfield.IntegerField;
import lombok.Data;

import javax.persistence.*;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity(name = "warehouse_item")
@Data
public class WarehouseItem extends AbstractEntity {

	@Size(max = 255)
	private String comment;

	@Column(name = "state")
	private WarehouseState state;

	@ManyToOne
	@JoinColumn(name="product_id",referencedColumnName = "id")
	private Product product;

	@OneToOne
	@JoinColumn(name="order_item_id",referencedColumnName = "id")
	private OrderItem orderItem;

	@ManyToOne
	@JoinColumn(name="machine_id",referencedColumnName = "id")
	private Machine machine;

	@ManyToOne
	@JoinColumn(name="material_id",referencedColumnName = "id")
	private Material material;

	@Min(1)
	private Integer quantity ;

}
