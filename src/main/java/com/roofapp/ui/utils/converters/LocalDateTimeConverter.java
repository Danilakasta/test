package com.roofapp.ui.utils.converters;

import com.vaadin.flow.templatemodel.ModelEncoder;

import java.time.LocalDateTime;

import static com.roofapp.ui.dataproviders.DataProviderUtil.convertIfNotNull;
import static com.roofapp.ui.utils.FormattingUtils.FULL_DATE_FORMATTER;

public class LocalDateTimeConverter implements ModelEncoder<LocalDateTime, String> {


	private static final LocalTimeConverter TIME_FORMATTER = new LocalTimeConverter();

	@Override
	public String encode(LocalDateTime modelValue) {
		return convertIfNotNull(modelValue,
				v -> FULL_DATE_FORMATTER.format(v) + " " + TIME_FORMATTER.encode(v.toLocalTime()));
	}

	@Override
	public LocalDateTime decode(String presentationValue) {
		throw new UnsupportedOperationException();
	}
}
