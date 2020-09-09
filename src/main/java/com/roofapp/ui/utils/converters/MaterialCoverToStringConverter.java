package com.roofapp.ui.utils.converters;

import com.roofapp.backend.dao.roofdb.MaterialCover;
import com.vaadin.flow.templatemodel.ModelEncoder;

public class MaterialCoverToStringConverter implements ModelEncoder<MaterialCover, String> {

	@Override
	public String encode( MaterialCover modelValue) {
		if (modelValue == null) {
			return null;
		}
		return modelValue.toString();
	}

	@Override
	public MaterialCover decode(String presentationValue) {
		if (presentationValue == null) {
			return null;
		}
		return null ; //Long.parseLong(presentationValue);
	}

}
