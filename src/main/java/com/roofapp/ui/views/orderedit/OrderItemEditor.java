package com.roofapp.ui.views.orderedit;

import com.roofapp.backend.dao.roofdb.*;
import com.roofapp.backend.dao.roofdb.entity.Material;
import com.roofapp.backend.dao.roofdb.entity.OrderItem;
import com.roofapp.backend.dao.roofdb.entity.Product;
import com.roofapp.backend.dao.roofdb.entity.guides.Width;
import com.roofapp.backend.service.MaterialService;
import com.roofapp.backend.service.ProductAmountService;
import com.roofapp.backend.service.ProductService;
import com.roofapp.backend.service.guides.WidthGuideService;
import com.roofapp.backend.utils.Helper;
import com.roofapp.ui.views.order.events.*;
import com.vaadin.flow.component.*;
import com.vaadin.flow.component.AbstractField.ComponentValueChangeEvent;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.combobox.ComboBox;
import com.vaadin.flow.component.dependency.JsModule;
import com.vaadin.flow.component.html.Div;
import com.vaadin.flow.component.internal.AbstractFieldSupport;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;
import com.vaadin.flow.component.polymertemplate.Id;
import com.vaadin.flow.component.polymertemplate.PolymerTemplate;
import com.vaadin.flow.component.textfield.IntegerField;
import com.vaadin.flow.component.textfield.NumberField;
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.data.binder.BeanValidationBinder;
import com.vaadin.flow.data.binder.BindingValidationStatus;
import com.vaadin.flow.shared.Registration;
import com.vaadin.flow.templatemodel.TemplateModel;
import lombok.extern.java.Log;
import org.apache.commons.lang3.ObjectUtils;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Tag("order-item-editor")
@JsModule("./src/views/orderedit/order-item-editor.js")
@Log
public class OrderItemEditor extends PolymerTemplate<TemplateModel> implements HasValueAndElement<ComponentValueChangeEvent<OrderItemEditor, OrderItem>, OrderItem> {

    @Id("products")
    private ComboBox<Product> products;


    @Id("layProfileParams")
    private HorizontalLayout layProfileParams;

    @Id("layAdditionalParams")
    private HorizontalLayout layAdditionalParams;

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

    @Id("comment")
    private TextField comment;

    @Id("size")
    private TextField size;

    @Id("delete")
    private Button delete;

    @Id("amount")
    private IntegerField amount;

    @Id("price")
    private NumberField price;

    @Id("materialSquaring")
    private Div materialSquaring;


    //@Id("comment")
//	private TextField comment;

    private Double totalPrice;

    private final AbstractFieldSupport<OrderItemEditor, OrderItem> fieldSupport;


    private final ProductAmountService productAmountService;

    private BeanValidationBinder<OrderItem> binder = new BeanValidationBinder<>(OrderItem.class);

    public OrderItemEditor(/*DataProvider<Product, String> productDataProvider*/ProductService productService,
                                                                                ProductAmountService productAmountService,
                                                                                MaterialService materialService,
                                                                                WidthGuideService widthGuideService) {
        this.productAmountService = productAmountService;
        this.fieldSupport = new AbstractFieldSupport<>(this, null,
                Objects::equals, c -> {
        });
        //    products.setDataProvider(productDataProvider);
        products.setItems(productService.findAllOrderTypeAndName());

        products.addValueChangeListener(e -> {
            materialSquaring.setText("");
            setPrice();
            fireEvent(new ProductChangeEvent(this, e.getValue()));

            if (e.getValue().getType() != null) {
                if (e.getValue().getType().equals(ProductType.PROFILED) || e.getValue().getType().equals(ProductType.METAL_TILE)) {
                    layProfileParams.setVisible(true);
                }else if (e.getValue().getType().equals(ProductType.ADDITIONAL_ELEMENTS) || e.getValue().getType().equals(ProductType.ADDITIONAL_COMPONENT)) {
                    layAdditionalParams.setVisible(true);
                    layProfileParams.setVisible(true);
                    height.setValue(2d);
                } else {
                    layProfileParams.setVisible(false);
                    layAdditionalParams.setVisible(false);
                }
                if(e.getValue().getType().equals(ProductType.PRODUCTS_SERVICES) )
                    price.setReadOnly(false);
                else
                    price.setReadOnly(true);


                //Для саморезов цвет
                if(e.getValue().getType().equals(ProductType.ADDITIONAL_COMPONENT)){
                    layAdditionalParams.setVisible(false);
                    width.setVisible(false);
                    materialClass.setVisible(false);
                    materialCover.setVisible(false);
                    materialColor.setItems(MaterialColor.values());
                    height.setVisible(false);
                }else{
                    width.setVisible(true);
                    materialClass.setVisible(true);
                    materialCover.setVisible(true);
                    height.setVisible(true);
                }
            } else {
                layProfileParams.setVisible(false);
                layAdditionalParams.setVisible(false);
            }


        });
        products.setLabel("Продукт");

        amount.addValueChangeListener(e -> {
            setPrice();
            setMaterialSquaring();
        });
      //  amount.setPattern("#0");
        amount.setLabel("кол-во");
      //  amount.setStep(1d);
        amount.setMin(0);
        amount.setMax(100000);
        //	comment.addValueChangeListener(e -> fireEvent(new CommentChangeEvent(this, e.getValue())));

        binder.forField(amount).bind("quantity");
        amount.setRequiredIndicatorVisible(true);


        List<Material> materials = materialService.findAllByRemains();

        Set<Width> allWidth = new HashSet<>();
        allWidth.addAll(materials.stream().collect(Collectors.groupingBy(Material::getWidth)).keySet());

        width.setItems(allWidth);
        width.setLabel("Толшина");

        width.addValueChangeListener(e -> {
            setPrice();
            materialCover.setItems(materials.stream()
                    .filter(i -> i.getWidth().equals(e.getValue()))
                    .collect(Collectors.groupingBy(i -> i.getCover())).keySet());
            materialClass.setItems(new ArrayList<>());
            materialColor.setItems(new ArrayList<>());
        });
        width.setRequired(true);
        binder.forField(width)
                .withValidator(item -> manufacturedProductValidator() && item == null || item != null, "Толщина не выбрана")
                .bind("width");

        //   materialCover.setItems(MaterialCover.values());
        materialCover.setLabel("Покрытие");
        materialCover.addValueChangeListener(e -> {
            setPrice();
            materialClass.setItems(materials.stream()
                    .filter(i -> i.getWidth().equals(width.getValue()))
                    .filter(i -> i.getCover().equals(e.getValue()))
                    .collect(Collectors.groupingBy(i -> i.getMaterialClass())).keySet());
            materialColor.setItems(new ArrayList<>());

        });

        //У цинка не блокируем выбор цвета
        materialCover.addValueChangeListener(e -> {
            if (e.getValue() != null) {
                if (e.getValue().equals(MaterialCover.ZINK)) {
                    materialColor.setEnabled(false);
                    materialColor.setInvalid(false);
                } else {
                    materialColor.setEnabled(true);
                }
            }
        });

        materialCover.setRequired(true);
        binder.forField(materialCover)
                .withValidator(item -> manufacturedProductValidator() && item == null || item != null, "Покрытие не выбрано")
                .bind("materialCover");


        materialClass.setLabel("Класс");
        materialClass.addValueChangeListener(e -> {
            setPrice();
            try {
                materialColor.setItems(materials.stream()
                        .filter(i -> i.getWidth().equals(width.getValue()))
                        .filter(i -> i.getCover().equals(materialCover.getValue()))
                        .filter(i -> i.getMaterialClass().equals(e.getValue()))
                        .collect(Collectors.groupingBy(i -> i.getMaterialColor())).keySet());
            } catch (Exception e1) {
            }
        });
        materialClass.setRequired(true);
        binder.forField(materialClass)
                .withValidator(item -> manufacturedProductValidator() && item == null || item != null , "Класс не выбран")
                .bind("materialClass");


        //   materialColor.setItems(MaterialColor.values());
        materialColor.setLabel("Цвет");
        materialColor.addValueChangeListener(e -> {
            setPrice();
        });

        materialColor.setRequired(true);
        binder.forField(materialColor)
           //     .withValidator(item -> (manufacturedProductValidator() && zinkCoverValidator() && item == null) || item != null, "Цвет не выбран")
                .bind("materialColor");


        height.setLabel("Длинна");
        height.addInputListener(e -> {
            setPrice();
            setMaterialSquaring();
        });
        height.addValueChangeListener(e -> {
            setPrice();
            setMaterialSquaring();
        });
        height.addKeyPressListener(e -> {
            setPrice();
            setMaterialSquaring();
        });

        binder.forField(height)
                .withValidator(item ->  manufacturedProductValidator() && item ==null || item!= null , "Высота введена не корректно")
                .bind("height");

        //	binder.forField(comment).bind("comment");
        binder.forField(products).bind("product");
        //   products.setRequired(true);


        //  price.setEnabled(false);
        price.setReadOnly(true);
        price.setLabel("Цена");
        binder.forField(price).bind("price");

        layProfileParams.setVisible(false);
        layAdditionalParams.setVisible(false);

        comment.setLabel("Коментарий");
        comment.setWidth("100%");
        binder.forField(comment).bind("comment");

        size.setLabel("Размеры");
        size.setPlaceholder("10+10+20...");
        size.addValueChangeListener(e -> {
            setAdditionalLength(e);
            setPrice();
        });
        binder.forField(size)
                .withValidator(item ->  additionalElementsValidator( )&&  item.isEmpty() || !item.isEmpty(), "Размеры не введены")
                .bind("size");


        // materialSquaring.setLabel("Квадратура");
        //  materialSquaring.setEnabled(false);


        delete.addClickListener(e -> fireEvent(new DeleteEvent(this)));
        setPrice();
    }

    private boolean zinkCoverValidator() {
        try {
            return materialCover.getValue() != null ? materialCover.getValue().equals(MaterialCover.ZINK) : false;
        } catch (Exception e) {
            return false;
        }
    }

    private boolean additionalElementsValidator() {
        try {
            return products.getValue() != null ? !(products.getValue().getType().equals(ProductType.ADDITIONAL_ELEMENTS)) : true;
        } catch (Exception e) {
            return  true;
        }
    }

    private boolean manufacturedProductValidator() {
        try {
            boolean ищщд =!(products.getValue().getType().equals(ProductType.PROFILED)
                    || products.getValue().getType().equals(ProductType.METAL_TILE)
                    || products.getValue().getType().equals(ProductType.ADDITIONAL_ELEMENTS));
            return products.getValue() != null ? !(products.getValue().getType().equals(ProductType.PROFILED)
                    || products.getValue().getType().equals(ProductType.METAL_TILE)
                    || products.getValue().getType().equals(ProductType.ADDITIONAL_ELEMENTS)) : true;
        } catch (Exception e) {
            return true;
        }
    }

    private void setMaterialSquaring() {
        Product product = products.getValue();
        Double heightVal = height.getValue();
        if (product != null && heightVal != null && amount != null) {
            if (product.getType() != null) {
                if (product.getSquareMeters() != null)
                    materialSquaring.setText(String.format("%.2f", product.getSquareMeters() * heightVal * amount.getValue()) + " кв.м.");

                if (product.getType().equals(ProductType.ADDITIONAL_ELEMENTS))
                    materialSquaring.setText(String.format("%.2f", calculateAdditionalWidth() / 1000 * heightVal * amount.getValue()) + " кв.м.");
            }
        }
    }

    private void setAdditionalLength(ComponentValueChangeEvent event) {
        Double result = calculateAdditionalWidth();
        comment.setValue(result + " мм " + "1/" + Helper.aroundToTheWhole((products.getValue().getWidth() * 1000) / result) + " листа");
    }

    private Double calculateAdditionalWidth() {
        ScriptEngine engine = new ScriptEngineManager().getEngineByName("JavaScript");
        if (size != null && size.getValue() != null) {
            try {
                return Double.valueOf(engine.eval(size.getValue()).toString());
            } catch (Exception e) {
                //  log.warning("Calculator mScriptEngine error: " + e.getMessage());
            }
        }
        return 0D;

    }


    private Double findProductPrice() {
        if (!width.isEmpty() && !materialClass.isEmpty() && !materialCover.isEmpty()) {
            return productAmountService.findProductPrice(width.getValue(), materialClass.getValue(), materialCover.getValue());
        }
        return 0d;
    }


    private void setPrice() {
        setMaterialSquaring();
        Double oldValue = totalPrice;
        Integer selectedAmount = amount.getValue();
        Product product = products.getValue();
        totalPrice = Double.valueOf(0);
        if (selectedAmount != null && product != null) {
            totalPrice = new BigDecimal(selectedAmount * product.getPrice()).setScale(2, RoundingMode.HALF_UP).doubleValue();
            if (product.getType() != null) {
                if (product.getType().equals(ProductType.PROFILED) || product.getType().equals(ProductType.METAL_TILE)) {
                    if (!ObjectUtils.isEmpty(height.getValue()) && !ObjectUtils.isEmpty(product.getSquareMeters())) {
                        totalPrice = new BigDecimal(selectedAmount * (findProductPrice()) * product.getSquareMeters() * height.getValue()).setScale(2, RoundingMode.HALF_UP).doubleValue();
                    }
                } else if (product.getType().equals(ProductType.ADDITIONAL_ELEMENTS)) {
                    if (!ObjectUtils.isEmpty(height.getValue()) && !ObjectUtils.isEmpty(product.getSquareMeters())) {
                        totalPrice = new BigDecimal(selectedAmount * (findProductPrice()) * calculateAdditionalWidth() / 1000 * height.getValue()).setScale(2, RoundingMode.HALF_UP).doubleValue();

                    }
                }
            }

        }

        totalPrice = Helper.aroundDouble(totalPrice);
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
