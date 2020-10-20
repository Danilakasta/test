package com.roofapp.backend.dao.roofdb.repositories;

import com.roofapp.backend.dao.roofdb.entity.Machine;
import com.roofapp.backend.dao.roofdb.entity.guides.Width;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Set;

public interface WidthRepository extends JpaRepository<Width, Long> {

    //Set<Width> findAllByOrderByValue();

    List<Width> findAllByOrderByValue();

  //  Page<Width> findByValueLikeIgnoreCase(Double value, Pageable page);

 //   int countByValueLikeIgnoreCase(Double value);


    Page<Width> findByOrderById(Pageable page);


}

