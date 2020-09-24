package com.roofapp.ui.utils.converters;

import com.roofapp.backend.dao.roofdb.MaterialCover;
import com.roofapp.backend.dao.roofdb.entity.Contractor;
import com.vaadin.flow.templatemodel.ModelEncoder;

public class ContractorToStringConverter implements ModelEncoder<Contractor, String> {

	@Override
	public String encode( Contractor modelValue) {
		if (modelValue == null) {
			return null;
		}
		return modelValue.toString();
	}

	@Override
	public Contractor decode(String presentationValue) {
		if (presentationValue == null) {
			return null;
		}
		return null ; //Long.parseLong(presentationValue);
	}

}
