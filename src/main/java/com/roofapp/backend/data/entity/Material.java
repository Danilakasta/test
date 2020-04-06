package com.roofapp.backend.data.entity;

import com.roofapp.backend.data.*;
import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.math.BigDecimal;

@Entity(name="Materials")
@Data
public class Material {

    @Id
    @GeneratedValue(strategy=GenerationType.SEQUENCE)
    private Long id;

   // @Size(min = 2, message = "Product name must have at least two characters")
    private String name;
  //  @Min(0)
    private BigDecimal price = BigDecimal.ZERO;

    private int weight = 0;

    private int length = 0;

    private MaterialType type ;

    private MaterialColor materialColor = MaterialColor.BROWN;

    private Width width = Width.W28;

    //Покрытие
    private CoverType cover = CoverType.NONE;

    private String party;

    private String manufacturer;

    private Double teorCoefficient;

    private Double factCoefficient;

    private int used;

    public boolean isNew() {
        return this.id == null;
    }


}
