package com.roofapp.ui.views.manufacture;

import com.roofapp.backend.dao.roofdb.entity.Manufacturers;
import com.roofapp.backend.service.ManufacturerService;
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
import com.vaadin.flow.router.BeforeEvent;
import com.vaadin.flow.router.HasUrlParameter;
import com.vaadin.flow.router.OptionalParameter;
import com.vaadin.flow.router.Route;

/**
 * A view for performing create-read-update-delete operations on Manufacturerss.
 *
 * See also {@link } for fetching the data, the actual CRUD
 * operations and controlling the view based on events from outside.
 */
@Route(value = "manufacture", layout = MainLayout.class)
//@RouteAlias(value = "", layout = MainLayout.class)
public class ManufactureView extends HorizontalLayout
        implements HasUrlParameter<String> {

    public static final String VIEW_NAME = "Производство";


   private final ManufacturerService manufacturerService;

    private final ManufacturerGrid grid;
   //private final ManufacturersForm form;
    private TextField filter;

  //  private final ManufacturersViewLogic viewLogic = new ManufacturersViewLogic(this);
    private Button newManufacturers;

    private ManufacturerDataProvider dataProvider;

    public ManufactureView(ManufacturerService manufacturerService) {

        this.manufacturerService= manufacturerService;
        // Sets the width and the height of InventoryView to "100%".
        setSizeFull();
        final HorizontalLayout topLayout = createTopBar();
        grid = new ManufacturerGrid();
        dataProvider = new ManufacturerDataProvider(manufacturerService.findAllSortedOrders(), manufacturerService);
        grid.setDataProvider(this.dataProvider);
        // Allows user to select a single row in the grid.
        //grid.asSingleSelect().addValueChangeListener(
            //    event -> viewLogic.rowSelected(event.getValue()));
       //form = new ManufacturersForm(viewLogic,ManufacturersService);
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
    //    add(form);

      //  viewLogic.init();
    }

    public HorizontalLayout createTopBar() {
        filter = new TextField();
        filter.setPlaceholder("Фильтр по названию");
        // Apply the filter to grid's data provider. TextField value is never
        filter.addValueChangeListener(
                event -> dataProvider.setFilter(event.getValue()));
        // A shortcut to focus on the textField by pressing ctrl + F
        filter.addFocusShortcut(Key.KEY_F, KeyModifier.CONTROL);

        newManufacturers = new Button("Новый");
        // Setting theme variant of new Manufacturersion button to LUMO_PRIMARY that
        // changes its background color to blue and its text color to white
        newManufacturers.addThemeVariants(ButtonVariant.LUMO_PRIMARY);
        newManufacturers.setIcon(VaadinIcon.PLUS_CIRCLE.create());
       // newManufacturers.addClickListener(click -> viewLogic.newManufacturers());
        // A shortcut to click the new Manufacturers button by pressing ALT + N
        newManufacturers.addClickShortcut(Key.KEY_N, KeyModifier.ALT);
        final HorizontalLayout topLayout = new HorizontalLayout();
        topLayout.setWidth("100%");
        topLayout.add(filter);
        topLayout.add(newManufacturers);
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
     * @see Notification#show(String)
     * @param msg
     */
    public void showNotification(String msg) {
        Notification.show(msg);
    }

    /**
     * Enables/Disables the new Manufacturers button.
     * 
     * @param enabled
     */
    public void setNewManufacturersEnabled(boolean enabled) {

        newManufacturers.setEnabled(enabled);
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
    public void selectRow(Manufacturers row) {
        grid.getSelectionModel().select(row);
    }

    /**
     * Updates a Manufacturers in the list of Manufacturerss.
     * 
     * @param Manufacturers
     */
    public void updateManufacturers(Manufacturers Manufacturers) {
        dataProvider.save(Manufacturers);
    }

    /**
     * Removes a Manufacturers from the list of Manufacturerss.
     * 
     * @param Manufacturers
     */
    public void removeManufacturers(Manufacturers Manufacturers) {
        dataProvider.delete(Manufacturers);
    }

    /**
     * Displays user a form to edit a Manufacturers.
     * 
     * @param Manufacturers
     */
    public void editManufacturers(Manufacturers Manufacturers) {
        showForm(Manufacturers != null);
     //   form.editManufacturers(Manufacturers);
    }

    /**
     * Shows and hides the new Manufacturers form
     * 
     * @param show
     */
    public void showForm(boolean show) {
     //   form.setVisible(show);
    //    form.setEnabled(show);
    }

    @Override
    public void setParameter(BeforeEvent event,
            @OptionalParameter String parameter) {
      //  viewLogic.enter(parameter);
    }
}
