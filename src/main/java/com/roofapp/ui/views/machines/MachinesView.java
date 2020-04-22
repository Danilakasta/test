package com.roofapp.ui.views.machines;

import com.roofapp.backend.data.entity.Machine;
import com.roofapp.backend.service.MachineService;
import com.roofapp.ui.MainLayout;
import com.roofapp.ui.views.products.ProductViewLogic;
import com.vaadin.flow.component.Key;
import com.vaadin.flow.component.KeyModifier;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.html.H2;
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
 * A view for performing create-read-update-delete operations on products.
 * <p>
 * See also {@link ProductViewLogic} for fetching the data, the actual CRUD
 * operations and controlling the view based on events from outside.
 */
@Route(value = "machines", layout = MainLayout.class)
//@RouteAlias(value = "", layout = MainLayout.class)
public class MachinesView extends HorizontalLayout
        implements HasUrlParameter<String> {

    public static final String VIEW_NAME = "Оборудование";


    private final MachineService machineService;

    private final MachinesGrid grid;
    private final MachineForm form;
    private TextField filter;

    private final MachineViewLogic viewLogic = new MachineViewLogic(this);

    private Button newProduct;

    private MachineDataProvider dataProvider;

    public MachinesView(MachineService machineService) {
        this.machineService = machineService;
        // Sets the width and the height of InventoryView to "100%".
        setSizeFull();
        final HorizontalLayout topLayout = createTopBar();
        grid = new MachinesGrid();
        dataProvider = new MachineDataProvider(machineService.findAll(), machineService);
        grid.setDataProvider(this.dataProvider);
        // Allows user to select a single row in the grid.
        grid.asSingleSelect().addValueChangeListener(
                event -> viewLogic.rowSelected(event.getValue()));
        form = new MachineForm(viewLogic, machineService);
//        form.setCategories(DataService.get().getAllCategories());
        final VerticalLayout barAndGridLayout = new VerticalLayout();
        barAndGridLayout.add( new H2(this.VIEW_NAME));

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

        newProduct = new Button("Новый");
        // Setting theme variant of new production button to LUMO_PRIMARY that
        // changes its background color to blue and its text color to white
        newProduct.addThemeVariants(ButtonVariant.LUMO_PRIMARY);
        newProduct.setIcon(VaadinIcon.PLUS_CIRCLE.create());
        newProduct.addClickListener(click -> viewLogic.newMachine());
        // A shortcut to click the new Machine button by pressing ALT + N
        newProduct.addClickShortcut(Key.KEY_N, KeyModifier.ALT);
        final HorizontalLayout topLayout = new HorizontalLayout();
        topLayout.setWidth("100%");
        topLayout.add(filter);
        topLayout.add(newProduct);
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
     * Enables/Disables the new Machine button.
     *
     * @param enabled
     */
    public void setNewProductEnabled(boolean enabled) {

        newProduct.setEnabled(enabled);
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
    public void selectRow(Machine row) {
        grid.getSelectionModel().select(row);
    }

    /**
     * Updates a Machine in the list of products.
     *
     * @param item
     */
    public void update(Machine item) {
        dataProvider.save(item);
    }

    /**
     * Removes a Machine from the list of products.
     *
     * @param item
     */
    public void remove(Machine item ) {
        dataProvider.delete(item);
    }

    /**
     * Displays user a form to edit a Product.
     *
     * @param item
     */
    public void edit(Machine item) {
        showForm(item != null);
        form.editMachine(item);
    }

    /**
     * Shows and hides the new Machine form
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
