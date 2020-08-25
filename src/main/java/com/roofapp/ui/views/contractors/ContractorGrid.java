package com.roofapp.ui.views.contractors;

import com.roofapp.backend.dao.roofdb.entity.Contractor;
import com.roofapp.backend.dao.roofdb.entity.Product;
import com.roofapp.backend.service.AccountService;
import com.roofapp.ui.views.accounts.AccountDataProvider;
import com.roofapp.ui.views.accounts.AccountGrid;
import com.vaadin.flow.component.AttachEvent;
import com.vaadin.flow.component.UI;
import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.button.ButtonVariant;
import com.vaadin.flow.component.dialog.Dialog;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.component.icon.VaadinIcon;
import com.vaadin.flow.component.notification.Notification;
import com.vaadin.flow.data.renderer.TemplateRenderer;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Comparator;

/**
 * Grid of products, handling the visual presentation and filtering of a set of
 * items. This version uses an in-memory data source that is suitable for small
 * data sets.
 */
public class ContractorGrid extends Grid<Contractor> {


    @Autowired
    private final AccountService accountService;

    private Button newAccount;
    private AccountGrid grid;
  //  private final AccountViewLogic viewLogic = new AccountViewLogic(this);

    public ContractorGrid(AccountService accountService) {
        this.accountService = accountService;

        setSizeFull();

        Dialog dialog = new Dialog();
        dialog.setWidth("1200px");
        dialog.setHeight("600px");

        newAccount = new Button("Новый");
        newAccount.addThemeVariants(ButtonVariant.LUMO_PRIMARY);
        newAccount.setIcon(VaadinIcon.PLUS_CIRCLE.create());
    //    newAccount.addClickListener(click -> viewLogic.newAccount());
        grid = new AccountGrid();
        dialog.add(grid);
        addComponentColumn(contractor -> {
            Button button = new Button("");
            button.setIcon(VaadinIcon.CASH.create());
            button.addClickListener(event -> {
                AccountDataProvider dataProvider = new AccountDataProvider(this.accountService.findByContractor(contractor), this.accountService);
                grid.setDataProvider(dataProvider);
                dialog.open();
            });
            return button;
        });
        addColumn(Contractor::getName).setHeader("Название")
                .setWidth("300px")
                .setFlexGrow(20).setSortable(true);

        addColumn(Contractor::getName).setHeader("Название")
                .setWidth("300px")
                .setFlexGrow(20).setSortable(true).setKey("name");

        final String typeTemplate = "[[item.type]]";
        addColumn(TemplateRenderer.<Contractor>of(typeTemplate)
                .withProperty("type",
                        item -> item.getType().toString()))
                .setHeader("Тип материала")
                .setComparator(Comparator
                        .comparing(Contractor::getType))
                .setFlexGrow(5).setKey("type");

        addColumn(Contractor::getPhone).setHeader("Телефон")
                .setFlexGrow(5).setSortable(true).setKey("phone");


        addColumn(Contractor::getEmail).setHeader("Почта")
                .setWidth("200px")
                .setFlexGrow(5).setSortable(true).setKey("email");


        addColumn(Contractor::getUrAddress).setHeader("Юр. адрес")
                .setWidth("300px")
                .setFlexGrow(5).setSortable(true).setKey("urAddress");

        addColumn(Contractor::getFizAddress).setHeader("Физ. адрес")
                .setWidth("300px")
                .setFlexGrow(5).setSortable(true).setKey("fizAddress");

        addColumn(Contractor::getInn).setHeader("ИНН")
                .setFlexGrow(5).setSortable(true).setKey("inn");

        addColumn(Contractor::getKpp).setHeader("КПП")
                .setFlexGrow(5).setSortable(true).setKey("kpp");

        addColumn(Contractor::getOkpo).setHeader("ОКПО")
                .setFlexGrow(5).setSortable(true).setKey("okpo");

        addColumn(Contractor::getOgrn).setHeader("ОГРН")
                .setFlexGrow(5).setSortable(true).setKey("ogpn");


        UI.getCurrent().getPage().addBrowserWindowResizeListener(
                e -> setColumnVisibility(e.getWidth()));
    }

    private void setColumnVisibility(int width) {
        if (width > 800) {
            getColumnByKey("name").setVisible(true);

        }
    }

    @Override
    protected void onAttach(AttachEvent attachEvent) {
        super.onAttach(attachEvent);

        // fetch browser width
        UI.getCurrent().getInternals().setExtendedClientDetails(null);
        UI.getCurrent().getPage().retrieveExtendedClientDetails(e -> {
            setColumnVisibility(e.getBodyClientWidth());
        });
    }

    public Contractor getSelectedRow() {
        Notification.show("ок");
        return asSingleSelect().getValue();
    }

    public void refresh(Contractor contractor) {
        getDataCommunicator().refresh(contractor);
    }

    private String formatCategories(Product product) {
      /*  if (product.getCategory() == null || product.getCategory().isEmpty()) {
            return "";
        }
        return product.getCategory().stream()
                .sorted(Comparator.comparing(Category::getId))
                .map(Category::getName).collect(Collectors.joining(", "));*/
        return "";
    }
}
