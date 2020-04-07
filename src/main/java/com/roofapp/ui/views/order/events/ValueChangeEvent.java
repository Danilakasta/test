package com.roofapp.ui.views.order.events;

import com.roofapp.ui.views.orderedit.OrderItemsEditor;
import com.vaadin.flow.component.ComponentEvent;

public class ValueChangeEvent extends ComponentEvent<OrderItemsEditor> {

	public ValueChangeEvent(OrderItemsEditor component) {
		super(component, false);
	}
}