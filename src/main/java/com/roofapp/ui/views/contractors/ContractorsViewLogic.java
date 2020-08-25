package com.roofapp.ui.views.contractors;

///import com.roofapp.authentication.AccessControl;
//import com.roofapp.authentication.AccessControlFactory;
import com.roofapp.backend.dao.roofdb.entity.Contractor;
import com.vaadin.flow.component.UI;

import java.io.Serializable;

/**
 * This class provides an interface for the logical operations between the CRUD
 * view, its parts like the Contractor editor form and the data source, including
 * fetching and saving Contractors.
 *
 * Having this separate from the view makes it easier to test various parts of
 * the system separately, and to e.g. provide alternative views for the same
 * data.
 */
public class ContractorsViewLogic implements Serializable {

    private final ContractorsView view;

    public ContractorsViewLogic(ContractorsView simpleCrudView) {
        view = simpleCrudView;
    }

    /**
     * Does the initialization of the inventory view including disabling the
     * buttons if the user doesn't have access.
     */
    public void init() {
    //    if (!AccessControlFactory.getInstance().createAccessControl()
     //          .isUserInRole(AccessControl.ADMIN_ROLE_NAME)) {
            view.setNewContractorEnabled(true);
     //   }


    }

    public void cancelContractor() {
        setFragmentParameter("");
        view.clearSelection();
    }

    /**
     * Updates the fragment without causing InventoryViewLogic navigator to
     * change view. It actually appends the ContractorId as a parameter to the URL.
     * The parameter is set to keep the view state the same during e.g. a
     * refresh and to enable bookmarking of individual Contractor selections.
     *
     */
    private void setFragmentParameter(String ContractorId) {
        String fragmentParameter;
        if (ContractorId == null || ContractorId.isEmpty()) {
            fragmentParameter = "";
        } else {
            fragmentParameter = ContractorId;
        }

        UI.getCurrent().navigate(ContractorsView.class, fragmentParameter);
    }

    /**
     * Opens the Contractor form and clears its fields to make it ready for
     * entering a new Contractor if ContractorId is null, otherwise loads the Contractor
     * with the given ContractorId and shows its data in the form fields so the
     * user can edit them.
     *
     * 
     * @param ContractorId
     */
    public void enter(String ContractorId) {
        if (ContractorId != null && !ContractorId.isEmpty()) {
            if (ContractorId.equals("new")) {
                newContractor();
            } else {
                // Ensure this is selected even if coming directly here from
                // login
                try {
                    final int pid = Integer.parseInt(ContractorId);
                    final Contractor contractor = findContractor(pid);
                    view.selectRow(contractor);
                } catch (final NumberFormatException e) {
                }
            }
        } else {
            view.showForm(false);
        }
    }

    private Contractor findContractor(int ContractorId) {
        return null;// DataService.get().getContractorById(ContractorId);
    }

    public void saveContractor(Contractor item) {
        final boolean newContractor = item.isNew();
        view.clearSelection();
        view.updateContractor(item);
        setFragmentParameter("");
        view.showNotification(item.getName()
                + (newContractor ? " добавлено" : " сохранено"));
    }

    public void deleteContractor(Contractor item) {
        view.clearSelection();
        view.removeContractor(item);
        setFragmentParameter("");
        view.showNotification(item.getName() + " удалено");
    }

    public void editContractor(Contractor Contractor) {
        if (Contractor == null) {
            setFragmentParameter("");
        } else {
            setFragmentParameter(Contractor.getId() + "");
        }
        view.editContractor(Contractor);
    }

    public void newContractor() {
        view.clearSelection();
        setFragmentParameter("new");
        view.editContractor(new Contractor());
    }

    public void rowSelected(Contractor item) {
      //  if (AccessControlFactory.getInstance().createAccessControl()
       //         .isUserInRole(AccessControl.ADMIN_ROLE_NAME)) {
            editContractor(item);
      //7  }
    }
}
