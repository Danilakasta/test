package com.roofapp.ui.views.guides.grids;

import com.roofapp.backend.dao.roofdb.entity.guides.WarehouseType;
import com.roofapp.backend.dao.roofdb.entity.guides.WarehouseType;
import com.roofapp.backend.service.guides.WarehouseTypeGuideService;
import com.roofapp.backend.service.guides.WarehouseTypeGuideService;
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
public class WarehouseTypeGrid extends Grid<WarehouseType> {

    @Autowired
    private final WarehouseTypeGuideService warehouseTypeGuideService;

    private GridDataProvider dataProvider;

    public WarehouseTypeGrid(WarehouseTypeGuideService warehouseTypeGuideService) {
        this.warehouseTypeGuideService = warehouseTypeGuideService;
        create();
        addGridColumn();
    }

    public void create(){
        dataProvider = new GridDataProvider(warehouseTypeGuideService);
        setDataProvider(this.dataProvider);
    }


   public void addGridColumn(){

        addColumn(WarehouseType::getId).setHeader("Id").setWidth("50px")
                .setFlexGrow(5).setSortable(true).setKey("id").setResizable(true);

       addColumn(WarehouseType::getName).setHeader("Название").setWidth("80px")
               .setFlexGrow(5).setSortable(true).setKey("name").setResizable(true);

       addColumn(WarehouseType::getDescription).setHeader("Назначение").setWidth("100px")
               .setFlexGrow(5).setSortable(true).setKey("color").setResizable(true);

       addColumn(WarehouseType::getUser).setHeader("Пользователь").setWidth("20px")
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


    public void refresh(WarehouseType item) {

        getDataCommunicator().refresh(item);
    }

}
