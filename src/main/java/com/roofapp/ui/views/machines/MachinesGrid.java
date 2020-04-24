package com.roofapp.ui.views.machines;

import com.roofapp.backend.data.entity.Machine;
import com.vaadin.flow.component.AttachEvent;
import com.vaadin.flow.component.UI;
import com.vaadin.flow.component.grid.ColumnTextAlign;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.data.renderer.TemplateRenderer;

import java.util.Comparator;

/**
 * Grid of products, handling the visual presentation and filtering of a set of
 * items. This version uses an in-memory data source that is suitable for small
 * data sets.
 */
public class MachinesGrid extends Grid<Machine> {

    public MachinesGrid() {

        setSizeFull();

        addColumn(Machine::getName).setHeader("Название")
                .setFlexGrow(20).setSortable(true).setKey("name");

        final String widthTemplateTemplate = "[[item.waveHeight]]";
        addColumn(TemplateRenderer.<Machine>of(widthTemplateTemplate)
                .withProperty("waveHeight",
                        item -> item.getWaveHeight().toString()))
                .setHeader("Тип волны")
                .setComparator(Comparator
                        .comparing(Machine::getWaveHeight))
                .setFlexGrow(5).setKey("waveHeight");


        final String typeTemplate = "[[item.type]]";
        addColumn(TemplateRenderer.<Machine>of(typeTemplate)
                .withProperty("type",
                        item ->  item.getType().toString()))
                                .setHeader("Тип проката")
                                .setComparator(Comparator
                                        .comparing(Machine::getType))
                                .setFlexGrow(5).setKey("type");

        final String widthTemplate = "[[item.width]]";
        addColumn(TemplateRenderer.<Machine>of(widthTemplate)
                .withProperty("width",
                        item -> item.getWidth().toString()))
                .setHeader("Допуст.толщ.метала")
                .setComparator(Comparator
                        .comparing(Machine::getWidth))
                .setFlexGrow(5).setKey("width");

        addColumn(product -> product.getLength() == 0 ? "-"
                : Integer.toString(product.getLength()))
                .setHeader("Длина стана м.")
                .setTextAlign(ColumnTextAlign.END)
                .setComparator(
                        Comparator.comparingInt(Machine::getLength))
                .setFlexGrow(3).setKey("length");





        UI.getCurrent().getPage().addBrowserWindowResizeListener(
                e -> setColumnVisibility(e.getWidth()));
    }

    private void setColumnVisibility(int width) {
        if (width > 800) {
            getColumnByKey("name").setVisible(true);
            getColumnByKey("type").setVisible(true);
        } else if (width > 550) {
            getColumnByKey("name").setVisible(true);
            getColumnByKey("type").setVisible(false);
        } else {
            getColumnByKey("name").setVisible(true);
            getColumnByKey("type").setVisible(false);
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

    public Machine getSelectedRow() {
        Notification.show("ok");
        return asSingleSelect().getValue();
    }

    public void refresh(Machine item) {
        getDataCommunicator().refresh(item);
    }

    private String formatCategories(Machine item) {
      /*  if (product.getCategory() == null || product.getCategory().isEmpty()) {
            return "";
        }
        return product.getCategory().stream()
                .sorted(Comparator.comparing(Category::getId))
                .map(Category::getName).collect(Collectors.joining(", "));*/
        return "";
    }
}
