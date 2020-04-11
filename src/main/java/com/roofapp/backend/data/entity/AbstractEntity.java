package com.roofapp.backend.data.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Objects;

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
