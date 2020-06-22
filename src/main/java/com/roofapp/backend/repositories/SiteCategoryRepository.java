package com.roofapp.backend.repositories;

import com.roofapp.backend.data.entity.parser.SiteCategory;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SiteCategoryRepository extends JpaRepository<SiteCategory, Long> {
}
