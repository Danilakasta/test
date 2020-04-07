package com.roofapp.backend.data;

public enum MachineType {
    W100("V 1000"),
    F200("F 2000");


    private final String name;

    private MachineType(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}
