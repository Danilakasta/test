package com.roofapp.ui.views.machines;

//import com.roofapp.authentication.AccessControl;
//import com.roofapp.authentication.AccessControlFactory;
import com.roofapp.backend.dao.roofdb.entity.Machine;
import com.roofapp.backend.service.MachineService;
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
public class MachineViewLogic<T> implements Serializable {

    private final MachinesView view;
    private final MachineService machineService;

    public MachineViewLogic(MachinesView simpleCrudView, MachineService machineService) {
        view = simpleCrudView;
        this.machineService = machineService;
    }

    /**
     * Does the initialization of the inventory view including disabling the
     * buttons if the user doesn't have access.
     */
   // public void init() {
     //   if (!AccessControlFactory.getInstance().createAccessControl()
        //       .isUserInRole(AccessControl.ADMIN_ROLE_NAME)) {
         //   view.setEnabled(true);
       // }


  //  }

    public void cancel() {
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
    private void setFragmentParameter(String id) {
        String fragmentParameter;
        if (id == null || id.isEmpty()) {
            fragmentParameter = "";
        } else {
            fragmentParameter = id;
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
     * @param id
     */
    public void enter(String id) {
        if (id != null && !id.isEmpty()) {
            if (id.equals("new")) {
                newMachine();
            } else {
                // Ensure this is selected even if coming directly here from
                // login
                try {
                    final Long pid = Long.parseLong(id);
                    final Machine Machine = findMachine(pid);
                    view.selectRow(Machine);
                } catch (final NumberFormatException e) {
                }
            }
        } else {
            view.showForm(false);
        }
    }

    private Machine findMachine(Long id) {
        return machineService.findById(id);// DataService.get().getMachineById(MachineId);
    }

    public void saveMachine(Machine item) {
        final boolean newMachine = item.isNew();
        view.clearSelection();
        view.update(item);
        setFragmentParameter("");
        view.showNotification(item.toString()
                + (newMachine ? " добавлено" : " сохранено"));
    }

    public void deleteMachine(Machine Machine) {
        view.clearSelection();
        view.remove(Machine);
        setFragmentParameter("");
        view.showNotification(Machine.getName().toString() + " удалено");
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
