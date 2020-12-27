package com.roofapp.backend.service.guides;

import com.roofapp.backend.dao.roofdb.entity.User;
import com.roofapp.backend.dao.roofdb.entity.guides.WarehouseType;
import com.roofapp.backend.dao.roofdb.repositories.WarehouseTypeRepository;
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
public class WarehouseTypeGuideService implements FilterableCrudService<WarehouseType> {

    private final WarehouseTypeRepository WarehouseTypeRepository;

    public WarehouseTypeGuideService(WarehouseTypeRepository WarehouseType) {
        this.WarehouseTypeRepository = WarehouseType;
    }


    @Override
    public Page<WarehouseType> findAnyMatching(Optional<String> filter, Pageable pageable) {
        if (filter.isPresent()) {
            // String repositoryFilter = "%" + filter.get() + "%";
            return null; //WarehouseTypeRepository.findByValueLikeIgnoreCase(Double.valueOf(filter.get()), pageable);
        } else {
            return find(pageable);
        }
    }

    public Page<WarehouseType> find(Pageable pageable) {
        return WarehouseTypeRepository.findByOrderById(pageable);
    }

    @Override
    public long countAnyMatching(Optional<String> filter) {
        if (filter.isPresent()) {
            // String repositoryFilter = "%" + filter.get() + "%";
            return 0;//WarehouseTypeRepository.countByValueLikeIgnoreCase(Double.valueOf(filter.get()));
        } else {
            return count();
        }
    }


    @Override
    public JpaRepository<WarehouseType, Long> getRepository() {
        return WarehouseTypeRepository;
    }

    @Override
    public WarehouseType createNew(User currentUser) {
        return new WarehouseType();
    }

    @Override
    public WarehouseType save(User currentUser, WarehouseType entity) {
        try {
            return FilterableCrudService.super.save(currentUser, entity);
        } catch (DataIntegrityViolationException e) {
            throw new UserFriendlyDataException(
                    "There is already a Machine with that name.");
        }

    }

    @Override
    public List<WarehouseType> findAll() {
        return WarehouseTypeRepository.findAllByOrderByName();
    }

    public Set<WarehouseType> getAllWarehouseType() {
        return WarehouseTypeRepository.findAllByOrderByName().stream().collect(Collectors.toSet());
    }


}
