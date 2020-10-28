package com.roofapp.ui.views.manufacture;

import com.roofapp.backend.dao.roofdb.OrderState;
import com.roofapp.backend.dao.roofdb.OrderType;
import com.roofapp.backend.dao.roofdb.WarehouseState;
import com.roofapp.backend.dao.roofdb.entity.*;
import com.roofapp.backend.service.*;
import com.roofapp.ui.views.warehouse.WarehouseViewLogic;
import com.vaadin.flow.component.Key;
import com.vaadin.flow.component.KeyModifier;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.combobox.ComboBox;
import com.vaadin.flow.component.dialog.Dialog;
import com.vaadin.flow.component.html.Div;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.data.binder.Binder;
import com.vaadin.flow.data.converter.StringToBigDecimalConverter;
import com.vaadin.flow.data.converter.StringToIntegerConverter;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import java.util.Optional;

import com.vaadin.flow.component.html.*;
//import io.swagger.models.auth.In;

/**
 * A form for editing a single product.
 */

public class ManufactureForm extends Div {

    private final VerticalLayout content;

    OrderItemsService itemService;

    /* private final ComboBox<Product> product;
     private final IntegerField quantity;

     private final Select<WarehouseState>  state;
 */
    private final H3 orderInfo = new H3();
    private final H3 subOrderInfo = new H3();

    private final Div productInfo = new Div();
    private final Div sizeInfo = new Div();
    private final Div coverInfo = new Div();
    private final Div comment = new Div();

    private final ComboBox<Machine> machineSelect;
    private final ComboBox<Material> materialSelect;
    private Dialog dialog;
    //    private final NumberField height;
    //  private final TextField product;
    private final WarehouseItemService warehouseItemService;
    private final MaterialService materialService;
    private final OrderService orderService;
    private Button save;
    private Button ok;
    // private Button discard;
    private Button cancel;
    /*  private final Button delete;*/

    private WarehouseViewLogic viewLogic;

    public void setViewLogic(WarehouseViewLogic viewLogic) {
        this.viewLogic = viewLogic;
    }

    private final Binder<OrderItem> binder;

    private OrderItem item;

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

    private final MachineService machineService;

    @Autowired
    public ManufactureForm(ManufactureViewLogic viewLogic,
                           OrderItemsService itemService,
                           MachineService machineService,
                           MaterialService materialService,
                           WarehouseItemService warehouseItemService,
                           OrderService orderService) {
        this.itemService = itemService;
        this.warehouseItemService = warehouseItemService;
        this.materialService = materialService;
        this.orderService = orderService;
        this.machineService = machineService;
        setClassName("manufacture-form");

        content = new VerticalLayout();
        content.setSizeUndefined();
        content.setSizeFull();
        //  content.addClassName("product-form-content");
        add(content);

        content.add(orderInfo);
        content.add(subOrderInfo);
        content.add(productInfo);
        content.add(sizeInfo);
        content.add(coverInfo);
        content.add(comment);


        machineSelect = new ComboBox<Machine>();
        machineSelect.setLabel("Выберите станок");
        machineSelect.setItems(machineService.findAll());
        machineSelect.setWidth("100%");
        machineSelect.setReadOnly(true);
        content.add(machineSelect);


        materialSelect = new ComboBox<Material>();
        materialSelect.setLabel("Выберите сырье");
        materialSelect.setItems(materialService.findAll());
        materialSelect.setWidth("100%");
        content.add(materialSelect);

        machineSelect.addValueChangeListener(e -> save.setEnabled(!materialSelect.isEmpty() && !machineSelect.isEmpty()));
        materialSelect.addValueChangeListener(e -> save.setEnabled(!materialSelect.isEmpty() && !machineSelect.isEmpty()));


        /*final HorizontalLayout horizontalLayout = new HorizontalLayout(machineSelect, materialSelect);
        horizontalLayout.setWidth("100%");
        horizontalLayout.setFlexGrow(1, machineSelect, materialSelect);
        content.add(horizontalLayout);
*/
        //   binder = new BeanValidationBinder<>(OrderItem.class);
        binder = new Binder<>(OrderItem.class);


        //binder.bindInstanceFields(this);
        binder.addStatusChangeListener(event -> {
            //  final boolean isValid = !event.hasValidationErrors();
            //   final boolean hasChanges = binder.hasChanges();
            //   discard.setEnabled(hasChanges);
        });

        save = new Button("Запустить цикл производства");
        save.setWidth("100%");
        save.addThemeVariants(ButtonVariant.LUMO_PRIMARY);
        save.addClickListener(event -> {
            if (item != null
                /*  && binder.writeBeanIfValid(item)*/) {
                emulateManufactureWork();
                viewLogic.saveItem(item);
            }
        });
        save.setEnabled(false);
        save.addClickShortcut(Key.KEY_S, KeyModifier.CONTROL);
        //  content.add(save);


/*
      discard = new Button("Сбросить");
        discard.setWidth("100%");
        discard.addClickListener(
                event -> viewLogic.edit(item));
*/
        cancel = new Button("Отмена");
        cancel.setWidth("100%");
        cancel.addClickListener(event -> viewLogic.cancel());
        cancel.addClickShortcut(Key.ESCAPE);
        getElement()
                .addEventListener("keydown", event -> viewLogic.cancel())
                .setFilter("event.key == 'Escape'");
        //  content.add(cancel);


        final HorizontalLayout horizontalLayout = new HorizontalLayout(cancel, save);
        horizontalLayout.setWidth("100%");
        horizontalLayout.setFlexGrow(1, cancel, save);
        content.add(horizontalLayout);


      /*    delete = new Button("Удалить");
        delete.setWidth("100%");
        delete.addThemeVariants(ButtonVariant.LUMO_ERROR,
                ButtonVariant.LUMO_PRIMARY);
        delete.addClickListener(event -> {
            if (item != null) {
                viewLogic.delete(item);
            }
        });*/

        //  content.add(save/*, discard, delete, cancel*/);
    }

    //  public void setCategories(Collection<Category> categories) {
    //    category.setItems(categories);
    //  }

    public void edit(OrderItem editItem) {
        if (editItem == null) {
            editItem = new OrderItem();
        }
        //    delete.setVisible(! editItem.isNew());
        item = editItem;
        binder.readBean(editItem);

        try {
         //   orderInfo.setText("Заказ №" + editItem.getOrder().getId().toString());
            subOrderInfo.setText("Наряд на производство №" + editItem.getId().toString());
            productInfo.setText(editItem.getProduct().getName() + " Ширина заданная - " + editItem.getProduct().getWidth());
            sizeInfo.setText("Длинна - " + editItem.getHeight() + " Кол-во - " + editItem.getQuantity());
            coverInfo.setText("Цвет - " + editItem.getMaterialColor().toString() + " Покрытие - " + editItem.getMaterialCover() + " Класс - " + editItem.getMaterialClass());
            comment.setText("Комментарий - " + editItem.getComment());
        } catch (Exception e) {

        }

        findMachine(editItem);
    }

    public void emulateManufactureWork() {

        Dialog dialog = new Dialog();
        dialog.add("Загрузите бухту, отсканируйте QCode");

        dialog.setCloseOnEsc(false);
        dialog.setCloseOnOutsideClick(false);
        Button confirmButton = new Button("Загружена", event -> {
            dialog.close();
            Dialog dialog2 = new Dialog();
            dialog2.add("Станок работает!");

            dialog2.setCloseOnEsc(false);
            dialog2.setCloseOnOutsideClick(false);
            Button confirmButton2 = new Button("Завершить выпуск продукции?", event2 -> {
                dialog2.close();
                Dialog dialog3 = new Dialog();
                dialog3.add("Прокат завершен");

                dialog3.setCloseOnEsc(false);
                dialog3.setCloseOnOutsideClick(false);
                Button confirmButton3 = new Button("Передать на склад?", event3 -> {
                    dialog3.close();
                    addToWarehouse();
                    useMaterial();
                    changeOrderState();
                });
                dialog3.add(confirmButton3);
                dialog3.open();


            });
            dialog2.add(confirmButton2);
            dialog2.open();


        });
        dialog.add(confirmButton);
        dialog.open();

    }

    private void addToWarehouse() {
        WarehouseItem warehouseItem = warehouseItemService.createNew(null);
        warehouseItem.setProduct(item.getProduct());
        warehouseItem.setQuantity(item.getQuantity().intValue());
        warehouseItem.setState(WarehouseState.STORAGE);
        warehouseItem.setMachine(machineSelect.getValue());
        warehouseItem.setMaterial(materialSelect.getValue());
        warehouseItemService.save(warehouseItem);
        Notification.show("Передано на склад");
    }

    private void useMaterial() {
        Material material = materialSelect.getValue();
        material.setUsed(material.getUsed() + item.getHeight() * item.getQuantity());
        material.setRemains(material.getLength() - (item.getHeight() * item.getQuantity()));
        materialService.save(material);
    }


    private void changeOrderState() {
        Optional<Order> order = orderService.findById(item.getId());
        order.get().setState(OrderState.READY);
        orderService.saveOrder(order.get());

        //   item.setOrderType(OrderType.MANUFACTURED);
    }

    private void findMachine(OrderItem editItem) {
        machineSelect.clear();
        try {
            if (machineService != null && editItem != null) {
                List<Machine> machine = machineService.findAll();
                machine.forEach(item -> {
                    if (item.getName().equals(editItem.getProduct().getName().replace("Профнастил ", "")))
                        machineSelect.setValue(item);
                });
            }
        }catch (Exception e){}
    }
}
