package com.roofapp.backend.data.entity;

import com.roofapp.backend.data.ContractorSubType;
import com.roofapp.backend.data.ContractorType;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.NotNull;

@Entity(name = "Contractors")
@Data
@EqualsAndHashCode
public class Contractor {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    // @Size(min = 2, message = "")
    private String name;

    @NotNull
    private ContractorType type = ContractorType.UR;

    //@NotNull
    private  ContractorSubType contractorSubType;

    @NotNull
    private String phone;

    @NotNull
    private String email;

    private String urAddress;

    private String fizAddress;

    private Integer inn;

    private Integer kpp;

    private Integer okpo;

    private Integer ogrn;


    private String deliveryAddress;

    //private Integer bankAccount ;

    public boolean isNew() {
        return this.id == null;
    }


}
