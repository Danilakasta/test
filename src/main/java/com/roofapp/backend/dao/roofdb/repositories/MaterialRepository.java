package com.roofapp.backend.dao.roofdb.repositories;

import com.roofapp.backend.dao.roofdb.MaterialClass;
import com.roofapp.backend.dao.roofdb.MaterialCover;
import com.roofapp.backend.dao.roofdb.Width;
import com.roofapp.backend.dao.roofdb.entity.Material;
import org.springframework.data.jpa.repository.JpaRepository;
import org.w3c.dom.stylesheets.LinkStyle;

import java.util.Date;
import java.util.List;

public interface MaterialRepository extends JpaRepository<Material, Long> {

    List<Material> findAllByWidthEqualsAndCoverEqualsAndMaterialClassEquals(Width width, MaterialCover materialCover, MaterialClass materialClass);

    List<Material> findAllByCreatedAfter(Date date);

    List<Material> findAllByRemainsGreaterThan(Double aDouble);

}
