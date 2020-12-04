package com.roofapp.ui.views.order;

import com.roofapp.app.HasLogger;
import com.roofapp.backend.dao.roofdb.entity.Order;
import com.roofapp.backend.dao.roofdb.entity.util.EntityUtil;
import com.roofapp.ui.ConfirmDialog;
import com.roofapp.ui.MainLayout;
//import com.roofapp.ui.MainView;
import com.roofapp.ui.components.SearchBar;
import com.roofapp.ui.utils.AppConst;
import com.roofapp.ui.views.EntityView;
import com.roofapp.ui.views.orderedit.OrderDetails;
import com.roofapp.ui.views.orderedit.OrderEditor;
import com.vaadin.flow.component.HasValue;
import com.vaadin.flow.component.Tag;
import com.vaadin.flow.component.UI;
//import com.vaadin.flow.component.confirmdialog.ConfirmDialog;
import com.vaadin.flow.component.dependency.JsModule;
import com.vaadin.flow.component.dialog.Dialog;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.component.polymertemplate.Id;
import com.vaadin.flow.component.polymertemplate.PolymerTemplate;
import com.vaadin.flow.data.binder.ValidationException;
import com.vaadin.flow.router.*;
import com.vaadin.flow.templatemodel.TemplateModel;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.stream.Stream;

@Tag("storefront-view")
@JsModule("./src/views/storefront/storefront-view.js")
@Route(value = "orders", layout = MainLayout.class)
@RouteAlias(value = "", layout = MainLayout.class)
//@Route(value = BakeryConst.PAGE_STOREFRONT, layout = MainLayout.class)
@RouteAlias(value = AppConst.PAGE_STOREFRONT_EDIT, layout = MainLayout.class)
//@RouteAlias(value = BakeryConst.PAGE_ROOT, layout = MainLayout.class)
@PageTitle(AppConst.TITLE_STOREFRONT)
public class OrderView extends PolymerTemplate<TemplateModel>
		implements HasLogger, HasUrlParameter<Long>, EntityView<Order> {

	public static final String VIEW_NAME = "Заказы";

	@Id("search")
	private SearchBar searchBar;

	@Id("grid")
	private Grid<Order> grid;

	@Id("dialog")
	private Dialog dialog;

	private ConfirmDialog  confirmation = new ConfirmDialog();

	private final OrderEditor orderEditor;

	private final OrderDetails orderDetails = new OrderDetails();

	private final OrderPresenter presenter;

	@Autowired
	public OrderView(OrderPresenter presenter, OrderEditor orderEditor) {
		this.presenter = presenter;
		this.orderEditor = orderEditor;

		searchBar.setActionText("Новый");
		searchBar.setCheckboxText("Все заказы");
		searchBar.setPlaceHolder("Поиск заказов");

		grid.setSelectionMode(Grid.SelectionMode.NONE);

		grid.addColumn(OrderCard.getTemplate()
				.withProperty("orderCard", OrderCard::create)
				.withProperty("header", order -> presenter.getHeaderByOrderId(order.getId()))
				.withEventHandler("cardClick",
						order -> UI.getCurrent().navigate(AppConst.PAGE_STOREFRONT + "/" + order.getId())));

		getSearchBar().addFilterChangeListener(
				e -> presenter.filterChanged(getSearchBar().getFilter(), getSearchBar().isCheckboxChecked()));
		getSearchBar().addActionClickListener(e -> presenter.createNewOrder());

		presenter.init(this);

		dialog.addDialogCloseActionListener(e -> presenter.cancel());
	}

	@Override
	public ConfirmDialog getConfirmDialog() {
		return confirmation;
	}

	@Override
	public void setConfirmDialog(ConfirmDialog confirmDialog) {
		this.confirmation = confirmDialog;
	}


	void setOpened(boolean opened) {
		dialog.setOpened(opened);
	}

	@Override
	public void setParameter(BeforeEvent event, @OptionalParameter Long orderId) {
		boolean editView = event.getLocation().getPath().contains(AppConst.PAGE_STOREFRONT_EDIT);
		if (orderId != null) {
			presenter.onNavigation(orderId, editView);
		} else if (dialog.isOpened()) {
			presenter.closeSilently();
		}
	}

	void navigateToMainView() {
		getUI().ifPresent(ui -> ui.navigate(AppConst.PAGE_STOREFRONT));
	}

	@Override
	public boolean isDirty() {
		return orderEditor.hasChanges() || orderDetails.isDirty();
	}

	@Override
	public void write(Order entity) throws ValidationException {
		orderEditor.write(entity);
	}

	public Stream<HasValue<?, ?>> validate() {
		return orderEditor.validate();
	}

	SearchBar getSearchBar() {
		return searchBar;
	}

	OrderEditor getOpenedOrderEditor() {
		return orderEditor;
	}

	OrderDetails getOpenedOrderDetails() {
		return orderDetails;
	}

	Grid<Order> getGrid() {
		return grid;
	}

	@Override
	public void clear() {
		orderDetails.setDirty(false);
		orderEditor.clear();
	}

	void setDialogElementsVisibility(boolean editing) {
		dialog.add(editing ? orderEditor : orderDetails);
		orderEditor.setVisible(editing);
		orderDetails.setVisible(!editing);
	}

	@Override
	public String getEntityName() {
		return EntityUtil.getName(Order.class);
	}
}
