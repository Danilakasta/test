package com.roofapp.backend.data.entity;

import com.roofapp.backend.data.MaterialColor;
import com.roofapp.backend.data.ProductType;
import com.roofapp.backend.data.Width;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

import java.math.BigDecimal;

import javax.persistence.*;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

@Entity
@Data

public class Product extends AbstractEntity {

    /* @Id
     @GeneratedValue(strategy=GenerationType.SEQUENCE)
     private Long id;
 */
    // @Size(min = 2, message = "Product name must have at least two characters")
  //  @NotBlank(message = "{bakery.name.required}")
    private String name;
    //  @Min(0)
 //   @Min(value = 0, message = "{bakery.price.limits}")
  //  @Max(value = 100000, message = "{bakery.price.limits}")
    private Double price;

    private int weight = 0;

    private int length = 0;

    private ProductType type;

    private MaterialColor materialColor = MaterialColor.RAL9016;

    private Width width = Width.W28;

    @Override
    public String toString() {
        return name +" "+width+" "+materialColor;
    }
}
