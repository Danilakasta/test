package com.roofapp.ui.views.guides;


import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Setter
@Getter
public class Person {
     Integer id;
     String  firstName;

    public Person(Integer id, String firstName) {
        this.id = id;
        this.firstName = firstName;
    }
}
