package com.roofapp.ui.views.manufacture;

import com.roofapp.backend.dao.roofdb.entity.OrderItemManufacture;
import com.vaadin.flow.component.UI;

import java.io.Serializable;


/**
 * This class provides an interface for the logical operations between the CRUD
 * view, its parts like the product editor form and the data source, including
 * fetching and saving products.
 *
 * Having this separate from the view makes it easier to test various parts of
 * the system separately, and to e.g. provide alternative views for the same
 * data.
 */
public class ManufactureViewLogic implements Serializable {

    private final ManufactureView view;

    public ManufactureViewLogic( ManufactureView  simpleCrudView) {
        view = simpleCrudView;
    }

    /**
     * Does the initialization of the inventory view including disabling the
     * buttons if the user doesn't have access.
     */
    public void init() {
            view.setNewItemEnabled(true);

    }

    public void cancel() {
        setFragmentParameter("");
        view.clearSelection();
    }

    /**
     * Updates the fragment without causing InventoryViewLogic navigator to
     * change view. It actually appends the productId as a parameter to the URL.
     * The parameter is set to keep the view state the same during e.g. a
     * refresh and to enable bookmarking of individual product selections.
     *
     */
    private void setFragmentParameter(String id) {
        String fragmentParameter;
        if (id == null || id.isEmpty()) {
            fragmentParameter = "";
        } else {
            fragmentParameter = id;
        }

        UI.getCurrent().navigate(ManufactureView.class, fragmentParameter);
    }

    /**
     * Opens the product form and clears its fields to make it ready for
     * entering a new product if productId is null, otherwise loads the product
     * with the given productId and shows its data in the form fields so the
     * user can edit them.
     *
     * 
     * @param id
     */
    public void enter(String id) {
        if (id != null && !id.isEmpty()) {
            if (id.equals("new")) {
                newItem();
            } else {
                // Ensure this is selected even if coming directly here from
                // login
                try {
                    final int pid = Integer.parseInt(id);
                    final OrderItemManufacture item = findItem(pid);
                    view.selectRow(item);
                } catch (final NumberFormatException e) {
                }
            }
        } else {
            view.showForm(false);
        }
    }

    private OrderItemManufacture findItem(int id) {
        return null;// DataService.get().getProductById(productId);
    }

    public void saveItem(OrderItemManufacture item) {
        final boolean newItem = item.isNew();
        view.clearSelection();
        view.update(item);
        view.grid.refresh(item);
     //   view.remove(item);
        setFragmentParameter("");
     /*   view.showNotification(item.getProduct().getName()
                + (newItem ? " добавлено" : " сохранено"));*/
    }

    public void delete(OrderItemManufacture item) {
        view.clearSelection();
    //    view.remove(item);
        setFragmentParameter("");
     //   view.showNotification(item.OrderItem getName() + " удалено");
    }

    public void edit(OrderItemManufacture item) {
        if (item == null) {
            setFragmentParameter("");
        } else {
            setFragmentParameter(item.getId() + "");
        }
        view.edit(item);
    }

    public void newItem() {
        view.clearSelection();
        setFragmentParameter("new");
        view.edit(new OrderItemManufacture());
    }

    public void rowSelected(OrderItemManufacture item) {
       // if (AccessControlFactory.getInstance().createAccessControl()
        //        .isUserInRole(AccessControl.ADMIN_ROLE_NAME)) {
            edit(item);
     //   }
    }
}
