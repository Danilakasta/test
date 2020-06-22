package com.roofapp.backend.data.entity.parser;

import com.roofapp.backend.data.entity.AbstractEntity;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.util.Date;

@Data
@Builder
@Entity
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class SiteProduct extends AbstractEntity {
    @Id
    @GeneratedValue(strategy= GenerationType.SEQUENCE)
    private Long id ;
    private String path;
    private String title;
    private String prop;
    private String price;
    private String fullPrice;
    private String imgPath;



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
