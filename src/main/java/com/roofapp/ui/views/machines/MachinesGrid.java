package com.roofapp.ui.views.machines;

import com.roofapp.backend.dao.roofdb.entity.Machine;
import com.roofapp.backend.dao.roofdb.entity.guides.Width;
import com.vaadin.flow.component.AttachEvent;
import com.vaadin.flow.component.UI;
import com.vaadin.flow.component.grid.ColumnTextAlign;
import com.vaadin.flow.component.grid.Grid;
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
        addGridColumn();


      //  UI.getCurrent().getPage().addBrowserWindowResizeListener(
           //     e -> setColumnVisibility(e.getWidth()));
    }

   public void addGridColumn(){
        addColumn(Machine::getName).setHeader("Тип станка").setWidth("100px")
                .setFlexGrow(10).setSortable(true).setKey("name").setResizable(true);

       addColumn(Machine::getLength).setHeader("Длинна станка").setWidth("50px")
               .setFlexGrow(5).setSortable(true).setKey("length").setResizable(true);

       addColumn(TemplateRenderer.<Machine>of("[[item.allowableSize]]")
               .withProperty("allowableSize",
                       machine -> machine.getAllowableSize().stream().min(Comparator.comparing(Width::getValue)).get()+"-"+
                               machine.getAllowableSize().stream().max(Comparator.comparing(Width::getValue)).get()))
               .setHeader("Допустимые толщины")
               .setFlexGrow(5).setKey("allowableSize");
   }

    @Override
    protected void onAttach(AttachEvent attachEvent) {
        super.onAttach(attachEvent);
        UI.getCurrent().getInternals().setExtendedClientDetails(null);
    }


    public void refresh(Machine item) {
        getDataCommunicator().refresh(item);
    }

}
