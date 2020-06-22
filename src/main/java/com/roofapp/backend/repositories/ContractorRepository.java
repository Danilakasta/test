package com.roofapp.backend.repositories;

import com.roofapp.backend.data.entity.Contractor;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ContractorRepository extends JpaRepository<Contractor, Long> {
}
