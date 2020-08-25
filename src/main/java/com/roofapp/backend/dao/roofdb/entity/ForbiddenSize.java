package com.roofapp.backend.dao.roofdb.entity;

import com.roofapp.backend.dao.roofdb.WaveHeight;
import lombok.Data;

import javax.persistence.Entity;

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
