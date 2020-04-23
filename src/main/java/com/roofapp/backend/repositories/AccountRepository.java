package com.roofapp.backend.repositories;

import com.roofapp.backend.data.entity.Account;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AccountRepository extends JpaRepository<Account, Long> {
}
