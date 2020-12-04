package com.roofapp.backend.dao.roofdb.entity;

import com.roofapp.backend.dao.roofdb.*;
import com.roofapp.backend.dao.roofdb.entity.guides.Width;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Date;

@Entity(name = "Materials")
@Data
public class Material extends AbstractEntity {

    // @Size(min = 2, message = "Product name must have at least two characters")
    //Порядковый номер
    @NotNull
    @Column(name = "serial_number")

    private Integer serialNumber;
    //Производитель
    @NotNull
    private String manufacturer;
    //Номер партии
    @NotNull
    private String party;

    //цвет
  //  @NotNull
    @Column(name = "material_color")
    private MaterialColor materialColor;
    //Покрытие
    @NotNull
    private MaterialCover cover ;

    //клас
    @NotNull
    @Column(name = "material_class")
    private MaterialClass materialClass ;

    //толшина
    @ManyToOne( fetch = FetchType.EAGER, cascade = {CascadeType.MERGE})
    private Width width ;

    @NotNull
    @Column(name = "width_fact")
    private Double widthFact;

    //  @Min(0)
    //Цена бухты
    @NotNull
    private Double price;
    //Цена доставки
    @NotNull
    @Column(name = "price_delivery")

    private Double priceDelivery;
    // Цена за тонну
    @NotNull
    @Column(name = "price_one_tone")
    private Double priceOneTone;


    //Вес бухты кг
    @Column(name = "weight_of_bay")
    @NotNull
    private Double weightOfBay;

    //Длинна паспортная
    @NotNull
    private Integer length;
    //Себестоймость погонного метра теор
    @Column(name = "price_one_metre")
    private Double priceOneMetre;


    //Теоритический коэф
    @Column(name = "teor_coefficient")
    private Double teorCoefficient;
    //Факт коэф
    @Column(name = "fact_coefficient")
    private Double factCoefficient;

    //расход
    private Double used = 0D;
    //остаток
    private Double remains;


    @Column(name = "created")
    @CreationTimestamp
    @Temporal(TemporalType.TIMESTAMP)
    private Date created;

    @Column(name = "modified")
    @UpdateTimestamp
    @Temporal(TemporalType.TIMESTAMP)
    private Date modified;


    @Transient
    private Double remainInProduction;


    @Transient
    private Integer countInProduction;


    @Override
    public String toString(){
        return   serialNumber +" " + manufacturer+" "+width +" "+materialColor  +" "+ cover+" "+materialClass +" Остаток-"+ remains+
              " Производимая длина- "+remainInProduction +  " Колличество- "+countInProduction;
    }

}
