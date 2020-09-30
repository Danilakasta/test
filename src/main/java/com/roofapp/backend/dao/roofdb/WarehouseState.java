package com.roofapp.backend.dao.roofdb;

public enum WarehouseState {

	DELIVERED_TO_WAREHOUSE("Доставляется на склад"),
	UNLOADING("Разгрузка"),
	RECEIVING("Приемка"),
	MANUFACTURED("В производстве"),
	STORAGE("Хранение"),
	LOADING("Погрузка"),
	DELIVERY("Доставка"),
	IS_DELIIVERY("Доставлен");

	private final String name;

	private WarehouseState(String name) {
		this.name = name;
	}

	public String getDisplayName() {
		return name;
	}


	@Override
	public String toString() {
		return name;
	}
}
