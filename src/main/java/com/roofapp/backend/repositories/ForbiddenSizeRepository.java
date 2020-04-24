package com.roofapp.backend.repositories;

import com.roofapp.backend.data.entity.ForbiddenSize;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ForbiddenSizeRepository extends JpaRepository<ForbiddenSize, Long> {
    Page<ForbiddenSize> findBy(Pageable page);

}
