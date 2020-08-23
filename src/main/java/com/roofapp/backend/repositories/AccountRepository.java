package com.roofapp.backend.repositories;

import com.roofapp.backend.data.entity.Account;
import com.roofapp.backend.data.entity.Contractor;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AccountRepository extends JpaRepository<Account, Long> {

    List<Account> findByContractor(Contractor contractor);
}
