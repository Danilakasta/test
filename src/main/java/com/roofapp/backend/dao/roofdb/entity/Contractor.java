package com.roofapp.backend.dao.roofdb.entity;

import com.roofapp.backend.dao.roofdb.ContractorSubType;
import com.roofapp.backend.dao.roofdb.ContractorType;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.*;

@Entity(name = "Contractors")
@Data
@EqualsAndHashCode
public class Contractor {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    // @Size(min = 2, message = "")
    private String name;

    //  @NotNull
    private ContractorType type = ContractorType.UR;

    //@NotNull
    @Column(name = "contractor_sub_type")
    private ContractorSubType contractorSubType;

    //   @NotNull
    private String phone;

    //   @NotNull
    private String email;
    @Column(name = "ur_address")
    private String urAddress;
    @Column(name = "fiz_address")
    private String fizAddress;

    private Integer inn;

    private Integer kpp;

    private Integer okpo;

    private Integer ogrn;

    @Column(name = "delivery_address")
    private String deliveryAddress;

    //private Integer bankAccount ;

    public boolean isNew() {
        return this.id == null;
    }


    @Override
    public String toString() {
        return  name;
    }

}
