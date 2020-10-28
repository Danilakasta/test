package com.roofapp.backend.dao.roofdb.entity;

import com.roofapp.backend.dao.roofdb.OrderState;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity(name="history_item")
@AllArgsConstructor
public class HistoryItem extends AbstractEntity {

	@Column(name = "new_state")
	private OrderState newState;

	@NotBlank
	@Size(max = 255)
	private String message;

	//@NotNull
	private LocalDateTime timestamp;
	@ManyToOne
	@JoinColumn(name="created_by_id",referencedColumnName = "id")
	private User createdBy = new User();

	HistoryItem() {
		// Empty constructor is needed by Spring Data / JPA
	}

	public HistoryItem(User createdBy, String message) {
		this.createdBy = createdBy;
		this.message = message;
		timestamp = LocalDateTime.now();
	}

	public OrderState getNewState() {
		return newState;
	}

	public void setNewState(OrderState newState) {
		this.newState = newState;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public LocalDateTime getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(LocalDateTime timestamp) {
		this.timestamp = timestamp;
	}

	public User getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(User createdBy) {
		this.createdBy = createdBy;
	}


	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;
		if (!super.equals(o)) return false;
		HistoryItem that = (HistoryItem) o;
		return newState == that.newState &&
				Objects.equals(message, that.message) &&
				Objects.equals(timestamp, that.timestamp) &&
				Objects.equals(createdBy, that.createdBy);
	}

	@Override
	public int hashCode() {
		return Objects.hash(super.hashCode(), newState, message, timestamp, createdBy);
	}
}
