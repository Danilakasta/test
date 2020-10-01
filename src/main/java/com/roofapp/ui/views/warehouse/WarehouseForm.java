package com.roofapp.ui.views.warehouse;

import com.roofapp.backend.dao.roofdb.WarehouseState;
import com.roofapp.backend.dao.roofdb.entity.Contractor;
import com.roofapp.backend.dao.roofdb.entity.Product;
import com.roofapp.backend.dao.roofdb.entity.WarehouseItem;
import com.roofapp.backend.service.ProductService;
import com.roofapp.backend.service.WarehouseItemService;
import com.vaadin.flow.component.Key;
import com.vaadin.flow.component.KeyModifier;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.combobox.ComboBox;
import com.vaadin.flow.component.html.Div;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.component.select.Select;
import com.vaadin.flow.component.textfield.IntegerField;
import com.vaadin.flow.component.textfield.TextField;
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

//import io.swagger.models.auth.In;

/**
 * A form for editing a single product.
 */

public class WarehouseForm extends Div {

    private final VerticalLayout content;

    WarehouseItemService itemService;

    private final ComboBox<Product> product;
    private final IntegerField quantity;

    private final Select<WarehouseState>  state;

    private final TextField comment;

    private Button save;
    private Button discard;
    private Button cancel;
    private final Button delete;

    private WarehouseViewLogic viewLogic;

    public void setViewLogic(WarehouseViewLogic viewLogic) {
        this.viewLogic = viewLogic;
    }

    private final Binder<WarehouseItem> binder;

    private WarehouseItem item;

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
    public WarehouseForm(WarehouseViewLogic viewLogic, WarehouseItemService itemService, ProductService productService) {
        this.itemService = itemService;
        setClassName("product-form");
        content = new VerticalLayout();
        content.setSizeUndefined();
        content.addClassName("product-form-content");
        add(content);

        product = new ComboBox<>();
        product.setLabel("Номенклатура");
        product.setWidth("100%");
        product.setItemLabelGenerator(Product::toString);
        product.setItems(productService.findAll());
        content.add(product);


        quantity = new IntegerField("Колличество");
        quantity.setWidth("100%");
        content.add(quantity);

        state =new Select<WarehouseState>();
        state.setLabel("Статус");
        state.setWidth("100%");
        state.setItems(WarehouseState.values());
        content.add(state);

        comment = new TextField("Комментарий");
        comment.setWidth("100%");
        comment.setRequired(true);
        content.add(comment);

        binder = new BeanValidationBinder<>(WarehouseItem.class);

        binder.bindInstanceFields(this);

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
            if (item != null
                    && binder.writeBeanIfValid(item)) {
                viewLogic.saveItem(item);
            }
        });
        save.addClickShortcut(Key.KEY_S, KeyModifier.CONTROL);

        discard = new Button("Сбросить");
        discard.setWidth("100%");
        discard.addClickListener(
                event -> viewLogic.edit(item));

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
            if (item != null) {
                viewLogic.delete(item);
            }
        });

        content.add(save, discard, delete, cancel);
    }

  //  public void setCategories(Collection<Category> categories) {
    //    category.setItems(categories);
  //  }

    public void edit(WarehouseItem editItem) {
        if ( editItem== null) {
            editItem = new WarehouseItem();
        }
        delete.setVisible(! editItem.isNew());
        item =  editItem;
        binder.readBean(editItem);
    }
}
