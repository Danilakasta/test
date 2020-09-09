package com.roofapp.backend.dao.roofZavod.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.sql.Timestamp;

@Entity
@Data
public class WpOrderItems {

    @Id
    private Long id;

    @Column(name = "product_id")
    private Long productId;

    private Double quantity;

    private Double price;
}
