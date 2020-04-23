package com.roofapp.backend.service;

import com.roofapp.app.security.CurrentUser;
import com.roofapp.backend.data.entity.Account;
import com.roofapp.backend.data.entity.User;
import com.roofapp.backend.repositories.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class AccountService implements FilterableCrudService<Account> {

    private final AccountRepository accountRepository;

    @Autowired
    public AccountService( AccountRepository accountRepository) {
        this.accountRepository = accountRepository;
    }


    @Override
    public JpaRepository<Account, Long> getRepository() {
        return accountRepository;
    }

    @Override
    public Account save(User currentUser, Account entity) {
        return accountRepository.save(entity);
    }

    @Override
    public void delete(User currentUser, Account entity) {
        accountRepository.delete(entity);
    }

    @Override
    public void delete(User currentUser, long id) {
        accountRepository.deleteById(id);
    }

    @Override
    public long count() {
        return accountRepository.count();
    }

    @Override
    public Account load(long id) {
        return null;
    }

    @Override
    public Account createNew(User currentUser) {
        return new Account();
    }

    @Override
    public Page<Account> findAnyMatching(Optional<String> filter, Pageable pageable) {
        return null;
    }

    @Override
    public long countAnyMatching(Optional<String> filter) {
        return 0;
    }

    public List<Account> findAll() {
        return accountRepository.findAll();
    }
}
