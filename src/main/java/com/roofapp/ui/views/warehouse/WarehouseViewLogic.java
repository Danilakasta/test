package com.roofapp.ui.views.warehouse;

import com.roofapp.backend.dao.roofdb.entity.WarehouseItem;
import com.roofapp.ui.views.products.ProductView;
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
public class WarehouseViewLogic implements Serializable {

    private final WarehouseView view;

    public WarehouseViewLogic(WarehouseView simpleCrudView) {
        view = simpleCrudView;
    }

    /**
     * Does the initialization of the inventory view including disabling the
     * buttons if the user doesn't have access.
     */
    public void init() {
     //   if (!AccessControlFactory.getInstance().createAccessControl()
        //       .isUserInRole(AccessControl.ADMIN_ROLE_NAME)) {
            view.setNewItemEnabled(true);
      //  }


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

        UI.getCurrent().navigate(WarehouseView.class, fragmentParameter);
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
                    final WarehouseItem item = findItem(pid);
                    view.selectRow(item);
                } catch (final NumberFormatException e) {
                }
            }
        } else {
            view.showForm(false);
        }
    }

    private WarehouseItem findItem(int id) {
        return null;// DataService.get().getProductById(productId);
    }

    public void saveItem(WarehouseItem item) {
        final boolean newItem = item.isNew();
        view.clearSelection();
        view.updateItem(item);
        setFragmentParameter("");
        view.showNotification(item.getProduct().getName()
                + (newItem ? " добавлено" : " сохранено"));
    }

    public void delete(WarehouseItem item) {
        view.clearSelection();
        view.removeItem(item);
        setFragmentParameter("");
        view.showNotification(item.getProduct().getName() + " удалено");
    }

    public void edit(WarehouseItem item) {
        if (item == null) {
            setFragmentParameter("");
        } else {
            setFragmentParameter(item.getId() + "");
        }
        view.editItem(item);
    }

    public void newItem() {
        view.clearSelection();
        setFragmentParameter("new");
        view.editItem(new WarehouseItem());
    }

    public void rowSelected(WarehouseItem item) {
       // if (AccessControlFactory.getInstance().createAccessControl()
        //        .isUserInRole(AccessControl.ADMIN_ROLE_NAME)) {
            edit(item);
     //   }
    }
}
