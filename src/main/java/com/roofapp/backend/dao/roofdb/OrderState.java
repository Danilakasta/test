package com.roofapp.backend.dao.roofdb;

public enum OrderState {
	NEW("В ожидании оплаты"), CONFIRMED("Обработка"), READY("Выполнен"), DELIVERED("Доставлен"), PROBLEM("Не удался"), CANCELLED("Отменен");

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
