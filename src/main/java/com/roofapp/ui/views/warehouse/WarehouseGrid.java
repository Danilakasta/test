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

        addColumn(WarehouseItem::getProduct).setHeader("Название номенклатуры")
                .setFlexGrow(100).setSortable(true).setKey("product");

        addColumn(WarehouseItem::getQuantity).setHeader("кол-во")
                .setFlexGrow(20).setSortable(true).setKey("quantity");

        addColumn(WarehouseItem::getState).setHeader("статус")
                .setFlexGrow(20).setSortable(true).setKey("state");

        addColumn(WarehouseItem::getComment).setHeader("коментарий")
                .setFlexGrow(20).setSortable(true).setKey("comment");

        addColumn(WarehouseItem::getOrderItem).setHeader("заказ")
                .setFlexGrow(20).setSortable(true).setKey("orderItem");

        addColumn(WarehouseItem::getMachine).setHeader("станок")
                .setFlexGrow(20).setSortable(true).setKey("machine");

        addColumn(WarehouseItem::getMaterial).setHeader("материал")
                .setFlexGrow(20).setSortable(true).setKey("material");



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
