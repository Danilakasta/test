package com.roofapp.backend.dao.roofdb.entity;

import com.roofapp.backend.dao.roofdb.ContractorSubType;
import com.roofapp.backend.dao.roofdb.ContractorType;
import lombok.*;

import javax.persistence.*;
import java.util.Objects;

@Entity(name = "Contractors")
//@Data
//@EqualsAndHashCode
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Contractor that = (Contractor) o;
        return Objects.equals(id, that.id) &&
                Objects.equals(name, that.name) &&
                type == that.type &&
                contractorSubType == that.contractorSubType &&
                Objects.equals(phone, that.phone) &&
                Objects.equals(email, that.email) &&
                Objects.equals(urAddress, that.urAddress) &&
                Objects.equals(fizAddress, that.fizAddress) &&
                Objects.equals(inn, that.inn) &&
                Objects.equals(kpp, that.kpp) &&
                Objects.equals(okpo, that.okpo) &&
                Objects.equals(ogrn, that.ogrn) &&
                Objects.equals(deliveryAddress, that.deliveryAddress);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, type, contractorSubType, phone, email, urAddress, fizAddress, inn, kpp, okpo, ogrn, deliveryAddress);
    }
}
