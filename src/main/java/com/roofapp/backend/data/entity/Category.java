package com.roofapp.backend.data.entity;

import lombok.Data;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
@Data
public class Category implements Serializable {

    @Id
    @GeneratedValue(strategy= GenerationType.SEQUENCE)
    private Long id ;
   // @Size(min = 2, message = "Category name must be at least two characters")
    private String name;

}
