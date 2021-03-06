package com.roofapp.backend.service;

import com.roofapp.backend.dao.roofdb.entity.PickupLocation;
import com.roofapp.backend.dao.roofdb.entity.User;
import com.roofapp.backend.dao.roofdb.repositories.PickupLocationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PickupLocationService implements FilterableCrudService<PickupLocation> {

    private final PickupLocationRepository pickupLocationRepository;

    @Autowired
    public PickupLocationService(PickupLocationRepository pickupLocationRepository) {
        this.pickupLocationRepository = pickupLocationRepository;
    }

    public Page<PickupLocation> findAnyMatching(Optional<String> filter, Pageable pageable) {
        if (filter.isPresent()) {
            String repositoryFilter = "%" + filter.get() + "%";
            return pickupLocationRepository.findByNameLikeIgnoreCase(repositoryFilter, pageable);
        } else {
            return pickupLocationRepository.findAll(pageable);
        }
    }

    public long countAnyMatching(Optional<String> filter) {
        if (filter.isPresent()) {
            String repositoryFilter = "%" + filter.get() + "%";
            return pickupLocationRepository.countByNameLikeIgnoreCase(repositoryFilter);
        } else {
            return pickupLocationRepository.count();
        }
    }


    public PickupLocation getDefault() {
        return findAnyMatching(Optional.empty(), PageRequest.of(0, 1)).iterator().next();
    }

    @Override
    public JpaRepository<PickupLocation, Long> getRepository() {
        return pickupLocationRepository;
    }

    @Override
    public PickupLocation createNew(User currentUser) {
        return new PickupLocation();
    }

    @Override
    public List<PickupLocation> findAll() {
        return null;
    }

   public Optional<PickupLocation> findById(Long id) {
        return pickupLocationRepository.findById(id);
    }
}
