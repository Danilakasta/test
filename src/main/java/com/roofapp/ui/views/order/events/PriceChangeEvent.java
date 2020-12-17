package com.roofapp.ui.views.order.events;

import com.roofapp.backend.utils.Helper;
import com.roofapp.ui.views.orderedit.OrderItemEditor;
import com.vaadin.flow.component.ComponentEvent;

public class PriceChangeEvent extends ComponentEvent<OrderItemEditor> {

	private final Double oldValue;

	private final Double newValue;

	public PriceChangeEvent(OrderItemEditor component, Double oldValue, Double newValue) {
		super(component, false);
		this.oldValue = oldValue;
		this.newValue = newValue;
	}

	public Double getOldValue() {
		return Helper.aroundDouble(oldValue);
	}

	public Double getNewValue() {
		return Helper.aroundDouble(newValue);
	}

}