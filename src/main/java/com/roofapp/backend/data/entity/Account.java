package com.roofapp.backend.data.entity;


import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.math.BigInteger;

@Entity(name = "account")
@Data
@EqualsAndHashCode
public class Account extends AbstractEntity {

    //счет
    @NotNull
    @Size(max = 20, message = "неверный счет")
    private String value;

    //Кор счет
     @Size(max = 20, message = "неверный кор счет")
    @NotNull
    private String corrAccount;

    //банк получателя
    @NotNull
    private String bankName;

    //Инн банка получателя
   // @Size(min=10, max = 10, message = "неверный инн")
    @NotNull
    private Integer inn;

    //Бик банка получателя
   // @Size(min=9, max = 9, message = "неверный бик")
    @NotNull
    private Integer bik;



    //Код подразделения
    private Integer code;

    //Адрес подразделения банка
    private String departAddress;

    //Получатель
    @ManyToOne
    @NotNull
    private Contractor contractor;

}
