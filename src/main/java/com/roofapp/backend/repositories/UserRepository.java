package com.roofapp.backend.repositories;

import com.roofapp.backend.data.Role;
import com.roofapp.backend.data.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {

	User findByEmailIgnoreCase(String email);

	Page<User> findBy(Pageable pageable);

	Page<User> findByEmailLikeIgnoreCaseOrFirstNameLikeIgnoreCaseOrLastNameLikeIgnoreCase(
			String emailLike, String firstNameLike, String lastNameLike, Pageable pageable);

	long countByEmailLikeIgnoreCaseOrFirstNameLikeIgnoreCaseOrLastNameLikeIgnoreCase (
            String emailLike, String firstNameLike, String lastNameLike);
}
