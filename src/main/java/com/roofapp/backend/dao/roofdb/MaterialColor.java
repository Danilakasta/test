package com.roofapp.backend.dao.roofdb;

public enum MaterialColor {
  /*  RAL9016("RAL9016"), //#F7FBF5
    RAL5015("RAL5015"), //#2874B2
    RAL6010("RAL6010"), //#3E753B
    RAL7035("RAL7035"), //#CBD0CC
    RAL8016("RAL8016"),//#4C2F26*/
    RAL1014("1014"),
    RAL3005("3005"),
    RAL3009("3009"),
    RAL3011("3011"),
    RAL5002("5002"),
    RAL5005("5005"),
    RAL5021("5021"),
    RAL6002("6002"),
    RAL6005("6005"),
    RAL6020("6020"),
    RAL7024("7024"),
    RAL8004("8004"),
    RAL8017("8017"),
    RAL8019("8019"),
    RAL9003("9003"),
    RAL9006("9006"),
    RAL1("Античный дуб"),
    RAL2("Дикий камень"),
    RAL3("Золотой дуб 3D"),
    RAL4("Золотой дуб"),
    RAL5("Кирпичная кладка"),
    RAL6("Красное дерево 3D"),
    RAL7("Красное дерево"),
    RAL8("Крупнозернистое матовое покрытие  (RR32)"),
    RAL9("Матовая двухцветная кровля (Roof 2 Tone Brown W/S)"),
    RAL14("Светлое дерево"),
    RAL10("Серебристый волос"),
    RAL11("Тёмное дерево"),
    RAL12("Хаки"),
    RAL13("Оц");


    private final String name;

    private MaterialColor(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
    }
