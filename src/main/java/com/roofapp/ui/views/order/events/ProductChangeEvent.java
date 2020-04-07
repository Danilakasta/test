package com.roofapp.ui.views.order.events;

import com.roofapp.backend.data.entity.Product;
import com.roofapp.ui.views.orderedit.OrderItemEditor;
import com.vaadin.flow.component.ComponentEvent;

public class ProductChangeEvent extends ComponentEvent<OrderItemEditor> {

	private final Product product;

	public ProductChangeEvent(OrderItemEditor component, Product product) {
		super(component, false);
		this.product = product;
	}

	public Product getProduct() {
		return product;
	}

}