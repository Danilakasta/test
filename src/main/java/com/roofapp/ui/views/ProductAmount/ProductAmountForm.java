package com.roofapp.ui.views.ProductAmount;

import com.roofapp.backend.dao.roofdb.MaterialClass;
import com.roofapp.backend.dao.roofdb.MaterialCover;
import com.roofapp.backend.dao.roofdb.Width;
import com.roofapp.backend.dao.roofdb.entity.ProductAmount;
import com.roofapp.backend.service.MaterialService;
import com.roofapp.backend.service.ProductAmountService;
import com.roofapp.backend.service.ProductService;
import com.vaadin.flow.component.Key;
import com.vaadin.flow.component.KeyModifier;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.html.Div;
import com.vaadin.flow.component.html.Span;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.component.select.Select;
import com.vaadin.flow.component.textfield.NumberField;
import com.vaadin.flow.component.textfield.TextFieldVariant;
import com.vaadin.flow.data.binder.BeanValidationBinder;
import com.vaadin.flow.data.binder.Binder;
import com.vaadin.flow.data.converter.StringToBigDecimalConverter;
import com.vaadin.flow.data.converter.StringToIntegerConverter;
import com.vaadin.flow.data.value.ValueChangeMode;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Locale;

//import io.swagger.models.auth.In;

/**
 * A form for editing a single product.
 */

public class ProductAmountForm extends Div {

    private final VerticalLayout content;

    ProductAmountService productAmountService;

   // private final Select<Product> product;
    private final NumberField price;

    private final NumberField selfPrice;

    // private final NumberField width;

    // private final NumberField squareMeters;

    // private final TextField weight;

    // private final TextField length;

    private final Select<Width> width;

    private final Select<MaterialClass> materialClass;
    private final Select<MaterialCover> materialCover;

    // private final Select<MaterialColor> materialColor;

    //  private final Select<Width> width;
    //   private final CheckboxGroup<Category> category;
    private Button save;
    private Button discard;
    private Button cancel;
    private final Button delete;

    private ProductAmountViewLogic viewLogic;
    private MaterialService materialService;

    public void setViewLogic(ProductAmountViewLogic viewLogic) {
        this.viewLogic = viewLogic;
    }

    private final Binder<ProductAmount> binder;
    private ProductAmount currentProduct;

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
    public ProductAmountForm(ProductAmountViewLogic viewLogic,
                             ProductAmountService productAmountService,
                             ProductService productService,
                             MaterialService materialService) {
        this.productAmountService = productAmountService;
        this.materialService = materialService;
        setClassName("product-form");

        content = new VerticalLayout();
        content.setSizeUndefined();
        content.addClassName("product-form-content");
        add(content);

        //   viewLogic = sampleCrudLogic;

    /*    product = new Select<>();
        product.setLabel("Продуст");
        product.setWidth("100%");
        product.setItemLabelGenerator(Product::toString);
        product.setItems(productService.findByType(new ArrayList<ProductType>(Arrays.asList(ProductType.PROFILED, ProductType.METAL_TILE))));
*/
        width = new Select<>();
        width.setWidth("100%");
        width.setLabel("Толщина метала");
        width.setItems(Width.values());
        width.addValueChangeListener(e -> calculateSelfPrice());

        materialClass = new Select<>();
        materialClass.setWidth("100%");
        materialClass.setLabel("Класс");
        materialClass.setItems(MaterialClass.values());
        materialClass.addValueChangeListener(e -> calculateSelfPrice());

        materialCover = new Select<>();
        materialCover.setWidth("100%");
        materialCover.setLabel("Покрытие");
        materialCover.setItems(MaterialCover.values());
        materialCover.addValueChangeListener(e -> calculateSelfPrice());

        price = new NumberField("Процент надбавки");
        price.setWidth("100%");
        price.setSuffixComponent(new Span("%"));
        price.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        price.setValueChangeMode(ValueChangeMode.EAGER);


        selfPrice = new NumberField("Себестоймость");
        selfPrice.setWidth("100%");
        selfPrice.setSuffixComponent(new Span("р"));
        selfPrice.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        selfPrice.setValueChangeMode(ValueChangeMode.EAGER);


        final HorizontalLayout horizontalLayout = new HorizontalLayout(width);
        horizontalLayout.setWidth("100%");
        horizontalLayout.setFlexGrow(3, width);
        content.add(horizontalLayout);

        final HorizontalLayout horizontalLayout3 = new HorizontalLayout(materialCover,materialClass);
        horizontalLayout3.setWidth("100%");
        horizontalLayout3.setFlexGrow(3, materialCover,materialClass);
        content.add(horizontalLayout3);

        final HorizontalLayout horizontalLayout2 = new HorizontalLayout(selfPrice, price );
        horizontalLayout2.setWidth("100%");
        horizontalLayout2.setFlexGrow(3, selfPrice, price);
        content.add(horizontalLayout2);


        binder = new BeanValidationBinder<>(ProductAmount.class);
        //  binder.forField(price).withConverter(new PriceConverter())
        //    .bind("price");
        //  binder.forField(weight).withConverter(new StockCountConverter())
        //      .bind("weight");
        //  binder.forField(length).withConverter(new StockCountConverter())
        //         .bind("length");
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
            if (currentProduct != null
                    && binder.writeBeanIfValid(currentProduct)) {
                viewLogic.saveProduct(currentProduct);
            }
        });
        save.addClickShortcut(Key.KEY_S, KeyModifier.CONTROL);

        discard = new Button("Сбросить");
        discard.setWidth("100%");
        discard.addClickListener(
                event -> viewLogic.editProduct(currentProduct));

        cancel = new Button("Отменить");
        cancel.setWidth("100%");
        cancel.addClickListener(event -> viewLogic.cancelProduct());
        cancel.addClickShortcut(Key.ESCAPE);
        getElement()
                .addEventListener("keydown", event -> viewLogic.cancelProduct())
                .setFilter("event.key == 'Escape'");

        delete = new Button("Удалить");
        delete.setWidth("100%");
        delete.addThemeVariants(ButtonVariant.LUMO_ERROR,
                ButtonVariant.LUMO_PRIMARY);
        delete.addClickListener(event -> {
            if (currentProduct != null) {
                viewLogic.deleteProduct(currentProduct);
            }
        });

        content.add(save, discard, delete, cancel);
    }

    //  public void setCategories(Collection<Category> categories) {
    //    category.setItems(categories);
    //  }

    public void editProduct(ProductAmount product) {
        if (product == null) {
            product = ProductAmount.builder().build();
        }
        delete.setVisible(!product.isNew());
        currentProduct = product;
        binder.readBean(product);
    }

    /**
     * Расчет себестоймости
     */
    private void calculateSelfPrice() {

            selfPrice.setValue(productAmountService.calculateSelfPrice(width.getValue(), materialCover.getValue(), materialClass.getValue()));

    }


}
