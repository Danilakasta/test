package com.roofapp.backend.dao.roofdb;

public enum WaveHeight {
    H07("ПС 07"),
    H08("ПС 08"),
    H20("ПС 20"),
    H21("ПС 21"),
    H35("ПС 35"),
    H40("ПС 40"),
    H60("ПС 60"),
    H75("ПС 75"),
    H114("ПС 114"),
    SMOOTH_SHEET("Гладкий лист"),
    SUPER_MATURE("Супермонтеррей"),
    MODERN("Модерн"),
    CLASSIC("Классика");


    private final String height;

    private WaveHeight(String height) {
        this.height = height;
    }

    public String getHeight(){
        return height;
    }
    @Override
    public String toString() {
        return height.toString();
    }
}
