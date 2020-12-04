package com.roofapp.backend.service.guides;

import com.roofapp.backend.dao.roofdb.entity.User;
import com.roofapp.backend.dao.roofdb.entity.guides.MaterialColor;
import com.roofapp.backend.dao.roofdb.repositories.MaterialColorRepository;
import com.roofapp.backend.service.FilterableCrudService;
import com.roofapp.backend.service.UserFriendlyDataException;
import lombok.extern.java.Log;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@Log
public class MaterialColorGuideService implements FilterableCrudService<MaterialColor> {

    private final MaterialColorRepository materialColorRepository;

    public MaterialColorGuideService( MaterialColorRepository materialColor) {
        this.materialColorRepository = materialColor;
    }


    @Override
    public Page<MaterialColor> findAnyMatching(Optional<String> filter, Pageable pageable) {
        if (filter.isPresent()) {
            // String repositoryFilter = "%" + filter.get() + "%";
            return null; //MaterialColorRepository.findByValueLikeIgnoreCase(Double.valueOf(filter.get()), pageable);
        } else {
            return find(pageable);
        }
    }

    public Page<MaterialColor> find(Pageable pageable) {
        return materialColorRepository.findByOrderById(pageable);
    }

    @Override
    public long countAnyMatching(Optional<String> filter) {
        if (filter.isPresent()) {
            // String repositoryFilter = "%" + filter.get() + "%";
            return 0;//MaterialColorRepository.countByValueLikeIgnoreCase(Double.valueOf(filter.get()));
        } else {
            return count();
        }
    }

    

    @Override
    public JpaRepository<MaterialColor, Long> getRepository() {
        return materialColorRepository;
    }

    @Override
    public MaterialColor createNew(User currentUser) {
        return new MaterialColor();
    }

    @Override
    public MaterialColor save(User currentUser, MaterialColor entity) {
        try {
            return FilterableCrudService.super.save(currentUser, entity);
        } catch (DataIntegrityViolationException e) {
            throw new UserFriendlyDataException(
                    "There is already a Machine with that name.");
        }

    }

    @Override
    public List<MaterialColor> findAll() {
        return materialColorRepository.findAllByOrderByName();
    }

    public Set<MaterialColor> getAllMaterialColor() {
        return materialColorRepository.findAllByOrderByName().stream().collect(Collectors.toSet());
    }


}
