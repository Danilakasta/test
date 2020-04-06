package com.roofapp.ui.views.contractors;

import com.roofapp.backend.data.entity.Contractor;
import com.roofapp.backend.data.entity.Product;
import com.vaadin.flow.component.AttachEvent;
import com.vaadin.flow.component.UI;
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
public class ContractorGrid extends Grid<Contractor> {

    public ContractorGrid() {

        setSizeFull();

        addColumn(Contractor::getCompanyName).setHeader("Название")
                .setFlexGrow(20).setSortable(true).setKey("companyname");

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


        final String typeTemplate = "[[item.type]]";
        addColumn(TemplateRenderer.<Contractor>of(typeTemplate)
                .withProperty("type",
                        item -> item.getType().toString()))
                                .setHeader("Тип материала")
                                .setComparator(Comparator
                                        .comparing(Contractor::getType))
                                .setFlexGrow(5).setKey("type");

        addColumn(Contractor::getPhone).setHeader("Телефон")
                .setFlexGrow(5).setSortable(true).setKey("phone");


        addColumn(Contractor::getEmail).setHeader("Почта")
                .setFlexGrow(5).setSortable(true).setKey("email");


        addColumn(Contractor::getUrAddress).setHeader("Юр. адрес")
                .setFlexGrow(5).setSortable(true).setKey("urAddress");

        addColumn(Contractor::getFizAddress).setHeader("Физ. адрес")
                .setFlexGrow(5).setSortable(true).setKey("fizAddress");

        addColumn(Contractor::getInn).setHeader("ИНН")
                .setFlexGrow(5).setSortable(true).setKey("inn");

        addColumn(Contractor::getKpp).setHeader("КПП")
                .setFlexGrow(5).setSortable(true).setKey("kpp");

        addColumn(Contractor::getOkpo).setHeader("ОКПО")
                .setFlexGrow(5).setSortable(true).setKey("okpo");

        addColumn(Contractor::getOgrn).setHeader("ОГРН")
                .setFlexGrow(5).setSortable(true).setKey("ogpn");

      /*  final String widthTemplate = "[[item.width]]";
        addColumn(TemplateRenderer.<Product>of(widthTemplate)
                .withProperty("width",
                        item -> item.getWidth().toString()))
                .setHeader("Толшина")
                .setComparator(Comparator
                        .comparing(Contractor::getWidth))
                .setFlexGrow(5).setKey("width");

        addColumn(product -> decimalFormat.format(product.getPrice()) + " р")
                .setHeader("Цена закупки").setTextAlign(ColumnTextAlign.END)
                .setComparator(Comparator.comparing(Product::getPrice))
                .setFlexGrow(3).setKey("price");

        addColumn(product -> product.getWeight() == 0 ? "-"
                : Integer.toString(product.getWeight()))
                        .setHeader("Вес")
                        .setTextAlign(ColumnTextAlign.END)
                        .setComparator(
                                Comparator.comparingInt(Product::getWeight))
                        .setFlexGrow(3).setKey("stock");

        addColumn(product -> product.getLength() == 0 ? "-"
                : Integer.toString(product.getLength()))
                .setHeader("Длина м.")
                .setTextAlign(ColumnTextAlign.END)
                .setComparator(
                        Comparator.comparingInt(Product::getLength))
                .setFlexGrow(3).setKey("length");

        // Show all categories the product is in, separated by commas
      //  addColumn(this::formatCategories).setHeader("Category").setFlexGrow(12)
         //       .setKey("category");

        // If the browser window size changes, check if all columns fit on
        // screen
        // (e.g. switching from portrait to landscape mode)*/

        UI.getCurrent().getPage().addBrowserWindowResizeListener(
                e -> setColumnVisibility(e.getWidth()));
    }

    private void setColumnVisibility(int width) {
     if (width > 800) {
            getColumnByKey("companyname").setVisible(true);
           // getColumnByKey("price").setVisible(true);
          //  getColumnByKey("type").setVisible(true);
          //  getColumnByKey("stock").setVisible(true);
          //  getColumnByKey("category").setVisible(true);
      /*     } else if (width > 550) {
            getColumnByKey("productname").setVisible(true);
            getColumnByKey("price").setVisible(true);
            getColumnByKey("type").setVisible(false);
            getColumnByKey("stock").setVisible(false);
         //   getColumnByKey("category").setVisible(true);
        } else {
            getColumnByKey("productname").setVisible(true);
            getColumnByKey("price").setVisible(true);
            getColumnByKey("type").setVisible(false);
            getColumnByKey("stock").setVisible(false);
          //  getColumnByKey("category").setVisible(false);*/
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

    public Contractor getSelectedRow() {
        Notification.show("ок");
        return asSingleSelect().getValue();
    }

    public void refresh(Contractor contractor) {
        getDataCommunicator().refresh(contractor);
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
