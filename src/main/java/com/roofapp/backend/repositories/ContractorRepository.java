package com.roofapp.backend.repositories;

import com.roofapp.backend.data.entity.Contractor;
import com.roofapp.backend.data.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ContractorRepository extends JpaRepository<Contractor, Long> {
}
