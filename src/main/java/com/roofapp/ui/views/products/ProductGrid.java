package com.roofapp.ui.views.products;

import java.text.DecimalFormat;
import java.util.Comparator;

import com.vaadin.flow.component.AttachEvent;
import com.vaadin.flow.component.UI;
import com.vaadin.flow.component.grid.ColumnTextAlign;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.data.renderer.TemplateRenderer;
import com.roofapp.backend.dao.roofdb.entity.Product;
import lombok.extern.java.Log;

/**
 * Grid of products, handling the visual presentation and filtering of a set of
 * items. This version uses an in-memory data source that is suitable for small
 * data sets.
 */
@Log
public class ProductGrid extends Grid<Product> {

    public ProductGrid() {

        setSizeFull();

        addColumn(Product::getName).setHeader("Название")
                .setFlexGrow(20).setSortable(true).setKey("name");

        // Format and add " €" to price
        final DecimalFormat decimalFormat = new DecimalFormat();
        decimalFormat.setMaximumFractionDigits(2);
        decimalFormat.setMinimumFractionDigits(2);

        // Add an traffic light icon in front of availability
        // Three css classes with the same names of three availability values,
        // Available, Coming and Discontinued, are defined in shared-styles.css
        // and are
        // used here in availabilityTemplate.

        //final String availabilityTemplate = "<iron-icon icon=\"vaadin:circle\" class-name=\"[[item.type]]\"></iron-icon> [[item.type]]";
        final String materialColorTemplate = "<iron-icon icon=\"vaadin:circle\" class-name=\"[[item.materialColor]]\"></iron-icon> [[item.materialColor]]";
      /*  addColumn(TemplateRenderer.<Product>of(materialColorTemplate)
                .withProperty("materialColor",
                        product -> product.getMaterialColor().toString()))
                .setHeader("Цвет материала")
                .setComparator(Comparator
                        .comparing(Product::getMaterialColor))
                .setFlexGrow(5).setKey("materialColor");
*/
       /* final String typeTemplate = "[[item.type]]";
        addColumn(TemplateRenderer.<Product>of(typeTemplate)
                .withProperty("type",
                        product -> product.getType().toString()))
                                .setHeader("Тип материала")
                                .setComparator(Comparator
                                        .comparing(Product::getType))
                                .setFlexGrow(5).setKey("type");

        final String widthTemplate = "[[item.width]]";
        addColumn(TemplateRenderer.<Product>of(widthTemplate)
                .withProperty("width",
                        product -> product.getWidth().toString()))
                .setHeader("Толшина")
                .setComparator(Comparator
                        .comparing(Product::getWidth))
                .setFlexGrow(5).setKey("width");
*/

     /*  addColumn(product -> decimalFormat.format(product.getPrice()) + " р")
                   .setHeader("Цена ").setTextAlign(ColumnTextAlign.END)
                   .setComparator(Comparator.comparing(Product::getPrice))
                   .setFlexGrow(3).setKey("price");
*/

        final String cargoTypeTemplate = "[[item.cargoType]]";
        addColumn(TemplateRenderer.<Product>of(cargoTypeTemplate )
                .withProperty("cargoType",
                        product -> product.getCargoType().toString()))
                .setHeader("Тип материала")
                .setComparator(Comparator
                        .comparing(Product::getCargoType))
                .setFlexGrow(5).setKey("cargoType");


        addColumn(Product::getPrice).setHeader("Цена")
                .setFlexGrow(20).setSortable(true).setKey("price");

        addColumn(Product::getTitle).setHeader("Описание")
                .setFlexGrow(20).setSortable(true).setKey("title");

        addColumn(Product::getSecondTitle).setHeader("Доп. описание")
                .setFlexGrow(20).setSortable(true).setKey("second_title");

        addColumn(Product::getCategory).setHeader("Категория")
                .setFlexGrow(20).setSortable(true).setKey("category");

       /* addColumn(product -> product.getWeight() == 0 ? "-"
                : Integer.toString(product.getWeight()))
                        .setHeader("Вес")
                        .setTextAlign(ColumnTextAlign.END)
                        .setComparator(
                                Comparator.comparingInt(Product::getWeight))
                        .setFlexGrow(3).setKey("stock");
*/
    /*    addColumn(product -> product.getLength() == 0 ? "-"
                : Integer.toString(product.getLength()))
                .setHeader("Длина м.")
                .setTextAlign(ColumnTextAlign.END)
                .setComparator(
                        Comparator.comparingInt(Product::getLength))
                .setFlexGrow(3).setKey("length");
*/
        // Show all categories the product is in, separated by commas
      //  addColumn(this::formatCategories).setHeader("Category").setFlexGrow(12)
         //       .setKey("category");

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

    public Product getSelectedRow() {
        Notification.show("asdasd");
        return asSingleSelect().getValue();
    }

    public void refresh(Product product) {
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
