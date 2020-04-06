package com.roofapp.backend.data.entity;

import com.roofapp.backend.data.MaterialColor;
import com.roofapp.backend.data.ProductType;
import com.roofapp.backend.data.Width;
import lombok.Data;

import java.math.BigDecimal;

import javax.persistence.*;

@Entity
@Data
public class Product  {

    @Id
    @GeneratedValue(strategy=GenerationType.SEQUENCE)
    private Long id;

   // @Size(min = 2, message = "Product name must have at least two characters")
    private String productName;
  //  @Min(0)
    private BigDecimal price = BigDecimal.ZERO;

    private int weight = 0;

    private int length = 0;

    private ProductType type ;

    private MaterialColor materialColor = MaterialColor.BROWN;

    private Width width = Width.W28;

    public boolean isNew() {
        return this.id == null;
    }


}
