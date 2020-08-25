package com.roofapp.backend.service;

import com.roofapp.backend.dao.roofdb.entity.ForbiddenSize;
import com.roofapp.backend.dao.roofdb.entity.User;
import com.roofapp.backend.dao.roofdb.repositories.ForbiddenSizeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ForbiddenSizeService implements FilterableCrudService<ForbiddenSize> {

    private final ForbiddenSizeRepository forbiddenSizeRepository;

    @Autowired
    public ForbiddenSizeService(ForbiddenSizeRepository forbiddenSizeRepository) {
        this.forbiddenSizeRepository = forbiddenSizeRepository;
    }

    @Override
    public Page<ForbiddenSize> findAnyMatching(Optional<String> filter, Pageable pageable) {
        return null;
    }

    @Override
    public long countAnyMatching(Optional<String> filter) {
        return 0;
    }

    @Override
    public JpaRepository<ForbiddenSize, Long> getRepository() {
        return null;
    }

    @Override
    public ForbiddenSize save(User currentUser, ForbiddenSize entity) {
        return forbiddenSizeRepository.save(entity);
    }

    @Override
    public void delete(User currentUser, ForbiddenSize entity) {
        forbiddenSizeRepository.delete(entity);
    }

    @Override
    public void delete(User currentUser, long id) {
        forbiddenSizeRepository.deleteById(id);
    }

    @Override
    public long count() {
        return forbiddenSizeRepository.count();
    }

    @Override
    public ForbiddenSize load(long id) {
        return null;
    }

    @Override
    public ForbiddenSize createNew(User currentUser) {
        return new ForbiddenSize();
    }

    @Override
    public List<ForbiddenSize> findAll() {
        return null;
    }

    public List<ForbiddenSize> getFindAll() {
        return forbiddenSizeRepository.findAll();
    }
}
