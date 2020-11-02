package com.roofapp.ui.views.materials;

import com.roofapp.backend.dao.roofdb.entity.Material;
import com.vaadin.flow.component.AttachEvent;
import com.vaadin.flow.component.UI;
import com.vaadin.flow.component.grid.ColumnTextAlign;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.data.renderer.TemplateRenderer;

import java.util.Comparator;

/**
 * Grid of Materials, handling the visual presentation and filtering of a set of
 * items. This version uses an in-memory data source that is suitable for small
 * data sets.
 */
public class MaterialsGrid extends Grid<Material> {

    public MaterialsGrid() {
        setSizeFull();

        addColumn(Material::getSerialNumber).setHeader("Порядковый номер")
                .setFlexGrow(20).setSortable(true).setKey("serialNumber").setWidth("100px").setResizable(true);

        addColumn(Material::getManufacturer).setHeader("Производитель")
                .setFlexGrow(50).setSortable(true).setKey("manufacturer").setWidth("200px").setResizable(true);

        addColumn(Material::getParty).setHeader("Номер партии")
                .setFlexGrow(20).setSortable(true).setKey("рarty").setWidth("150px").setResizable(true);

        final String materialColorTemplate = "<iron-icon icon=\"vaadin:circle\" class-name=\"[[item.materialColor]]\"></iron-icon> [[item.materialColor]]";
        addColumn(TemplateRenderer.<Material>of(materialColorTemplate)
                .withProperty("materialColor",
                        Material -> Material.getMaterialColor() != null ? Material.getMaterialColor().toString(): null))
                .setHeader("Цвет материала")
                .setComparator(Comparator
                        .comparing(Material::getMaterialColor))
                .setFlexGrow(5).setKey("materialColor").setWidth("150px").setResizable(true);

        addColumn(Material::getCover).setHeader("Покрытие")
                .setFlexGrow(20).setSortable(true).setKey("cover").setWidth("150px").setResizable(true);


        addColumn(Material::getMaterialClass).setHeader("Классс покрытия")
                .setFlexGrow(20).setSortable(true).setKey("materialClass").setResizable(true);

        addColumn(Material::getWidth).setHeader("Толщина")
                .setFlexGrow(20).setSortable(true).setKey("width").setResizable(true).setWidth("100px");

        addColumn(Material -> Material.getPrice())
                .setHeader("Цена бухты").setTextAlign(ColumnTextAlign.END)
                .setComparator(Comparator.comparing(Material::getPrice))
                .setFlexGrow(3).setKey("price").setResizable(true).setWidth("150px");

        addColumn(Material -> Material.getPriceDelivery())
                .setHeader("Цена доставки").setTextAlign(ColumnTextAlign.END)
                .setComparator(Comparator.comparing(Material::getPriceDelivery))
                .setFlexGrow(3).setKey("priceDelivery").setResizable(true).setWidth("150px");

        addColumn(Material -> Material.getPriceOneTone())
                .setHeader("Цена за тонну").setTextAlign(ColumnTextAlign.END)
                .setComparator(Comparator.comparing(Material::getPriceOneTone))
                .setFlexGrow(3).setKey("priceOneTone").setResizable(true).setWidth("150px");


        addColumn(Material -> Material.getWeightOfBay())
                .setHeader("Вес бухты кг").setTextAlign(ColumnTextAlign.END)
                .setComparator(Comparator.comparing(Material::getPriceOneMetre))
                .setFlexGrow(3).setKey("weightOfBay").setResizable(true).setWidth("150px");

        addColumn(Material -> Material != null && Material.getLength() == 0 ? "-"
                : Integer.toString(Material.getLength()))
                .setHeader("Длина м.")
                .setTextAlign(ColumnTextAlign.END)
                .setComparator(
                        Comparator.comparingInt(Material::getLength))
                .setFlexGrow(3).setKey("length").setResizable(true).setWidth("150px");

        addColumn(Material -> Material.getPriceOneMetre())
                .setHeader("Себес. пог.м. теор").setTextAlign(ColumnTextAlign.END)
                .setComparator(Comparator.comparing(Material::getPriceOneMetre))
                .setFlexGrow(3).setKey("priceOneMetre").setResizable(true).setWidth("150px");

        addColumn(Material::getTeorCoefficient).setHeader("Теор. коеф")
                .setFlexGrow(5).setSortable(true).setKey("teorCoefficient").setResizable(true).setWidth("150px");

        addColumn(Material::getFactCoefficient).setHeader("Факт. коэф")
                .setFlexGrow(5).setSortable(true).setKey("factCoefficient").setResizable(true).setWidth("150px");

        addColumn(Material::getUsed).setHeader("Израсходовано")
                .setFlexGrow(5).setSortable(true).setKey("used").setResizable(true).setWidth("150px");

        addColumn(Material::getRemains).setHeader("остаток")
                .setFlexGrow(5).setSortable(true).setKey("remains").setResizable(true).setWidth("150px");

        UI.getCurrent().getPage().addBrowserWindowResizeListener(
                e -> setColumnVisibility(e.getWidth()));
    }

    private void setColumnVisibility(int width) {
        if (width > 800) {
            getColumnByKey("cover").setVisible(true);
            getColumnByKey("width").setVisible(true);
            getColumnByKey("price").setVisible(true);
            getColumnByKey("priceDelivery").setVisible(true);
            getColumnByKey("priceOneTone").setVisible(true);
            getColumnByKey("weightOfBay").setVisible(true);
            getColumnByKey("length").setVisible(true);
            getColumnByKey("priceOneMetre").setVisible(true);
            getColumnByKey("factCoefficient").setVisible(true);
            getColumnByKey("used").setVisible(true);
            getColumnByKey("remains").setVisible(true);
        } else if (width > 550) {
            getColumnByKey("cover").setVisible(false);
            getColumnByKey("width").setVisible(false);
            getColumnByKey("price").setVisible(false);
            getColumnByKey("priceDelivery").setVisible(false);
            getColumnByKey("priceOneTone").setVisible(false);
            getColumnByKey("weightOfBay").setVisible(false);
            getColumnByKey("length").setVisible(false);
            getColumnByKey("priceOneMetre").setVisible(false);
            getColumnByKey("factCoefficient").setVisible(false);
            getColumnByKey("used").setVisible(false);
            getColumnByKey("remains").setVisible(false);
        } else {
            getColumnByKey("price").setVisible(true);
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
