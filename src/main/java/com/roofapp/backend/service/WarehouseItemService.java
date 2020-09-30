package com.roofapp.backend.service;

import com.roofapp.backend.dao.roofdb.entity.User;
import com.roofapp.backend.dao.roofdb.entity.WarehouseItem;
import com.roofapp.backend.dao.roofdb.repositories.WarehouseItemsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;


@Service
public class WarehouseItemService implements FilterableCrudService<WarehouseItem>  {


    private final WarehouseItemsRepository warehouseItemsRepository;

    @Autowired
    public WarehouseItemService(WarehouseItemsRepository  warehouseItemsRepository) {
        this.warehouseItemsRepository = warehouseItemsRepository;;
    }

    public void save(WarehouseItem item) {
        warehouseItemsRepository.save(item);
    }


    public List<WarehouseItem> findAll() {
        return warehouseItemsRepository.findAll();
    }


    public WarehouseItem findById(Long id) {
        try {
            return warehouseItemsRepository.findById(id).get();
        }catch (Exception e){
            return null;
        }
    }

    public void delete(WarehouseItem item) {
       warehouseItemsRepository.delete(item);
    }


    @Override
    public Page<WarehouseItem> findAnyMatching(Optional<String> filter, Pageable pageable) {
        if (filter.isPresent()) {
            String repositoryFilter = "%" + filter.get() + "%";
            return null;// warehouseItemsRepository.findByNameLikeIgnoreCase(repositoryFilter, pageable);
        } else {
            return find(pageable);
        }
    }

    @Override
    public long countAnyMatching(Optional<String> filter) {
        if (filter.isPresent()) {
            String repositoryFilter = "%" + filter.get() + "%";
            return 0l;// warehouseItemsRepository.countByNameLikeIgnoreCase(repositoryFilter);
        } else {
            return count();
        }
    }



    public Page<WarehouseItem> find(Pageable pageable) {
        return warehouseItemsRepository.findBy(pageable);
    }

    @Override
    public JpaRepository<WarehouseItem, Long> getRepository() {
        return warehouseItemsRepository;
    }

    @Override
    public WarehouseItem createNew(User currentUser) {
        return new WarehouseItem();
    }

    @Override
    public WarehouseItem save(User currentUser, WarehouseItem entity) {
        try {
            return FilterableCrudService.super.save(currentUser, entity);
        } catch (DataIntegrityViolationException e) {
            throw new UserFriendlyDataException(
                    "There is already a product with that name. Please select a unique name for the product.");
        }

    }



}
