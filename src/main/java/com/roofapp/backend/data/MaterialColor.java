package com.roofapp.backend.data;

public enum MaterialColor {
    BROWN("Brown"), GREEN("Green"), BLUE("Blue");

    private final String name;

    private MaterialColor(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}
