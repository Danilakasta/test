package com.roofapp.backend.data.entity;

import com.roofapp.backend.data.*;
import lombok.Data;

import javax.persistence.Entity;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

@Entity
@Data

public class Machine extends AbstractEntity {


    private String name;

    private int weight = 0;

    private int length = 0;

    private MachineType type;

    private Width width = Width.W28;

    private WaveHeight waveHeight;

    @Override
    public String toString() {
        return name +" "+width ;
    }
}
