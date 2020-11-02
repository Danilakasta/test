package com.roofapp.backend.service.guides;

import com.roofapp.backend.dao.roofdb.entity.Machine;
import com.roofapp.backend.dao.roofdb.entity.User;
import com.roofapp.backend.dao.roofdb.entity.guides.Width;
import com.roofapp.backend.dao.roofdb.repositories.WidthRepository;
import com.roofapp.backend.service.FilterableCrudService;
import com.roofapp.backend.service.UserFriendlyDataException;
import lombok.extern.java.Log;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@Log
public class WidthGuideService implements FilterableCrudService<Width> {

    private final WidthRepository widthRepository;

    public WidthGuideService(WidthRepository widthRepository) {
        this.widthRepository = widthRepository;
    }


    @Override
    public Page<Width> findAnyMatching(Optional<String> filter, Pageable pageable) {
        if (filter.isPresent()) {
            // String repositoryFilter = "%" + filter.get() + "%";
            return null; //widthRepository.findByValueLikeIgnoreCase(Double.valueOf(filter.get()), pageable);
        } else {
            return find(pageable);
        }
    }

    @Override
    public long countAnyMatching(Optional<String> filter) {
        if (filter.isPresent()) {
            // String repositoryFilter = "%" + filter.get() + "%";
            return 0;//widthRepository.countByValueLikeIgnoreCase(Double.valueOf(filter.get()));
        } else {
            return count();
        }
    }


    public Page<Width> find(Pageable pageable) {
        return widthRepository.findByOrderById(pageable);
    }


    @Override
    public JpaRepository<Width, Long> getRepository() {
        return widthRepository;
    }

    @Override
    public Width createNew(User currentUser) {
        return new Width();
    }

    @Override
    public Width save(User currentUser, Width entity) {
        try {
            return FilterableCrudService.super.save(currentUser, entity);
        } catch (DataIntegrityViolationException e) {
            throw new UserFriendlyDataException(
                    "There is already a Machine with that name.");
        }

    }

    @Override
    public List<Width> findAll() {
        return widthRepository.findAllByOrderByValue();
    }

    public Set<Width> getAllWidth() {
        return widthRepository.findAllByOrderByValue().stream().collect(Collectors.toSet());
    }


}
