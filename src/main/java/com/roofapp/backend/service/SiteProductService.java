package com.roofapp.backend.service;

import com.roofapp.backend.data.entity.User;
import com.roofapp.backend.data.entity.parser.SiteProduct;
import com.roofapp.backend.repositories.SiteProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;


@Service
public class SiteProductService implements FilterableCrudService<SiteProduct>  {


    private final SiteProductRepository productRepository;

    @Autowired
    public SiteProductService(SiteProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public void save(SiteProduct product) {
        productRepository.save(product);
    }


    public List<SiteProduct> findAll() {
        return productRepository.findAll();
    }



    public SiteProduct findById(Long id) {
        try {
            return productRepository.findById(id).get();
        }catch (Exception e){
            return null;
        }
    }

    public void delete(SiteProduct product) {
       productRepository.delete(product);
    }


    @Override
    public Page<SiteProduct> findAnyMatching(Optional<String> filter, Pageable pageable) {
        if (filter.isPresent()) {
            String repositoryFilter = "%" + filter.get() + "%";
            return productRepository.findByTitleLikeIgnoreCase(repositoryFilter, pageable);
        } else {
            return find(pageable);
        }
    }

    @Override
    public long countAnyMatching(Optional<String> filter) {
        if (filter.isPresent()) {
            String repositoryFilter = "%" + filter.get() + "%";
            return productRepository.countByTitleLikeIgnoreCase(repositoryFilter);
        } else {
            return count();
        }
    }



    public Page<SiteProduct> find(Pageable pageable) {
        return productRepository.findBy(pageable);
    }

    @Override
    public JpaRepository<SiteProduct, Long> getRepository() {
        return productRepository;
    }

    @Override
    public SiteProduct createNew(User currentUser) {
        return SiteProduct.builder().build();
    }

    @Override
    public SiteProduct save(User currentUser, SiteProduct entity) {
        try {
            return FilterableCrudService.super.save(currentUser, entity);
        } catch (DataIntegrityViolationException e) {
            throw new UserFriendlyDataException(
                    "There is already a product with that name. Please select a unique name for the product.");
        }

    }

}
