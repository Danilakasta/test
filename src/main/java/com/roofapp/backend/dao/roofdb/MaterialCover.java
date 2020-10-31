package com.roofapp.backend.dao.roofdb;

//Покрытие
public enum MaterialCover {
    NO_ENTER("Не выбрано"),
    ZINK("Цинк"),
    POLIESTER("Полиэстер"),
    PRINTEK("Принтек"),
    MAT("Матовый");


    private final String name;

    private MaterialCover(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}
