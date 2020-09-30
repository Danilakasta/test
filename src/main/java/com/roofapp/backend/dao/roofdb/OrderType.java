package com.roofapp.backend.dao.roofdb;

public enum OrderType {
	CONTRACTOR_ORDER("Заказ"),
	MANUFACTURED("Производство");


	private final String name;

	private OrderType(String name) {
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

	@Override
	public String toString() {
		return name;
	}
}
