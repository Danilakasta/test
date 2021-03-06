package com.roofapp.ui.views.warehouse;

import com.roofapp.backend.dao.roofdb.entity.WarehouseItem;
import com.roofapp.backend.service.ProductService;
import com.roofapp.backend.service.WarehouseItemService;
import com.roofapp.backend.service.guides.WarehouseTypeGuideService;
import com.roofapp.ui.MainLayout;
import com.roofapp.ui.views.products.ProductViewLogic;
import com.vaadin.flow.component.Key;
import com.vaadin.flow.component.KeyModifier;
import com.vaadin.flow.component.Text;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.checkbox.Checkbox;
import com.vaadin.flow.component.dialog.Dialog;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.component.grid.contextmenu.GridContextMenu;
import com.vaadin.flow.component.grid.contextmenu.GridMenuItem;
import com.vaadin.flow.component.html.Div;
import com.vaadin.flow.component.html.Paragraph;
import com.vaadin.flow.component.html.Pre;
import com.vaadin.flow.component.html.Span;
import com.vaadin.flow.component.icon.Icon;
import com.vaadin.flow.component.icon.VaadinIcon;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.router.BeforeEvent;
import com.vaadin.flow.router.HasUrlParameter;
import com.vaadin.flow.router.OptionalParameter;
import com.vaadin.flow.router.Route;
import org.springframework.security.core.parameters.P;

import java.util.stream.Collectors;

/**
 * A view for performing create-read-update-delete operations on products.
 * <p>
 * See also {@link ProductViewLogic} for fetching the data, the actual CRUD
 * operations and controlling the view based on events from outside.
 */
@Route(value = "warehouse", layout = MainLayout.class)
//@RouteAlias(value = "", layout = MainLayout.class)
public class WarehouseView extends HorizontalLayout
        implements HasUrlParameter<String> {
    public static final String VIEW_NAME = "Склад";


    private final WarehouseItemService itemService;

    private final WarehouseGrid grid;
    private final WarehouseForm form;
    private TextField filter;

    private final WarehouseViewLogic viewLogic = new WarehouseViewLogic(this);
    private Button newItem;
    private Button filterColumn;
    private Dialog dialog;

    private WarehouseDataProvider dataProvider;

    public WarehouseView(WarehouseItemService itemService, ProductService productService, WarehouseTypeGuideService warehouseTypeGuideService) {
        this.itemService = itemService;
        // Sets the width and the height of InventoryView to "100%".
        setSizeFull();
        final HorizontalLayout topLayout = createTopBar();
        grid = new WarehouseGrid();
        dataProvider = new WarehouseDataProvider(itemService.findAll(), itemService);
        grid.setDataProvider(this.dataProvider);
        // Allows user to select a single row in the grid.
        //   grid.asSingleSelect().addValueChangeListener()
        //          event -> viewLogic.rowSelected(event.getValue()));
        grid.setColumnReorderingAllowed(true);


        addGridFilterItem();
        form = new WarehouseForm(viewLogic, itemService, productService,warehouseTypeGuideService);
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

    public void addGridFilterItem() {
        GridContextMenu<WarehouseItem> contextMenu = new GridContextMenu<>(grid);
        GridMenuItem<WarehouseItem> insert = contextMenu.addItem(new Span(VaadinIcon.PLUS.create(), new Text(" "), new Span("Добавить")));
        insert.addMenuItemClickListener(event -> viewLogic.newItem());

        GridMenuItem<WarehouseItem> edit = contextMenu.addItem(new Span(VaadinIcon.EDIT.create(), new Text(" "), new Span("Редакторовать")));
        edit.addMenuItemClickListener(event -> viewLogic.rowSelected(event.getItem().get()));

        GridMenuItem<WarehouseItem> filterColumn = contextMenu.addItem(new Span(VaadinIcon.TABLE.create(), new Text(" "), new Span("Скрыть колонки")));

        //Динамически подкидываем колонки
        grid.getColumns().forEach(column -> {
            Checkbox idColumnVisibility = new Checkbox(column.getKey());
            idColumnVisibility.addValueChangeListener(
                    event -> column.setVisible(!column.isVisible()));
            filterColumn.getSubMenu().addItem(idColumnVisibility);
        });


        add(contextMenu);
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

        //Фильтр по колонкам
        //  filterColumn = new Button(new Icon(VaadinIcon.TABLE));
        //  filterColumn.addClickListener(buttonClickEvent -> {
        //     dialog.open();
        //  });

        final HorizontalLayout topLayout = new HorizontalLayout();
        topLayout.setWidth("100%");
        topLayout.add(filter);
        // topLayout.add(filterColumn);
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
    public void selectRow(WarehouseItem row) {
        grid.getSelectionModel().select(row);
    }

    /**
     * Updates a product in the list of products.
     *
     * @param item
     */
    public void updateItem(WarehouseItem item) {
        dataProvider.save(item);
    }

    /**
     * Removes a product from the list of products.
     *
     * @param item
     */
    public void removeItem(WarehouseItem item) {
        dataProvider.delete(item);
    }

    /**
     * Displays user a form to edit a Product.
     *
     * @param item
     */
    public void editItem(WarehouseItem item) {
        showForm(item != null);
        form.edit(item);
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
