package com.roofapp.ui.views.manufacture;

import com.roofapp.backend.dao.roofdb.*;
import com.roofapp.backend.dao.roofdb.entity.*;
import com.roofapp.backend.dao.roofdb.entity.guides.Width;
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

import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.Timestamp;
import java.util.*;

import com.vaadin.flow.component.html.*;
import org.springframework.web.client.RestTemplate;
import sk.smartbase.component.qrscanner.QrScanner;

/**
 * A form for editing a single product.
 */
@Log
public class ManufactureForm extends Dialog {
    OrderItemsManufactureService itemService;

    private final VerticalLayout content;

    private final HorizontalLayout horizontalLayout;
    private final HorizontalLayout horizontalLayout2;
    private final HorizontalLayout horizontalLayoutInfo;
    private final VerticalLayout verticalLayoutLeft;
    private final VerticalLayout verticalLayoutRight;

    private final VerticalLayout machineInfo;
    private final VerticalLayout materialInfo;

    private final H6 materialRequired = new H6();
    private final H6 materialRemains = new H6();
    private final H6 materialUsed = new H6();

    private final ComboBox<Material> materialSelect;

    private final WarehouseItemService warehouseItemService;
    private final MaterialService materialService;
    private final OrderService orderService;
    private final OrderItemsService orderItemsService;
    private Button save;
    private Button cancel;

    private ManufactureViewLogic viewLogic;


    private Binder<OrderItemManufacture> binder;

    private OrderItemManufacture item;


    private MachineService machineService;

    Machine currentMachine;

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

        setWidth("1200px");
        setHeight("600px");

        content = new VerticalLayout();
        content.setSizeUndefined();
        content.setSizeFull();
        add(content);

        verticalLayoutLeft = new VerticalLayout();
        verticalLayoutRight = new VerticalLayout();

        materialSelect = new ComboBox<Material>();
        //   materialSelect.setLabel("Cырье");
        materialSelect.setWidth("100%");
        // content.add(materialSelect);
        materialSelect.addValueChangeListener(e -> {
            if (e.getValue() != null) {
                materialRemains.setText("Остаток - " + e.getValue().getRemains() + " м");
                materialUsed.setText("Израсходовано - " + e.getValue().getUsed() + " м");
            }
        });
        horizontalLayout = new HorizontalLayout(verticalLayoutLeft, verticalLayoutRight);
        horizontalLayout.setWidth("100%");
        horizontalLayout.setFlexGrow(1, verticalLayoutLeft, verticalLayoutRight);
        content.add(horizontalLayout);


        machineInfo = new VerticalLayout();
        machineInfo.setWidth("30%");

        materialInfo = new VerticalLayout();
        machineInfo.removeAll();
        materialInfo.setWidth("70%");
        materialInfo.add(new H3("Cырье"));
        materialInfo.add(materialSelect);
        materialInfo.add(new HorizontalLayout(materialUsed, materialRemains, materialRequired));

        horizontalLayoutInfo = new HorizontalLayout(machineInfo, materialInfo);
        horizontalLayoutInfo.setWidth("100%");
        horizontalLayoutInfo.setFlexGrow(1, machineInfo, materialInfo);
        content.add(horizontalLayoutInfo);


        materialSelect.addValueChangeListener(e -> save.setEnabled(!materialSelect.isEmpty()));

        binder = new Binder<>(OrderItemManufacture.class);
        binder.addStatusChangeListener(event -> {
        });

        save = new Button("Запустить цикл производства");
        save.setWidth("100%");
        save.addThemeVariants(ButtonVariant.LUMO_PRIMARY);
        save.addClickListener(event -> {
            if (item != null
                /*  && binder.writeBeanIfValid(item)*/) {
                close();
                emulateManufactureWork();
            }
        });
        save.setEnabled(false);
        save.addClickShortcut(Key.KEY_S, KeyModifier.CONTROL);


        cancel = new Button("Отмена");
        cancel.setWidth("100%");
        cancel.addClickListener(event -> close());
        cancel.addClickShortcut(Key.ESCAPE);
        getElement()
                .addEventListener("keydown", event -> viewLogic.cancel())
                .setFilter("event.key == 'Escape'");
        //  content.add(cancel);


        horizontalLayout2 = new HorizontalLayout(cancel, save);
        horizontalLayout2.setWidth("100%");
        horizontalLayout2.setFlexGrow(1, cancel, save);
        content.add(horizontalLayout2);


    }


    public void edit(OrderItemManufacture editItem) {
        addInfo(editItem);
        if (editItem == null) {
            editItem = new OrderItemManufacture();
        }
        item = editItem;
        binder.readBean(editItem);
        findMachine(editItem);
        findMaterial(editItem);
    }

    public void addInfo(OrderItemManufacture editItem) {
        verticalLayoutLeft.removeAll();
        verticalLayoutRight.removeAll();
        H3 h3 = new H3();
        try {
            h3.setText("Наряд на производство №" + editItem.getId().toString());
        } catch (Exception e) {
        }
        Div div2 = new Div();
        try {

            div2.setText(editItem.getProduct().getName() + " Ширина - " + editItem.getProduct().getWidth());
        } catch (Exception e) {
        }
        Div div3 = new Div();
        try {
            div3.setText("Длинна - " + editItem.getHeight() + " Кол-во - " + editItem.getQuantity());
        } catch (Exception e) {
        }
        Div div4 = new Div();
        try {

            div4.setText("Цвет - " + (editItem.getMaterialColor() != null ? editItem.getMaterialColor().toString() : ""));
        } catch (Exception e) {
        }
        Div div5 = new Div();
        try {

            div5.setText(" Покрытие - " + editItem.getMaterialCover().toString());
        } catch (Exception e) {
        }
        Div div6 = new Div();
        try {

            div6.setText(" Класс - " + editItem.getMaterialClass().toString());
        } catch (Exception e) {
        }
        Div div7 = new Div();
        try {

            div7.setText(" Покрытие - " + editItem.getMaterialCover().toString());
        } catch (Exception e) {
        }

        verticalLayoutLeft.add(h3, div2, div2, div3, div4, div5, div6, div7);


        H3 h3_ = new H3();
        try {

            h3_.setText("Заказ №" + editItem.getOrder().getId());
        } catch (Exception e) {
        }
        Div div9 = new Div();
        try {

            div9.setText(editItem.getOrder().getCustomer().getName());
        } catch (Exception e) {
        }
        Div div10 = new Div();
        try {
            div10.setText("Телефон - " + editItem.getOrder().getCustomer().getPhone());
        } catch (Exception e) {
        }
        Div div11 = new Div();
        try {

            div11.setText("Адрес -" + (editItem.getOrder().getCustomer().getFizAddress() != null ? editItem.getOrder().getCustomer().getFizAddress() : ""));
        } catch (Exception e) {
        }

        materialRequired.setText("Требуется - " + editItem.getHeight() * editItem.getQuantity() + " м");


        verticalLayoutRight.add(h3_, div9, div10, div11);
    }


    public void addMachineInfo() {
        machineInfo.removeAll();
        H3 h3 = new H3();
        machineInfo.add(h3);

        if (currentMachine == null) {
            h3.setText("СТАНОК НЕ НАЙДЕН!");
            return;
        }
        try {
            h3.setText("Станок  " + currentMachine.getName());
        } catch (Exception e) {
        }
        Div div2 = new Div();
        try {
            div2.setText("Длинна станка - " + currentMachine.getLength());
        } catch (Exception e) {
        }
        Div div3 = new Div();
        try {
            div3.setText("Допустимые толщины - " + currentMachine.getAllowableSize().stream().min(Comparator.comparing(Width::getValue)).get() + "-" +
                    currentMachine.getAllowableSize().stream().max(Comparator.comparing(Width::getValue)).get());
        } catch (Exception e) {
        }
        machineInfo.add(div2, div3);

    }

    private Button confirmButton;

    public void emulateManufactureWork() {

        Dialog dialog = new Dialog();
        String result = "ok";

     /*  QrScanner qrScanner = new QrScanner(false);

        qrScanner.setConsumer(qrCode -> {
            if (!"error decoding QR Code".equals(qrCode)) {
                System.out.println("scanned qr code: " + qrCode);
            }
        });*/



      /*  ZXingVaadinReader zXingVaadin = new ZXingVaadinReader();
        zXingVaadin.setFrom(Constants.From.camera);
        zXingVaadin.setId("video");
        zXingVaadin.setWidth("350");
        zXingVaadin.setStyle("border : 1px solid gray");

        zXingVaadin.addValueChangeListener(e->{
            System.out.println("=QR=:"+e.getValue());
        });
        zXingVaadin.onEnabledStateChanged(true);
*/

       QrScanner qrScanner = new QrScanner(false);
        qrScanner.setFrequency(1);
        qrScanner.setActive(true);
       // qrScanner.setDebug(true);
      //  qrScanner.setShowChangeCamera(true);
        qrScanner.setVisible(true);

        dialog.setWidth("1200px");
        dialog.setHeight("550px");
        qrScanner.setConsumer(event -> {
            if (!event.equalsIgnoreCase(QrScanner.ERROR_DECODING_QR_CODE)) {
                qrScanner.setActive(false);
                dialog.add(new Span(confirmButton));
                System.out.println("consumer event value: " + event);
            }
        });

    /*   QrScanner qrScanner = new QrScanner(false);

        qrScanner.setConsumer(qrCode -> {
            if (!"error decoding QR Code".equals(qrCode)) {
                System.out.println("scanned qr code: " + qrCode);
                qrScanner.setActive(false);
                dialog.add(new Span(confirmButton));
                System.out.println("consumer event value: " + qrCode);
            }
            System.out.println("ERR: " + qrCode);
        });
*/

        dialog.open();

        dialog.add(new Span("Загрузите бухту, отсканируйте QCode"));
        Div divWithCamera = new Div();
        divWithCamera.setHeight("200px");
        divWithCamera.add(qrScanner);
        dialog.add(divWithCamera);
        //   dialog.add(zXingVaadin );
        dialog.setCloseOnEsc(false);
        dialog.setCloseOnOutsideClick(false);

        confirmButton = new Button("Загружена", event -> {
            try {
                // result = sendOrderToArduino(item, currentMachine, materialSelect.getValue());
            } catch (Exception e) {
                Notification.show("Нет связи со станком!" + result);
            }
            if (result.equals("ok")) {
                dialog.close();
                Dialog dialog2 = new Dialog();
                dialog2.add("Задание отправлено Станок работает!");
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
            } else {
                dialog.add("Ошибка отправки задания на станок!!!!");
            }
        });


    }


    private WarehouseItem getWhereHouseItems() {
        OrderItem orderItem = orderItemsService.findById(item.getId());
        return warehouseItemService.findByOrderItem(orderItem);
    }


    private void addToWarehouse() {
        WarehouseItem warehouseItems = getWhereHouseItems();
        OrderItem orderItem = orderItemsService.findById(item.getId()); //TODO оптимизировать

        if (warehouseItems == null) {
            WarehouseItem warehouseItem = warehouseItemService.createNew(null);
            warehouseItem.setProduct(item.getProduct());
            warehouseItem.setQuantity(materialSelect.getValue().getCountInProduction());
            warehouseItem.setState(WarehouseState.STORAGE);
            warehouseItem.setMachine(currentMachine);
            warehouseItem.setMaterial(materialSelect.getValue());
            warehouseItem.setOrderItem(orderItem);
            warehouseItemService.save(warehouseItem);
            Notification.show("Передано на склад");


        } else {
            warehouseItems.setQuantity(warehouseItems.getQuantity() + materialSelect.getValue().getCountInProduction());
            warehouseItemService.save(warehouseItems);
        }
        orderItem.setState(ItemState.READY);
        orderItemsService.save(null, orderItem);

    }

    private void useMaterial() {
        Material material = materialSelect.getValue();
        material.setUsed(material.getUsed() + material.getRemainInProduction());
        material.setRemains(material.getRemains() - (material.getRemainInProduction()));
        materialService.save(material);
    }


    private void changeOrderState() {
        WarehouseItem warehouseItems = getWhereHouseItems();

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
        item.setState(ItemState.READY);
        item.setDone(new Timestamp(System.currentTimeMillis()));
        OrderItem orderItem = orderItemsService.findById(item.getId());
        orderItem.setDone(new Timestamp(System.currentTimeMillis()));
        orderItemsService.save(null, orderItem);
    }


    private void findMachine(OrderItemManufacture editItem) {
        currentMachine = null;
        try {
            if (machineService != null && editItem != null) {
                List<Machine> machine = machineService.findAll();
                machine.forEach(item -> {
                    if (item.getName().equals(editItem.getProduct().getName().replace("Профнастил ", ""))) {
                        //  machineSelect.setValue(item);
                        currentMachine = item;
                    } else if (editItem.getProduct().getType().equals(ProductType.ADDITIONAL_ELEMENTS)) {
                        if (item.getName().equals("Гибочный станок"))
                            currentMachine = item;
                    }
                });
            }
        } catch (Exception e) {

        }
        addMachineInfo();
    }

    private void findMaterial(OrderItemManufacture editItem) {
        materialSelect.clear();
        WarehouseItem warehouseItems = getWhereHouseItems();

        Double orderMetalLength = (editItem.getHeight() * editItem.getQuantity());
        if (warehouseItems != null) {
            orderMetalLength = orderMetalLength - editItem.getHeight() * warehouseItems.getQuantity();
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
                        Double maxLenght = material.getRemains() - currentMachine.getLength();
                        Integer maxCount = Helper.aroundToTheWhole(maxLenght / item.getHeight());
                        Double maxProductionLength = maxCount * item.getHeight();


                        if (orderMetalLength > maxProductionLength) {
                            Double production = maxProductionLength;
                            orderMetalLength = orderMetalLength - production;
                            material.setRemainInProduction(production);
                            material.setCountInProduction(maxCount);
                            allProdMaterials.add(material);
                        } else {
                            Double production = orderMetalLength;
                            orderMetalLength = orderMetalLength - production;
                            material.setRemainInProduction(production);
                            material.setCountInProduction(production.intValue() / item.getHeight().intValue());
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

    /**
     * Отправка Задания на станок
     *
     * @param machine
     * @param material
     */
    private String sendOrderToArduino(OrderItemManufacture item, Machine machine, Material material) {
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://192.168.0.108:8090/manufactureOrder?" +
                "id=" + item.getId().toString() +
                "&count=" + item.getQuantity().toString() +
                "&lenght=" + item.getHeight().toString() +
                "&materialId=" + material.getId();
        return restTemplate.getForObject(url, String.class);
    }


    public ManufactureViewLogic getViewLogic() {
        return viewLogic;
    }
}
