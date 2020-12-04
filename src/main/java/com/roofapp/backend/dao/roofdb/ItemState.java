package com.roofapp.backend.dao.roofdb;

public enum ItemState {
	NEW("Новый"),
	MANUFACTURE("Производство"),
	TRANSFERED("Передано в производство"),
	READY("Выполнен"),
	STORAGE("Хранение"),
	CANCELLED("Отменен");

	private final String name;

	private ItemState(String name) {
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
