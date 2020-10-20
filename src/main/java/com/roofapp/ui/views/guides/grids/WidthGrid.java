package com.roofapp.ui.views.guides.grids;

import com.roofapp.backend.dao.roofdb.entity.Machine;
import com.roofapp.backend.dao.roofdb.entity.guides.Width;
import com.roofapp.backend.service.guides.WidthGuideService;
import com.roofapp.backend.utils.Helper;
import com.roofapp.ui.dataproviders.GridDataProvider;
import com.vaadin.flow.component.AttachEvent;
import com.vaadin.flow.component.UI;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.data.renderer.LocalDateRenderer;
import com.vaadin.flow.data.renderer.TemplateRenderer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.Comparator;

/**
 * Grid of products, handling the visual presentation and filtering of a set of
 * items. This version uses an in-memory data source that is suitable for small
 * data sets.
 */
@Component
public class WidthGrid extends Grid<Width> {

    @Autowired
    private final WidthGuideService widthGuideService;

    private GridDataProvider dataProvider;

    public WidthGrid(WidthGuideService widthGuideService) {
        this.widthGuideService = widthGuideService;
        create();
        addGridColumn();
    }

    public void create(){
        dataProvider = new GridDataProvider(widthGuideService);
        setDataProvider(this.dataProvider);
    }


   public void addGridColumn(){

        addColumn(Width::getId).setHeader("Id").setWidth("50px")
                .setFlexGrow(5).setSortable(true).setKey("id").setResizable(true);

       addColumn(Width::getValue).setHeader("Толщина листа").setWidth("20px")
               .setFlexGrow(5).setSortable(true).setKey("value").setResizable(true);


       addColumn(Width::getUser).setHeader("Пользователь").setWidth("20px")
               .setFlexGrow(5).setSortable(true).setKey("user").setResizable(true);


       addColumn(item-> Helper.dateFormat(item.getCreated())).setHeader("Создано")
               .setFlexGrow(5).setSortable(true).setKey("created").setResizable(true);


       addColumn(item-> Helper.dateFormat(item.getModified())).setHeader("Изменено")
               .setFlexGrow(5).setSortable(true).setKey("modified").setResizable(true);

   }

    @Override
    protected void onAttach(AttachEvent attachEvent) {
        super.onAttach(attachEvent);
        UI.getCurrent().getInternals().setExtendedClientDetails(null);
    }


    public void refresh(Width item) {

        getDataCommunicator().refresh(item);
    }

}
