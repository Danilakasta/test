package com.roofapp.ui.views.order.events;

import com.roofapp.ui.views.orderedit.OrderItemsEditor;
import com.vaadin.flow.component.ComponentEvent;

public class TotalPriceChangeEvent extends ComponentEvent<OrderItemsEditor> {

	private final Double totalPrice;

	public TotalPriceChangeEvent(OrderItemsEditor component, Double totalPrice) {
		super(component, false);
		this.totalPrice = totalPrice;
	}

	public Double getTotalPrice() {
		return totalPrice;
	}

}