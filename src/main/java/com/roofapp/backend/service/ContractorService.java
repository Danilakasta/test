package com.roofapp.backend.service;

import com.roofapp.backend.data.entity.Contractor;

import java.util.List;

public interface ContractorService {

    void save(Contractor contractor);

    void saveAll(List<Contractor> contractor);

    List<Contractor> findAll();

    Contractor findById(Long id);

    void delete(Contractor contractor);
}
