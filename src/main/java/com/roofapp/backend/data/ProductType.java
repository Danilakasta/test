package com.roofapp.backend.data;

public enum ProductType {
    PROFILED ("Профнастил"),
    METAL_TILE("Металочерепица"),
    ADDITIONAL_ELEMENTS("Доборные элементы"),
    DRAINAGE_SYSTEM("Водосточные системы"),
    PRODUCTS_STOCK("Продукция на складе");

    private final String name;

    private ProductType(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}