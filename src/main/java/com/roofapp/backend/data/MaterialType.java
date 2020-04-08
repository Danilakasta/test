package com.roofapp.backend.data;

public enum MaterialType {
    METAL("Метал"),
    PROFILE("Профиль");


    private final String name;

    private MaterialType(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}