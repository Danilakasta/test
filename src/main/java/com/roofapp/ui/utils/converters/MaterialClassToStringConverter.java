package com.roofapp.ui.utils.converters;

import com.roofapp.backend.dao.roofdb.MaterialClass;
import com.vaadin.flow.templatemodel.ModelEncoder;

public class MaterialClassToStringConverter implements ModelEncoder<MaterialClass, String> {

	@Override
	public String encode( MaterialClass modelValue) {
		if (modelValue == null) {
			return null;
		}
		return modelValue.toString();
	}

	@Override
	public MaterialClass decode(String presentationValue) {
		if (presentationValue == null) {
			return null;
		}
		return null ; //Long.parseLong(presentationValue);
	}

}
