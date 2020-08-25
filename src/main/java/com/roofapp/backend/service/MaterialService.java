package com.roofapp.backend.service;

import com.roofapp.backend.dao.roofdb.entity.Material;

import java.util.List;

public interface MaterialService {

    void save(Material item);

    List<Material> findAll();

    Material findById(Long id);

    void delete(Material item);
}
