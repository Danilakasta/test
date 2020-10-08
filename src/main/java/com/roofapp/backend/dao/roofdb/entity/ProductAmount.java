package com.roofapp.backend.dao.roofdb.entity;

import com.roofapp.backend.dao.roofdb.*;
import lombok.*;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;

@Entity(name = "product_amount")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ProductAmount extends AbstractEntity {


   // @ManyToOne
 //   @JoinColumn(name="product_id",referencedColumnName = "id")
  //  private Product product;


    private Width width ;

    @Column(name = "material_class")
    private MaterialClass materialClass;

    @Column(name = "material_cover")
    private MaterialCover materialCover;

 /*   @Column(name = "material_color")
    private MaterialColor materialColor;
*/

    @Min(1)
    @Max(1000)
    private Double price;

    @Column(name = "self_price")
    private Double selfPrice;


    @Override
    public String toString() {
        return materialClass  + " " + width + " " +   materialCover/*+ " " + materialColor*/;
    }


}
