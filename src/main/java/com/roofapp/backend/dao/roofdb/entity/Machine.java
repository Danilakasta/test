package com.roofapp.backend.dao.roofdb.entity;

import com.roofapp.backend.dao.roofdb.entity.guides.Width;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.HashSet;
import java.util.Set;

@Entity
@Data
@EqualsAndHashCode
@ToString
public class Machine extends AbstractEntity {

    @NotNull(message = "Заполните тип станка")
    private String name;

    @NotNull(message = "Заполнитедлинну стана")
    private int length = 0;


    @ManyToMany(fetch = FetchType.EAGER, cascade = {CascadeType.MERGE})
    @JoinTable(name = "machine_width",
            joinColumns = @JoinColumn(name = "machine_id", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "width_id", nullable = false))
    @NotNull(message = "Заполните допустимые толщины")
    private Set<Width> allowableSize = new HashSet<>();

    @Override
    public String toString() {
        return name;
    }
}
