package com.roofapp.backend.dao.roofdb;

public enum Width {
    W28(0.28),
    W30(0.30),
    W35(0.35),
    W38(0.38),
    W40(0.40),
    W43(0.43),
    W45(0.45),
    W47(0.47),
    W50(0.50),
    W55(0.55),
    W65(0.65),
    W70(0.70);

    private final Double width;

    private Width(Double name) {
        this.width = name;
    }

    @Override
    public String toString() {
        return width.toString();
    }
}
