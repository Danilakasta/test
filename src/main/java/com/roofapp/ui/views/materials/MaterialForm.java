package com.roofapp.ui.views.materials;

import com.roofapp.backend.dao.roofdb.MaterialClass;
import com.roofapp.backend.dao.roofdb.MaterialColor;
import com.roofapp.backend.dao.roofdb.MaterialCover;
import com.roofapp.backend.dao.roofdb.entity.Material;
import com.roofapp.backend.dao.roofdb.entity.guides.Width;
import com.roofapp.backend.service.MaterialService;
import com.roofapp.backend.service.guides.WidthGuideService;
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

import java.math.BigDecimal;
import java.math.RoundingMode;
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
    private final NumberField weightOfBay;
    private final IntegerField length;
    private final NumberField priceOneMetre;
    private final Select<MaterialColor> materialColor;
    private final Select<Width> width;
    private final NumberField widthFact;
    private final Select<MaterialCover> cover;

    private final Select<MaterialClass> materialClass;

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
    public MaterialForm(MateriaslViewLogic viewLogic, MaterialService MaterialService, WidthGuideService widthGuideService) {
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
        cover.setItems(MaterialCover.values());
        //У цинка не блокируем выбор цвета

        cover.addValueChangeListener(e -> {
            if(e.getValue() !=null) {
                if (e.getValue().ordinal() == 0) {
                    materialColor.setEnabled(false);
                } else {
                    materialColor.setEnabled(true);
                }
            }
        });



        materialClass = new Select<>();
        materialClass.setLabel("Клас покрытия");
        materialClass.setWidth("100%");
        materialClass.setItems(MaterialClass.values());



        width = new Select<>();
        width.setLabel("Толщина теория");
        width.setWidth("100%");
        width.setItems(widthGuideService.getAllWidth());
        width.addValueChangeListener(e -> {
            setTeorCoefficient();
        });
        // content.add(materialColor);


        widthFact = new NumberField();
        widthFact.setLabel("Толщина Факт");
        widthFact.setWidth("100%");
        widthFact.setSuffixComponent(new Span("мм."));

        // content.add(materialColor);

        final HorizontalLayout horizontalLayout2 = new HorizontalLayout(cover,  materialClass, materialColor, width, widthFact);
        horizontalLayout2.setWidth("100%");
        horizontalLayout2.setFlexGrow(3, cover, materialClass, materialColor, width, widthFact);
        content.add(horizontalLayout2);


        price = new NumberField("Цена бухты");
        price.setSuffixComponent(new Span("р"));
        price.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        price.setValueChangeMode(ValueChangeMode.EAGER);
        price.addValueChangeListener(e -> setPriceOneMetre());

        price.addValueChangeListener(e -> setPriceOneTone());

        priceDelivery = new NumberField("Цена доставки");
        priceDelivery.setSuffixComponent(new Span("р"));
        priceDelivery.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        priceDelivery.setValueChangeMode(ValueChangeMode.EAGER);
        priceDelivery.addValueChangeListener(e -> setPriceOneTone());

        priceOneTone = new NumberField("Цена за тонну");
        priceOneTone.setSuffixComponent(new Span("р"));
        priceOneTone.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        priceOneTone.setValueChangeMode(ValueChangeMode.EAGER);
        priceOneTone.setEnabled(false);

        weightOfBay = new NumberField("Вес бухты");
        weightOfBay.setSuffixComponent(new Span("т"));
        weightOfBay.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        weightOfBay.setValueChangeMode(ValueChangeMode.EAGER);
        weightOfBay.addValueChangeListener(e -> {
            setPriceOneTone();
            setTeorCoefficient();
        });

        final HorizontalLayout horizontalLayout3 = new HorizontalLayout(price, priceDelivery, weightOfBay, priceOneTone);
        horizontalLayout3.setWidth("100%");
        horizontalLayout3.setFlexGrow(3, price, priceDelivery, weightOfBay, priceOneTone);
        content.add(horizontalLayout3);


        length = new IntegerField("Длинна паспорт");
        length.setSuffixComponent(new Span("пог. м."));
        length.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        length.setValueChangeMode(ValueChangeMode.EAGER);


        priceOneMetre = new NumberField("Себеc. теор");
        priceOneMetre.setSuffixComponent(new Span("р пог.м."));
        priceOneMetre.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        priceOneMetre.setValueChangeMode(ValueChangeMode.EAGER);
        priceOneMetre.setEnabled(false);

        final HorizontalLayout horizontalLayout4 = new HorizontalLayout(length, priceOneMetre);
        horizontalLayout4.setWidth("100%");
        horizontalLayout4.setFlexGrow(3, length, priceOneMetre);
        content.add(horizontalLayout4);


        teorCoefficient = new NumberField("Длинна теория");
        teorCoefficient.setSuffixComponent(new Span("пог.м.т."));
        teorCoefficient.setWidth("100%");
        teorCoefficient.setValueChangeMode(ValueChangeMode.EAGER);
      //  teorCoefficient.setEnabled(false);
        content.add(teorCoefficient);

        factCoefficient = new NumberField("Факт. длинна");
        factCoefficient.setSuffixComponent(new Span("пог.м."));
        factCoefficient.setWidth("100%");
        factCoefficient.setValueChangeMode(ValueChangeMode.EAGER);
        factCoefficient.setEnabled(false);
        content.add(factCoefficient);
        used = new NumberField("Израсходовано");
        used.setSuffixComponent(new Span("м"));
     //   used.setEnabled(false);
        used.setWidth("100%");
        used.setValueChangeMode(ValueChangeMode.EAGER);
        content.add(used);

        remains = new NumberField("Остаток");
        remains.setSuffixComponent(new Span("м"));
      //  remains.setEnabled(false);
        remains.setWidth("100%");
        remains.setValueChangeMode(ValueChangeMode.EAGER);
        length.addValueChangeListener(e -> {
            setPriceOneMetre();
            remains.setValue(Double.valueOf(e.getValue()));
        });


        content.add(remains);


        final HorizontalLayout horizontalLayout5 = new HorizontalLayout(teorCoefficient, factCoefficient, used, remains);
        horizontalLayout5.setWidth("100%");
        horizontalLayout5.setFlexGrow(2, teorCoefficient, factCoefficient, used, remains);
        content.add(horizontalLayout5);


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

    private void setPriceOneTone() {
        Double priceDouble = 0D;
        if (!price.isEmpty() && !weightOfBay.isEmpty()) {
            priceDouble = (price.getValue() / weightOfBay.getValue()) + priceDelivery.getValue();
            priceOneTone.setValue(aroundDouble(priceDouble));
        } else
            priceOneTone.setValue(0D);

    }

    private void setPriceOneMetre() {
        Double priceDouble = 0D;
        if (!price.isEmpty() && !length.isEmpty()) {
            priceDouble = price.getValue() / length.getValue();
            priceOneMetre.setValue(aroundDouble(priceDouble));
        } else
            priceOneMetre.setValue(0D);
    }

    private void setTeorCoefficient() {
        final Double weightOfMetalConst = 1.25D;
        final Double specificWeightConst = 7.85D;
        Double teofCofDouble = 0D;

        if (!weightOfBay.isEmpty() && !width.isEmpty()) {
            teofCofDouble = (weightOfBay.getValue() / width.getValue().getValue() / weightOfMetalConst / specificWeightConst) * 1000;
            teorCoefficient.setValue(aroundDouble(teofCofDouble));
        } else
            teorCoefficient.setValue(teofCofDouble);
    }

    private Double aroundDouble(Double val) {
        return new BigDecimal(val.toString()).setScale(2, RoundingMode.HALF_UP).doubleValue();
    }

}
