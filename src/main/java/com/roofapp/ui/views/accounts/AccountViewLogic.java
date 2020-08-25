package com.roofapp.ui.views.accounts;

import com.roofapp.backend.dao.roofdb.entity.Account;
import com.vaadin.flow.component.UI;

import java.io.Serializable;

/**
 * This class provides an interface for the logical operations between the CRUD
 * view, its parts like the Machine editor form and the data source, including
 * fetching and saving Machines.
 *
 * Having this separate from the view makes it easier to test various parts of
 * the system separately, and to e.g. provide alternative views for the same
 * data.
 */
public class AccountViewLogic implements Serializable {

    private final AccountView view;

    public AccountViewLogic(AccountView simpleCrudView) {
        view = simpleCrudView;
    }

    /**
     * Does the initialization of the inventory view including disabling the
     * buttons if the user doesn't have access.
     */
    public void init() {
     //   if (!AccessControlFactory.getInstance().createAccessControl()
        //       .isUserInRole(AccessControl.ADMIN_ROLE_NAME)) {
            view.setEnabled(true);
       // }


    }

    public void cancelMachine() {
        setFragmentParameter("");
        view.clearSelection();
    }

    /**
     * Updates the fragment without causing InventoryViewLogic navigator to
     * change view. It actually appends the MachineId as a parameter to the URL.
     * The parameter is set to keep the view state the same during e.g. a
     * refresh and to enable bookmarking of individual Machine selections.
     *
     */
    private void setFragmentParameter(String MachineId) {
        String fragmentParameter;
        if (MachineId == null || MachineId.isEmpty()) {
            fragmentParameter = "";
        } else {
            fragmentParameter = MachineId;
        }

        UI.getCurrent().navigate(AccountView.class, fragmentParameter);
    }

    /**
     * Opens the Machine form and clears its fields to make it ready for
     * entering a new Machine if MachineId is null, otherwise loads the Machine
     * with the given MachineId and shows its data in the form fields so the
     * user can edit them.
     *
     * 
     * @param MachineId
     */
    public void enter(String MachineId) {
        if (MachineId != null && !MachineId.isEmpty()) {
            if (MachineId.equals("new")) {
                newAccount();
            } else {
                // Ensure this is selected even if coming directly here from
                // login
                try {
                    final int pid = Integer.parseInt(MachineId);
                    final Account item = findMachine(pid);
                    view.selectRow(item);
                } catch (final NumberFormatException e) {
                }
            }
        } else {
            view.showForm(false);
        }
    }

    private Account findMachine(int MachineId) {
        return null;// DataService.get().getMachineById(MachineId);
    }

    public void saveMachine(Account account) {
        final boolean newMachine = account.isNew();
        view.clearSelection();
        view.update(account);
        setFragmentParameter("");
        view.showNotification(account.getValue()
                + (newMachine ? " добавлено" : " сохранено"));
    }

    public void deleteMachine(Account item) {
        view.clearSelection();
        view.remove(item);
        setFragmentParameter("");
        view.showNotification(item.getValue() + " удалено");
    }

    public void editMachine(Account item) {
        if (item == null) {
            setFragmentParameter("");
        } else {
            setFragmentParameter(item.getId() + "");
        }
        view.edit(item);
    }

    public void newAccount() {
        view.clearSelection();
        setFragmentParameter("new");
        view.edit(new Account());
    }

    public void rowSelected(Account item) {
      //  if (AccessControlFactory.getInstance().createAccessControl()
         //       .isUserInRole(AccessControl.ADMIN_ROLE_NAME)) {
            editMachine(item);
      //  }
    }
}
