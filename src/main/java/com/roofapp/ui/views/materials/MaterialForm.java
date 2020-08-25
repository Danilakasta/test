package com.roofapp.ui.views.materials;

import com.roofapp.backend.dao.roofdb.CoverType;
import com.roofapp.backend.dao.roofdb.MaterialColor;
import com.roofapp.backend.dao.roofdb.Width;
import com.roofapp.backend.dao.roofdb.entity.Material;
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
import com.vaadin.flow.data.converter.StringToIntegerConverter;
import com.vaadin.flow.data.value.ValueChangeMode;
import org.springframework.beans.factory.annotation.Autowired;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Locale;

/**
 * A form for editing a single Material.
 */

public class MaterialForm extends Div {

    private final VerticalLayout content;

    MaterialService materialService;

    private final IntegerField serialNumber;
    private final TextField manufacturer;
    private final TextField party;


    private final NumberField price;
    private final NumberField priceDelivery;
    private final NumberField priceOneTone;
    private final IntegerField weightOfBay;
    private final IntegerField length;
    private final NumberField priceOneMetre;
    private final Select<MaterialColor> materialColor;
    private final Select<Width> width;
    private final Select<CoverType> cover;
    private final NumberField teorCoefficient;
    private final NumberField factCoefficient;
    private final NumberField used;
    private final NumberField remains;

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

    private static class PriceConverter extends StringToIntegerConverter {

        public PriceConverter() {
            super(0, "Cannot convert value to a number.");
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

    private static class IntConverter extends StringToIntegerConverter {

        public IntConverter() {
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
        setClassName("product-form ");

        content = new VerticalLayout();
        content.setSizeUndefined();
        content.addClassName("product-form-content");
        add(content);


        serialNumber = new IntegerField("Порядковый номер");
        serialNumber.setSuffixComponent(new Span("№"));
        serialNumber.setWidth("25%");
        serialNumber.setValueChangeMode(ValueChangeMode.EAGER);
        content.add(serialNumber);

        manufacturer = new TextField("Производитель");
        manufacturer.setWidth("50%");
        manufacturer.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        manufacturer.setValueChangeMode(ValueChangeMode.EAGER);

        party = new TextField("Партия");
        party.setWidth("25%");
        party.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        party.setValueChangeMode(ValueChangeMode.EAGER);

        final HorizontalLayout horizontalLayout = new HorizontalLayout(serialNumber, manufacturer, party);
        horizontalLayout.setWidth("100%");
        horizontalLayout.setFlexGrow(1, serialNumber, manufacturer);
        content.add(horizontalLayout);


        materialColor = new Select<>();
        materialColor.setLabel("Цвет");
        materialColor.setWidth("100%");
        materialColor.setItems(MaterialColor.values());
        // content.add(materialColor);

        cover = new Select<>();
        cover.setLabel("Покрытие");
        cover.setWidth("100%");
        cover.setItems(CoverType.values());

        width = new Select<>();
        width.setLabel("Толщина");
        width.setWidth("100%");
        width.setItems(Width.values());
        // content.add(materialColor);

        final HorizontalLayout horizontalLayout2 = new HorizontalLayout(materialColor, cover, width);
        horizontalLayout2.setWidth("100%");
        horizontalLayout2.setFlexGrow(3, materialColor, cover, width);
        content.add(horizontalLayout2);


        price = new NumberField("Цена бухты");
        price.setSuffixComponent(new Span("р"));
        price.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        price.setValueChangeMode(ValueChangeMode.EAGER);

        priceDelivery = new NumberField("Цена доставки");
        priceDelivery.setSuffixComponent(new Span("р"));
        priceDelivery.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        priceDelivery.setValueChangeMode(ValueChangeMode.EAGER);

        priceOneTone = new NumberField("Цена за тонну");
        priceOneTone.setSuffixComponent(new Span("р"));
        priceOneTone.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        priceOneTone.setValueChangeMode(ValueChangeMode.EAGER);

        final HorizontalLayout horizontalLayout3 = new HorizontalLayout(price, priceDelivery, priceOneTone);
        horizontalLayout3.setWidth("100%");
        horizontalLayout3.setFlexGrow(3, price, priceDelivery, priceOneTone);
        content.add(horizontalLayout3);


        weightOfBay = new IntegerField("Вес бухты");
        weightOfBay.setSuffixComponent(new Span("кг"));
        weightOfBay.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        weightOfBay.setValueChangeMode(ValueChangeMode.EAGER);

        length = new IntegerField("Длинна пас.");
        length.setSuffixComponent(new Span("пог. м."));
        length.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        length.setValueChangeMode(ValueChangeMode.EAGER);

        priceOneMetre = new NumberField("Себеc. теор");
        priceOneMetre.setSuffixComponent(new Span("р пог.м."));
        priceOneMetre.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        priceOneMetre.setValueChangeMode(ValueChangeMode.EAGER);

        final HorizontalLayout horizontalLayout4 = new HorizontalLayout(weightOfBay, length, priceOneMetre);
        horizontalLayout4.setWidth("100%");
        horizontalLayout4.setFlexGrow(3, weightOfBay, length, priceOneMetre);
        content.add(horizontalLayout4);


        teorCoefficient = new NumberField("Теор. коеф");
        teorCoefficient.setWidth("100%");
        teorCoefficient.setValueChangeMode(ValueChangeMode.EAGER);
        content.add(teorCoefficient);

        factCoefficient = new NumberField("Факт. коеф");
        factCoefficient.setWidth("100%");
        factCoefficient.setValueChangeMode(ValueChangeMode.EAGER);
        content.add(factCoefficient);

        final HorizontalLayout horizontalLayout5 = new HorizontalLayout(teorCoefficient, factCoefficient);
        horizontalLayout5.setWidth("100%");
        horizontalLayout5.setFlexGrow(2, teorCoefficient, factCoefficient);
        content.add(horizontalLayout5);


        used = new NumberField("Израсходовано");
        used.setSuffixComponent(new Span("м"));
        used.setEnabled(false);
        used.setWidth("100%");
        used.setValueChangeMode(ValueChangeMode.EAGER);
        content.add(used);

        remains = new NumberField("Остаток");
        remains.setSuffixComponent(new Span("м"));
        remains.setEnabled(false);
        remains.setWidth("100%");
        remains.setValueChangeMode(ValueChangeMode.EAGER);
        content.add(remains);

        final HorizontalLayout horizontalLayout6 = new HorizontalLayout(used, remains);
        horizontalLayout6.setWidth("100%");
        horizontalLayout6.setFlexGrow(2, used, remains);
        content.add(horizontalLayout6);


        binder = new BeanValidationBinder<>(Material.class);


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
