package com.roofapp.backend.service;

import com.roofapp.backend.dao.roofdb.MaterialClass;
import com.roofapp.backend.dao.roofdb.MaterialCover;
import com.roofapp.backend.dao.roofdb.entity.Material;
import com.roofapp.backend.dao.roofdb.entity.guides.Width;
import com.roofapp.backend.dao.roofdb.repositories.MaterialRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@Service
public class MaterialServiceImpl implements MaterialService {


    private final MaterialRepository materialRepository;

    @Autowired
    public MaterialServiceImpl(MaterialRepository MaterialRepository) {
        this.materialRepository = MaterialRepository;
    }

    @Override
    public void save(Material item) {
        materialRepository.save(item);
    }

    @Override
    public List<Material> findAll() {
        return materialRepository.findAll();
    }

    @Override
    public Material findById(Long id) {
        try {
            return materialRepository.findById(id).get();
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public void delete(Material item) {
        materialRepository.delete(item);
    }


    @Override
    public List<Material> findByWidthEqualsAndCoverEqualsAndMaterialClassEquals(Width width, MaterialCover materialCover, MaterialClass materialClass) {
        try {
            return materialRepository.findAllByWidthEqualsAndCoverEqualsAndMaterialClassEquals(width, materialCover, materialClass);
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }


    @Override
    public List<Material> findAllByCreatedAfter(Date date) {
        try {
            return materialRepository.findAllByCreatedAfter(date);
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }

    @Override
    @Transactional(readOnly = true)
    public List<Material> findAllByRemains() {
        try {
            return materialRepository.findAllByRemainsGreaterThanOrderByWidth(0D);
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }

}
