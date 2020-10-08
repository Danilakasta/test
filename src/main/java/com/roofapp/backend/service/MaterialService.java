package com.roofapp.backend.service;

import com.roofapp.backend.dao.roofdb.MaterialClass;
import com.roofapp.backend.dao.roofdb.MaterialCover;
import com.roofapp.backend.dao.roofdb.Width;
import com.roofapp.backend.dao.roofdb.entity.Material;

import java.util.Date;
import java.util.List;

public interface MaterialService {

    void save(Material item);

    List<Material> findAll();

    Material findById(Long id);

    void delete(Material item);

    List<Material> findByWidthEqualsAndCoverEqualsAndMaterialClassEquals(Width width, MaterialCover materialCover, MaterialClass materialClass);

    List<Material> findAllByCreatedAfter(Date date);
}
