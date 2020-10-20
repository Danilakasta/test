package com.roofapp.backend.dao.roofdb.entity.guides;


import com.roofapp.backend.dao.roofdb.entity.AbstractEntity;
import com.roofapp.backend.dao.roofdb.entity.User;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.util.Date;

/**
 * Торцовка
 */
@Entity
@Data
@EqualsAndHashCode
public class Trimming extends AbstractEntity {

    @ManyToOne
    @JoinColumn(name="width_id",referencedColumnName = "id")
    private Width width;

    private Double value;

    @ManyToOne
    @JoinColumn(name="user_id",referencedColumnName = "id")
    private User user;

    @Column(name = "created")
    @CreationTimestamp
    @Temporal(TemporalType.TIMESTAMP)
    private Date created;

    @Column(name = "modified")
    @UpdateTimestamp
    @Temporal(TemporalType.TIMESTAMP)
    private Date modified;


    @Override
    public String toString(){
        return String.valueOf(value);
    }

}
