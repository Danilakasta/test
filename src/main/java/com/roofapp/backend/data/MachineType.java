package com.roofapp.backend.data;

public enum MachineType {
    W100("Профнастил"),
    F200("Метало черепица");


    private final String name;

    private MachineType(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}
