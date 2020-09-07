package com.roofapp.ui.views.ProductAmount;

import com.roofapp.backend.dao.roofdb.entity.ProductAmount;
import com.vaadin.flow.component.AttachEvent;
import com.vaadin.flow.component.UI;
import com.vaadin.flow.component.grid.ColumnTextAlign;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.data.renderer.TemplateRenderer;

import java.text.DecimalFormat;
import java.util.Comparator;

/**
 * Grid of products, handling the visual presentation and filtering of a set of
 * items. This version uses an in-memory data source that is suitable for small
 * data sets.
 */
public class ProductAmountGrid extends Grid<ProductAmount> {

    public ProductAmountGrid() {

        setSizeFull();

        addColumn(ProductAmount::getProduct).setHeader("Название")
                .setFlexGrow(10).setSortable(true).setKey("name");

        // Format and add " €" to price
        final DecimalFormat decimalFormat = new DecimalFormat();
        decimalFormat.setMaximumFractionDigits(2);
        decimalFormat.setMinimumFractionDigits(2);


        final String typeTemplate = "[[item.width]]";
        addColumn(TemplateRenderer.<ProductAmount>of(typeTemplate)
                .withProperty("width",
                        product -> product.getWidth().toString()))
                .setHeader("Толщина метала")
                .setComparator(Comparator
                        .comparing(ProductAmount::getWidth))
                .setFlexGrow(5).setKey("width");

        final String materialClassTemplate = "[[item.materialClass]]";
        addColumn(TemplateRenderer.<ProductAmount>of(materialClassTemplate)
                .withProperty("materialClass",
                        product -> product.getMaterialClass().toString()))
                .setHeader("Клас")
                .setComparator(Comparator
                        .comparing(ProductAmount::getMaterialClass))
                .setFlexGrow(5).setKey("materialClass");

        final String materialCoverTemplate = "[[item.materialCover]]";
        addColumn(TemplateRenderer.<ProductAmount>of(materialCoverTemplate)
                .withProperty("materialCover",
                        product -> product.getMaterialCover().toString()))
                .setHeader("Покрытие")
                .setComparator(Comparator
                        .comparing(ProductAmount::getMaterialCover))
                .setFlexGrow(5).setKey("materialCover");

        addColumn(product -> decimalFormat.format(product.getPrice()) + " р")
                .setHeader("Цена ").setTextAlign(ColumnTextAlign.END)
                .setComparator(Comparator.comparing(ProductAmount::getPrice))
                .setFlexGrow(3).setKey("price");

        // If the browser window size changes, check if all columns fit on
        // screen
        // (e.g. switching from portrait to landscape mode)
        UI.getCurrent().getPage().addBrowserWindowResizeListener(
                e -> setColumnVisibility(e.getWidth()));
    }

    private void setColumnVisibility(int width) {
        if (width > 800) {
            getColumnByKey("name").setVisible(true);
            getColumnByKey("price").setVisible(true);
       //     getColumnByKey("type").setVisible(true);
//            getColumnByKey("stock").setVisible(true);
          //  getColumnByKey("category").setVisible(true);
        } else if (width > 550) {
            getColumnByKey("name").setVisible(true);
            getColumnByKey("price").setVisible(true);
         //   getColumnByKey("type").setVisible(false);
         //   getColumnByKey("stock").setVisible(false);
         //   getColumnByKey("category").setVisible(true);
        } else {
            getColumnByKey("name").setVisible(true);
            getColumnByKey("price").setVisible(true);
          //  getColumnByKey("type").setVisible(false);
      //      getColumnByKey("stock").setVisible(false);
          //  getColumnByKey("category").setVisible(false);
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

    public ProductAmount  getSelectedRow() {
        Notification.show("asdasd");
        return asSingleSelect().getValue();
    }

    public void refresh(ProductAmount product) {
        getDataCommunicator().refresh(product);
    }

    private String formatCategories(ProductAmount product) {
      /*  if (product.getCategory() == null || product.getCategory().isEmpty()) {
            return "";
        }
        return product.getCategory().stream()
                .sorted(Comparator.comparing(Category::getId))
                .map(Category::getName).collect(Collectors.joining(", "));*/
        return "";
    }
}
