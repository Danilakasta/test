package com.roofapp.backend.service;

import com.roofapp.backend.dao.roofdb.entity.Contractor;

import java.util.List;

public interface ContractorService {

    void save(Contractor contractor);

    void saveAll(List<Contractor> contractor);

    List<Contractor> findAll();

    List<Contractor> findAllOrderName();

    Contractor findById(Long id);

    void delete(Contractor contractor);
}
