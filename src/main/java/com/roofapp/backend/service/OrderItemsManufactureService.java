package com.roofapp.backend.service;

import com.roofapp.backend.dao.roofdb.OrderType;
import com.roofapp.backend.dao.roofdb.entity.OrderItemManufacture;
import com.roofapp.backend.dao.roofdb.entity.User;
import com.roofapp.backend.dao.roofdb.repositories.OrderItemManufactureRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;


@Service
public class OrderItemsManufactureService implements FilterableCrudService<OrderItemManufacture>  {


	private final OrderItemManufactureRepository orderItemManufactureRepository;

	@Autowired
	public OrderItemsManufactureService(OrderItemManufactureRepository orderItemRepository) {
		this.orderItemManufactureRepository = orderItemRepository;
	}

	public void save(OrderItemManufacture item) {
		orderItemManufactureRepository.save(item);
	}
	

	public OrderItemManufacture findById(Long id) {
		try {
			return orderItemManufactureRepository.findById(id).get();
		}catch (Exception e){
			return null;
		}
	}

	public void delete(OrderItemManufacture item) {
		orderItemManufactureRepository.delete(item);
	}


	@Override
	public Page<OrderItemManufacture> findAnyMatching(Optional<String> filter, Pageable pageable) {
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



	public Page<OrderItemManufacture> find(Pageable pageable) {
		return orderItemManufactureRepository.findBy(pageable);
	}

	@Override
	public JpaRepository<OrderItemManufacture, Long> getRepository() {
		return orderItemManufactureRepository;
	}

	@Override
	public OrderItemManufacture createNew(User currentUser) {
		return new OrderItemManufacture();
	}

	@Override
	public List<OrderItemManufacture> findAll() {
		return orderItemManufactureRepository.findAll();
	}

	@Override
	public OrderItemManufacture save(User currentUser, OrderItemManufacture entity) {
		try {
			return FilterableCrudService.super.save(currentUser, entity);
		} catch (DataIntegrityViolationException e) {
			throw new UserFriendlyDataException(
					"There is already a item with that name. Please select a unique name for the item.");
		}

	}

	@Transactional
	public List<OrderItemManufacture> findAllByPriority() {
		return orderItemManufactureRepository.findByByPriority(OrderType.MANUFACTURED.ordinal());
	}


}
