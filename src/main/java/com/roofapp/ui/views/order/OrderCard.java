package com.roofapp.ui.views.order;

import com.roofapp.backend.dao.roofdb.entity.Order;
import com.roofapp.backend.dao.roofdb.entity.OrderItem;
import com.roofapp.backend.dao.roofdb.entity.OrderSummary;
import com.roofapp.ui.utils.converters.OrderStateConverter;
import com.vaadin.flow.data.renderer.TemplateRenderer;

import java.time.LocalDate;
import java.util.List;

import static com.roofapp.ui.utils.FormattingUtils.*;

/**
 * Help class to get ready to use TemplateRenderer for displaying order card list on the Storefront and Dashboard grids.
 * Using TemplateRenderer instead of ComponentRenderer optimizes the CPU and memory consumption.
 * <p>
 * In addition, component includes an optional header above the order card. It is used
 * to visually separate orders into groups. Technically all order cards are
 * equivalent, but those that do have the header visible create a visual group
 * separation.
 */
public class OrderCard {

	public static TemplateRenderer<Order> getTemplate() {
		return TemplateRenderer.of(
				  "<order-card"
				+ "  header='[[item.header]]'"
				+ "  order-card='[[item.orderCard]]'"
				+ "  on-card-click='cardClick'>"
				+ "</order-card>");
	}
	
	public static OrderCard create(OrderSummary order) {
		return new OrderCard(order);
	}

	private static OrderStateConverter stateConverter = new OrderStateConverter();

	private boolean recent, inWeek;

	private final OrderSummary order;
	
	public OrderCard(OrderSummary order) {
		this.order = order;
		LocalDate now = LocalDate.now();
		LocalDate date = order.getDueDate();
		recent = date.equals(now) || date.equals(now.minusDays(1));
		inWeek = !recent && now.getYear() == date.getYear() && now.get(WEEK_OF_YEAR_FIELD) == date.get(WEEK_OF_YEAR_FIELD);
	}

	public String getPlace() {
		return order.getPickupLocation() !=null && (recent || inWeek )?  order.getPickupLocation().getName() : null;
	}

	public String getTime() {
		return recent ? HOUR_FORMATTER.format(order.getDueTime()) : null;
	}

	public String getShortDay() {
		return inWeek ? SHORT_DAY_FORMATTER.format(order.getDueDate()) : null;
	}

	public String getSecondaryTime() {
		return inWeek ? HOUR_FORMATTER.format(order.getDueTime()) : null;
	}

	public String getMonth() {
		return recent || inWeek ? null : MONTH_AND_DAY_FORMATTER.format(order.getDueDate());
	}

	public String getFullDay() {
		return recent || inWeek ? null : WEEKDAY_FULLNAME_FORMATTER.format(order.getDueDate());
	}

	public String getState() {
		return stateConverter.encode(order.getState());
	}

	public String getFullName() {
		return order.getCustomer().getName();
	}

	public String getOrderType() {
		return order.getOrderType().toString();
	}

	public String getParentId() {
		return order.getParentId()!=null ? order.getParentId().toString() : order.getId().toString();
	}


	public List<OrderItem> getItems() {
		return order.getItems();
	}
}
