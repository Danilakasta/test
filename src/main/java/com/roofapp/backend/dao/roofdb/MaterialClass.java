package com.roofapp.backend.dao.roofdb;

//Клас покрытия
public enum MaterialClass {
    PREMIUM("Премиум"),
    STANDART("Стандарт");


    private final String name;

    private MaterialClass(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}
