package com.roofapp.backend.dao.roofdb.repositories;

import com.roofapp.backend.dao.roofdb.entity.guides.Trimming;
import com.roofapp.backend.dao.roofdb.entity.guides.Width;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TrimmingRepository extends JpaRepository<Trimming, Long> {

    List<Trimming> findAllByOrderById();

    Page<Trimming> findByOrderById(Pageable page);


}

