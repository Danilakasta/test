package com.roofapp.backend.data;

public enum CoverType {
    NONE("Без покрытия"),
    FLAT("Гладкое"),
    COLOR("Окраска");


    private final String name;

    private CoverType(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}
