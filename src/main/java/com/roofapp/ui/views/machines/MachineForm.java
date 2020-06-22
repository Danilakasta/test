package com.roofapp.ui.views.machines;

import com.roofapp.backend.data.MachineType;
import com.roofapp.backend.data.WaveHeight;
import com.roofapp.backend.data.Width;
import com.roofapp.backend.data.entity.Machine;
import com.vaadin.flow.component.Key;
import com.vaadin.flow.component.KeyModifier;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.html.Div;
import com.vaadin.flow.component.html.Span;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.component.select.Select;
import com.vaadin.flow.component.textfield.IntegerField;
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.component.textfield.TextFieldVariant;
import com.vaadin.flow.data.binder.BeanValidationBinder;
import com.vaadin.flow.data.binder.Binder;
import com.vaadin.flow.data.value.ValueChangeMode;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * A form for editing a single Machine.
 */

public class MachineForm extends Div {

    //Form field
    private VerticalLayout content;
    private TextField name;
    private IntegerField length;
    private Select<MachineType> type;
    private Select<Width> width;
    private Select<WaveHeight> waveHeight;
    private IntegerField trimming;

    private Binder<Machine> binder;
    private Machine currentMachine;

    //Form button
    private Button save;
    private Button discard;
    private Button cancel;
    private Button delete;


    private final MachineViewLogic viewLogic;

  //  public void setViewLogic(MachineViewLogic viewLogic) {
     //   this.viewLogic = viewLogic;
   // }



    @Autowired
    public MachineForm(MachineViewLogic viewLogic) {
        this.viewLogic = viewLogic;
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

        name = new TextField("Название");
        name.setWidth("50%");
        name.setRequired(true);
        name.setValueChangeMode(ValueChangeMode.EAGER);

        waveHeight = new Select<>();
        waveHeight.setLabel("Высота волны");
        waveHeight.setWidth("25%");
        waveHeight.setItems(WaveHeight.values());

        type = new Select<>();
        type.setLabel("Тип проката");
        type.setWidth("25%");
        type.setItems(MachineType.values());

        final HorizontalLayout horizontalLayout2 = new HorizontalLayout(name, waveHeight, type);
        horizontalLayout2.setWidth("100%");
        horizontalLayout2.setFlexGrow(1, name, waveHeight, type);
        content.add(horizontalLayout2);


        width = new Select<>();
        width.setLabel("Допустимая толщина мет");
        width.setWidth("100%");
        width.setItems(Width.values());

        // content.add(materialColor);
        length = new IntegerField("Длинна стана м.");
        length.setWidth("100%");
        length.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        length.setValueChangeMode(ValueChangeMode.EAGER);

        final HorizontalLayout horizontalLayout3 = new HorizontalLayout(width, length);
        horizontalLayout3.setWidth("100%");
        horizontalLayout3.setFlexGrow(1, width, length);
        content.add(horizontalLayout3);


        trimming = new IntegerField("Торцовка");
        trimming.setWidth("50%");
        trimming.setSuffixComponent(new Span("см."));
        trimming.setValueChangeMode(ValueChangeMode.EAGER);

        final HorizontalLayout horizontalLayout4 = new HorizontalLayout(trimming);
        horizontalLayout4.setWidth("50%");
        horizontalLayout4.setFlexGrow(1, trimming);
        content.add(horizontalLayout4);

    }

    public void setBinder() {
        binder = new BeanValidationBinder<>(Machine.class);
        binder.bindInstanceFields(this);


        // enable/disable save button while editing
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
