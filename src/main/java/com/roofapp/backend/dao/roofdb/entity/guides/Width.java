package com.roofapp.backend.dao.roofdb.entity.guides;


import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.roofapp.backend.dao.roofdb.entity.AbstractEntity;
import com.roofapp.backend.dao.roofdb.entity.Machine;
import com.roofapp.backend.dao.roofdb.entity.User;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.util.Date;


@Entity
@Data
@EqualsAndHashCode
public class Width extends AbstractEntity {

    private Double value;

    @ManyToOne
    @JoinColumn(name="user_id",referencedColumnName = "id")
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
    public String toString(){
        return String.valueOf(value);
    }

}
