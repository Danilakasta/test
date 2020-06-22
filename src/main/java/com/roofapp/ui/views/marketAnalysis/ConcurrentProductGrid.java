package com.roofapp.ui.views.marketAnalysis;

import com.roofapp.backend.data.entity.Product;
import com.roofapp.backend.data.entity.parser.SiteProduct;
import com.vaadin.flow.component.AttachEvent;
import com.vaadin.flow.component.UI;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.component.notification.Notification;

import java.text.DecimalFormat;

/**
 * Grid of products, handling the visual presentation and filtering of a set of
 * items. This version uses an in-memory data source that is suitable for small
 * data sets.
 */
public class ConcurrentProductGrid extends Grid<SiteProduct> {

    public ConcurrentProductGrid() {

        setSizeFull();
        addColumn(SiteProduct::getSiteName).setHeader("Сайт")
                .setFlexGrow(20).setSortable(true).setKey("siteName");

        addColumn(SiteProduct::getCategory).setHeader("Категория")
                .setFlexGrow(20).setSortable(true).setKey("category");


        addColumn(SiteProduct::getTitle).setHeader("Название продукта")
                .setFlexGrow(20).setSortable(true).setKey("title");

        addColumn(SiteProduct::getFullPrice).setHeader("Цена")
                .setFlexGrow(20).setSortable(true).setKey("fullPrice");

        addColumn(SiteProduct::getProp).setHeader("описание")
                .setFlexGrow(20).setSortable(true).setKey("prop");


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

    public SiteProduct getSelectedRow() {
        Notification.show("");
        return asSingleSelect().getValue();
    }

    public void refresh(SiteProduct product) {
        getDataCommunicator().refresh(product);
    }

    private String formatCategories(Product product) {
      /*  if (product.getCategory() == null || product.getCategory().isEmpty()) {
            return "";
        }
        return product.getCategory().stream()
                .sorted(Comparator.comparing(Category::getId))
                .map(Category::getName).collect(Collectors.joining(", "));*/
        return "";
    }
}
