package com.roofapp.backend.data.entity;

import com.roofapp.backend.data.ContractorType;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity(name="Contractors")
@Data
@EqualsAndHashCode
public class Contractor {

    @Id
    @GeneratedValue(strategy=GenerationType.SEQUENCE)
    private Long id;

   // @Size(min = 2, message = "")
   private String companyName;

    private ContractorType type = ContractorType.UR;

    private String phone;

    private String email;

    private String urAddress;

    private String fizAddress;

    private Integer inn;

    private Integer kpp;

    private Integer okpo;

    private Integer ogrn;

    public boolean isNew() {
        return  this.id == null;
    }


}
