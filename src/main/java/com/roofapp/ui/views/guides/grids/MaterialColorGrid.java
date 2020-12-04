package com.roofapp.ui.views.guides.grids;

import com.roofapp.backend.dao.roofdb.entity.guides.MaterialColor;
import com.roofapp.backend.dao.roofdb.entity.guides.Width;
import com.roofapp.backend.service.guides.MaterialColorGuideService;
import com.roofapp.backend.service.guides.WidthGuideService;
import com.roofapp.backend.utils.Helper;
import com.roofapp.ui.dataproviders.GridDataProvider;
import com.vaadin.flow.component.AttachEvent;
import com.vaadin.flow.component.UI;
import com.vaadin.flow.component.grid.Grid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * Grid of products, handling the visual presentation and filtering of a set of
 * items. This version uses an in-memory data source that is suitable for small
 * data sets.
 */
@Component
public class MaterialColorGrid extends Grid<MaterialColor> {

    @Autowired
    private final MaterialColorGuideService materialColorGuideService;

    private GridDataProvider dataProvider;

    public MaterialColorGrid(MaterialColorGuideService materialColorGuideService) {
        this.materialColorGuideService = materialColorGuideService;
        create();
        addGridColumn();
    }

    public void create(){
        dataProvider = new GridDataProvider(materialColorGuideService);
        setDataProvider(this.dataProvider);
    }


   public void addGridColumn(){

        addColumn(MaterialColor::getId).setHeader("Id").setWidth("50px")
                .setFlexGrow(5).setSortable(true).setKey("id").setResizable(true);

       addColumn(MaterialColor::getName).setHeader("Название цвета").setWidth("80px")
               .setFlexGrow(5).setSortable(true).setKey("name").setResizable(true);

       addColumn(MaterialColor::getColor).setHeader("Цвет").setWidth("20px")
               .setFlexGrow(5).setSortable(true).setKey("color").setResizable(true);

       addColumn(MaterialColor::getUser).setHeader("Пользователь").setWidth("20px")
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


    public void refresh(MaterialColor item) {

        getDataCommunicator().refresh(item);
    }

}
