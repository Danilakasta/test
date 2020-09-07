package com.roofapp.ui.views.order.events;

import com.roofapp.backend.dao.roofdb.Width;
import com.roofapp.backend.dao.roofdb.entity.Product;
import com.roofapp.ui.views.orderedit.OrderItemEditor;
import com.vaadin.flow.component.ComponentEvent;

public class WidthChangeEvent extends ComponentEvent<OrderItemEditor> {

	private final Width width;

	public WidthChangeEvent(OrderItemEditor component, Width width) {
		super(component, false);
		this.width = width;
	}

	public Width getWidth() {
		return width;
	}

}