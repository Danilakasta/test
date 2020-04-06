package com.roofapp.backend.data.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.persistence.Version;
import java.io.Serializable;
import java.util.Objects;

@MappedSuperclass
@Data
@EqualsAndHashCode
public abstract class AbstractEntity implements Serializable {

	@Id
	@GeneratedValue
	private Long id;

	@Version
	private int version;


}
