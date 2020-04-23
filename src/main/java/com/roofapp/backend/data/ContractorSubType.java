package com.roofapp.backend.data;

public enum ContractorSubType {
    UR("Юр лицо"),
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
