package com.roofapp.backend.dao.roofdb.entity.guides;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.roofapp.backend.dao.roofdb.entity.AbstractEntity;
import com.roofapp.backend.dao.roofdb.entity.Machine;
import com.roofapp.backend.dao.roofdb.entity.Product;
import com.roofapp.backend.dao.roofdb.entity.User;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.util.Date;

@Entity
@Data
@Table(name = "forbidden_size")

public class ForbiddenSize extends AbstractEntity {

    @Column(name = "value_from")
    private Double valueFrom;

    @Column(name = "value_to")
    private Double valueTo;

    @ManyToOne
    @JoinColumn(name = "machine_id", referencedColumnName = "id")
    private Machine machine;

    @ManyToOne
    @JoinColumn(name = "product_id", referencedColumnName = "id")
    private Product product;

    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    private User user;

    @Column(name = "created")
    @CreationTimestamp
    @Temporal(TemporalType.TIMESTAMP)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd@HH:mm:ss")
    private Date created;

    @Column(name = "modified")
    @UpdateTimestamp
    @Temporal(TemporalType.TIMESTAMP)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd@HH:mm:ss")
    private Date modified;


    @Override
    public String toString() {
        return valueFrom + "-"+valueTo;
    }


}
