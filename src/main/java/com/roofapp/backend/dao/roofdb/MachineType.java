package com.roofapp.backend.dao.roofdb;

public enum MachineType {
    P("Профнастил"),
    M("Метало черепица"),
    G("Гладкий лист");


    private final String name;

    private MachineType(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}
