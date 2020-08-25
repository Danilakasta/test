package com.roofapp.backend.dao.roofdb.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.*;
import java.io.Serializable;

@MappedSuperclass
@Data
@EqualsAndHashCode
public abstract class AbstractEntity implements Serializable {

	@Id
	@GeneratedValue(strategy= GenerationType.SEQUENCE)
	private Long id;

//	@Version
	//private int version;

	public boolean isNew() {
		return id == null;
	}
}
