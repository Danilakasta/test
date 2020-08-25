package com.roofapp.backend.dao.roofdb.entity;

import com.roofapp.backend.dao.roofdb.CoverType;
import com.roofapp.backend.dao.roofdb.MaterialColor;
import com.roofapp.backend.dao.roofdb.Width;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.validation.constraints.NotNull;

@Entity(name="Materials")
@Data
public class Material extends AbstractEntity {

   // @Size(min = 2, message = "Product name must have at least two characters")
    //Порядковый номер
    @NotNull
    @Column(name = "serial_number")

    private Integer serialNumber ;
    //Производитель
    @NotNull
    private String manufacturer;
    //Номер партии
    @NotNull
    private String party;

    //цвет
    @NotNull
    @Column(name = "material_color")
    private MaterialColor materialColor = MaterialColor.RAL9016;
    //Покрытие
    @NotNull
    private CoverType cover = CoverType.NONE;
    //толшина
    @NotNull
    private Width width = Width.W28;

    //  @Min(0)
    //Цена бухты
    @NotNull
    private Double price ;
    //Цена доставки
    @NotNull
    @Column(name = "price_delivery")

    private Double priceDelivery ;
    // Цена за тонну
    @NotNull
    @Column(name = "price_one_tone")
    private Double  priceOneTone;


    //Вес бухты кг
    @Column(name = "weight_of_bay")
    private Integer weightOfBay;
    //Длинна паспортная
    private Integer length;
    //Себестоймость погонного метра теор
    @Column(name = "price_one_metre")

    private Double priceOneMetre ;


    //Теоритический коэф
    @Column(name = "teor_coefficient")
    private Double teorCoefficient;
    //Факт коэф
    @Column(name = "fact_coefficient")
    private Double factCoefficient;

    //расход
    private Double used;
    //остаток
    private Double remains;

}
