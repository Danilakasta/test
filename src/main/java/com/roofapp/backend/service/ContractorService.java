package com.roofapp.backend.service;

import com.roofapp.backend.data.entity.Contractor;
import com.roofapp.backend.data.entity.Product;

import java.util.List;

public interface ContractorService {

    void save(Contractor contractor);

    List<Contractor> findAll();

    Contractor findById(Long id);

    void delete(Contractor contractor);
}
