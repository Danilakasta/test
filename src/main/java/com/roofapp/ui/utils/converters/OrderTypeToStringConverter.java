package com.roofapp.ui.utils.converters;

import com.roofapp.backend.dao.roofdb.OrderType;
import com.vaadin.flow.templatemodel.ModelEncoder;

public class OrderTypeToStringConverter implements ModelEncoder<OrderType, String> {

	@Override
	public String encode( OrderType modelValue) {
		if (modelValue == null) {
			return null;
		}
		return modelValue.toString();
	}

	@Override
	public OrderType decode(String presentationValue) {
		if (presentationValue == null) {
			return null;
		}
		return null ; //Long.parseLong(presentationValue);
	}

}
