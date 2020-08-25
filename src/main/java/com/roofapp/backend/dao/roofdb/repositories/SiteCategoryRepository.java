package com.roofapp.backend.dao.roofdb.repositories;

import com.roofapp.backend.dao.roofdb.entity.parser.SiteCategory;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SiteCategoryRepository extends JpaRepository<SiteCategory, Long> {
}
