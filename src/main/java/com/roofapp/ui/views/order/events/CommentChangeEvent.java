package com.roofapp.ui.views.order.events;

import com.roofapp.ui.views.orderedit.OrderItemEditor;
import com.vaadin.flow.component.ComponentEvent;

public class CommentChangeEvent extends ComponentEvent<OrderItemEditor> {

	private final String comment;

	public CommentChangeEvent(OrderItemEditor component, String comment) {
		super(component, false);
		this.comment = comment;
	}

	public String getComment() {
		return comment;
	}

}