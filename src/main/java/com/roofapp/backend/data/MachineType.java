package com.roofapp.backend.data;

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
