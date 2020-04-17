package com.roofapp.backend.service;

import com.roofapp.backend.data.entity.Machine;
import com.roofapp.backend.data.entity.User;
import com.roofapp.backend.repositories.MachineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;


@Service
public class MachineService implements FilterableCrudService<Machine>  {


    private final MachineRepository MachineRepository;

    @Autowired
    public MachineService(MachineRepository MachineRepository) {
        this.MachineRepository = MachineRepository;
    }

    public void save(Machine Machine) {
        MachineRepository.save(Machine);
    }


    public List<Machine> findAll() {
        return MachineRepository.findAll();
    }


    public Machine findById(Long id) {
        try {
            return MachineRepository.findById(id).get();
        }catch (Exception e){
            return null;
        }
    }

    public void delete(Machine Machine) {
       MachineRepository.delete(Machine);
    }


    @Override
    public Page<Machine> findAnyMatching(Optional<String> filter, Pageable pageable) {
        if (filter.isPresent()) {
            String repositoryFilter = "%" + filter.get() + "%";
            return MachineRepository.findByNameLikeIgnoreCase(repositoryFilter, pageable);
        } else {
            return find(pageable);
        }
    }

    @Override
    public long countAnyMatching(Optional<String> filter) {
        if (filter.isPresent()) {
            String repositoryFilter = "%" + filter.get() + "%";
            return MachineRepository.countByNameLikeIgnoreCase(repositoryFilter);
        } else {
            return count();
        }
    }


    public Page<Machine> find(Pageable pageable) {
        return MachineRepository.findBy(pageable);
    }

    @Override
    public JpaRepository<Machine, Long> getRepository() {
        return MachineRepository;
    }

    @Override
    public Machine createNew(User currentUser) {
        return new Machine();
    }

    @Override
    public Machine save(User currentUser, Machine entity) {
        try {
            return FilterableCrudService.super.save(currentUser, entity);
        } catch (DataIntegrityViolationException e) {
            throw new UserFriendlyDataException(
                    "There is already a Machine with that name. Please select a unique name for the Machine.");
        }

    }

}
