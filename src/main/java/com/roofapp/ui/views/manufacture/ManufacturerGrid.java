package com.roofapp.ui.views.manufacture;

import com.roofapp.backend.dao.roofdb.entity.OrderItem;
import com.roofapp.backend.utils.Helper;
import com.vaadin.flow.component.AttachEvent;
import com.vaadin.flow.component.UI;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.data.renderer.TemplateRenderer;
import lombok.extern.java.Log;

import java.text.DecimalFormat;
import java.util.Comparator;

/**
 * Grid of Manufacturerss, handling the visual presentation and filtering of a set of
 * items. This version uses an in-memory data source that is suitable for small
 * data sets.
 */
@Log
public class ManufacturerGrid extends Grid<OrderItem> {

    public ManufacturerGrid() {

        setSizeFull();
        addColumn(orderItems-> Helper.dateFormat(orderItems.getOrder().getCreated())).setHeader("Дата заказа")
                .setFlexGrow(5).setSortable(true).setKey("created").setResizable(true);


        addColumn(item-> Helper.dateFormat(item.getOrder().getDone())).setHeader("Дата готовности")
                .setFlexGrow(5).setSortable(true).setKey("modified").setResizable(true);

        addColumn(item-> item.getOrder().getCustomer()).setHeader("Клиент")
                .setFlexGrow(5).setSortable(true).setKey("castomer").setResizable(true);

        addColumn(orderItems -> orderItems.getId())
                .setHeader("id ордера на производство")
                .setFlexGrow(3).setKey("id");

        addColumn(orderItems -> orderItems.getProduct() )
                .setHeader("Название продукта")
                .setFlexGrow(3).setKey("name");

        addColumn(orderItems -> orderItems.getHeight() )
                .setHeader("Длинна")
                .setFlexGrow(3).setKey("height");

        addColumn(orderItems -> orderItems.getQuantity() )
                .setHeader("кол-во")
                .setFlexGrow(3).setKey("quantity");

        addColumn(orderItems -> orderItems.getMaterialCover() )
                .setHeader("Покрытие")
                .setFlexGrow(3).setKey("MaterialCover");

        addColumn(orderItems -> orderItems.getMaterialColor() )
                .setHeader("Цвет")
                .setFlexGrow(3).setKey("MaterialColor");

        addColumn(orderItems -> orderItems.getMaterialClass() )
                .setHeader("Класс")
                .setFlexGrow(3).setKey("MaterialClass");


        UI.getCurrent().getPage().addBrowserWindowResizeListener(
                e -> setColumnVisibility(e.getWidth()));
    }

    private void setColumnVisibility(int width) {
        if (width > 800) {
         //   getColumnByKey("name").setVisible(true);

        } else if (width > 550) {
         //   getColumnByKey("name").setVisible(true);

        } else {
       //     getColumnByKey("name").setVisible(true);

        }
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

    public OrderItem getSelectedRow() {
        Notification.show("");
        return asSingleSelect().getValue();
    }

    public void refresh(OrderItem Manufacturers) {
        getDataCommunicator().refresh(Manufacturers);
    }


}
