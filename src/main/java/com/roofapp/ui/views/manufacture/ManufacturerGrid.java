package com.roofapp.ui.views.manufacture;

import com.roofapp.backend.dao.roofdb.entity.Manufacturers;
import com.roofapp.backend.dao.roofdb.entity.Manufacturers;
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
public class ManufacturerGrid extends Grid<Manufacturers> {

    public ManufacturerGrid() {

        setSizeFull();

        addColumn(Manufacturers::getName).setHeader("Название")
                .setFlexGrow(15).setSortable(true).setKey("name");


        // Format and add " €" to price
        final DecimalFormat decimalFormat = new DecimalFormat();
        decimalFormat.setMaximumFractionDigits(2);
        decimalFormat.setMinimumFractionDigits(2);

        // Add an traffic light icon in front of availability
        // Three css classes with the same names of three availability values,
        // Available, Coming and Discontinued, are defined in shared-styles.css
        // and are
        // used here in availabilityTemplate.

        final String availabilityTemplate = "<iron-icon icon=\"vaadin:circle\" class-name=\"[[item.type]]\"></iron-icon> [[item.type]]";
      final String materialColorTemplate = "<iron-icon icon=\"vaadin:circle\" class-name=\"[[item.materialColor]]\"></iron-icon> [[item.materialColor]]";

        final String widthTemplate = "[[item.width]]";
        addColumn(TemplateRenderer.<Manufacturers>of(widthTemplate)
                .withProperty("width",
                        Manufacturers -> Manufacturers.getWidth().toString()))
                .setHeader("Толшина")
                .setComparator(Comparator
                        .comparing(Manufacturers::getWidth))
                .setFlexGrow(5).setKey("width");


        final String materialClassTemplate = "[[item.MaterialClass]]";
        addColumn(TemplateRenderer.<Manufacturers>of(materialClassTemplate)
                .withProperty("MaterialClass",
                        Manufacturers -> Manufacturers.getMaterialClass().toString()))
                .setHeader("Клас покрытия")
                .setComparator(Comparator
                        .comparing(Manufacturers::getMaterialClass))
                .setFlexGrow(5).setKey("MaterialClass");

        final String materialCoverTemplate = "[[item.MaterialCover]]";
        addColumn(TemplateRenderer.<Manufacturers>of(materialCoverTemplate)
                .withProperty("MaterialCover",
                        Manufacturers -> Manufacturers.getMaterialCover().toString()))
                .setHeader("Ппокрытие")
                .setComparator(Comparator
                        .comparing(Manufacturers::getMaterialCover))
                .setFlexGrow(5).setKey("MaterialCover");

        addColumn(TemplateRenderer.<Manufacturers>of(materialColorTemplate)
                .withProperty("materialColor",
                        Manufacturers -> Manufacturers.getMaterialColor()))
                .setHeader("Цвет материала")
                .setComparator(Comparator
                        .comparing(Manufacturers::getMaterialColor))
                .setFlexGrow(5).setKey("materialColor");

         addColumn(Manufacturers -> Manufacturers.getHeight() == 0 ? "-"
                : Double.toString(Manufacturers.getHeight()))
                .setHeader("Длина м.")
                .setComparator(
                        Comparator.comparingDouble(Manufacturers::getHeight))
                .setFlexGrow(3).setKey("length");



        UI.getCurrent().getPage().addBrowserWindowResizeListener(
                e -> setColumnVisibility(e.getWidth()));
    }

    private void setColumnVisibility(int width) {
        if (width > 800) {
            getColumnByKey("name").setVisible(true);
//            getColumnByKey("price").setVisible(true);
       //     getColumnByKey("type").setVisible(true);
//            getColumnByKey("stock").setVisible(true);
          //  getColumnByKey("category").setVisible(true);
        } else if (width > 550) {
            getColumnByKey("name").setVisible(true);
         //   getColumnByKey("price").setVisible(true);
         //   getColumnByKey("type").setVisible(false);
         //   getColumnByKey("stock").setVisible(false);
         //   getColumnByKey("category").setVisible(true);
        } else {
            getColumnByKey("name").setVisible(true);
          //  getColumnByKey("price").setVisible(true);
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

    public Manufacturers getSelectedRow() {
        Notification.show("asdasd");
        return asSingleSelect().getValue();
    }

    public void refresh(Manufacturers Manufacturers) {
        getDataCommunicator().refresh(Manufacturers);
    }

    private String formatCategories(Manufacturers Manufacturers) {
      /*  if (Manufacturers.getCategory() == null || Manufacturers.getCategory().isEmpty()) {
            return "";
        }
        return Manufacturers.getCategory().stream()
                .sorted(Comparator.comparing(Category::getId))
                .map(Category::getName).collect(Collectors.joining(", "));*/
        return "";
    }
}
