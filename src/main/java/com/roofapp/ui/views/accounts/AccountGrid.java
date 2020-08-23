package com.roofapp.ui.views.accounts;

import com.roofapp.backend.data.entity.Account;
import com.vaadin.flow.component.AttachEvent;
import com.vaadin.flow.component.UI;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.component.notification.Notification;


/**
 * Grid of products, handling the visual presentation and filtering of a set of
 * items. This version uses an in-memory data source that is suitable for small
 * data sets.
 */
public class AccountGrid extends Grid<Account> {

    public AccountGrid() {

        setSizeFull();
      /*  addColumn(Account::getContractor).setHeader("Плптельщик")
                .setWidth("300px")
                .setFlexGrow(200).setSortable(true).setKey("");
*/
        addColumn(Account::getValue).setHeader("Cчет")
                .setWidth("200px")
                .setFlexGrow(20).setSortable(true).setKey("value");

        addColumn(Account::getCorrAccount).setHeader("Кор счет")
                .setWidth("200px")
                .setFlexGrow(20).setSortable(true).setKey("corrAccount");

        addColumn(Account::getBankName).setHeader("банк получателя")
                .setWidth("300px")
                .setFlexGrow(20).setSortable(true).setKey("bankName");

        addColumn(Account::getInn).setHeader("Инн банка получателя")
                .setFlexGrow(20).setSortable(true).setKey("inn");

        addColumn(Account::getBik).setHeader("Бик банка получателя")
                .setFlexGrow(20).setSortable(true).setKey("bik");

        addColumn(Account::getCode).setHeader("Код подразделения")
                .setFlexGrow(20).setSortable(true).setKey("code");

        addColumn(Account::getDepartAddress).setHeader("Адрес подразделения банка")
                .setFlexGrow(20).setSortable(true).setKey("departAddress");



        UI.getCurrent().getPage().addBrowserWindowResizeListener(
                e -> setColumnVisibility(e.getWidth()));
    }

    private void setColumnVisibility(int width) {

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

    public Account getSelectedRow() {
        Notification.show("ok");
        return asSingleSelect().getValue();
    }

    public void refresh(Account item) {
        getDataCommunicator().refresh(item);
    }

    private String formatCategories(Account item) {
      /*  if (product.getCategory() == null || product.getCategory().isEmpty()) {
            return "";
        }
        return product.getCategory().stream()
                .sorted(Comparator.comparing(Category::getId))
                .map(Category::getName).collect(Collectors.joining(", "));*/
        return "";
    }
}
