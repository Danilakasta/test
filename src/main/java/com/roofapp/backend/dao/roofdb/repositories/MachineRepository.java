package com.roofapp.backend.dao.roofdb.repositories;

import com.roofapp.backend.dao.roofdb.entity.Machine;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MachineRepository extends JpaRepository<Machine, Long> {
    Page<Machine> findByOrderById(Pageable page);

    Page<Machine> findByNameLikeIgnoreCase(String name, Pageable page);

    int countByNameLikeIgnoreCase(String name);

    List<Machine> findAllByOrderById();

}
