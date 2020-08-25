package com.roofapp.ui.views.manufacture;

import com.roofapp.backend.dao.roofdb.entity.Product;
import com.roofapp.backend.service.ProductService;
import com.roofapp.ui.MainLayout;
import com.roofapp.ui.views.products.ProductDataProvider;
import com.roofapp.ui.views.products.ProductGrid;
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
 *
 * See also {@link ProductViewLogic} for fetching the data, the actual CRUD
 * operations and controlling the view based on events from outside.
 */
@Route(value = "manufacture", layout = MainLayout.class)
//@RouteAlias(value = "", layout = MainLayout.class)
public class ManufactureView extends HorizontalLayout
        implements HasUrlParameter<String> {

    public static final String VIEW_NAME = "Производство";


   private final ProductService productService;

    private final ProductGrid grid;
   //private final ProductForm form;
    private TextField filter;

  //  private final ProductViewLogic viewLogic = new ProductViewLogic(this);
    private Button newProduct;

    private ProductDataProvider dataProvider;

    public ManufactureView(ProductService productService) {

        this.productService = productService;
        // Sets the width and the height of InventoryView to "100%".
        setSizeFull();
        final HorizontalLayout topLayout = createTopBar();
        grid = new ProductGrid();
        dataProvider = new ProductDataProvider(productService.findAllSortedOrders(), productService);
        grid.setDataProvider(this.dataProvider);
        // Allows user to select a single row in the grid.
        //grid.asSingleSelect().addValueChangeListener(
            //    event -> viewLogic.rowSelected(event.getValue()));
       //form = new ProductForm(viewLogic,productService);
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

        newProduct = new Button("Новый");
        // Setting theme variant of new production button to LUMO_PRIMARY that
        // changes its background color to blue and its text color to white
        newProduct.addThemeVariants(ButtonVariant.LUMO_PRIMARY);
        newProduct.setIcon(VaadinIcon.PLUS_CIRCLE.create());
       // newProduct.addClickListener(click -> viewLogic.newProduct());
        // A shortcut to click the new product button by pressing ALT + N
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
     * @see Notification#show(String)
     * @param msg
     */
    public void showNotification(String msg) {
        Notification.show(msg);
    }

    /**
     * Enables/Disables the new product button.
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
    public void selectRow(Product row) {
        grid.getSelectionModel().select(row);
    }

    /**
     * Updates a product in the list of products.
     * 
     * @param product
     */
    public void updateProduct(Product product) {
        dataProvider.save(product);
    }

    /**
     * Removes a product from the list of products.
     * 
     * @param product
     */
    public void removeProduct(Product product) {
        dataProvider.delete(product);
    }

    /**
     * Displays user a form to edit a Product.
     * 
     * @param product
     */
    public void editProduct(Product product) {
        showForm(product != null);
     //   form.editProduct(product);
    }

    /**
     * Shows and hides the new product form
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
