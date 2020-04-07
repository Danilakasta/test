package com.roofapp.ui.views.contractors;

import com.roofapp.backend.data.entity.Contractor;

import com.roofapp.backend.service.ContractorService;
import com.roofapp.ui.MainLayout;
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
import com.vaadin.flow.router.*;

/**
 * A view for performing create-read-update-delete operations on Contractors.
 * <p>
 * See also {@link ContractorsViewLogic} for fetching the data, the actual CRUD
 * operations and controlling the view based on events from outside.
 */
//@Route(value = "Contractors", layout = MainLayout.class)
//@RouteAlias(value = "", layout = MainLayout.class)
@Route(value = "contractors", layout = MainLayout.class)
@PageTitle("contractors")
public class ContractorsView extends HorizontalLayout
        implements HasUrlParameter<String> {

    public static final String VIEW_NAME = "Контрагенты";


    private final ContractorService contractorService;

    private final ContractorGrid grid;
    private final ContractorsForm form;
    private TextField filter;

    private final ContractorsViewLogic viewLogic = new ContractorsViewLogic(this);
    private Button newContractor;

    private ContractorDataProvider dataProvider;

    public ContractorsView(ContractorService contractorService) {
        this.contractorService = contractorService;
        // Sets the width and the height of InventoryView to "100%".
        setSizeFull();
        final HorizontalLayout topLayout = createTopBar();
        grid = new ContractorGrid();
        dataProvider = new ContractorDataProvider(contractorService.findAll(), contractorService);
        grid.setDataProvider(this.dataProvider);
        // Allows user to select a single row in the grid.
        grid.asSingleSelect().addValueChangeListener(
                event -> viewLogic.rowSelected(event.getValue()));
        form = new ContractorsForm(viewLogic, contractorService);
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
        filter.setPlaceholder("Фильтр");
        // Apply the filter to grid's data provider. TextField value is never
        filter.addValueChangeListener(
                event -> dataProvider.setFilter(event.getValue()));
        // A shortcut to focus on the textField by pressing ctrl + F
        filter.addFocusShortcut(Key.KEY_F, KeyModifier.CONTROL);

        newContractor = new Button("Новый");
        // Setting theme variant of new Contractorion button to LUMO_PRIMARY that
        // changes its background color to blue and its text color to white
        newContractor.addThemeVariants(ButtonVariant.LUMO_PRIMARY);
        newContractor.setIcon(VaadinIcon.PLUS_CIRCLE.create());
        newContractor.addClickListener(click -> viewLogic.newContractor());
        // A shortcut to click the new Contractor button by pressing ALT + N
        newContractor.addClickShortcut(Key.KEY_N, KeyModifier.ALT);
        final HorizontalLayout topLayout = new HorizontalLayout();
        topLayout.setWidth("100%");
        topLayout.add(filter);
        topLayout.add(newContractor);
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
     * Enables/Disables the new Contractor button.
     *
     * @param enabled
     */
    public void setNewContractorEnabled(boolean enabled) {

        newContractor.setEnabled(enabled);
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
    public void selectRow(Contractor row) {
        grid.getSelectionModel().select(row);
    }

    /**
     * Updates a Contractor in the list of Contractors.
     *
     * @param Contractor
     */
    public void updateContractor(Contractor Contractor) {
        dataProvider.save(Contractor);
    }

    /**
     * Removes a Contractor from the list of Contractors.
     *
     * @param Contractor
     */
    public void removeContractor(Contractor Contractor) {
        dataProvider.delete(Contractor);
    }

    /**
     * Displays user a form to edit a Contractor.
     *
     * @param Contractor
     */
    public void editContractor(Contractor Contractor) {
        showForm(Contractor != null);
        form.editContractor(Contractor);
    }

    /**
     * Shows and hides the new Contractor form
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
