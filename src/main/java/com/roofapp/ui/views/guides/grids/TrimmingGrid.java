package com.roofapp.ui.views.guides.grids;

import com.roofapp.backend.dao.roofdb.entity.guides.Trimming;
import com.roofapp.backend.dao.roofdb.entity.guides.Trimming;
import com.roofapp.backend.service.guides.TrimmingGuideService;
import com.roofapp.backend.utils.Helper;
import com.roofapp.ui.dataproviders.GridDataProvider;
import com.vaadin.flow.component.AttachEvent;
import com.vaadin.flow.component.UI;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.data.renderer.TemplateRenderer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * Grid of products, handling the visual presentation and filtering of a set of
 * items. This version uses an in-memory data source that is suitable for small
 * data sets.
 */
@Component
public class TrimmingGrid extends Grid<Trimming> {

    @Autowired
    private final TrimmingGuideService trimmingGuideService;

    private GridDataProvider dataProvider;

    public TrimmingGrid( TrimmingGuideService  trimmingGuideService) {
        this.trimmingGuideService = trimmingGuideService;
        create();
        addGridColumn();
    }

    public void create(){
        dataProvider = new GridDataProvider(trimmingGuideService);
        setDataProvider(this.dataProvider);
    }


   public void addGridColumn(){

        addColumn(Trimming::getId).setHeader("Id")
                .setFlexGrow(5).setSortable(true).setKey("id").setResizable(true);

       addColumn(Trimming::getWidth).setHeader("Толщина листа")
               .setFlexGrow(5).setSortable(true).setKey("width").setResizable(true);

       addColumn(item-> item.getValue() + " м").setHeader("Значение торцевания")
               .setFlexGrow(5).setSortable(true).setKey("value").setResizable(true);


       addColumn(Trimming::getUser).setHeader("Пользователь")
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


    public void refresh(Trimming item) {

        getDataCommunicator().refresh(item);
    }

}
