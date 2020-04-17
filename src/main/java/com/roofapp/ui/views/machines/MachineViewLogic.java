package com.roofapp.ui.views.machines;

//import com.roofapp.authentication.AccessControl;
//import com.roofapp.authentication.AccessControlFactory;
import com.roofapp.backend.data.entity.Machine;
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
public class MachineViewLogic implements Serializable {

    private final MachinesView view;

    public MachineViewLogic( MachinesView simpleCrudView) {
        view = simpleCrudView;
    }

    /**
     * Does the initialization of the inventory view including disabling the
     * buttons if the user doesn't have access.
     */
    public void init() {
     //   if (!AccessControlFactory.getInstance().createAccessControl()
        //       .isUserInRole(AccessControl.ADMIN_ROLE_NAME)) {
            view.setEnabled(false);
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

        UI.getCurrent().navigate(MachinesView.class, fragmentParameter);
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
                newMachine();
            } else {
                // Ensure this is selected even if coming directly here from
                // login
                try {
                    final int pid = Integer.parseInt(MachineId);
                    final Machine Machine = findMachine(pid);
                    view.selectRow(Machine);
                } catch (final NumberFormatException e) {
                }
            }
        } else {
            view.showForm(false);
        }
    }

    private Machine findMachine(int MachineId) {
        return null;// DataService.get().getMachineById(MachineId);
    }

    public void saveMachine(Machine Machine) {
        final boolean newMachine = Machine.isNew();
        view.clearSelection();
        view.update(Machine);
        setFragmentParameter("");
        view.showNotification(Machine.getName()
                + (newMachine ? " добавлено" : " сохранено"));
    }

    public void deleteMachine(Machine Machine) {
        view.clearSelection();
        view.remove(Machine);
        setFragmentParameter("");
        view.showNotification(Machine.getName() + " удалено");
    }

    public void editMachine(Machine Machine) {
        if (Machine == null) {
            setFragmentParameter("");
        } else {
            setFragmentParameter(Machine.getId() + "");
        }
        view.edit(Machine);
    }

    public void newMachine() {
        view.clearSelection();
        setFragmentParameter("new");
        view.edit(new Machine());
    }

    public void rowSelected(Machine Machine) {
      //  if (AccessControlFactory.getInstance().createAccessControl()
         //       .isUserInRole(AccessControl.ADMIN_ROLE_NAME)) {
            editMachine(Machine);
      //  }
    }
}
