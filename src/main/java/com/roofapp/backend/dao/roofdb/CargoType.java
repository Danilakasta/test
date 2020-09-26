package com.roofapp.backend.dao.roofdb;

public enum CargoType {
    MANUFACTURED("Производство"),
    WAREHOUSE("Склад");


    private final String name;

    private CargoType(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}
