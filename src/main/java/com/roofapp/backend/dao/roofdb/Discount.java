package com.roofapp.backend.dao.roofdb;

public enum Discount {
	NULL_PERCENT("0%"),
	FIVE_PERCENT("5%"),
	TEN_PERCENT("10%"),
	FIFTEEN_PERCENT( "15%"),
	TWENTY_PERCENT("20%"),
	THIRTY_PERCENT("30%");

	private final String name;

	Discount(String name) {
		this.name = name;
	}

	/**
	 * Gets a version of the enum identifier in a human friendly format.
	 *
	 * @return a human friendly version of the identifier
	 */
	public String getDisplayName() {
		return name;
	}

	@Override
	public String toString() {
		return name;
	}
}
