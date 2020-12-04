package com.roofapp.backend.dao.roofdb.repositories;

import com.roofapp.backend.dao.roofdb.entity.guides.MaterialColor;
import com.roofapp.backend.dao.roofdb.entity.guides.Width;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MaterialColorRepository extends JpaRepository<MaterialColor, Long> {


    List<MaterialColor> findAllByOrderByName();

    Page<MaterialColor> findByOrderById(Pageable page);


}

