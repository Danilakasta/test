package com.roofapp.backend.dao.roofdb.entity;

import com.roofapp.backend.dao.roofdb.MachineType;
import com.roofapp.backend.dao.roofdb.WaveHeight;
import com.roofapp.backend.dao.roofdb.Width;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
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
    @Column(name = "wave_height")
    private WaveHeight waveHeight;

    //Торцовка
    private Integer trimming;

    //Запрещеные размеры
    @Column(name = "forbidden_size")
    private ForbiddenSize forbiddenSize;

    //Ширина изделия
    @Column(name = "product_width")

    private Integer productWidth;

    @Override
    public String toString() {
        return name  +" "+ type.toString()+" Волна -"+waveHeight.toString();
    }
}
