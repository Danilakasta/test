package com.roofapp.backend.dao.roofZavod.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.sql.Timestamp;

@Entity
@Data
public class WpOrder {

    @Id
    private Long id;

    private String author;

    private Timestamp date;

    private String status ;

    private String details;

    @Column(name = "full_name")
    private String fullName;
    @Column(name = "phone_numbers")
    private String phoneNumbers;


}
