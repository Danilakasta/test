package com.roofapp.backend.data;

public enum WaveHeight {
    H0(0),
    H07(7),
    H08(8),
    H20(20),
    H21(21),
    H35(35),
    H40(40),
    H60(60),
    H75(75),
    H114(114);

    private final Integer height;

    private WaveHeight(Integer height) {
        this.height = height;
    }

    @Override
    public String toString() {
        return height.toString();
    }
}
