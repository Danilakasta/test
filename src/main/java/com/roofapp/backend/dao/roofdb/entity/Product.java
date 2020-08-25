package com.roofapp.backend.dao.roofdb.entity;

import com.roofapp.backend.dao.roofdb.MaterialColor;
import com.roofapp.backend.dao.roofdb.ProductType;
import com.roofapp.backend.dao.roofdb.Width;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Product extends AbstractEntity {

//	@Version
    //private int version;

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
    @Column(name = "material_color")
    private MaterialColor materialColor = MaterialColor.RAL9016;

    private Width width = Width.W28;


    private String title;

    @Column(name= "second_title")
    private String secondTitle;

    private String category;

    @Override
    public String toString() {
        return name +" "+width+" "+materialColor;
    }
}
