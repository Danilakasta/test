package com.roofapp.ui.views.products;

import java.io.Serializable;

import com.roofapp.authentication.AccessControl;
import com.roofapp.authentication.AccessControlFactory;
import com.roofapp.backend.data.entity.Product;
import com.vaadin.flow.component.UI;

/**
 * This class provides an interface for the logical operations between the CRUD
 * view, its parts like the product editor form and the data source, including
 * fetching and saving products.
 *
 * Having this separate from the view makes it easier to test various parts of
 * the system separately, and to e.g. provide alternative views for the same
 * data.
 */
public class ProductViewLogic implements Serializable {

    private final ProductView view;

    public ProductViewLogic(ProductView simpleCrudView) {
        view = simpleCrudView;
    }

    /**
     * Does the initialization of the inventory view including disabling the
     * buttons if the user doesn't have access.
     */
    public void init() {
        if (!AccessControlFactory.getInstance().createAccessControl()
               .isUserInRole(AccessControl.ADMIN_ROLE_NAME)) {
            view.setNewProductEnabled(false);
        }


    }

    public void cancelProduct() {
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

        UI.getCurrent().navigate(ProductView.class, fragmentParameter);
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
                newProduct();
            } else {
                // Ensure this is selected even if coming directly here from
                // login
                try {
                    final int pid = Integer.parseInt(productId);
                    final Product product = findProduct(pid);
                    view.selectRow(product);
                } catch (final NumberFormatException e) {
                }
            }
        } else {
            view.showForm(false);
        }
    }

    private Product findProduct(int productId) {
        return null;// DataService.get().getProductById(productId);
    }

    public void saveProduct(Product product) {
        final boolean newProduct = product.isNew();
        view.clearSelection();
        view.updateProduct(product);
        setFragmentParameter("");
        view.showNotification(product.getProductName()
                + (newProduct ? " добавлено" : " сохранено"));
    }

    public void deleteProduct(Product product) {
        view.clearSelection();
        view.removeProduct(product);
        setFragmentParameter("");
        view.showNotification(product.getProductName() + " удалено");
    }

    public void editProduct(Product product) {
        if (product == null) {
            setFragmentParameter("");
        } else {
            setFragmentParameter(product.getId() + "");
        }
        view.editProduct(product);
    }

    public void newProduct() {
        view.clearSelection();
        setFragmentParameter("new");
        view.editProduct(new Product());
    }

    public void rowSelected(Product product) {
        if (AccessControlFactory.getInstance().createAccessControl()
                .isUserInRole(AccessControl.ADMIN_ROLE_NAME)) {
            editProduct(product);
        }
    }
}
