package com.roofapp.backend.service;

import com.roofapp.backend.dao.roofdb.MaterialClass;
import com.roofapp.backend.dao.roofdb.MaterialCover;
import com.roofapp.backend.dao.roofdb.entity.Material;
import com.roofapp.backend.dao.roofdb.entity.guides.Width;
import org.springframework.cache.annotation.Cacheable;

import java.util.Date;
import java.util.List;

public interface MaterialService {

    void save(Material item);

    List<Material> findAll();

    Material findById(Long id);

    void delete(Material item);

    List<Material> findByWidthEqualsAndCoverEqualsAndMaterialClassEquals(Width width, MaterialCover materialCover, MaterialClass materialClass);

    List<Material> findAllByCreatedAfter(Date date);

    @Cacheable("materials")
    List<Material> findAllByRemains();
}
