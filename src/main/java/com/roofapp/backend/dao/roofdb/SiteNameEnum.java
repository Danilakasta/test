package com.roofapp.backend.dao.roofdb;

public enum SiteNameEnum {
    RichStone("Рич Стоун"),
    CrimProfStal("Крым Проф Сталь"),
    KrovelnyjMir("Кровельный Мир"),
    StroyKomfort("Строй Комфорт"),
    ;


    private final String name;

    private SiteNameEnum(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}
