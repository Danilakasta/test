package com.roofapp.backend.repositories;

import com.roofapp.backend.data.entity.Machine;
import com.roofapp.backend.data.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MachineRepository extends JpaRepository<Machine, Long> {
    Page<Machine> findBy(Pageable page);

    Page<Machine> findByNameLikeIgnoreCase(String name, Pageable page);

    int countByNameLikeIgnoreCase(String name);
}
