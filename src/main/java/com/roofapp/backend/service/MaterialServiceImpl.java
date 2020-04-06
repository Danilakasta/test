package com.roofapp.backend.service;

import com.roofapp.backend.data.entity.Material;
import com.roofapp.backend.repositories.MaterialRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
        }catch (Exception e){
            return null;
        }
    }

    @Override
    public void delete(Material item) {
       materialRepository.delete(item);
    }
}
