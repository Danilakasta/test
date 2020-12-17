package com.roofapp.ui.views.order;

//import com.roofapp.app.security.CurrentUser;
import com.roofapp.backend.dao.roofdb.entity.Contractor;
import com.roofapp.backend.dao.roofdb.entity.Order;
import com.roofapp.backend.service.OrderService;
import com.roofapp.ui.crud.EntityPresenter;
import com.roofapp.ui.dataproviders.OrdersGridDataProvider;
import com.roofapp.ui.dataproviders.OrdersGridDataProvider.OrderFilter;
import com.roofapp.ui.utils.AppConst;
import com.roofapp.ui.views.order.beans.OrderCardHeader;
import com.vaadin.flow.component.Focusable;
import com.vaadin.flow.component.HasValue;
import com.vaadin.flow.component.UI;
import com.vaadin.flow.spring.annotation.SpringComponent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.ConfigurableBeanFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@SpringComponent
@Scope(ConfigurableBeanFactory.SCOPE_PROTOTYPE)
@Transactional("roofTransactionManager")
public class OrderPresenter {

	private OrderCardHeaderGenerator headersGenerator;
	private OrderView view;

	private final EntityPresenter<Order, OrderView> entityPresenter;
	private final OrdersGridDataProvider dataProvider;
	//private final CurrentUser currentUser;
	private final OrderService orderService;

	@Autowired
    OrderPresenter(OrderService orderService, OrdersGridDataProvider dataProvider,
                   EntityPresenter<Order, OrderView> entityPresenter/*, CurrentUser currentUser*/) {
		this.orderService = orderService;
		this.entityPresenter = entityPresenter;
		this.dataProvider = dataProvider;
	//	this.currentUser = currentUser;
		headersGenerator = new OrderCardHeaderGenerator();
		headersGenerator.resetHeaderChain(false);
		dataProvider.setPageObserver(p -> headersGenerator.ordersRead(p.getContent()));
	}

	void init(OrderView view) {
		this.entityPresenter.setView(view);
		this.view = view;
		view.getGrid().setDataProvider(dataProvider);
		//view.getOpenedOrderEditor().setCurrentUser(currentUser.getUser());
		view.getOpenedOrderEditor().addCancelListener(e -> cancel());
		view.getOpenedOrderEditor().addReviewListener(e -> review());
		view.getOpenedOrderDetails().addSaveListenter(e -> save());
		view.getOpenedOrderDetails().addCancelListener(e -> cancel());
		view.getOpenedOrderDetails().addBackListener(e -> back());
		view.getOpenedOrderDetails().addEditListener(e -> edit());
		view.getOpenedOrderDetails().addCommentListener(e -> addComment(e.getMessage()));
	}

	OrderCardHeader getHeaderByOrderId(Long id) {
		return headersGenerator.get(id);
	}

	public void filterChanged(String filter, boolean showPrevious) {
		headersGenerator.resetHeaderChain(showPrevious);
		dataProvider.setFilter(new OrderFilter(filter, showPrevious));
	}

	void onNavigation(Long id, boolean edit) {
		entityPresenter.loadEntity(id, e -> open(e, edit));
	}

	void createNewOrder() {
		open(entityPresenter.createNew(), true);
	}

	void cancel() {
		entityPresenter.cancel(() -> close(), () -> view.setOpened(true));
	}


	void closeSilently() {
		entityPresenter.close();
		view.setOpened(false);
	}

	void edit() {
		UI.getCurrent().navigate(AppConst.PAGE_STOREFRONT_EDIT + "/" + entityPresenter.getEntity().getId());
	}

	void back() {
		view.setDialogElementsVisibility(true);
	}

	void review() {
		// Using collect instead of findFirst to assure all streams are
		// traversed, and every validation updates its view
		List<HasValue<?, ?>> fields = view.validate().collect(Collectors.toList());
		if (fields.isEmpty()) {
			if (entityPresenter.writeEntity()) {
				view.setDialogElementsVisibility(false);
				view.getOpenedOrderDetails().display(entityPresenter.getEntity(), true);
			}
		} else if (fields.get(0) instanceof Focusable) {
			((Focusable<?>) fields.get(0)).focus();
		}
	}

	void save() {
		entityPresenter.save(e -> {
			if (entityPresenter.isNew()) {
				view.showCreatedNotification();
				dataProvider.refreshAll();
			} else {
				view.showUpdatedNotification();
				dataProvider.refreshItem(e);
			}
			close();
		});

	}

	void addComment(String comment) {
		if (entityPresenter.executeUpdate(e -> orderService.addComment(/*currentUser.getUser()*/null, e, comment))) {
			// You can only add comments when in view mode, so reopening in that state.
			open(entityPresenter.getEntity(), false);
		}
	}

	private void open(Order order, boolean edit) {
		view.setDialogElementsVisibility(edit);
		view.setOpened(true);

		if (edit) {
			view.getOpenedOrderEditor().read(order, entityPresenter.isNew());
		} else {
			view.getOpenedOrderDetails().display(order, false);
		}
	}

	private void close() {
		view.getOpenedOrderEditor().close();
		view.setOpened(false);
		view.navigateToMainView();
		entityPresenter.close();
	}
}
