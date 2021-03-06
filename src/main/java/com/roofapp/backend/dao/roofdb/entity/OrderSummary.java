package com.roofapp.backend.dao.roofdb.entity;

import com.roofapp.backend.dao.roofdb.OrderState;
import com.roofapp.backend.dao.roofdb.OrderType;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

public interface OrderSummary {
	Long getId();

	OrderState getState();

	Contractor getCustomer();

	List<OrderItem> getItems();

	LocalDate getDueDate();

	LocalTime getDueTime();

	PickupLocation getPickupLocation();

	Double getTotalPrice();

	OrderType getOrderType();

	Long getParentId();
}
