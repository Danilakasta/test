package com.roofapp.ui;

//import com.roofapp.authentication.AccessControl;
//import com.roofapp.authentication.AccessControlFactory;

//import com.roofapp.ui.views.deliveries.DeliveriesView;

import com.roofapp.app.security.CurrentUser;
import com.roofapp.backend.dao.roofdb.Role;
import com.roofapp.ui.views.ProductAmount.ProductAmountView;
import com.roofapp.ui.views.accounts.AccountView;
import com.roofapp.ui.views.guides.GuidesView;
import com.roofapp.ui.views.machines.MachinesView;
import com.roofapp.ui.views.manufacture.ManufactureView;
import com.roofapp.ui.views.marketAnalysis.ConcurrentProductView;
import com.roofapp.ui.views.materials.MaterialsView;
import com.roofapp.ui.views.products.ProductView;
import com.roofapp.ui.views.contractors.ContractorsView;
import com.roofapp.ui.views.order.OrderView;
import com.roofapp.ui.views.users.UserView;
import com.roofapp.ui.views.warehouse.WarehouseView;
import com.vaadin.flow.component.*;
import com.vaadin.flow.component.applayout.AppLayout;
import com.vaadin.flow.component.applayout.DrawerToggle;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.dependency.CssImport;
import com.vaadin.flow.component.html.Label;
import com.vaadin.flow.component.html.Span;
import com.vaadin.flow.component.icon.Icon;
import com.vaadin.flow.component.icon.VaadinIcon;
import com.vaadin.flow.component.orderedlayout.FlexComponent.Alignment;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;
import com.vaadin.flow.component.tabs.Tab;
import com.vaadin.flow.component.tabs.Tabs;
import com.vaadin.flow.router.RouterLayout;
import com.vaadin.flow.router.RouterLink;
import com.vaadin.flow.server.PWA;
import com.vaadin.flow.server.VaadinSession;
import com.vaadin.flow.theme.Theme;
import com.vaadin.flow.theme.lumo.Lumo;
import com.roofapp.ui.about.AboutView;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * The main layout. Contains the navigation menu.
 */
@Theme(value = Lumo.class)
@PWA(name = "Roof Factory", shortName = "roofApp",
        startPath = "login",
        backgroundColor = "#227aef", themeColor = "#227aef",
        offlinePath = "offline-page.html",
        offlineResources = {"images/offline-login-banner.jpg"})

@CssImport("./styles/shared-styles.css")
@CssImport(value = "./styles/menu-buttons.css", themeFor = "vaadin-button")
public class MainLayout extends AppLayout implements RouterLayout {

    private final Button logoutButton;


    private final CurrentUser currentUser;

    @Autowired
    public MainLayout(CurrentUser currentUser) {
        this.currentUser = currentUser;
        // Header of the menu (the navbar)

        // menu toggle
        final DrawerToggle drawerToggle = new DrawerToggle();
        drawerToggle.addClassName("menu-toggle");
        addToNavbar(drawerToggle);

        // image, logo
        final HorizontalLayout top = new HorizontalLayout();
        top.setDefaultVerticalComponentAlignment(Alignment.CENTER);
        top.setClassName("menu-header");

        // Note! Image resource url is resolved here as it is dependent on the
        // execution mode (development or production) and browser ES level
        // support
        // final String resolvedImage = VaadinService.getCurrent().resolveResource(
        //        "img/logo.png"/*, VaadinSession.getCurrent().getBrowser()*/);

        //  final Image image = new Image(resolvedImage, "");
        final Label title = new Label("Roof Factory Prototype");
        //  top.add(image, title);
        top.add(title);
        addToNavbar(top);

        Tabs tabs = new Tabs();
        tabs.setOrientation(Tabs.Orientation.VERTICAL);
        tabs.setClassName("menu-link");

     /*    RouterLink routerLink = new RouterLink("Заказы", OrderView.class);
        routerLink.add(VaadinIcon.EDIT.create());
        Tab tab = new Tab(routerLink);
        tabs.add(tab);

        addToDrawer( tabs);
*/

        if (currentUser.getUser().getRole().equals(Role.ADMIN) ||
                currentUser.getUser().getRole().equals(Role.DIRECTOR) ||
                currentUser.getUser().getRole().equals(Role.MANAGER))
            tabs.add(createMenuLink(OrderView.class, "Заказы",
                    VaadinIcon.EDIT.create()));
        if (currentUser.getUser().getRole().equals(Role.ADMIN)
                || currentUser.getUser().getRole().equals(Role.DIRECTOR)
                || currentUser.getUser().getRole().equals(Role.MANAGER))
            tabs.add(createMenuLink(ContractorsView.class, ContractorsView.VIEW_NAME,
                    VaadinIcon.USER_CARD.create()));

        if (currentUser.getUser().getRole().equals(Role.ADMIN)
                || currentUser.getUser().getRole().equals(Role.DIRECTOR)
                || currentUser.getUser().getRole().equals(Role.MANAGER))
            tabs.add(createMenuLink(AccountView.class, AccountView.VIEW_NAME,
                    VaadinIcon.CASH.create()));

        if (currentUser.getUser().getRole().equals(Role.ADMIN)
                || currentUser.getUser().getRole().equals(Role.DIRECTOR))
            tabs.add(createMenuLink(ProductView.class, ProductView.VIEW_NAME,
                    VaadinIcon.BARCODE.create()));

        if (currentUser.getUser().getRole().equals(Role.ADMIN)
                || currentUser.getUser().getRole().equals(Role.DIRECTOR))
            tabs.add(createMenuLink(ProductAmountView.class, ProductAmountView.VIEW_NAME,
                    VaadinIcon.TABLE.create()));

        if (currentUser.getUser().getRole().equals(Role.ADMIN)
                || currentUser.getUser().getRole().equals(Role.DIRECTOR))
            tabs.add(createMenuLink(MaterialsView.class, MaterialsView.VIEW_NAME,
                    VaadinIcon.VIEWPORT.create()));

        if (currentUser.getUser().getRole().equals(Role.ADMIN)
                || currentUser.getUser().getRole().equals(Role.DIRECTOR))
            tabs.add(createMenuLink(MachinesView.class, MachinesView.VIEW_NAME,
                    VaadinIcon.WORKPLACE.create()));

        if (currentUser.getUser().getRole().equals(Role.ADMIN)
                || currentUser.getUser().getRole().equals(Role.DIRECTOR) ||
                currentUser.getUser().getRole().equals(Role.MACHINE_ENGINEER))
            tabs.add(createMenuLink(ManufactureView.class, ManufactureView.VIEW_NAME,
                    VaadinIcon.ADD_DOCK.create()));

        if (currentUser.getUser().getRole().equals(Role.ADMIN)
                || currentUser.getUser().getRole().equals(Role.DIRECTOR) ||
                currentUser.getUser().getRole().equals(Role.MACHINE_ENGINEER))
            tabs.add(createMenuLink(WarehouseView.class, WarehouseView.VIEW_NAME,
                    VaadinIcon.STORAGE.create()));



        if (currentUser.getUser().getRole().equals(Role.ADMIN))
            tabs.add(createMenuLink(UserView.class, UserView.VIEW_NAME,
                    VaadinIcon.USERS.create()));

        //   addToDrawer(createMenuLink(DeliveriesView.class, DeliveriesView .VIEW_NAME,
        //         VaadinIcon.INFO_CIRCLE.create()));
        if (currentUser.getUser().getRole().equals(Role.ADMIN) ||
                currentUser.getUser().getRole().equals(Role.DIRECTOR))
            tabs.add(createMenuLink(ConcurrentProductView.class, ConcurrentProductView.VIEW_NAME,
                    VaadinIcon.CASH.create()));

        if (currentUser.getUser().getRole().equals(Role.ADMIN))
            tabs.add(createMenuLink(GuidesView.class, GuidesView.VIEW_NAME,
                    VaadinIcon.COG.create()));

        if (currentUser.getUser().getRole().equals(Role.ADMIN))
            tabs.add(createMenuLink(AboutView.class, AboutView.VIEW_NAME,
                    VaadinIcon.INFO_CIRCLE.create()));

        addToDrawer(tabs);


        // Create logout button but don't add it yet; admin view might be added
        // in between (see #onAttach())
        logoutButton = createMenuButton("Выйти", VaadinIcon.SIGN_OUT.create());
        logoutButton.addClickListener(e -> logout());
        logoutButton.getElement().setAttribute("title", "Logout (Ctrl+L)");
        addToDrawer(logoutButton);

    }


    private void logout() {
        VaadinSession.getCurrent().getSession().invalidate();
        UI.getCurrent().navigate("");
    }

    private Tab createMenuLink(Class<? extends Component> viewClass,
                               String caption, Icon icon) {
        final RouterLink routerLink = new RouterLink(null, viewClass);
      //  routerLink.setClassName("menu-link");
        routerLink.add(icon);
        routerLink.add(new Span(caption));
        icon.setSize("25px");
        return new Tab(routerLink);
    }


    private Button createMenuButton(String caption, Icon icon) {
        final Button routerButton = new Button(caption);
        routerButton.setClassName("menu-button");
        routerButton.addThemeVariants(ButtonVariant.LUMO_TERTIARY_INLINE);
        routerButton.setIcon(icon);
        icon.setSize("24px");
        return routerButton;
    }

    /*  private void registerAdminViewIfApplicable(AccessControl accessControl) {
          // register the admin view dynamically only for any admin user logged in
          if (accessControl.isUserInRole(AccessControl.ADMIN_ROLE_NAME)
                  && !RouteConfiguration.forSessionScope()
                  .isRouteRegistered(AdminView.class)) {
              RouteConfiguration.forSessionScope().setRoute(AdminView.VIEW_NAME,
                      AdminView.class, MainLayout.class);
              // as logout will purge the session route registry, no need to
              // unregister the view on logout
          }
      }
  */
    @Override
    protected void onAttach(AttachEvent attachEvent) {
        super.onAttach(attachEvent);

        // User can quickly activate logout with Ctrl+L
        attachEvent.getUI().addShortcutListener(() -> logout(), Key.KEY_L,
                KeyModifier.CONTROL);

        // add the admin view menu item if user has admin role
      /*  final AccessControl accessControl = AccessControlFactory.getInstance()
                .createAccessControl();
        if (accessControl.isUserInRole(AccessControl.ADMIN_ROLE_NAME)) {

            // Create extra navigation target for admins
            registerAdminViewIfApplicable(accessControl);

            // The link can only be created now, because the RouterLink checks
            // that the target is valid.
            addToDrawer(createMenuLink(AdminView.class, AdminView.VIEW_NAME,
                    VaadinIcon.DOCTOR.create()));
        }
*/
        // Finally, add logout button for all users

    }

}
