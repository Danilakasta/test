package com.roofapp.backend.dao.roofdb;

public enum Trimming {
    T05(0.05),
    T03(0.03),
    T02(0.02),
    T01(0.01);

    private final Double size;

    Trimming(Double name) {
        this.size = name;
    }

    @Override
    public String toString() {
        return size.toString();
    }

    public Double getSize(){
        return this.size;
    }
}
