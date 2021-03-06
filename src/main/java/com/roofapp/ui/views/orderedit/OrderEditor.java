package com.roofapp.ui.views.orderedit;

import com.roofapp.backend.dao.roofdb.Discount;
import com.roofapp.backend.dao.roofdb.OrderState;
import com.roofapp.backend.dao.roofdb.entity.*;
import com.roofapp.backend.service.*;
import com.roofapp.backend.service.guides.WidthGuideService;
import com.roofapp.backend.utils.Helper;
import com.roofapp.ui.crud.CrudEntityDataProvider;
import com.roofapp.ui.dataproviders.DataProviderUtil;
import com.roofapp.ui.events.CancelEvent;
import com.roofapp.ui.utils.FormattingUtils;
import com.roofapp.ui.utils.converters.LocalTimeConverter;
import com.roofapp.ui.views.contractors.ContractorDataProvider;
import com.roofapp.ui.views.contractors.ContractorsForm;
import com.roofapp.ui.views.order.events.ContractorChangeEvent;
import com.roofapp.ui.views.order.events.ReviewEvent;
import com.roofapp.ui.views.order.events.ValueChangeEvent;
import com.vaadin.flow.component.ComponentEventListener;
import com.vaadin.flow.component.ComponentUtil;
import com.vaadin.flow.component.HasValue;
import com.vaadin.flow.component.Tag;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.combobox.ComboBox;
import com.vaadin.flow.component.datepicker.DatePicker;
import com.vaadin.flow.component.dependency.JsModule;
import com.vaadin.flow.component.html.Div;
import com.vaadin.flow.component.html.H2;
import com.vaadin.flow.component.html.Span;
import com.vaadin.flow.component.polymertemplate.Id;
import com.vaadin.flow.component.polymertemplate.PolymerTemplate;
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.data.binder.BeanValidationBinder;
import com.vaadin.flow.data.binder.BindingValidationStatus;
import com.vaadin.flow.data.binder.ValidationException;
import com.vaadin.flow.data.provider.DataProvider;
import com.vaadin.flow.data.validator.BeanValidator;
import com.vaadin.flow.shared.Registration;
import com.vaadin.flow.spring.annotation.SpringComponent;
import com.vaadin.flow.templatemodel.TemplateModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.ConfigurableBeanFactory;
import org.springframework.context.annotation.Scope;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalTime;
import java.util.SortedSet;
import java.util.TreeSet;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

import static com.roofapp.ui.dataproviders.DataProviderUtil.createItemLabelGenerator;

@Tag("order-editor")
@JsModule("./src/views/orderedit/order-editor.js")
@SpringComponent
@Scope(ConfigurableBeanFactory.SCOPE_PROTOTYPE)
public class OrderEditor extends PolymerTemplate<OrderEditor.Model> {

    public interface Model extends TemplateModel {
        void setTotalPrice(String totalPrice);

        void setStatus(String status);
    }

    @Id("title")
    private H2 title;

    @Id("metaContainer")
    private Div metaContainer;

    @Id("orderNumber")
    private Span orderNumber;

    @Id("status")
    private ComboBox<OrderState> status;

    @Id("dueDate")
    private DatePicker dueDate;

    @Id("dueTime")
    private ComboBox<LocalTime> dueTime;

    @Id("pickupLocation")
    private ComboBox<PickupLocation> pickupLocation;

    @Id("customerName")
    private ComboBox<Contractor> customerName;

    @Id("addCustomer")
    private Button addCustomer;

    @Id("customerNumber")
    private TextField customerNumber;

    @Id("customerDetails")
    private TextField customerDetails;

    @Id("discount")
    private ComboBox<Discount> discount;

    @Id("cancel")
    private Button cancel;

    @Id("review")
    private Button review;

    @Id("itemsContainer")
    private Div itemsContainer;

    private OrderItemsEditor itemsEditor;

    private User currentUser;

    private BeanValidationBinder<Order> binder = new BeanValidationBinder<>(Order.class);

    private final LocalTimeConverter localTimeConverter = new LocalTimeConverter();

    private final ProductAmountService productAmountService;

    private final ContractorService contractorService;

    private final MaterialService materialService;

    private final WidthGuideService widthGuideService;

    private Double totalPrice = 0D;

    private ContractorsForm form;

    private ContractorDataProvider dataProvider;

    @Autowired
    public OrderEditor(PickupLocationService locationService,
                       ProductService productService,
                       ProductAmountService productAmountService,
                       ContractorService contractorService,
                       MaterialService materialService,
                       WidthGuideService widthGuideService) {
        this.productAmountService = productAmountService;
        this.contractorService = contractorService;
        this.materialService = materialService;
        this.widthGuideService = widthGuideService;
        DataProvider<PickupLocation, String> locationDataProvider = new CrudEntityDataProvider<>(locationService);
        DataProvider<Product, String> productDataProvider = new CrudEntityDataProvider<>(productService);
        itemsEditor = new OrderItemsEditor(productService, this.productAmountService, this.materialService, this.widthGuideService);

        dataProvider = new ContractorDataProvider(contractorService);

        //  customerName.setItems(contractorService.findAllOrderName());
        customerName.setDataProvider(dataProvider);
        customerName.addValueChangeListener(e -> {
            if (e != null && e.getValue() != null) {
                if (e.getValue().getPhone() != null) {
                    customerNumber.setValue(e.getValue().getPhone());
                } else customerNumber.clear();
            }else customerNumber.clear();
        });

        itemsContainer.add(itemsEditor);

        cancel.addClickListener(e -> fireEvent(new CancelEvent(this, true)));
        review.addClickListener(e -> fireEvent(new ReviewEvent(this)));

        status.setItemLabelGenerator(createItemLabelGenerator(OrderState::getDisplayName));
        status.setDataProvider(DataProvider.ofItems(OrderState.values()));
        status.addValueChangeListener(
                e -> getModel().setStatus(DataProviderUtil.convertIfNotNull(e.getValue(), OrderState::name)));
        binder.forField(status)
                .withValidator(new BeanValidator(Order.class, "state"))
                .bind(Order::getState, (o, s) -> {
                    o.changeState(currentUser, s);
                });

        dueDate.setRequired(true);
        binder.bind(dueDate, "dueDate");

        SortedSet<LocalTime> timeValues = IntStream.rangeClosed(8, 16).mapToObj(i -> LocalTime.of(i, 0))
                .collect(Collectors.toCollection(TreeSet::new));
        dueTime.setItems(timeValues);
        dueTime.setItemLabelGenerator(localTimeConverter::encode);
        binder.bind(dueTime, "dueTime");

        pickupLocation.setItemLabelGenerator(createItemLabelGenerator(PickupLocation::getName));
        pickupLocation.setDataProvider(locationDataProvider);
        binder.bind(pickupLocation, "pickupLocation");
        pickupLocation.setRequired(false);

        customerName.setRequired(true);
        binder.bind(customerName, "customer");


        form = new ContractorsForm(contractorService);
        form.setDataProvider(dataProvider);
        getElement().appendChild(form.getElement());

        addCustomer.addClickListener(click -> {
            if (this.customerName != null) {
                form.editContractor(customerName.getValue());
            } else {
                form.editContractor(null);
            }
            form.open();
        });

        form.addEditContractorListener(contractorChangeEvent -> {
            this.customerName.setValue(contractorChangeEvent.getContractor());
            if (contractorChangeEvent.getContractor() != null)
                this.customerNumber.setValue(contractorChangeEvent.getContractor().getPhone());
        });


        discount.setDataProvider(DataProvider.ofItems(Discount.values()));
        discount.setItemLabelGenerator(createItemLabelGenerator(Discount::getDisplayName));
        discount.addValueChangeListener(e -> setTotalPrice(totalPrice));
        //  discount.addValueChangeListener(e-> setTotalPrice());
        binder.bind(discount, "discount");

        customerNumber.setReadOnly(true);
        //	binder.bind(customerNumber, "customer.phone");

        //binder.bind(customerDetails, "customer.details");

        itemsEditor.setRequiredIndicatorVisible(true);
        binder.bind(itemsEditor, "items");

        itemsEditor.addPriceChangeListener(e -> setTotalPrice(e.getTotalPrice()));

        ComponentUtil.addListener(itemsEditor, ValueChangeEvent.class, e -> review.setEnabled(hasChanges()));
        binder.addValueChangeListener(e -> {
            if (e.getOldValue() != null) {
                review.setEnabled(hasChanges());
            }
        });
    }


    public boolean hasChanges() {
        return binder.hasChanges() || itemsEditor.hasChanges();
    }

    public void clear() {
        binder.readBean(null);
        itemsEditor.setValue(null);
    }

    public void close() {
        setTotalPrice(0d);
    }

    public void write(Order order) throws ValidationException {
        binder.writeBean(order);
    }

    public void read(Order order, boolean isNew) {
        binder.readBean(order);

        this.orderNumber.setText(isNew ? "" : order.getId().toString());
        title.setVisible(isNew);
        metaContainer.setVisible(!isNew);

        if (order.getState() != null) {
            getModel().setStatus(order.getState().name());
        }

        review.setEnabled(false);
    }

    public Stream<HasValue<?, ?>> validate() {
        Stream<HasValue<?, ?>> errorFields = binder.validate().getFieldValidationErrors().stream()
                .map(BindingValidationStatus::getField);

        return Stream.concat(errorFields, itemsEditor.validate());
    }

    public Registration addReviewListener(ComponentEventListener<ReviewEvent> listener) {
        return addListener(ReviewEvent.class, listener);
    }

    public Registration addCancelListener(ComponentEventListener<CancelEvent> listener) {
        return addListener(CancelEvent.class, listener);
    }


    private void setTotalPrice(Double totalPrice) {
        if (discount.getValue() != null) {
            this.totalPrice = totalPrice;
            getModel().setTotalPrice(new BigDecimal(totalPrice - totalPrice * discount.getValue().getDiscount()).setScale(2, RoundingMode.HALF_UP).toString());
            //  getModel().setTotalPrice(/*FormattingUtils.formatAsCurrency(*/ Helper.aroundDouble(totalPrice).toString());
        }
    }

    public void setCurrentUser(User currentUser) {
        this.currentUser = currentUser;
    }
}
