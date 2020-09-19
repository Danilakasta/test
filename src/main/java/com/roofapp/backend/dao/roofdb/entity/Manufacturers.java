package com.roofapp.backend.dao.roofdb.entity;

import com.roofapp.backend.dao.roofdb.*;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;

@Entity
@Data
public class Manufacturers extends AbstractEntity {


    private String name;

    private ProductType type;

    private Width width;

    @Column(name = "material_class")
    private MaterialClass materialClass;

    @Column(name = "material_cover")
    private MaterialCover materialCover;

    @Column(name = "material_color")
    private MaterialColor materialColor;

    private Double height;

    @Column(name = "total_price")
    private Double price;



    @Override
    public String toString() {
        return name ;/*++ " " + width;  " " + materialColor;*/
    }



    public Manufacturers() { }

}
