package com.roofapp.backend.data;

public enum CoverType {
    NONE("Без покрытия"),
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
