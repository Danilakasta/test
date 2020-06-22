package com.roofapp.ui.views.materials;


import com.roofapp.backend.data.entity.Material;
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
public class MateriaslViewLogic implements Serializable {

    private final MaterialsView view;

    public MateriaslViewLogic(MaterialsView simpleCrudView) {
        view = simpleCrudView;
    }

    /**
     * Does the initialization of the inventory view including disabling the
     * buttons if the user doesn't have access.
     */
    public void init() {
       // if (!AccessControlFactory.getInstance().createAccessControl()
           //    .isUserInRole(AccessControl.ADMIN_ROLE_NAME)) {
            view.setNewProductEnabled(true);
      ///  }


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
    private void setFragmentParameter(String productId) {
        String fragmentParameter;
        if (productId == null || productId.isEmpty()) {
            fragmentParameter = "";
        } else {
            fragmentParameter = productId;
        }

        UI.getCurrent().navigate(MaterialsView.class, fragmentParameter);
    }

    /**
     * Opens the product form and clears its fields to make it ready for
     * entering a new product if productId is null, otherwise loads the product
     * with the given productId and shows its data in the form fields so the
     * user can edit them.
     *
     *
     * @param productId
     */
    public void enter(String productId) {
        if (productId != null && !productId.isEmpty()) {
            if (productId.equals("new")) {
                newItem();
            } else {
                // Ensure this is selected even if coming directly here from
                // login
                try {
                    final int pid = Integer.parseInt(productId);
                    final Material item = find(pid);
                    view.selectRow(item);
                } catch (final NumberFormatException e) {
                }
            }
        } else {
            view.showForm(false);
        }
    }

    private Material find(int productId) {
        return null;// DataService.get().getProductById(productId);
    }

    public void save(Material item) {
        final boolean newProduct = item.isNew();
        view.clearSelection();
        view.updateProduct(item);
        setFragmentParameter("");
        view.showNotification(item.getSerialNumber()
                + (newProduct ? " добавлено" : " сохранено"));
    }

    public void delete(Material item) {
        view.clearSelection();
        view.removeProduct(item);
        setFragmentParameter("");
        view.showNotification(item.getSerialNumber() + " удалено");
    }

    public void edit(Material item) {
        if (item == null) {
            setFragmentParameter("");
        } else {
            setFragmentParameter(item.getId() + "");
        }
        view.editProduct(item);
    }

    public void newItem() {
        view.clearSelection();
        setFragmentParameter("new");
        view.editProduct(new Material());
    }

    public void rowSelected(Material item) {
      //  if (AccessControlFactory.getInstance().createAccessControl()
       //         .isUserInRole(AccessControl.ADMIN_ROLE_NAME)) {
            edit(item);
     //   }
    }
}
