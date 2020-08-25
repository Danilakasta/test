package com.roofapp.backend.dao.roofdb.repositories;

import com.roofapp.backend.dao.roofdb.entity.ForbiddenSize;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ForbiddenSizeRepository extends JpaRepository<ForbiddenSize, Long> {
    Page<ForbiddenSize> findBy(Pageable page);

}
