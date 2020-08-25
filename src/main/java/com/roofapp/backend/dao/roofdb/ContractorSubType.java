package com.roofapp.backend.dao.roofdb;

public enum ContractorSubType {
    UR("Юр лицо"),
    FIZ("Физ лицо"),
    IP("ИП"),
    CT_COMPANY("Строительная компания"),
    DEALER("Дилер"),
    ROOFER("Кровельщик");

    private final String name;

    private ContractorSubType(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}
