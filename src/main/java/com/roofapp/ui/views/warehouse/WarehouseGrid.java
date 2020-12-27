package com.roofapp.ui.views.warehouse;

import com.roofapp.backend.dao.roofdb.entity.Product;
import com.roofapp.backend.dao.roofdb.entity.WarehouseItem;
import com.vaadin.flow.component.AttachEvent;
import com.vaadin.flow.component.UI;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.data.renderer.TemplateRenderer;
import lombok.extern.java.Log;

import java.text.DecimalFormat;
import java.util.Comparator;

/**
 * Grid of products, handling the visual presentation and filtering of a set of
 * items. This version uses an in-memory data source that is suitable for small
 * data sets.
 */
@Log
public class WarehouseGrid extends Grid<WarehouseItem> {

    public WarehouseGrid() {

        setSizeFull();
        addColumn(WarehouseItem::getWarehouseType).setHeader("Название склада")
                .setFlexGrow(40).setSortable(true).setKey("Название склада").setResizable(true);

        addColumn(WarehouseItem::getProduct).setHeader("Название номенклатуры")
                .setFlexGrow(20).setSortable(true).setKey("Название номенклатуры").setResizable(true);

        addColumn(WarehouseItem::getQuantity).setHeader("Кол-во")
                .setFlexGrow(20).setSortable(true).setKey("Кол-во").setResizable(true);

        addColumn(WarehouseItem::getState).setHeader("статус")
                .setFlexGrow(20).setSortable(true).setKey("статус").setResizable(true);

        addColumn(WarehouseItem::getComment).setHeader("Коментарий")
                .setFlexGrow(20).setSortable(true).setKey("Коментарий").setResizable(true);

        addColumn(WarehouseItem::getOrderItem).setHeader("Заказ")
                .setFlexGrow(20).setSortable(true).setKey("Заказ").setResizable(true);

        addColumn(WarehouseItem::getMachine).setHeader("Станок")
                .setFlexGrow(20).setSortable(true).setKey("Станок").setResizable(true);

        addColumn(WarehouseItem::getMaterial).setHeader("Материал")
                .setFlexGrow(20).setSortable(true).setKey("Материал").setResizable(true);


        UI.getCurrent().getPage().addBrowserWindowResizeListener(
                e -> setColumnVisibility(e.getWidth()));
    }

    private void setColumnVisibility(int width) {
        if (width > 800) {

        } else if (width > 550) {

        } else {

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

    public WarehouseItem getSelectedRow() {
        Notification.show("ok");
        return asSingleSelect().getValue();
    }

    public void refresh(WarehouseItem item) {
        getDataCommunicator().refresh(item);
    }

    private String formatCategories(WarehouseItem item) {
      /*  if (product.getCategory() == null || product.getCategory().isEmpty()) {
            return "";
        }
        return product.getCategory().stream()
                .sorted(Comparator.comparing(Category::getId))
                .map(Category::getName).collect(Collectors.joining(", "));*/
        return "";
    }
}
