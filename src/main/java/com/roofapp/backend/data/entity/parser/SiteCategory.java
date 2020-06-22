package com.roofapp.backend.data.entity.parser;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.util.Date;

@Data
@Builder
@Entity
@AllArgsConstructor
@NoArgsConstructor
public class SiteCategory {
    @Id
    @GeneratedValue(strategy= GenerationType.SEQUENCE)
    private Long id ;
    private String key;
    private String title;
    private String url;
    private String imgPath;

    @Column(name = "created")
    @CreationTimestamp
    @Temporal(TemporalType.TIMESTAMP)
    private Date created;

    @Column(name = "modified")
    @UpdateTimestamp
    @Temporal(TemporalType.TIMESTAMP)
    private Date modified;


    @Override
    public String toString() {
        return title;
    }

}
