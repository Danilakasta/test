package com.roofapp.backend.service;

import com.roofapp.backend.data.entity.Contractor;
import com.roofapp.backend.repositories.ContractorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class ContractorServiceImpl implements ContractorService {


    private final ContractorRepository contractorRepository;

    @Autowired
    public ContractorServiceImpl(ContractorRepository contractorRepository) {
        this.contractorRepository = contractorRepository;
    }

    @Override
    public void save(Contractor contractor) {
        contractorRepository.save(contractor);
    }

    @Override
    public List<Contractor> findAll() {
        return contractorRepository.findAll();
    }

    @Override
    public Contractor findById(Long id) {
        try {
            return contractorRepository.findById(id).get();
        }catch (Exception e){
            return null;
        }
    }

    @Override
    public void delete(Contractor contractor) {
       contractorRepository.delete(contractor);
    }
}
