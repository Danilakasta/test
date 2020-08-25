package com.roofapp.ui.views.accounts;

import com.roofapp.backend.dao.roofdb.entity.Account;
import com.roofapp.backend.service.AccountService;
import com.vaadin.flow.data.provider.ListDataProvider;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Collection;
import java.util.List;
import java.util.Locale;
import java.util.Objects;

/**
 * Utility class that encapsulates filtering and CRUD operations for
 * {@link Account} entities.
 * <p>

 */
public class AccountDataProvider extends ListDataProvider<Account> {

    /**
     * Text filter that can be changed separately.
     */
    private String filterText = "";
    private List<Account> Machines;


    private final AccountService service;

    @Autowired
    public AccountDataProvider(Collection<Account> items, AccountService service) {
        super(items);
        this.service = service;
    }


   /* public MachineDataProvider() {

        super(DataService.getAllMachines());
    }
*/

    /**
     * Store given Machine to the backing data service.
     *
     * @param item the updated or new Machine
     */
    public void save(Account item) {
        if (item.isNew()) {
            getItems().add(item);
            refreshAll();
        } else {
          // refreshItem(Machine);
            refreshAll();
        }
        service.save(null,item);
    }

    /**
     * Delete given Machine from the backing data service.
     *
     * @param item the Machine to be deleted
     */
    public void delete(Account item) {
     //   DataService.get().deleteMachine(Machine.getId());
        service.delete(null,item);
        getItems().remove(item);
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

        setFilter(item -> passesFilter(item.getValue(), this.filterText)
                        || passesFilter(item.getValue(), this.filterText)
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
