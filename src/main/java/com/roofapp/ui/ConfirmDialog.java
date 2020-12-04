package com.roofapp.ui;

import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.dialog.Dialog;
import com.vaadin.flow.component.html.H3;
import com.vaadin.flow.component.html.Span;
import com.vaadin.flow.component.orderedlayout.HorizontalLayout;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.shared.Registration;

public class ConfirmDialog extends Dialog {

    private String caption;

    private  String text;

    private String confirmButtonText = "ок";

    private  Runnable confirmListener;

    public ConfirmDialog() {

        final VerticalLayout content = new VerticalLayout();
        content.setPadding(false);
        add(content);

        add(new H3(caption));
        add(new Span(text));

        final HorizontalLayout buttons = new HorizontalLayout();
        buttons.setPadding(false);
        add(buttons);

        final Button confirm = new Button(confirmButtonText, e -> {
            confirmListener.run();
            close();
        });
        confirm.addThemeVariants(ButtonVariant.LUMO_PRIMARY);
        buttons.add(confirm);

        final Button cancel = new Button("Отмена", e -> close());
        buttons.add(cancel);

    }

    public void setCaption(String caption) {
        this.caption = caption;
    }

    public void setText(String text) {
        this.text = text;
    }

    public void setConfirmButtonText(String confirmButtonText) {
        this.confirmButtonText = confirmButtonText;
    }

    public void addConfirmListener(Runnable confirmListener) {
        this.confirmListener = confirmListener;
    }

   /* public Registration addCancelListener(Object o) {
    }*/
}
