package com.roofapp.backend.data;

public enum WaveHeight {
    H07(07),
    H08(08),
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
