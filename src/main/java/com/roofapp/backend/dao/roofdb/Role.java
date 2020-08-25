package com.roofapp.backend.dao.roofdb;


public enum Role {
    ADMIN("Админ"),
    DIRECTOR("Директор"),
    MANAGER("Манаджер"),
    MACHINE_ENGINEER("Инжинер станка"),
	LOADER("Грузчик"),
	DRIVER("Водитель");


	private final String name;

	private Role(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	@Override
	public String toString() {
		return name;
	}

}
