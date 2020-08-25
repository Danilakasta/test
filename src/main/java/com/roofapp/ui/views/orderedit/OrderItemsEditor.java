package com.roofapp.ui.views.orderedit;

import com.roofapp.backend.dao.roofdb.entity.OrderItem;
import com.roofapp.backend.dao.roofdb.entity.Product;
import com.roofapp.ui.views.order.events.TotalPriceChangeEvent;
import com.vaadin.flow.component.AbstractField.ComponentValueChangeEvent;
import com.vaadin.flow.component.ComponentEventListener;
import com.vaadin.flow.component.HasValue;
import com.vaadin.flow.component.HasValueAndElement;
import com.vaadin.flow.component.html.Div;
import com.vaadin.flow.component.internal.AbstractFieldSupport;
import com.vaadin.flow.data.provider.DataProvider;
import com.vaadin.flow.shared.Registration;

import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class OrderItemsEditor extends Div implements HasValueAndElement<ComponentValueChangeEvent<OrderItemsEditor,List<OrderItem>>, List<OrderItem>> {

	private OrderItemEditor empty;

	private DataProvider<Product, String> productDataProvider;

	private Double totalPrice = 0d;

	private boolean hasChanges = false;

	private final AbstractFieldSupport<OrderItemsEditor,List<OrderItem>> fieldSupport;
	
	public OrderItemsEditor(DataProvider<Product, String> productDataProvider) {
		this.productDataProvider = productDataProvider;
		this.fieldSupport = new AbstractFieldSupport<>(this, Collections.emptyList(),
				Objects::equals, c ->  {}); 
	}

	@Override
	public void setValue(List<OrderItem> items) {
		fieldSupport.setValue(items);
		removeAll();
		totalPrice = 0d;
		hasChanges = false;

		if (items != null) {
			items.forEach(this::createEditor);
		}
		createEmptyElement();
		setHasChanges(false);
	}

	private OrderItemEditor createEditor(OrderItem value) {
		OrderItemEditor editor = new OrderItemEditor(productDataProvider);
		getElement().appendChild(editor.getElement());
		editor.addPriceChangeListener(e -> updateTotalPriceOnItemPriceChange(e.getOldValue(), e.getNewValue()));
		editor.addProductChangeListener(e -> productChanged(e.getSource(), e.getProduct()));
		editor.addCommentChangeListener(e -> setHasChanges(true));
		editor.addDeleteListener(e -> {
			OrderItemEditor orderItemEditor = e.getSource();
			if (orderItemEditor != empty) {
				remove(orderItemEditor);
				OrderItem orderItem = orderItemEditor.getValue();
				setValue(getValue().stream().filter(element -> element != orderItem).collect(Collectors.toList()));
				updateTotalPriceOnItemPriceChange(orderItem.getTotalPrice(), Double.valueOf(0));
				setHasChanges(true);
			}
		});

		editor.setValue(value);
		return editor;
	}

	@Override
	public void setReadOnly(boolean readOnly) {
		HasValueAndElement.super.setReadOnly(readOnly);
		getChildren().forEach(e -> ((OrderItemEditor) e).setReadOnly(readOnly));
	}

	@Override
	public List<OrderItem> getValue() {
		return fieldSupport.getValue();
	}

	private void productChanged(OrderItemEditor item, Product product) {
		setHasChanges(true);
		if (empty == item) {
			createEmptyElement();
			OrderItem orderItem = new OrderItem();
			orderItem.setProduct(product);
			item.setValue(orderItem);
			setValue(Stream.concat(getValue().stream(),Stream.of(orderItem)).collect(Collectors.toList()));
		}
	}

	private void updateTotalPriceOnItemPriceChange(Double oldItemPrice, Double newItemPrice) {
		final Double delta = newItemPrice - oldItemPrice;
		totalPrice += delta;
		setHasChanges(true);
		fireEvent(new TotalPriceChangeEvent(this, totalPrice));
	}

	private void createEmptyElement() {
		empty = createEditor(null);
	}

	public Registration addPriceChangeListener(ComponentEventListener<TotalPriceChangeEvent> listener) {
		return addListener(TotalPriceChangeEvent.class, listener);
	}

	public boolean hasChanges() {
		return hasChanges;
	}

	private void setHasChanges(boolean hasChanges) {
		this.hasChanges = hasChanges;
		if (hasChanges) {
			fireEvent(new com.roofapp.ui.views.order.events.ValueChangeEvent(this));
		}
	}

	public Stream<HasValue<?, ?>> validate() {
		return getChildren()
				.filter(component -> fieldSupport.getValue().size() == 0 || !component.equals(empty))
				.map(editor -> ((OrderItemEditor) editor).validate()).flatMap(stream -> stream);
	}

	@Override
	public Registration addValueChangeListener(
			ValueChangeListener<? super ComponentValueChangeEvent<OrderItemsEditor, List<OrderItem>>> listener) {
		return fieldSupport.addValueChangeListener(listener);
	}
}
