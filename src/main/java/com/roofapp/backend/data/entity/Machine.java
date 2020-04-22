package com.roofapp.backend.data.entity;

import com.roofapp.backend.data.*;
import lombok.Data;

import javax.persistence.Entity;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Entity
@Data

public class Machine extends AbstractEntity {


    private String name;

    private int weight = 0;

    private int length = 0;

    @NotNull
    private MachineType type;

    @NotNull
    private Width width = Width.W28;

    @NotNull
    private WaveHeight waveHeight = WaveHeight.H0;

    @Override
    public String toString() {
        return name +" "+width ;
    }
}
