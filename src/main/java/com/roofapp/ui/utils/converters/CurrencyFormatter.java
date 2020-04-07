package com.roofapp.ui.utils.converters;

import com.roofapp.ui.dataproviders.DataProviderUtil;
import com.roofapp.ui.utils.FormattingUtils;
import com.vaadin.flow.templatemodel.ModelEncoder;

public class CurrencyFormatter implements ModelEncoder<Integer, String> {

	@Override
	public String encode(Integer modelValue) {
		return DataProviderUtil.convertIfNotNull(modelValue, FormattingUtils::formatAsCurrency);
	}

	@Override
	public Integer decode(String presentationValue) {
		throw new UnsupportedOperationException();
	}
}
