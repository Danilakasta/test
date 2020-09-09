package com.roofapp.ui.utils.converters;

import com.roofapp.backend.dao.roofdb.MaterialColor;
import com.vaadin.flow.templatemodel.ModelEncoder;

public class MaterialColorToStringConverter implements ModelEncoder<MaterialColor, String> {

	@Override
	public String encode( MaterialColor modelValue) {
		if (modelValue == null) {
			return null;
		}
		return modelValue.toString();
	}

	@Override
	public MaterialColor decode(String presentationValue) {
		if (presentationValue == null) {
			return null;
		}
		return null ; //Long.parseLong(presentationValue);
	}

}
