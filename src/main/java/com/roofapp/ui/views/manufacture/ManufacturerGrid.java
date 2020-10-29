package com.roofapp.ui.views.manufacture;

import com.roofapp.backend.dao.roofdb.entity.OrderItemManufacture;
import com.roofapp.backend.utils.Helper;
import com.vaadin.flow.component.AttachEvent;
import com.vaadin.flow.component.UI;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.component.notification.Notification;
import lombok.extern.java.Log;


/**
 * Grid of Manufacturerss, handling the visual presentation and filtering of a set of
 * items. This version uses an in-memory data source that is suitable for small
 * data sets.
 */
@Log
public class ManufacturerGrid extends Grid<OrderItemManufacture> {

    public ManufacturerGrid() {

        setSizeFull();
        addColumn(orderItems-> Helper.dateFormat(orderItems.getOrder().getCreated())).setHeader("Дата заказа")
                .setFlexGrow(5).setSortable(true).setKey("created").setResizable(true);


        addColumn(item-> item.getOrder().getCustomer()).setHeader("Клиент")
                .setFlexGrow(5).setSortable(true).setKey("castomer").setResizable(true);

        addColumn(orderItems -> orderItems.getId())
                .setHeader("id ордера на производство")
                .setFlexGrow(3).setKey("id").setResizable(true);;

        addColumn(orderItems -> orderItems.getProduct() )
                .setHeader("Название продукта")
                .setFlexGrow(3).setKey("name").setResizable(true);;

        addColumn(orderItems -> orderItems.getHeight() )
                .setHeader("Длинна")
                .setFlexGrow(3).setKey("height").setResizable(true);;

        addColumn(orderItems -> orderItems.getQuantity() )
                .setHeader("кол-во")
                .setFlexGrow(3).setKey("quantity").setResizable(true);;

        addColumn(orderItems -> orderItems.getMaterialCover() )
                .setHeader("Покрытие")
                .setFlexGrow(3).setKey("MaterialCover").setResizable(true);;

        addColumn(orderItems -> orderItems.getMaterialColor() )
                .setHeader("Цвет")
                .setFlexGrow(3).setKey("MaterialColor").setResizable(true);;

        addColumn(orderItems -> orderItems.getMaterialClass() )
                .setHeader("Класс")
                .setFlexGrow(3).setKey("MaterialClass").setResizable(true);;

        addColumn(item-> Helper.dateFormat(item.getOrder().getDone())).setHeader("Дата готовности")
                .setFlexGrow(5).setSortable(true).setKey("done").setResizable(true);

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

    public OrderItemManufacture getSelectedRow() {
        Notification.show("");
        return asSingleSelect().getValue();
    }

    public void refresh(OrderItemManufacture Manufacturers) {
        getDataCommunicator().refresh(Manufacturers);
    }


}
