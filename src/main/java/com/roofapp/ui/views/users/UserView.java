package com.roofapp.ui.views.users;

import com.roofapp.app.security.CurrentUser;
import com.roofapp.backend.data.entity.User;
import com.roofapp.backend.service.UserService;
import com.roofapp.ui.MainLayout;
import com.vaadin.flow.component.Key;
import com.vaadin.flow.component.KeyModifier;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.html.H4;
import com.vaadin.flow.component.icon.VaadinIcon;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.router.*;

/**
 * A view for performing create-read-update-delete operations on products.
 * <p>
 * See also {@link UserViewLogic} for fetching the data, the actual CRUD
 * operations and controlling the view based on events from outside.r
 */
@Route(value = "users", layout = MainLayout.class)
@PageTitle("users")
//@RouteAlias(value = "", layout = MainLayout.class)
public class UserView extends HorizontalLayout
        implements HasUrlParameter<String> {

    public static final String VIEW_NAME = "Пользователи";


    private final UserService userService;
    public final CurrentUser currentUser;

    private final UserGrid grid;
    private final UserForm form;
    private TextField filter;

    private final UserViewLogic viewLogic = new UserViewLogic(this);
    private Button newItem;

    private UserDataProvider dataProvider;

    public UserView(UserService userService, CurrentUser currentUser) {
        this.userService = userService;
        this.currentUser = currentUser;
        // Sets the width and the height of InventoryView to "100%".
        setSizeFull();
        final HorizontalLayout topLayout = createTopBar();
        grid = new UserGrid();
        dataProvider = new UserDataProvider(userService.findAll(), userService);
        grid.setDataProvider(this.dataProvider);
        // Allows user to select a single row in the grid.
        grid.asSingleSelect().addValueChangeListener(
                event -> viewLogic.rowSelected(event.getValue()));
        form = new UserForm(viewLogic, userService);
//        form.setCategories(DataService.get().getAllCategories());
        final VerticalLayout barAndGridLayout = new VerticalLayout();
        barAndGridLayout.add(new H4(this.VIEW_NAME));
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
        filter.setPlaceholder("Фильтр по имени");
        // Apply the filter to grid's data provider. TextField value is never
        filter.addValueChangeListener(
                event -> dataProvider.setFilter(event.getValue()));
        // A shortcut to focus on the textField by pressing ctrl + F
        filter.addFocusShortcut(Key.KEY_F, KeyModifier.CONTROL);

        newItem = new Button("Новый");
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
    public void setNewProductEnabled(boolean enabled) {

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
    public void selectRow(User row) {
        grid.getSelectionModel().select(row);
    }

    /**
     * Updates a product in the list of products.
     *
     * @param item
     */
    public void updateUser(User item) {
        dataProvider.save(item);
    }

    /**
     * Removes a product from the list of products.
     *
     * @param item
     */
    public void removeProduct(User item) {
        dataProvider.delete(item);
    }

    /**
     * Displays user a form to edit a Product.
     *
     * @param item
     */
    public void editUser(User item) {
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
