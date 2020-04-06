package com.roofapp.ui.views.products;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Locale;

import com.roofapp.backend.data.MaterialColor;
import com.roofapp.backend.data.ProductType;
import com.roofapp.backend.data.Width;
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
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.component.textfield.TextFieldVariant;
import com.vaadin.flow.data.binder.BeanValidationBinder;
import com.vaadin.flow.data.binder.Binder;
import com.vaadin.flow.data.converter.StringToBigDecimalConverter;
import com.vaadin.flow.data.converter.StringToIntegerConverter;
import com.vaadin.flow.data.value.ValueChangeMode;
import com.roofapp.backend.data.entity.Product;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * A form for editing a single product.
 */

public class ProductForm extends Div {

    private final VerticalLayout content;

    ProductService productService;

    private final TextField productName;
    private final TextField price;
    private final TextField weight;

    private final TextField length;

    private final Select<ProductType> type;

    private final Select<MaterialColor> materialColor;

    private final Select<Width> width;
 //   private final CheckboxGroup<Category> category;
    private Button save;
    private Button discard;
    private Button cancel;
    private final Button delete;

    private ProductViewLogic viewLogic;

    public void setViewLogic(ProductViewLogic viewLogic) {
        this.viewLogic = viewLogic;
    }

    private final Binder<Product> binder;
    private Product currentProduct;

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
    public ProductForm(ProductViewLogic viewLogic, ProductService productService) {
        this.productService = productService;
        setClassName("product-form ");

        content = new VerticalLayout();
        content.setSizeUndefined();
        content.addClassName("product-form-content");
        add(content);

     //   viewLogic = sampleCrudLogic;

        productName = new TextField("Название");
        productName.setWidth("100%");
        productName.setRequired(true);
        productName.setValueChangeMode(ValueChangeMode.EAGER);
        content.add(productName);
        type = new Select<>();
        type.setLabel("Вид");
        type.setWidth("100%");
        type.setItems(ProductType.values());
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

        length = new TextField("Длинна м.");
        length.addThemeVariants(TextFieldVariant.LUMO_ALIGN_RIGHT);
        length.setValueChangeMode(ValueChangeMode.EAGER);

        final HorizontalLayout horizontalLayout = new HorizontalLayout(price,
                weight, length);
        horizontalLayout.setWidth("100%");
        horizontalLayout.setFlexGrow(1, price, weight);
        content.add(horizontalLayout);


      /*  category = new CheckboxGroup<>();
        category.setLabel("Categories");
        category.setId("category");
        category.addThemeVariants(CheckboxGroupVariant.LUMO_VERTICAL);
        content.add(category);
*/
        binder = new BeanValidationBinder<>(Product.class);
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

    public void editProduct(Product product) {
        if (product == null) {
            product = new Product();
        }
        delete.setVisible(!product.isNew());
        currentProduct = product;
        binder.readBean(product);
    }
}
