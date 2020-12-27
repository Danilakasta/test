package com.roofapp.backend.dao.roofdb.repositories;

import com.roofapp.backend.dao.roofdb.entity.guides.WarehouseType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface WarehouseTypeRepository extends JpaRepository<WarehouseType, Long> {


    List<WarehouseType> findAllByOrderByName();

    Page<WarehouseType> findByOrderById(Pageable page);


}

