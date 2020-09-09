package com.roofapp.ui.views.orderedit;

import com.roofapp.backend.dao.roofdb.*;
import com.roofapp.backend.dao.roofdb.entity.OrderItem;
import com.roofapp.backend.dao.roofdb.entity.Product;
import com.roofapp.backend.dao.roofdb.entity.ProductAmount;
import com.roofapp.backend.service.ProductAmountService;
import com.roofapp.ui.views.order.events.*;
import com.vaadin.flow.component.AbstractField.ComponentValueChangeEvent;
import com.vaadin.flow.component.ComponentEventListener;
import com.vaadin.flow.component.HasValue;
import com.vaadin.flow.component.HasValueAndElement;
import com.vaadin.flow.component.Tag;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.combobox.ComboBox;
import com.vaadin.flow.component.dependency.JsModule;
import com.vaadin.flow.component.html.Div;
import com.vaadin.flow.component.internal.AbstractFieldSupport;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;
import com.vaadin.flow.component.polymertemplate.Id;
import com.vaadin.flow.component.polymertemplate.PolymerTemplate;
import com.vaadin.flow.component.textfield.NumberField;
import com.vaadin.flow.data.binder.BeanValidationBinder;
import com.vaadin.flow.data.binder.BindingValidationStatus;
import com.vaadin.flow.data.provider.DataProvider;
import com.vaadin.flow.shared.Registration;
import com.vaadin.flow.templatemodel.TemplateModel;
import org.apache.commons.lang3.ObjectUtils;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Objects;
import java.util.stream.Stream;

@Tag("order-item-editor")
@JsModule("./src/views/orderedit/order-item-editor.js")
public class OrderItemEditor extends PolymerTemplate<TemplateModel> implements HasValueAndElement<ComponentValueChangeEvent<OrderItemEditor, OrderItem>, OrderItem> {

    @Id("products")
    private ComboBox<Product> products;


    @Id("layWithParams")
    private HorizontalLayout layWithParams;

    @Id("width")
    private ComboBox<Width> width;

    @Id("materialClass")
    private ComboBox<MaterialClass> materialClass;


    @Id("materialCover")
    private ComboBox<MaterialCover> materialCover;

    @Id("materialColor")
    private ComboBox<MaterialColor> materialColor;

    @Id("height")
    private NumberField height;

    @Id("delete")
    private Button delete;

    @Id("amount")
    private NumberField amount;

    @Id("price")
    private NumberField price;


    //@Id("comment")
//	private TextField comment;

    private Double totalPrice;

    private final AbstractFieldSupport<OrderItemEditor, OrderItem> fieldSupport;


    private final ProductAmountService productAmountService;

    private BeanValidationBinder<OrderItem> binder = new BeanValidationBinder<>(OrderItem.class);

    public OrderItemEditor(DataProvider<Product, String> productDataProvider, ProductAmountService productAmountService) {
        this.productAmountService = productAmountService;
        this.fieldSupport = new AbstractFieldSupport<>(this, null,
                Objects::equals, c -> {
        });
        products.setDataProvider(productDataProvider);
        products.addValueChangeListener(e -> {
            setPrice();
            fireEvent(new ProductChangeEvent(this, e.getValue()));

            if (e.getValue().getType() != null)
                if (e.getValue().getType().equals(ProductType.PROFILED) || e.getValue().getType().equals(ProductType.METAL_TILE))
                    layWithParams.setVisible(true);
                else
                    layWithParams.setVisible(false);

        });

        products.setLabel("Продукт");
        amount.addValueChangeListener(e -> setPrice());
        amount.setPattern("#0.00");
        amount.setLabel("кол-во");
        //	comment.addValueChangeListener(e -> fireEvent(new CommentChangeEvent(this, e.getValue())));

        binder.forField(amount).bind("quantity");
        amount.setRequiredIndicatorVisible(true);


        width.setItems(Width.values());
        width.setLabel("Толшина");
        width.addValueChangeListener(e -> {
            setPrice();
        });
        width.setRequired(true);
        binder.forField( width).bind("width");

        materialClass.setItems(MaterialClass.values());
        materialClass.setLabel("Клас");
        materialClass.addValueChangeListener(e -> {
            setPrice();
        });
        materialClass.setRequired(true);
        binder.forField( materialClass).bind("materialClass");

        materialCover.setItems(MaterialCover.values());
        materialCover.setLabel("Покрытие");
        materialCover.addValueChangeListener(e -> {
            setPrice();
        });
        materialCover.setRequired(true);
        binder.forField(materialCover).bind("materialCover");

        materialColor.setItems(MaterialColor.values());
        materialColor.setLabel("Цвет");
        materialColor.addValueChangeListener(e -> {
            setPrice();
        });
        materialColor.setRequired(true);
        binder.forField( materialColor).bind("materialColor");


        height.setLabel("Высота");
        height.addKeyUpListener(e -> {
            setPrice();
        });
        binder.forField( height).bind("height");

        //	binder.forField(comment).bind("comment");
        binder.forField(products).bind("product");
        products.setRequired(true);


        price.setEnabled(false);
        binder.forField(price).bind("price");

        layWithParams.setVisible(false);

        delete.addClickListener(e -> fireEvent(new DeleteEvent(this)));
        setPrice();
    }

    private Double findProductPrice() {
        if (!ObjectUtils.isEmpty(products.getValue())
                && !ObjectUtils.isEmpty(width.getValue())
                && !ObjectUtils.isEmpty(materialClass.getValue())
                && !ObjectUtils.isEmpty(materialCover.getValue())) {
            ProductAmount productAmount = productAmountService.findProductAmount(products.getValue(),
                    width.getValue(),
                    materialClass.getValue(),
                    materialCover.getValue()
            );

            return productAmount.getPrice();
        }
        return 0d;
    }


    private void setPrice() {
        Double oldValue = totalPrice;
        Double selectedAmount = amount.getValue();
        Product product = products.getValue();
        totalPrice = Double.valueOf(0);
        if (selectedAmount != null && product != null) {
            if (product.getType() != null) {
                if (product.getType().equals(ProductType.PROFILED) || product.getType().equals(ProductType.METAL_TILE)) {
                    if (!ObjectUtils.isEmpty(height.getValue()) && !ObjectUtils.isEmpty(product.getSquareMeters())) {
                        totalPrice = new BigDecimal(selectedAmount * (findProductPrice()) * product.getSquareMeters() * height.getValue()).setScale(2, RoundingMode.HALF_UP).doubleValue();
                     //   product.setPrice(totalPrice);
                    }
                }
            } else {
                totalPrice = new BigDecimal(selectedAmount * product.getPrice()).setScale(2, RoundingMode.HALF_UP).doubleValue();
            }

        }
        price.setValue(/*FormattingUtils.formatAsCurrency(*/totalPrice/*)*/);


        if (oldValue != totalPrice) {
            fireEvent(new PriceChangeEvent(this, oldValue, totalPrice));
        }
    }

    @Override
    public void setValue(OrderItem value) {
        fieldSupport.setValue(value);
        binder.setBean(value);
        boolean noProductSelected = value == null || value.getProduct() == null;
        amount.setEnabled(!noProductSelected);
        delete.setEnabled(!noProductSelected);
        //comment.setEnabled(!noProductSelected);
        setPrice();
    }

    @Override
    public OrderItem getValue() {
        return fieldSupport.getValue();
    }

    public Stream<HasValue<?, ?>> validate() {
        return binder.validate().getFieldValidationErrors().stream().map(BindingValidationStatus::getField);
    }

    public Registration addPriceChangeListener(ComponentEventListener<PriceChangeEvent> listener) {
        return addListener(PriceChangeEvent.class, listener);
    }

    public Registration addProductChangeListener(ComponentEventListener<ProductChangeEvent> listener) {
        return addListener(ProductChangeEvent.class, listener);
    }

    public Registration addWidthChangeListener(ComponentEventListener<WidthChangeEvent> listener) {
        return addListener(WidthChangeEvent.class, listener);
    }

    public Registration addCommentChangeListener(ComponentEventListener<CommentChangeEvent> listener) {
        return addListener(CommentChangeEvent.class, listener);
    }

    public Registration addDeleteListener(ComponentEventListener<DeleteEvent> listener) {
        return addListener(DeleteEvent.class, listener);
    }

    @Override
    public Registration addValueChangeListener(
            ValueChangeListener<? super ComponentValueChangeEvent<OrderItemEditor, OrderItem>> listener) {
        return fieldSupport.addValueChangeListener(listener);
    }

}
