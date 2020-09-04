package com.roofapp.backend.dao.roofdb.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.*;
import java.io.Serializable;

@MappedSuperclass
@EqualsAndHashCode
//@Data
public abstract class AbstractEntity implements Serializable {

	@Id
	@GeneratedValue(strategy= GenerationType.AUTO)
	@Column(name="id", unique = true, nullable = false)
	private Long id;

//	@Version
	//private int version;

	public boolean isNew() {
		return id == null;
	}


	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public AbstractEntity(Long id) {
		this.id = id;
	}

	public AbstractEntity() {
	}
}
