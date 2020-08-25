package com.roofapp.backend.dao.roofZavod.entity;

import lombok.Data;

import javax.persistence.*;

@Entity
@Data
public class WpProduct{

    @Id
    private Long id;

    private String name;

    private String title;

    @Column(name= "second_title")
    private String secondTitle;

    private String price;

    private String category;


}
