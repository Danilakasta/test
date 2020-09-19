package com.roofapp.backend.service;

import com.roofapp.backend.dao.roofdb.entity.Manufacturers;
import com.roofapp.backend.dao.roofdb.entity.Product;
import com.roofapp.backend.dao.roofdb.entity.User;
import com.roofapp.backend.dao.roofdb.repositories.ManufacturerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;


@Service
public class ManufacturerService implements FilterableCrudService<Manufacturers>  {


    private final ManufacturerRepository manufacturerRepository;

    @Autowired
    public ManufacturerService(ManufacturerRepository manufacturerRepositor) {
        this.manufacturerRepository = manufacturerRepositor;
    }

    public void save(Manufacturers Manufacturers) {
        manufacturerRepository.save(Manufacturers);
    }


    public List<Manufacturers> findAll() {
        return manufacturerRepository.findAll();
    }
    

    public Manufacturers findById(Long id) {
        try {
            return manufacturerRepository.findById(id).get();
        }catch (Exception e){
            return null;
        }
    }

    public void delete(Manufacturers Manufacturers) {
       manufacturerRepository.delete(Manufacturers);
    }

    public List<Manufacturers> findAllSortedOrders() {
        return manufacturerRepository.findOrdersOrder();
    }

    @Override
    public Page<Manufacturers> findAnyMatching(Optional<String> filter, Pageable pageable) {
        if (filter.isPresent()) {
            String repositoryFilter = "%" + filter.get() + "%";
            return manufacturerRepository.findByNameLikeIgnoreCase(repositoryFilter, pageable);
        } else {
            return find(pageable);
        }
    }

    @Override
    public long countAnyMatching(Optional<String> filter) {
        if (filter.isPresent()) {
            String repositoryFilter = "%" + filter.get() + "%";
            return manufacturerRepository.countByNameLikeIgnoreCase(repositoryFilter);
        } else {
            return count();
        }
    }



    public Page<Manufacturers> find(Pageable pageable) {
        return manufacturerRepository.findBy(pageable);
    }

    @Override
    public JpaRepository<Manufacturers, Long> getRepository() {
        return manufacturerRepository;
    }

    @Override
    public Manufacturers createNew(User currentUser) {
        return new Manufacturers();
    }

    @Override
    public Manufacturers save(User currentUser, Manufacturers entity) {
        try {
            return FilterableCrudService.super.save(currentUser, entity);
        } catch (DataIntegrityViolationException e) {
            throw new UserFriendlyDataException(
                    "There is already a Manufacturers with that name. Please select a unique name for the Manufacturers.");
        }

    }

}
