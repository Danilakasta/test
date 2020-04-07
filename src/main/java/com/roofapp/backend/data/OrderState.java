package com.roofapp.backend.data;

import com.vaadin.flow.shared.util.SharedUtil;

import java.util.Locale;

public enum OrderState {
	NEW("Новый"), CONFIRMED("Подтвержден"), READY("Готов"), DELIVERED("Доставлен"), PROBLEM("Проблемный"), CANCELLED("Отменен");

	private final String name;

	private  OrderState (String name) {
		this.name = name;
	}

	/**
	 * Gets a version of the enum identifier in a human friendly format.
	 *
	 * @return a human friendly version of the identifier
	 */
	public String getDisplayName() {
		return name; // SharedUtil.capitalize(name().toLowerCase(Locale.ENGLISH));
	}
}
