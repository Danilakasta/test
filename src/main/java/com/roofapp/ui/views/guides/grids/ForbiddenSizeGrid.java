package com.roofapp.ui.views.guides.grids;

import com.roofapp.backend.dao.roofdb.entity.guides.ForbiddenSize;
import com.roofapp.backend.dao.roofdb.entity.guides.ForbiddenSize;
import com.roofapp.backend.service.guides.ForbiddenSizeService;
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
public class ForbiddenSizeGrid extends Grid<ForbiddenSize> {

    @Autowired
    private final ForbiddenSizeService forbiddenSizeService;

    private GridDataProvider dataProvider;

    public ForbiddenSizeGrid(ForbiddenSizeService forbiddenSizeService) {
        this.forbiddenSizeService = forbiddenSizeService;
        create();
        addGridColumn();
    }

    public void create(){
        dataProvider = new GridDataProvider(forbiddenSizeService);
        setDataProvider(this.dataProvider);
    }


   public void addGridColumn(){

        addColumn(ForbiddenSize::getId).setHeader("Id")
                .setFlexGrow(5).setSortable(true).setKey("id").setResizable(true);

       addColumn(ForbiddenSize::getMachine).setHeader("Станок")
               .setFlexGrow(5).setSortable(true).setKey("machine").setResizable(true);

       addColumn(ForbiddenSize::getProduct).setHeader("Продукт")
               .setFlexGrow(5).setSortable(true).setKey("product").setResizable(true);

       addColumn(ForbiddenSize::getValueFrom).setHeader("Значение от")
               .setFlexGrow(5).setSortable(true).setKey("valueFrom").setResizable(true);

       addColumn(ForbiddenSize::getValueTo).setHeader("Значение до")
               .setFlexGrow(5).setSortable(true).setKey("valueTo").setResizable(true);


       addColumn(ForbiddenSize::getUser).setHeader("Пользователь")
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


    public void refresh(ForbiddenSize item) {

        getDataCommunicator().refresh(item);
    }

}
