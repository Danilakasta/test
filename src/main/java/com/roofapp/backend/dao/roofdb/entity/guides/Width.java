package com.roofapp.backend.dao.roofdb.entity.guides;


import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.roofapp.backend.dao.roofdb.entity.AbstractEntity;
import com.roofapp.backend.dao.roofdb.entity.Machine;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.*;


@Entity
@Data
@EqualsAndHashCode
public class Width extends AbstractEntity {

    private Double value;

   /* @ManyToMany( fetch = FetchType.EAGER, mappedBy = "allowableSize")
   // @Fetch(FetchMode.JOIN)
            @JsonIgnore
    Set<Machine> machines = new HashSet<>();
*/
    @Override
    public String toString(){
        return String.valueOf(value);
    }

}
