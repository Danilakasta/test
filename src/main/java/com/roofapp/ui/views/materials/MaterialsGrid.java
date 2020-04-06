package com.roofapp.ui.views.materials;

import com.roofapp.backend.data.entity.Material;
import com.roofapp.backend.data.entity.Material;
import com.vaadin.flow.component.AttachEvent;
import com.vaadin.flow.component.UI;
import com.vaadin.flow.component.grid.ColumnTextAlign;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.data.renderer.TemplateRenderer;

import java.text.DecimalFormat;
import java.util.Comparator;

/**
 * Grid of Materials, handling the visual presentation and filtering of a set of
 * items. This version uses an in-memory data source that is suitable for small
 * data sets.
 */
public class MaterialsGrid extends Grid<Material> {

    public MaterialsGrid() {

        setSizeFull();

        addColumn(Material::getName).setHeader("Название")
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
        addColumn(TemplateRenderer.<Material>of(materialColorTemplate)
                .withProperty("materialColor",
                        Material -> Material.getMaterialColor().toString()))
                .setHeader("Цвет материала")
                .setComparator(Comparator
                        .comparing(Material::getMaterialColor))
                .setFlexGrow(5).setKey("materialColor");

        final String typeTemplate = "[[item.type]]";
        addColumn(TemplateRenderer.<Material>of(typeTemplate)
                .withProperty("type",
                        Material -> Material.getType().toString()))
                                .setHeader("Тип материала")
                                .setComparator(Comparator
                                        .comparing(Material::getType))
                                .setFlexGrow(5).setKey("type");


        final String widthTemplate = "[[item.width]]";
        addColumn(TemplateRenderer.<Material>of(widthTemplate)
                .withProperty("width",
                        Material -> Material.getWidth().toString()))
                .setHeader("Толшина")
                .setComparator(Comparator
                        .comparing(Material::getWidth))
                .setFlexGrow(5).setKey("width");

        final String coverTemplate = "[[item.cover]]";
        addColumn(TemplateRenderer.<Material>of(widthTemplate)
                .withProperty("cover",
                         Material -> Material.getCover().toString()))
                .setHeader("Покрытие")
                .setComparator(Comparator
                        .comparing(Material::getCover))
                .setFlexGrow(5).setKey("cover");


        addColumn(Material -> decimalFormat.format(Material.getPrice()) + " р")
                .setHeader("Цена закупки").setTextAlign(ColumnTextAlign.END)
                .setComparator(Comparator.comparing(Material::getPrice))
                .setFlexGrow(3).setKey("price");

        addColumn(Material -> Material.getWeight() == 0 ? "-"
                : Integer.toString(Material.getWeight()))
                        .setHeader("Вес")
                        .setTextAlign(ColumnTextAlign.END)
                        .setComparator(
                                Comparator.comparingInt(Material::getWeight))
                        .setFlexGrow(3).setKey("stock");

        addColumn(Material -> Material.getLength() == 0 ? "-"
                : Integer.toString(Material.getLength()))
                .setHeader("Длина м.")
                .setTextAlign(ColumnTextAlign.END)
                .setComparator(
                        Comparator.comparingInt(Material::getLength))
                .setFlexGrow(3).setKey("length");



        addColumn(Material::getParty).setHeader("Партия")
                .setFlexGrow(5).setSortable(true).setKey("рarty");

        addColumn(Material::getManufacturer).setHeader("Производитель")
                .setFlexGrow(5).setSortable(true).setKey("manufacturer");

        addColumn(Material::getTeorCoefficient).setHeader("Теор. коеф")
                .setFlexGrow(5).setSortable(true).setKey("teorCoefficient");

        addColumn(Material::getFactCoefficient).setHeader("Факт. коэф")
                .setFlexGrow(5).setSortable(true).setKey("factCoefficient");

        addColumn(Material::getUsed).setHeader("Израсходовано")
                .setFlexGrow(5).setSortable(true).setKey("used");


        // Show all categories the Material is in, separated by commas
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
            getColumnByKey("type").setVisible(true);
            getColumnByKey("stock").setVisible(true);
          //  getColumnByKey("category").setVisible(true);
        } else if (width > 550) {
            getColumnByKey("name").setVisible(true);
            getColumnByKey("price").setVisible(true);
            getColumnByKey("type").setVisible(false);
            getColumnByKey("stock").setVisible(false);
         //   getColumnByKey("category").setVisible(true);
        } else {
            getColumnByKey("name").setVisible(true);
            getColumnByKey("price").setVisible(true);
            getColumnByKey("type").setVisible(false);
            getColumnByKey("stock").setVisible(false);
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

    public Material getSelectedRow() {
        Notification.show("ок");
        return asSingleSelect().getValue();
    }

    public void refresh(Material Material) {
        getDataCommunicator().refresh(Material);
    }

    private String formatCategories(Material Material) {
      /*  if (Material.getCategory() == null || Material.getCategory().isEmpty()) {
            return "";
        }
        return Material.getCategory().stream()
                .sorted(Comparator.comparing(Category::getId))
                .map(Category::getName).collect(Collectors.joining(", "));*/
        return "";
    }
}
