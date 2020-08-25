package com.roofapp.backend.dao.roofdb;

public enum ContractorType {
    UR("Юр лицо"),
    IP("ИП"),
    FL("Физ лицо"),
    GOS("Гос. орган");

    private final String name;

    private ContractorType(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}
