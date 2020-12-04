package com.roofapp.ui.views.manufacture;

import com.roofapp.backend.dao.roofdb.OrderState;
import com.roofapp.backend.dao.roofdb.entity.OrderItemManufacture;
import com.roofapp.backend.service.*;
import com.roofapp.ui.MainLayout;
import com.vaadin.flow.component.Key;
import com.vaadin.flow.component.KeyModifier;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.icon.VaadinIcon;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.router.BeforeEvent;
import com.vaadin.flow.router.HasUrlParameter;
import com.vaadin.flow.router.OptionalParameter;
import com.vaadin.flow.router.Route;

/**
 * A view for performing create-read-update-delete operations on Manufacturerss.
 * <p>
 * See also {@link } for fetching the data, the actual CRUD
 * operations and controlling the view based on events from outside.
 */
@Route(value = "manufacture", layout = MainLayout.class)
//@RouteAlias(value = "", layout = MainLayout.class)
public class ManufactureView extends HorizontalLayout
        implements HasUrlParameter<String> {
    public static final String VIEW_NAME = "Производство";


    private final OrderItemsManufactureService itemService;

    private final ManufacturerGrid grid;
    private final ManufactureForm form;
    private TextField filter;

    private final ManufactureViewLogic viewLogic = new ManufactureViewLogic(this);
    private Button newItem;

    private ManufacturerDataProvider dataProvider;

    public ManufactureView(OrderItemsManufactureService itemService,
                           MachineService machineService,
                           MaterialService materialService,
                           WarehouseItemService warehouseItemService, OrderService orderService, OrderItemsService orderItemsService) {
        this.itemService = itemService;
        // Sets the width and the height of InventoryView to "100%".
        setSizeFull();
        final HorizontalLayout topLayout = createTopBar();
        grid = new ManufacturerGrid();
        dataProvider = new ManufacturerDataProvider(itemService.findAllByPriority(), itemService);
        grid.setDataProvider(this.dataProvider);
        // Allows user to select a single row in the grid.
        grid.asSingleSelect().addValueChangeListener(
                event -> viewLogic.rowSelected(event.getValue()));
        form = new ManufactureForm(viewLogic, itemService, machineService, materialService, warehouseItemService, orderService, orderItemsService);
//        form.setCategories(DataService.get().getAllCategories());
        final VerticalLayout barAndGridLayout = new VerticalLayout();
        barAndGridLayout.add(topLayout);
        barAndGridLayout.add(grid);
        barAndGridLayout.setFlexGrow(1, grid);
        barAndGridLayout.setFlexGrow(0, topLayout);
        barAndGridLayout.setSizeFull();
        barAndGridLayout.expand(grid);

        add(barAndGridLayout);
        add(form);

        viewLogic.init();
    }

    public HorizontalLayout createTopBar() {
        filter = new TextField();
        filter.setPlaceholder("Фильтр по названию");
        // Apply the filter to grid's data provider. TextField value is never
        filter.addValueChangeListener(
                event -> dataProvider.setFilter(event.getValue()));
        // A shortcut to focus on the textField by pressing ctrl + F
        filter.addFocusShortcut(Key.KEY_F, KeyModifier.CONTROL);

        newItem = new Button("Новая позиция");
        // Setting theme variant of new production button to LUMO_PRIMARY that
        // changes its background color to blue and its text color to white
        newItem.addThemeVariants(ButtonVariant.LUMO_PRIMARY);
        newItem.setIcon(VaadinIcon.PLUS_CIRCLE.create());
        newItem.addClickListener(click -> viewLogic.newItem());
        // A shortcut to click the new product button by pressing ALT + N
        newItem.addClickShortcut(Key.KEY_N, KeyModifier.ALT);
        final HorizontalLayout topLayout = new HorizontalLayout();
        topLayout.setWidth("100%");
        topLayout.add(filter);
        topLayout.add(newItem);
        topLayout.setVerticalComponentAlignment(Alignment.START, filter);
        topLayout.expand(filter);
        return topLayout;
    }

    public void showError(String msg) {
        Notification.show(msg);
    }

    /**
     * Shows a temporary popup notification to the user.
     *
     * @param msg
     * @see Notification#show(String)
     */
    public void showNotification(String msg) {
        Notification.show(msg);
    }

    /**
     * Enables/Disables the new product button.
     *
     * @param enabled
     */
    public void setNewItemEnabled(boolean enabled) {

        newItem.setEnabled(enabled);
    }

    /**
     * Deselects the selected row in the grid.
     */
    public void clearSelection() {
        grid.getSelectionModel().deselectAll();
    }

    /**
     * Selects a row
     *
     * @param row
     */
    public void selectRow(OrderItemManufacture row) {
        grid.getSelectionModel().select(row);
    }

    /**
     * Updates a product in the list of products.
     *
     * @param item
     */
    public void update(OrderItemManufacture item) {
        dataProvider.save(item);
        grid.getDataProvider().refreshAll();
    }

    /**
     * Removes a product from the list of products.
     *
     * @param item
     */
    public void remove(OrderItemManufacture item) {
        dataProvider.delete(item);
    }

    /**
     * Displays user a form to edit a Product.
     *
     * @param item
     */
    public void edit(OrderItemManufacture item) {
        if (item != null) {
            if (item.getOrder().getState().equals(OrderState.MANUFACTURE)) {
                showForm(item != null);
                form.edit(item);
            }
        }
    }

    /**
     * Shows and hides the new product form
     *
     * @param show
     */
    public void showForm(boolean show) {
        form.setVisible(show);
        form.setEnabled(show);
    }

    @Override
    public void setParameter(BeforeEvent event,
                             @OptionalParameter String parameter) {
        viewLogic.enter(parameter);
    }
}

