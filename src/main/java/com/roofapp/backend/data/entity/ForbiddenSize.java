package com.roofapp.backend.data.entity;

import com.roofapp.backend.data.MachineType;
import com.roofapp.backend.data.WaveHeight;
import com.roofapp.backend.data.Width;
import lombok.Data;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;

@Entity
@Data

public class ForbiddenSize extends AbstractEntity {

    //Высотаволны
    private WaveHeight waveHeight;

    //Значение
    private Integer value;

    //Габаритная ширина
    private Double overallWidth;

    // рабочая ширина
    private Double workingWidth;

}
