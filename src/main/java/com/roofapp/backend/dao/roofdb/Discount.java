package com.roofapp.backend.dao.roofdb;

public enum Discount {
	NULL_PERCENT("0"),
	FIVE_PERCENT("5"),
	TEN_PERCENT("10"),
	FIFTEEN_PERCENT( "15"),
	TWENTY_PERCENT("20"),
	THIRTY_PERCENT("30");

	private final String name;

	Discount(String name) {
		this.name = name;
	}


	public String getDisplayName() {
		return name+ "%";
	}

	@Override
	public String toString() {
		return name + "%";
	}

	public Double getDiscount(){
		return Double.valueOf(name)/100;
	}
}
