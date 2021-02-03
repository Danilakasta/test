package com.roofapp.ui.utils.converters;

import com.vaadin.flow.data.binder.ValueContext;
import com.vaadin.flow.data.converter.StringToIntegerConverter;
import com.vaadin.flow.data.converter.StringToLongConverter;

public class StringToLongConverterNotNull extends StringToLongConverter {
    public StringToLongConverterNotNull() {
        super("Not an Long");
    }

    @Override
    public String convertToPresentation(Long value, ValueContext context) {
        final String result = super.convertToPresentation(value, context);
        return result == null ? "" : result;
    }
}
