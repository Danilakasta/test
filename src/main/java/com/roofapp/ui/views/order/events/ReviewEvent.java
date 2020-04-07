package com.roofapp.ui.views.order.events;

import com.roofapp.ui.views.orderedit.OrderEditor;
import com.vaadin.flow.component.ComponentEvent;

public class ReviewEvent extends ComponentEvent<OrderEditor> {

	public ReviewEvent(OrderEditor component) {
		super(component, false);
	}
}