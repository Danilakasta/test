package com.roofapp.ui.views.machines;

import com.roofapp.backend.dao.roofdb.entity.Machine;
import com.roofapp.backend.dao.roofdb.entity.guides.Width;
import com.roofapp.backend.service.guides.WidthGuideService;
import com.vaadin.flow.component.Key;
import com.vaadin.flow.component.KeyModifier;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.html.Div;
import com.vaadin.flow.component.html.Span;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.component.textfield.IntegerField;
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.component.textfield.TextFieldVariant;
import com.vaadin.flow.data.binder.BeanValidationBinder;
import com.vaadin.flow.data.binder.Binder;
import com.vaadin.flow.data.value.ValueChangeMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.vaadin.gatanaso.MultiselectComboBox;

/**
 * A form for editing a single Machine.
 */

public class MachineForm extends Div {

    //Form field
    private VerticalLayout content;
    private TextField name;
    private IntegerField length;
    private MultiselectComboBox<Width> allowableSize;

    private Binder<Machine> binder;
    private Machine currentMachine;

    //Form button
    private Button save;
    private Button discard;
    private Button cancel;
    private Button delete;


    private final MachineViewLogic viewLogic;
    private final WidthGuideService guidesService;


    @Autowired
    public MachineForm(MachineViewLogic viewLogic, WidthGuideService guidesService) {
        this.viewLogic = viewLogic;
        this.guidesService = guidesService;
        addFormItems();
        setBinder();
        addButtonBar();
    }


    public void addFormItems() {
        setClassName("product-form");

        content = new VerticalLayout();
        content.setSizeUndefined();
        content.addClassName("product-form-content");
        add(content);

        name = new TextField("Тип станка");
        name.setWidth("100%");
        name.setRequired(true);
        content.add(name);

        length = new IntegerField("Длинна стана");
        length.setWidth("100%");
        length.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        length.setValueChangeMode(ValueChangeMode.EAGER);
        length.setSuffixComponent(new Span("м."));
        content.add(length);

        allowableSize = new MultiselectComboBox();
        allowableSize.setLabel("Допустимые толщины");
        allowableSize.setWidth("200px");
        allowableSize.setItems(guidesService.getAllWidth());
        content.add(allowableSize);


    }

    public void setBinder() {
        binder = new BeanValidationBinder<>(Machine.class);
        binder.bindInstanceFields(this);

        binder.addStatusChangeListener(event -> {
            final boolean isValid = !event.hasValidationErrors();
            final boolean hasChanges = binder.hasChanges();
            save.setEnabled(hasChanges && isValid);
            discard.setEnabled(hasChanges);
        });
    }


    public void addButtonBar() {
        save = new Button("Сохранить");
        save.setWidth("100%");
        save.addThemeVariants(ButtonVariant.LUMO_PRIMARY);
        save.addClickListener(event -> {
            if (currentMachine != null
                    && binder.writeBeanIfValid(currentMachine)) {
                viewLogic.saveMachine(currentMachine);
            }
        });
        save.addClickShortcut(Key.KEY_S, KeyModifier.CONTROL);

        discard = new Button("Сбросить");
        discard.setWidth("100%");
        discard.addClickListener(
                event -> viewLogic.editMachine(currentMachine));

        cancel = new Button("Отменить");
        cancel.setWidth("100%");
        cancel.addClickListener(event -> viewLogic.cancel());
        cancel.addClickShortcut(Key.ESCAPE);
        getElement()
                .addEventListener("keydown", event -> viewLogic.cancel())
                .setFilter("event.key == 'Escape'");

        delete = new Button("Удалить");
        delete.setWidth("100%");
        delete.addThemeVariants(ButtonVariant.LUMO_ERROR,
                ButtonVariant.LUMO_PRIMARY);
        delete.addClickListener(event -> {
            if (currentMachine != null) {
                viewLogic.deleteMachine(currentMachine);
            }
        });

        content.add(save, discard, delete, cancel);
    }

    /**
     * Edit item
     *
     * @param item
     */
    public void editMachine(Machine item) {
        if (item == null) {
            item = new Machine();
        }
        delete.setVisible(!item.isNew());
        currentMachine = item;
        binder.readBean(item);
    }
}
