package com.roofapp.backend.dao.roofdb.entity;

import com.roofapp.backend.dao.roofdb.Role;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.validation.constraints.*;
import java.util.Objects;

@Entity(name="Users")
public class User extends AbstractEntity {

	@NotEmpty
	@Email
	@Size(max = 255)
	@Column(unique = true)
	private String email;

	//@NotNull
	@Size(min = 4, max = 255)
	@Column(name = "password_hash")
	private String passwordHash;

	@NotBlank
	@Size(max = 255)
	@Column(name = "first_name")
	private String firstName;

	@NotBlank
	@Size(max = 255)
	@Column(name = "last_name")
	private String lastName;


	private Role role;

	private boolean locked = false;

	@PrePersist
	@PreUpdate
	private void prepareData(){
		this.email = email == null ? null : email.toLowerCase();
	}

	public User() {
		// An empty constructor is needed for all beans
	}

	public String getPasswordHash() {
		return passwordHash;
	}

	public void setPasswordHash(String passwordHash) {

		this.passwordHash = passwordHash;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public boolean isLocked() {
		return locked;
	}

	public void setLocked(boolean locked) {
		this.locked = locked;
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) {
			return true;
		}
		if (o == null || getClass() != o.getClass()) {
			return false;
		}
		if (!super.equals(o)) {
			return false;
		}
		User that = (User) o;
		return locked == that.locked &&
				Objects.equals(email, that.email) &&
				Objects.equals(firstName, that.firstName) &&
				Objects.equals(lastName, that.lastName) &&
				Objects.equals(role, that.role);
	}

	@Override
	public int hashCode() {
		return Objects.hash(super.hashCode(), email, firstName, lastName, role, locked);
	}

	@Override
	public String toString(){
		return firstName +" "+ lastName +" "+ email;
	}

}
