package com.roofapp.ui.views.manufacture;

import com.roofapp.backend.dao.roofdb.MaterialCover;
import com.roofapp.backend.dao.roofdb.OrderState;
import com.roofapp.backend.dao.roofdb.WarehouseState;
import com.roofapp.backend.dao.roofdb.entity.*;
import com.roofapp.backend.service.*;
import com.roofapp.backend.utils.Helper;
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
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.*;
import java.util.concurrent.atomic.AtomicReference;

import com.vaadin.flow.component.html.*;

/**
 * A form for editing a single product.
 */

public class ManufactureForm extends Div {

    private final VerticalLayout content;

    OrderItemsManufactureService itemService;

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
    private final OrderItemsService orderItemsService;
    private Button save;
    private Button ok;
    // private Button discard;
    private Button cancel;

    private final ManufactureViewLogic viewLogic;


    private final Binder<OrderItemManufacture> binder;

    private OrderItemManufacture item;


    private final MachineService machineService;

    @Autowired
    public ManufactureForm(ManufactureViewLogic viewLogic,
                           OrderItemsManufactureService itemService,
                           MachineService machineService,
                           MaterialService materialService,
                           WarehouseItemService warehouseItemService,
                           OrderService orderService, OrderItemsService orderItemsService) {
        this.itemService = itemService;
        this.warehouseItemService = warehouseItemService;
        this.materialService = materialService;
        this.orderService = orderService;
        this.machineService = machineService;
        this.orderItemsService = orderItemsService;
        this.viewLogic = viewLogic;

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
        //   machineSelect.setItems(machineService.findAll());
        machineSelect.setWidth("100%");
        machineSelect.setReadOnly(true);
        content.add(machineSelect);


        materialSelect = new ComboBox<Material>();
        materialSelect.setLabel("Выберите сырье");
        //  materialSelect.setItems(materialService.findAll());
        materialSelect.setWidth("100%");
        // materialSelect.setReadOnly(true);
        content.add(materialSelect);

        machineSelect.addValueChangeListener(e -> save.setEnabled(!materialSelect.isEmpty() && !machineSelect.isEmpty()));
        materialSelect.addValueChangeListener(e -> save.setEnabled(!materialSelect.isEmpty() && !machineSelect.isEmpty()));


        /*final HorizontalLayout horizontalLayout = new HorizontalLayout(machineSelect, materialSelect);
        horizontalLayout.setWidth("100%");
        horizontalLayout.setFlexGrow(1, machineSelect, materialSelect);
        content.add(horizontalLayout);
*/
        //   binder = new BeanValidationBinder<>(OrderItem.class);
        binder = new Binder<>(OrderItemManufacture.class);


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

    public void edit(OrderItemManufacture editItem) {
        if (editItem == null) {
            editItem = new OrderItemManufacture();
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
        findMaterial(editItem);
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
                    changeItemState();
                    changeOrderState();
                    viewLogic.saveItem(item);
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

    private WarehouseItem getWhereHouseItems() {
        OrderItem orderItem = orderItemsService.findById(item.getId());
        return warehouseItemService.findByOrderItem(orderItem);
    }

  /*  private Double getCalcWhereHouseItems() {
        return warehouseItems.stream().mapToDouble(item -> item.getQuantity()).sum();
    }*/

    private void addToWarehouse() {
        WarehouseItem warehouseItems =getWhereHouseItems();
        OrderItem orderItem = orderItemsService.findById(item.getId()); //TODO оптимизировать

        if (warehouseItems == null) {
            WarehouseItem warehouseItem = warehouseItemService.createNew(null);
            warehouseItem.setProduct(item.getProduct());
            warehouseItem.setQuantity( materialSelect.getValue().getCountInProduction());
            warehouseItem.setState(WarehouseState.STORAGE);
            warehouseItem.setMachine(machineSelect.getValue());
            warehouseItem.setMaterial(materialSelect.getValue());
            warehouseItem.setOrderItem( orderItem );
            warehouseItemService.save(warehouseItem);
            Notification.show("Передано на склад");
       }else{
            warehouseItems.setQuantity(  warehouseItems.getQuantity()+materialSelect.getValue().getCountInProduction());
            warehouseItemService.save(warehouseItems);
        }

    }

    private void useMaterial() {
        Material material = materialSelect.getValue();
        material.setUsed(material.getUsed() +  material.getRemainInProduction());
        material.setRemains(material.getRemains() - (material.getRemainInProduction()));
        materialService.save(material);
    }


    private void changeOrderState() {
        WarehouseItem warehouseItems =getWhereHouseItems();

        if (warehouseItems.getQuantity().intValue() == item.getQuantity()) {
            List<OrderItem> orderItems = orderItemsService.findAllByOrderId(item.getOrder().getId());
            for (OrderItem orderItem : orderItems) {
                if (orderItem.getDone() == null)
                    return;
            }
            Order order = item.getOrder();
            order.setDone(new Timestamp(System.currentTimeMillis()));
            order.setState(OrderState.READY);
            orderService.saveOrder(order);

            Optional<Order> parentOrder = orderService.findById(item.getOrder().getParentId());
            parentOrder.get().setState(OrderState.STORAGE);
            orderService.saveOrder(parentOrder.get());
        }
    }

    private void changeItemState() {
        OrderItem orderItem = orderItemsService.findById(item.getId());
        orderItem.setDone(new Timestamp(System.currentTimeMillis()));
        orderItemsService.save(null, orderItem);
    }


    private void findMachine(OrderItemManufacture editItem) {
        machineSelect.clear();
        try {
            if (machineService != null && editItem != null) {
                List<Machine> machine = machineService.findAll();
                machine.forEach(item -> {
                    if (item.getName().equals(editItem.getProduct().getName().replace("Профнастил ", "")))
                        machineSelect.setValue(item);
                });
            }
        } catch (Exception e) {
        }
    }

    private void findMaterial(OrderItemManufacture editItem) {
        materialSelect.clear();
        WarehouseItem warehouseItems =getWhereHouseItems();

        Double orderMetalLength = (editItem.getHeight() * editItem.getQuantity()) ;
        if(warehouseItems != null){
            orderMetalLength =   orderMetalLength - editItem.getHeight()*warehouseItems.getQuantity();
        }
        try {
            if (machineService != null && editItem != null) {

                List<Material> materials = materialService.findAll();
                List<Material> allMaterials = new ArrayList<>();
                materials.forEach(item -> {
                    if (item.getWidth().equals(editItem.getWidth())
                            && item.getCover().equals(editItem.getMaterialCover())
                            && item.getMaterialClass().equals(editItem.getMaterialClass())
                            //  && item.getRemains() > editItem.getHeight()
                            //если  <= 10 метров то на гладкий лист пускаем
                            && item.getRemains() >= 10)
                        if ((!item.getCover().equals(MaterialCover.ZINK) && item.getMaterialColor().equals(editItem.getMaterialColor())))
                            allMaterials.add(item);
                        else if (item.getCover().equals(MaterialCover.ZINK))
                            allMaterials.add(item);
                });

                /*    Material minMaterial = allMaterials.stream().min(Comparator.comparing(Material::getRemains)).get();
                if (minMaterial.getRemains() >= orderMetalLength) {
                    materialSelect.setValue(minMaterial);
                    return;
                }*/


                allMaterials.stream().sorted(Comparator.comparing(Material::getRemains));
                Double remainsToProduce = 0D;
                List<Material> allProdMaterials = new ArrayList<>();
                for (Material material : allMaterials) {
                    //Производим из меньшей по остатку сырья сли хватает остатка
                    if (material.getRemains() >= editItem.getHeight() * editItem.getQuantity()) {
                        material.setRemainInProduction(editItem.getHeight() * editItem.getQuantity());
                        material.setCountInProduction(editItem.getQuantity().intValue());
                        materialSelect.setValue(material);
                        return;
                    }
                    if (orderMetalLength >= 0D) {
                        //Пpозводство из 2 и более бухт;
                        Double maxLenght =   material.getRemains() - machineSelect.getValue().getLength();
                        Integer maxCount = Helper.aroundToTheWhole( maxLenght /item.getHeight());
                        Double maxProductionLength = maxCount *item.getHeight();


                        if (orderMetalLength >maxProductionLength ) {
                            Double production = maxProductionLength ;
                            orderMetalLength = orderMetalLength - production;
                            material.setRemainInProduction(production);
                            material.setCountInProduction(maxCount);
                            allProdMaterials.add(material);
                        } else {
                            Double production = orderMetalLength;
                            orderMetalLength = orderMetalLength - production;
                            material.setRemainInProduction(production);
                            material.setCountInProduction(production.intValue()/item.getHeight().intValue());
                            allProdMaterials.add(material);
                        }
                    }

                }
                if (orderMetalLength > 0) {
                    Notification.show("На складе на хватает сырья для производства");
                } else {
                    materialSelect.setItems(allProdMaterials);
                }
            }
        } catch (Exception e) {

        }
    }
}
