package com.roofapp.backend.data.entity;

import com.roofapp.backend.data.*;
import lombok.Data;
import org.springframework.lang.NonNull;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Entity(name="Materials")
@Data
public class Material extends AbstractEntity {

   // @Size(min = 2, message = "Product name must have at least two characters")
    //Порядковый номер
    @NotNull
    private Integer serialNumber ;
    //Производитель
    @NotNull
    private String manufacturer;
    //Номер партии
    @NotNull
    private String party;

    //цвет
    @NotNull
    private MaterialColor materialColor = MaterialColor.BROWN;
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
    private Double priceDelivery ;
    // Цена за тонну
    @NotNull
    private Double  priceOneTone;


    //Вес бухты кг
    private Integer weightOfBay;
    //Длинна паспортная
    private Integer length;
    //Себестоймость погонного метра теор
    private Double priceOneMetre ;


    //Теоритический коэф
    private Double teorCoefficient;
    //Факт коэф
    private Double factCoefficient;

    //расход
    private Double used;
    //остаток
    private Double remains;

}
