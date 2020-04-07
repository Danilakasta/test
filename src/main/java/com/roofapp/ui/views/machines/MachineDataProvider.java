package com.roofapp.ui.views.machines;

import com.roofapp.backend.data.entity.Machine;
import com.roofapp.backend.data.entity.Machine;
import com.roofapp.backend.service.MachineService;
import com.roofapp.backend.service.MachineService;
import com.vaadin.flow.data.provider.ListDataProvider;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Collection;
import java.util.List;
import java.util.Locale;
import java.util.Objects;

/**
 * Utility class that encapsulates filtering and CRUD operations for
 * {@link Machine} entities.
 * <p>

 */
public class MachineDataProvider extends ListDataProvider<Machine> {

    /**
     * Text filter that can be changed separately.
     */
    private String filterText = "";
    private List<Machine> Machines;


    private final MachineService MachineService;

    @Autowired
    public MachineDataProvider(Collection<Machine> items, MachineService MachineService) {
        super(items);
        this.MachineService = MachineService;
    }


   /* public MachineDataProvider() {

        super(DataService.getAllMachines());
    }
*/

    /**
     * Store given Machine to the backing data service.
     *
     * @param Machine the updated or new Machine
     */
    public void save(Machine Machine) {
        if (Machine.isNew()) {
            getItems().add(Machine);
            refreshAll();
        } else {
          // refreshItem(Machine);
            refreshAll();
        }
        MachineService.save(Machine);
    }

    /**
     * Delete given Machine from the backing data service.
     *
     * @param Machine the Machine to be deleted
     */
    public void delete(Machine Machine) {
     //   DataService.get().deleteMachine(Machine.getId());
        MachineService.delete(Machine);
        getItems().remove(Machine);
        refreshAll();
    }

    /**
     * Sets the filter to use for this data provider and refreshes data.
     * <p>
     * Filter is compared for Machine name, availability and category.
     *
     * @param filterText the text to filter by, never null
     */
    public void setFilter(String filterText) {
        Objects.requireNonNull(filterText, "Filter text cannot be null.");
        if (Objects.equals(this.filterText, filterText.trim())) {
            return;
        }
        this.filterText = filterText.trim().toLowerCase(Locale.ENGLISH);

        setFilter(Machine -> passesFilter(Machine.getName(), this.filterText)
                        || passesFilter(Machine.getType(), this.filterText)
                //    || passesFilter(Machine.getCategory(), this.filterText)
        );
    }

  /*  @Override
    public Integer getId(Machine Machine) {
        Objects.requireNonNull(Machine,
                "Cannot provide an id for a null Machine.");

        return Machine.getId();
    }
*/
    private boolean passesFilter(Object object, String filterText) {
        return object != null && object.toString().toLowerCase(Locale.ENGLISH)
                .contains(filterText);
    }
}
