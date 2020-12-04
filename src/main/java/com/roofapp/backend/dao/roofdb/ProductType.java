package com.roofapp.backend.dao.roofdb;

public enum ProductType {
    PROFILED ("Профнастил"),
    METAL_TILE("Металочерепица"),
    ADDITIONAL_ELEMENTS("Доборные элементы"),
    DRAINAGE_SYSTEM("Водосточные системы"),
    PRODUCTS_STOCK("Продукция на складе"),
    PRODUCTS_SERVICES("Услуги"),
    ADDITIONAL_COMPONENT("Кровельные комплектующие");

    private final String name;

    private ProductType(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}
