package com.roofapp.ui.views.accounts;


import com.roofapp.backend.dao.roofdb.entity.Account;
import com.roofapp.backend.dao.roofdb.entity.Contractor;
import com.roofapp.backend.service.AccountService;
import com.vaadin.flow.component.Key;
import com.vaadin.flow.component.KeyModifier;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.html.Div;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;
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
import com.roofapp.backend.service.ContractorService;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Locale;

/**
 * A form for editing a single Machine.
 */

public class AccountForm extends Div {

     private final VerticalLayout content;
  //  private final Dialog content;


    AccountService service;

    private final Select<Contractor> contractor;

    private final TextField value;

    private final TextField corrAccount;

    private final TextField bankName;

    private final IntegerField inn;

    private final IntegerField bik;


    private final IntegerField code;

    private final TextField departAddress;



    //   private final CheckboxGroup<Category> category;
    private Button save;
    private Button discard;
    private Button cancel;
    private final Button delete;

    private AccountViewLogic viewLogic;

    public void setViewLogic(AccountViewLogic viewLogic) {
        this.viewLogic = viewLogic;
    }

    private final Binder<Account> binder;
    private Account currentMachine;

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
    public AccountForm(AccountViewLogic viewLogic, AccountService service,ContractorService contractorService) {
        this.service = service;
        setClassName("product-form");

        content = new VerticalLayout();
        content.setSizeUndefined();
        content.addClassName("product-form-content");
        add(content);

      /*  content = new Dialog();;
        content.setWidth("1200px");
        content.setHeight("600px");
        add(content);
*/
        contractor = new Select<>();
        contractor.setLabel("Плательщик");
        contractor.setWidth("100%");
        contractor.setItemLabelGenerator(Contractor::toString);
        contractor.setItems(contractorService.findAll());
        content.add(contractor);

        //   viewLogic = sampleCrudLogic;
        bankName = new TextField("Банк получателя");
        bankName.setWidth("100%");
        bankName.setValueChangeMode(ValueChangeMode.EAGER);
        content.add(bankName);

        value = new TextField("Счет");
        value.setWidth("100%");
        value.setValueChangeMode(ValueChangeMode.EAGER);

        corrAccount = new TextField("Кор счет");
        corrAccount.setWidth("100%");
        corrAccount.setValueChangeMode(ValueChangeMode.EAGER);

        final HorizontalLayout horizontalLayout = new HorizontalLayout(value,corrAccount  );
        horizontalLayout .setWidth("100%");
        horizontalLayout .setFlexGrow(1,value,corrAccount );
        content.add(horizontalLayout );

        inn = new IntegerField("Инн");
        inn.setWidth("100%");
        inn.setValueChangeMode(ValueChangeMode.EAGER);

        bik = new IntegerField("Бик");
        bik.setWidth("100%");
        bik.setValueChangeMode(ValueChangeMode.EAGER);

        code = new IntegerField("Код подразделения");
        code.setWidth("100%");
        code.setValueChangeMode(ValueChangeMode.EAGER);

        final HorizontalLayout horizontalLayout2 = new HorizontalLayout( inn,bik,  code );
        horizontalLayout2 .setWidth("100%");
        horizontalLayout2 .setFlexGrow(1,inn, bik,  code  );
        content.add(horizontalLayout2 );

        departAddress = new TextField("Адрес подразделения банка");
        departAddress.setWidth("100%");
        departAddress.setValueChangeMode(ValueChangeMode.EAGER);
        content.add(departAddress);


        binder = new BeanValidationBinder<>(Account.class);

       /* binder.forField(value)
                .withConverter(new StringToLongConverter("Счет состоит из чисел"))
                .bind("value");
        binder.forField(corrAccount)
                .withConverter(new StringToLongConverter("Счет состоит из чиселёё Ё ЁяяяясссФЯМ"))
                .bind("corrAccount");
*/
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
            if (currentMachine != null
                    && binder.writeBeanIfValid(currentMachine)) {
                viewLogic.saveMachine(currentMachine);
            }
        });
        save.addClickShortcut(Key.KEY_S, KeyModifier.CONTROL);

        discard = new Button("Сбросить");
        discard.setWidth("100%");
        discard.addClickListener(
                event -> viewLogic.editMachine(currentMachine));

        cancel = new Button("Отменить");
        cancel.setWidth("100%");
        cancel.addClickListener(event -> viewLogic.cancelMachine());
        cancel.addClickShortcut(Key.ESCAPE);
        getElement()
                .addEventListener("keydown", event -> viewLogic.cancelMachine())
                .setFilter("event.key == 'Escape'");

        delete = new Button("Удалить");
        delete.setWidth("100%");
        delete.addThemeVariants(ButtonVariant.LUMO_ERROR,
                ButtonVariant.LUMO_PRIMARY);
        delete.addClickListener(event -> {
            if (currentMachine != null) {
                viewLogic.deleteMachine(currentMachine);
            }
        });

        content.add(save, discard, delete, cancel);
    }

    //  public void setCategories(Collection<Category> categories) {
    //    category.setItems(categories);
    //  }

    public void editMachine(Account account) {
        if (account == null) {
            account = new Account();
        }
        delete.setVisible(!account.isNew());
        currentMachine = account;
        binder.readBean(account);
    }

}
