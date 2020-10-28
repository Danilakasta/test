package com.roofapp.backend.service.guides;

import com.roofapp.backend.dao.roofdb.entity.User;
import com.roofapp.backend.dao.roofdb.entity.guides.Trimming;
import com.roofapp.backend.dao.roofdb.repositories.TrimmingRepository;
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
public class TrimmingGuideService implements FilterableCrudService<Trimming> {

    private final TrimmingRepository trimmingepository;

    public TrimmingGuideService(TrimmingRepository trimmingepository) {
        this.trimmingepository = trimmingepository;
    }





    @Override
    public Page<Trimming> findAnyMatching(Optional<String> filter, Pageable pageable) {
        if (filter.isPresent()) {
           // String repositoryFilter = "%" + filter.get() + "%";
            return  null; //TrimmingRepository.findByValueLikeIgnoreCase(Double.valueOf(filter.get()), pageable);
        } else {
            return find(pageable);
        }
    }

    @Override
    public long countAnyMatching(Optional<String> filter) {
        if (filter.isPresent()) {
           // String repositoryFilter = "%" + filter.get() + "%";
            return  0;//TrimmingRepository.countByValueLikeIgnoreCase(Double.valueOf(filter.get()));
        } else {
            return count();
        }
    }


    public Page<Trimming> find(Pageable pageable) {
        return  trimmingepository.findByOrderById(pageable);
    }


    @Override
    public JpaRepository<Trimming, Long> getRepository() {
        return trimmingepository;
    }

    @Override
    public Trimming createNew(User currentUser) {
        return new Trimming();
    }

    @Override
    public Trimming save(User currentUser, Trimming entity) {
        try {
            return FilterableCrudService.super.save(currentUser, entity);
        } catch (DataIntegrityViolationException e) {
            throw new UserFriendlyDataException(
                    "There is already a Machine with that name.");
        }

    }

    @Override
    public List<Trimming> findAll() {
        return trimmingepository.findAllByOrderById();
    }

    public Set<Trimming> getAllTrimming(){
        return trimmingepository.findAllByOrderById().stream().collect(Collectors.toSet());
    }
}
