package com.roofapp.backend.dao.roofdb.entity.parser;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity(name = "site_category")

public class SiteCategory {
    @Id
    @GeneratedValue(strategy= GenerationType.SEQUENCE)
    private Long id ;
    private String key;
    private String title;
    private String url;
    @Column(name = "img_path")
    private String imgPath;



    @OneToMany(cascade = {CascadeType.ALL}, orphanRemoval = true)
    @JoinColumn(name = "parent_id")
    private List<SiteCategory> subCategory;

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
