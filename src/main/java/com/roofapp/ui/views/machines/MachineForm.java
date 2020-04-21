package com.roofapp.ui.views.machines;

import com.roofapp.backend.data.MachineType;
import com.roofapp.backend.data.WaveHeight;
import com.roofapp.backend.data.Width;
import com.roofapp.backend.data.entity.Machine;
import com.roofapp.backend.service.MachineService;
import com.roofapp.ui.views.products.ProductForm;
import com.vaadin.flow.component.Key;
import com.vaadin.flow.component.KeyModifier;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.html.Div;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.component.select.Select;
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.component.textfield.TextFieldVariant;
import com.vaadin.flow.data.binder.BeanValidationBinder;
import com.vaadin.flow.data.binder.Binder;
import com.vaadin.flow.data.converter.StringToBigDecimalConverter;
import com.vaadin.flow.data.converter.StringToIntegerConverter;
import com.vaadin.flow.data.value.ValueChangeMode;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Locale;

/**
 * A form for editing a single Machine.
 */

public class MachineForm extends Div {

    private final VerticalLayout content;

    MachineService MachineService;

    private final TextField name;

    private final TextField length;
    private final Select<MachineType> type;
    
    private final Select<Width> width;

    private final Select<WaveHeight> waveHeight;

    //   private final CheckboxGroup<Category> category;
    private Button save;
    private Button discard;
    private Button cancel;
    private final Button delete;

    private MachineViewLogic viewLogic;

    public void setViewLogic(MachineViewLogic viewLogic) {
        this.viewLogic = viewLogic;
    }

    private final Binder<Machine> binder;
    private Machine currentMachine;

    private static class PriceConverter extends StringToBigDecimalConverter {

        public PriceConverter() {
            super(BigDecimal.ZERO, "Cannot convert value to a number.");
        }

        @Override
        protected NumberFormat getFormat(Locale locale) {
            // Always display currency with two decimals
            final NumberFormat format = super.getFormat(locale);
            if (format instanceof DecimalFormat) {
                format.setMaximumFractionDigits(2);
                format.setMinimumFractionDigits(2);
            }
            return format;
        }
    }

    private static class StockCountConverter extends StringToIntegerConverter {

        public StockCountConverter() {
            super(0, "Could not convert value to " + Integer.class.getName()
                    + ".");
        }

        @Override
        protected NumberFormat getFormat(Locale locale) {
            // Do not use a thousands separator, as HTML5 input type
            // number expects a fixed wire/DOM number format regardless
            // of how the browser presents it to the user (which could
            // depend on the browser locale).
            final DecimalFormat format = new DecimalFormat();
            format.setMaximumFractionDigits(0);
            format.setDecimalSeparatorAlwaysShown(false);
            format.setParseIntegerOnly(true);
            format.setGroupingUsed(false);
            return format;
        }
    }

    @Autowired
    public MachineForm(MachineViewLogic viewLogic, MachineService MachineService) {
        this.MachineService = MachineService;
        setClassName("Machine-form ");

        content = new VerticalLayout();
        content.setSizeUndefined();
        content.addClassName("Machine-form-content");
        add(content);

     //   viewLogic = sampleCrudLogic;

        name = new TextField("Название");
        name.setWidth("100%");
        name.setRequired(true);
        name.setValueChangeMode(ValueChangeMode.EAGER);
        content.add(name);

        type = new Select<>();
        type.setLabel("Вид");
        type.setWidth("100%");
        type.setItems(MachineType.values());
        //  content.add(type);

        waveHeight = new Select<>();
        waveHeight.setLabel("Высота волны");
        waveHeight.setWidth("100%");
        waveHeight.setItems(WaveHeight.values());
        // content.add(materialColor);

        width = new Select<>();
        width.setLabel("Допустимая толщина мет");
        width.setWidth("100%");
        width.setItems(Width.values());
        // content.add(materialColor);

        
        final HorizontalLayout horizontalLayout2 = new HorizontalLayout(type, waveHeight,width);
        horizontalLayout2.setWidth("100%");
        horizontalLayout2.setFlexGrow(1, type, waveHeight,width);
        content.add(horizontalLayout2);

        length = new TextField("Длинна станка м.");
        length.setWidth("20%");
        length.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        length.setValueChangeMode(ValueChangeMode.EAGER);
         content.add(length);

        binder = new BeanValidationBinder<>(Machine.class);
        binder.forField(length).withConverter(new MachineForm.StockCountConverter())
                .bind("length");
        binder.bindInstanceFields(this);


        // enable/disable save button while editing
        binder.addStatusChangeListener(event -> {
            final boolean isValid = !event.hasValidationErrors();
            final boolean hasChanges = binder.hasChanges();
            save.setEnabled(hasChanges && isValid);
            discard.setEnabled(hasChanges);
        });

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
        cancel.addClickListener(event -> viewLogic.cancelMachine());
        cancel.addClickShortcut(Key.ESCAPE);
        getElement()
                .addEventListener("keydown", event -> viewLogic.cancelMachine())
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

  //  public void setCategories(Collection<Category> categories) {
    //    category.setItems(categories);
  //  }

    public void editMachine(Machine Machine) {
        if (Machine == null) {
            Machine = new Machine();
        }
        delete.setVisible(!Machine.isNew());
        currentMachine = Machine;
        binder.readBean(Machine);
    }
}
