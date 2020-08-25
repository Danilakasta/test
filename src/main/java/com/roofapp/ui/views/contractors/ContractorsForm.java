package com.roofapp.ui.views.contractors;

import com.roofapp.backend.dao.roofdb.ContractorSubType;
import com.roofapp.backend.dao.roofdb.ContractorType;
import com.roofapp.backend.dao.roofdb.entity.Contractor;
import com.roofapp.backend.service.ContractorService;
import com.vaadin.flow.component.Key;
import com.vaadin.flow.component.KeyModifier;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.html.Div;
import com.vaadin.flow.component.html.Span;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.component.select.Select;
import com.vaadin.flow.component.textfield.EmailField;
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

/**
 * A form for editing a single Contractor.
 */

public class ContractorsForm extends Div {

    private final VerticalLayout content;

    ContractorService contractorService;

    private final TextField name;

    private final Select<ContractorType> type;

    private final Select<ContractorSubType> contractorSubType;


    //  private final PhoneNumberField phohe;
    private final TextField phohe;
    private final EmailField email;

    private final TextField urAddress;
    private final TextField fizAddress;
    private final IntegerField inn;
    private final IntegerField kpp;
    private final IntegerField okpo;
    private final IntegerField ogrn;


    private final TextField deliveryAddress;


    private Button save;
    private Button discard;
    private Button cancel;
    private final Button delete;

    private ContractorsViewLogic viewLogic;

    public void setViewLogic(ContractorsViewLogic viewLogic) {
        this.viewLogic = viewLogic;
    }

    private final Binder<Contractor> binder;
    private Contractor currentContractor;

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
    public ContractorsForm(ContractorsViewLogic viewLogic, ContractorService contractorService) {
        this.contractorService = contractorService;
        setClassName("product-form ");

        content = new VerticalLayout();
        content.setSizeUndefined();
        content.addClassName("product-form-content");
        add(content);

        //   viewLogic = sampleCrudLogic;

        name = new TextField("Наименование, *ФИО для физ лиц");
        name.setWidth("80%");
        name.setRequired(true);
        name.setValueChangeMode(ValueChangeMode.EAGER);
        content.add(name);

        type = new Select<>();
        type.setLabel("Тип");
        type.setWidth("20%");
        type.setItems(ContractorType.values());
        content.add(type);

        final HorizontalLayout horizontalLayout = new HorizontalLayout(name, type);
        horizontalLayout.setWidth("100%");
        horizontalLayout.setFlexGrow(1, name, type);
        content.add(horizontalLayout);

        phohe = new TextField("Номер телефона");
        phohe.setWidth("40%");
        content.add(phohe);

        email = new EmailField("Почта");
        email.setSuffixComponent(new Span("@"));
        email.setWidth("60%");
        email.setClearButtonVisible(true);
        email.setErrorMessage("Пожалуйста введидеадрес правильно");
        content.add(email);


        final HorizontalLayout horizontalLayout2 = new HorizontalLayout(phohe, email);
        horizontalLayout2.setWidth("100%");
        horizontalLayout2.setFlexGrow(1, phohe, email);
        content.add(horizontalLayout2);

        urAddress = new TextField("Юр. адрес");
        urAddress.setWidth("60%");
        urAddress.setRequired(true);
        urAddress.setValueChangeMode(ValueChangeMode.EAGER);

        inn = new IntegerField("ИНН");
        inn.setWidth("20%");
        inn.setValueChangeMode(ValueChangeMode.EAGER);

        kpp = new IntegerField("КПП");
        kpp.setWidth("20%");
        kpp.setValueChangeMode(ValueChangeMode.EAGER);


        final HorizontalLayout horizontalLayout3 = new HorizontalLayout(urAddress,inn,kpp   );
        horizontalLayout3.setWidth("100%");
        horizontalLayout3.setFlexGrow(1, urAddress,inn,kpp  );
        content.add(horizontalLayout3);

        fizAddress = new TextField("Физ. адрес");
        fizAddress.setWidth("60%");
        fizAddress.setRequired(true);
        fizAddress.setValueChangeMode(ValueChangeMode.EAGER);


        okpo = new IntegerField("ОКПО");
        okpo.setWidth("20%");
        okpo.setValueChangeMode(ValueChangeMode.EAGER);

        ogrn = new IntegerField("ОГРН");
        ogrn.setWidth("20%");
        ogrn.setValueChangeMode(ValueChangeMode.EAGER);


        final HorizontalLayout horizontalLayout4 = new HorizontalLayout(fizAddress ,  okpo, ogrn   );
        horizontalLayout4 .setWidth("100%");
        horizontalLayout4 .setFlexGrow(1, fizAddress ,  okpo, ogrn  );
        content.add(horizontalLayout4 );


        contractorSubType = new Select<>();
        contractorSubType.setLabel("Тип клиента");
        contractorSubType.setWidth("20%");
        contractorSubType.setItems(ContractorSubType.values());

        deliveryAddress = new TextField("Адрес доставки");
        deliveryAddress.setWidth("60%");
        deliveryAddress.setRequired(true);
        fizAddress.setValueChangeMode(ValueChangeMode.EAGER);

        final HorizontalLayout horizontalLayout5 = new HorizontalLayout( contractorSubType,deliveryAddress   );
        horizontalLayout5.setWidth("100%");
        horizontalLayout5 .setFlexGrow(1, contractorSubType, deliveryAddress   );
        content.add(horizontalLayout5);


        binder = new BeanValidationBinder<>(Contractor.class);
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
            if (currentContractor != null
                    && binder.writeBeanIfValid(currentContractor)) {
                viewLogic.saveContractor(currentContractor);
            }
        });
        save.addClickShortcut(Key.KEY_S, KeyModifier.CONTROL);

        discard = new Button("Сбросить");
        discard.setWidth("100%");
        discard.addClickListener(
                event -> viewLogic.editContractor(currentContractor));

        cancel = new Button("Отменить");
        cancel.setWidth("100%");
        cancel.addClickListener(event -> viewLogic.cancelContractor());
        cancel.addClickShortcut(Key.ESCAPE);
        getElement()
                .addEventListener("keydown", event -> viewLogic.cancelContractor())
                .setFilter("event.key == 'Escape'");

        delete = new Button("Удалить");
        delete.setWidth("100%");
        delete.addThemeVariants(ButtonVariant.LUMO_ERROR,
                ButtonVariant.LUMO_PRIMARY);
        delete.addClickListener(event -> {
            if (currentContractor != null) {
                viewLogic.deleteContractor(currentContractor);
            }
        });

        content.add(save, discard, delete, cancel);
    }

    //  public void setCategories(Collection<Category> categories) {
    //    category.setItems(categories);
    //  }

    public void editContractor(Contractor Contractor) {
        if (Contractor == null) {
            Contractor = new Contractor();
        }
        delete.setVisible(!Contractor.isNew());
        currentContractor = Contractor;
        binder.readBean(Contractor);
    }
}
