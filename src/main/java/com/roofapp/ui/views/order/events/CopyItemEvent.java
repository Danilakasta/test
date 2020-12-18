package com.roofapp.ui.views.order.events;

import com.roofapp.backend.dao.roofdb.entity.OrderItem;
import com.roofapp.backend.dao.roofdb.entity.Product;
import com.roofapp.ui.views.orderedit.OrderItemEditor;
import com.vaadin.flow.component.ComponentEvent;

public class CopyItemEvent extends ComponentEvent<OrderItemEditor> {

	private final OrderItem orderItem;

	public CopyItemEvent(OrderItemEditor component, OrderItem orderItem) {
		super(component, false);
		this.orderItem = orderItem;
	}

	public OrderItem getOrderItem() {
		return orderItem;
	}

}