package com.roofapp.backend.dao.roofdb;

public enum MaterialColor {
    RAL9016("RAL9016"), //#F7FBF5
    RAL5015("RAL5015"), //#2874B2
    RAL6010("RAL6010"), //#3E753B
    RAL7035("RAL7035"), //#CBD0CC
    RAL8016("RAL8016");//#4C2F26
    private final String name;

    private MaterialColor(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }
}
