package com.roofapp.ui.views.order.events;

import com.roofapp.backend.dao.roofdb.entity.Contractor;
import com.roofapp.ui.views.contractors.ContractorsForm;
import com.roofapp.ui.views.orderedit.OrderEditor;
import com.vaadin.flow.component.Component;
import com.vaadin.flow.component.ComponentEvent;

public class ContractorChangeEvent extends ComponentEvent<ContractorsForm> {

    private final Contractor contractor;

    public ContractorChangeEvent(ContractorsForm component, Contractor contractor) {
        super(component, false);
        this.contractor = contractor;
    }

    public Contractor getContractor() {
        return contractor;
    }

}