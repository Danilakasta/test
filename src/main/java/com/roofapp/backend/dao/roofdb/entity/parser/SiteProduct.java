package com.roofapp.backend.dao.roofdb.entity.parser;

import com.roofapp.backend.dao.roofdb.entity.AbstractEntity;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.util.Date;

@Data
@Builder
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Entity(name = "site_product")
public class SiteProduct extends AbstractEntity {
    @Id
    @GeneratedValue(strategy= GenerationType.SEQUENCE)
    private Long id ;
    private String path;
    private String title;
    private String prop;
    private String price;

    @Column(name = "full_price")
    private String fullPrice;

    @Column(name = "img_path")
    private String imgPath;

    @Column(name = "site_name")
    private String siteName;

    @ManyToOne(cascade = {CascadeType.ALL})
    private SiteCategory category;

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
        return category.getTitle() + ";" +
                title + ";" +
                 prop + ";" +
                 price + ";" +
                 fullPrice + ";" +
                imgPath + ";" +
                category.getUrl() + ";"+System.lineSeparator()
                ;
    }



}
