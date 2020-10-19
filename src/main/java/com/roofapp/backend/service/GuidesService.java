package com.roofapp.backend.service;

import com.roofapp.backend.dao.roofdb.entity.guides.Width;
import com.roofapp.backend.dao.roofdb.repositories.WidthRepository;
import lombok.extern.java.Log;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@Log
public class GuidesService {

    private final WidthRepository widthRepository;

    public GuidesService(WidthRepository widthRepository) {
        this.widthRepository = widthRepository;
    }


    public Set<Width> getAllWidth(){
        return widthRepository.findAllByOrderByValue();
    }

}
