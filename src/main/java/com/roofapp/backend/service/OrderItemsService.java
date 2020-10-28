package com.roofapp.backend.service;

import com.roofapp.backend.dao.roofdb.OrderType;
import com.roofapp.backend.dao.roofdb.entity.OrderItem;
import com.roofapp.backend.dao.roofdb.entity.User;
import com.roofapp.backend.dao.roofdb.repositories.OrderItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;


@Service
@Transactional(propagation= Propagation.REQUIRED, readOnly=true, noRollbackFor=Exception.class)
public class OrderItemsService implements FilterableCrudService<OrderItem>  {


	private final OrderItemRepository orderItemRepository;

	@Autowired
	public OrderItemsService(OrderItemRepository orderItemRepository) {
		this.orderItemRepository = orderItemRepository;
	}

	public void save(OrderItem item) {
		orderItemRepository.save(item);
	}
	

	public OrderItem findById(Long id) {
		try {
			return orderItemRepository.findById(id).get();
		}catch (Exception e){
			return null;
		}
	}

	public void delete(OrderItem item) {
		orderItemRepository.delete(item);
	}


	@Override
	public Page<OrderItem> findAnyMatching(Optional<String> filter, Pageable pageable) {
		if (filter.isPresent()) {
			String repositoryFilter = "%" + filter.get() + "%";
			return null;//orderItemRepository.findByNameLikeIgnoreCase(repositoryFilter, pageable);
		} else {
			return find(pageable);
		}
	}

	@Override
	public long countAnyMatching(Optional<String> filter) {
		if (filter.isPresent()) {
			String repositoryFilter = "%" + filter.get() + "%";
			return 0l;//orderItemRepository.countByNameLikeIgnoreCase(repositoryFilter);
		} else {
			return count();
		}
	}



	public Page<OrderItem> find(Pageable pageable) {
		return orderItemRepository.findBy(pageable);
	}

	@Override
	public JpaRepository<OrderItem, Long> getRepository() {
		return orderItemRepository;
	}

	@Override
	public OrderItem createNew(User currentUser) {
		return new OrderItem();
	}

	@Override
	public List<OrderItem> findAll() {
		return orderItemRepository.findAll();
	}

	@Override
	public OrderItem save(User currentUser, OrderItem entity) {
		try {
			return FilterableCrudService.super.save(currentUser, entity);
		} catch (DataIntegrityViolationException e) {
			throw new UserFriendlyDataException(
					"There is already a item with that name. Please select a unique name for the item.");
		}

	}

	@Transactional
	public List<OrderItem> findAllByPriority() {
		return orderItemRepository.findByByPriority(OrderType.MANUFACTURED);
	}


}
