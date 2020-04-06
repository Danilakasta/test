package com.roofapp.ui.views.materials;

import com.roofapp.backend.data.CoverType;
import com.roofapp.backend.data.MaterialColor;
import com.roofapp.backend.data.MaterialType;
import com.roofapp.backend.data.Width;
import com.roofapp.backend.data.entity.Material;
import com.roofapp.backend.service.MaterialService;
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
import com.vaadin.flow.component.textfield.NumberField;
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
 * A form for editing a single Material.
 */

public class MaterialForm extends Div {

    private final VerticalLayout content;

    MaterialService materialService;

    private final TextField name;
    private final TextField price;
    private final TextField weight;

    private final TextField length;

    private final Select<MaterialType> type;

    private final Select<MaterialColor> materialColor;

    private final Select<Width> width;

    private final Select<CoverType> cover ;

    private final TextField party;

    private final TextField manufacturer;

    private final NumberField teorCoefficient;

    private final NumberField factCoefficient;

    private final IntegerField used;


 //   private final CheckboxGroup<Category> category;
    private Button save;
    private Button discard;
    private Button cancel;
    private final Button delete;

    private MateriaslViewLogic viewLogic;

    public void setViewLogic(MateriaslViewLogic viewLogic) {
        this.viewLogic = viewLogic;
    }

    private final Binder<Material> binder;
    
    private Material currentMaterial;

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
    public MaterialForm(MateriaslViewLogic viewLogic, MaterialService MaterialService) {
        this.materialService = MaterialService;
        setClassName("Material-form ");

        content = new VerticalLayout();
        content.setSizeUndefined();
        content.addClassName("Material-form-content");
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
        type.setItems(MaterialType.values());
        //  content.add(type);

        materialColor = new Select<>();
        materialColor.setLabel("Цвет");
        materialColor.setWidth("100%");
        materialColor.setItems(MaterialColor.values());
        // content.add(materialColor);

        width = new Select<>();
        width.setLabel("Толщина");
        width.setWidth("100%");
        width.setItems(Width.values());
        // content.add(materialColor);

        final HorizontalLayout horizontalLayout2 = new HorizontalLayout(type,
                materialColor,width);
        horizontalLayout2.setWidth("100%");
        horizontalLayout2.setFlexGrow(1, type,materialColor);
        content.add(horizontalLayout2);

        price = new TextField("Цена закупки");
        price.setSuffixComponent(new Span("р"));
        price.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        price.setValueChangeMode(ValueChangeMode.EAGER);

        weight = new TextField("Вес кг.");
        weight.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        weight.setValueChangeMode(ValueChangeMode.EAGER);

        length = new TextField("Длинна пог. м.");
        length.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        length.setValueChangeMode(ValueChangeMode.EAGER);

        final HorizontalLayout horizontalLayout = new HorizontalLayout(price,
                weight, length);
        horizontalLayout.setWidth("100%");
        horizontalLayout.setFlexGrow(1, price, weight);
        content.add(horizontalLayout);

        cover= new Select<>();
        cover.setLabel("Покрытие");
        cover.setWidth("100%");
        cover.setItems(CoverType.values());


        party = new TextField("Партия");
        party.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        party.setValueChangeMode(ValueChangeMode.EAGER);

        manufacturer = new TextField("Производитель");
        manufacturer.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        manufacturer.setValueChangeMode(ValueChangeMode.EAGER);


        final HorizontalLayout horizontalLayout3 = new HorizontalLayout(cover,party,manufacturer);
        horizontalLayout3.setWidth("100%");
        horizontalLayout3.setFlexGrow(1, cover,party,manufacturer);
        content.add(horizontalLayout3);


        teorCoefficient = new NumberField("Теор. коеф");
        teorCoefficient.setWidth("100%");
        teorCoefficient.setValueChangeMode(ValueChangeMode.EAGER);
        content.add(teorCoefficient);

        factCoefficient = new NumberField("Факт. коеф");
        factCoefficient.setWidth("100%");
        factCoefficient.setValueChangeMode(ValueChangeMode.EAGER);
        content.add(factCoefficient);

        used = new IntegerField("Израсходовано");
        used.setWidth("100%");
        used.setValueChangeMode(ValueChangeMode.EAGER);
        content.add(used);

        final HorizontalLayout horizontalLayout4 = new HorizontalLayout(teorCoefficient,factCoefficient,used);
        horizontalLayout4.setWidth("100%");
        horizontalLayout4.setFlexGrow(1, teorCoefficient,factCoefficient,used);
        content.add(horizontalLayout4);
      /*  aaa = new TextField("");
        aaa.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        aaa.setValueChangeMode(ValueChangeMode.EAGER);

        */


        binder = new BeanValidationBinder<>(Material.class);
        binder.forField(price).withConverter(new PriceConverter())
                .bind("price");
        binder.forField(weight).withConverter(new StockCountConverter())
                .bind("weight");
        binder.forField(length).withConverter(new StockCountConverter())
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
            if (currentMaterial != null
                    && binder.writeBeanIfValid(currentMaterial)) {
                viewLogic.save(currentMaterial);
            }
        });
        save.addClickShortcut(Key.KEY_S, KeyModifier.CONTROL);

        discard = new Button("Сбросить");
        discard.setWidth("100%");
        discard.addClickListener(
                event -> viewLogic.edit(currentMaterial));

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
            if (currentMaterial != null) {
                viewLogic.delete(currentMaterial);
            }
        });

        content.add(save, discard, delete, cancel);
    }

  //  public void setCategories(Collection<Category> categories) {
    //    category.setItems(categories);
  //  }

    public void edit(Material Material) {
        if (Material == null) {
            Material = new Material();
        }
        delete.setVisible(!Material.isNew());
        currentMaterial = Material;
        binder.readBean(Material);
    }
}
