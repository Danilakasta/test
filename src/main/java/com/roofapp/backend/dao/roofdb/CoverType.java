package com.roofapp.backend.dao.roofdb;

public enum CoverType {
    NONE("Цинк"),
    MATE("Мат"),
    MATE_RR("RR Мат"),
    MATE_STANDART("Мат стандарт"),
    GLOSS("Глянец"),
    GLOSS_STANDART("Глянец стандарт"),
    PLAIN_LIST("Гладкий лист"),
    MODERN("Модерн");


    private final String name;

    private CoverType(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}
