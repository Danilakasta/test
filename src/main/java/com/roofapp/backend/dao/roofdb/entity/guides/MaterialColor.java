package com.roofapp.backend.dao.roofdb.entity.guides;


import com.fasterxml.jackson.annotation.JsonFormat;
import com.roofapp.backend.dao.roofdb.entity.AbstractEntity;
import com.roofapp.backend.dao.roofdb.entity.User;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.util.Date;


@Entity
@Data
@Table(name = "material_color")
@EqualsAndHashCode
public class MaterialColor extends AbstractEntity {

    private String name;
    private String color;

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
        return String.valueOf(name);
    }

}
