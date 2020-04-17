package com.roofapp.ui.views.users;

import com.roofapp.backend.data.Role;
import com.roofapp.backend.data.entity.User;
import com.roofapp.backend.service.UserService;
import com.vaadin.flow.component.Key;
import com.vaadin.flow.component.KeyModifier;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.html.Div;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.component.select.Select;
import com.vaadin.flow.component.textfield.EmailField;
import com.vaadin.flow.component.textfield.PasswordField;
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.data.binder.BeanValidationBinder;
import com.vaadin.flow.data.binder.Binder;
import com.vaadin.flow.data.converter.StringToIntegerConverter;
import com.vaadin.flow.data.value.ValueChangeMode;
import org.springframework.beans.factory.annotation.Autowired;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Locale;

/**
 * A form for editing a single Material.
 */

public class UserForm extends Div {

    private final VerticalLayout content;

    UserService userService;

    private final EmailField email;
    private final TextField firstName;
    private final TextField lastName;
    private final Select<Role> role;
    private final PasswordField passwordHash;

    private Button save;
    private Button discard;
    private Button cancel;
    private final Button delete;

    private UserViewLogic viewLogic;

    public void setViewLogic(UserViewLogic viewLogic) {
        this.viewLogic = viewLogic;
    }

    private final Binder<User> binder;

    private User current;

    private static class PriceConverter extends StringToIntegerConverter {

        public PriceConverter() {
            super(0, "Cannot convert value to a number.");
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

    private static class IntConverter extends StringToIntegerConverter {

        public IntConverter() {
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
    public UserForm(UserViewLogic viewLogic, UserService userService) {
        this.userService = userService;
        setClassName("product-form ");

        content = new VerticalLayout();
        content.setSizeUndefined();
        content.addClassName("product-form-content");
        add(content);

        email = new EmailField("email");
        email.setWidth("100%");
        email.setValueChangeMode(ValueChangeMode.EAGER);
        content.add(email);

        firstName = new TextField("Фамилия");
        firstName.setWidth("100%");
        firstName.setValueChangeMode(ValueChangeMode.EAGER);
        content.add(firstName);

        lastName = new TextField("Имя");
        lastName.setWidth("100%");
        lastName.setValueChangeMode(ValueChangeMode.EAGER);
        content.add(lastName);


        final HorizontalLayout horizontalLayout = new HorizontalLayout(firstName,lastName);
        horizontalLayout.setWidth("100%");
        horizontalLayout.setFlexGrow(1, firstName,lastName);
        content.add(horizontalLayout);

        role = new Select<>();
        role.setLabel("Роль");
        role.setWidth("100%");
        role.setItems(Role.values());
        content.add(role);

        // content.add(materialColor);
        passwordHash = new PasswordField("Пароль");
        passwordHash.setWidth("100%");
        passwordHash.setValueChangeMode(ValueChangeMode.EAGER);
        content.add(passwordHash);

        final HorizontalLayout horizontalLayout2 = new HorizontalLayout(role, passwordHash);
        horizontalLayout2.setWidth("100%");
        horizontalLayout2.setFlexGrow(1, role, passwordHash);
        content.add(horizontalLayout2);



        binder = new BeanValidationBinder<>(User.class);
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
            if (current != null
                    && binder.writeBeanIfValid(current)) {
                viewLogic.save(current);
            }
        });
        save.addClickShortcut(Key.KEY_S, KeyModifier.CONTROL);

        discard = new Button("Сбросить");
        discard.setWidth("100%");
        discard.addClickListener(
                event -> viewLogic.edit(current));

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
            if (current != null) {
                viewLogic.delete(current);
            }
        });

        content.add(save, discard, delete, cancel);
    }

    //  public void setCategories(Collection<Category> categories) {
    //    category.setItems(categories);
    //  }

    public void edit(User item) {
        if (item == null) {
            item = new User();
        }
        delete.setVisible(!item.isNew());
        current = item;
        binder.readBean(item);
    }
}
