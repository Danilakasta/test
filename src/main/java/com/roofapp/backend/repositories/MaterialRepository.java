package com.roofapp.backend.repositories;

import com.roofapp.backend.data.entity.Material;
import com.roofapp.backend.data.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MaterialRepository extends JpaRepository<Material, Long> {

}
