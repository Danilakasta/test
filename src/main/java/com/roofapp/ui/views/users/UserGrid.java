package com.roofapp.ui.views.users;

import com.roofapp.backend.dao.roofdb.entity.User;
import com.vaadin.flow.component.AttachEvent;
import com.vaadin.flow.component.UI;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.data.renderer.TemplateRenderer;

import java.util.Comparator;


/**
 * Grid of Materials, handling the visual presentation and filtering of a set of
 * items. This version uses an in-memory data source that is suitable for small
 * data sets.
 */
public class UserGrid extends Grid<User> {

    public UserGrid() {
        setSizeFull();

        addColumn(User::getEmail).setHeader("Email")
                .setFlexGrow(20).setSortable(true).setKey("email");

        addColumn(User::getFirstName).setHeader("Фамилия")
                .setFlexGrow(20).setSortable(true).setKey("firstName");

        addColumn(User::getLastName).setHeader("Имя")
                .setFlexGrow(20).setSortable(true).setKey("lastName");

        addColumn(User::isLocked).setHeader("Заблокирован")
                .setFlexGrow(20).setSortable(true).setKey("locked");



        final String coverTemplate = "[[item.role]]";
        addColumn(TemplateRenderer.<User>of(coverTemplate)
                .withProperty("role",
                        item -> item.getRole().toString()))
                .setHeader("Роль")
                .setComparator(Comparator
                        .comparing(User::getRole))
                .setFlexGrow(20).setKey("role");


        // If the browser window size changes, check if all columns fit on
        // screen
        // (e.g. switching from portrait to landscape mode)
        UI.getCurrent().getPage().addBrowserWindowResizeListener(
                e -> setColumnVisibility(e.getWidth()));
    }

    private void setColumnVisibility(int width) {

    }

    @Override
    protected void onAttach(AttachEvent attachEvent) {
        super.onAttach(attachEvent);

        // fetch browser width
        UI.getCurrent().getInternals().setExtendedClientDetails(null);
        UI.getCurrent().getPage().retrieveExtendedClientDetails(e -> {
            setColumnVisibility(e.getBodyClientWidth());
        });
    }

    public User getSelectedRow() {
        Notification.show("ок");
        return asSingleSelect().getValue();
    }

    public void refresh(User item) {
        getDataCommunicator().refresh(item);
    }


}
