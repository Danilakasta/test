package com.roofapp.ui.utils.converters;

import com.roofapp.backend.dao.roofdb.Discount;
import com.roofapp.backend.dao.roofdb.MaterialClass;
import com.vaadin.flow.templatemodel.ModelEncoder;

public class DiscountToStringConverter implements ModelEncoder<Discount, String> {

	@Override
	public String encode( Discount modelValue) {
		if (modelValue == null) {
			return null;
		}
		return modelValue.toString();
	}

	@Override
	public Discount decode(String presentationValue) {
		if (presentationValue == null) {
			return null;
		}
		return null ; //Long.parseLong(presentationValue);
	}

}
