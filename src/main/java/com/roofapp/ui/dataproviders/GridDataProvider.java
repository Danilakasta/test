package com.roofapp.ui.dataproviders;

import com.roofapp.backend.data.entity.AbstractEntity;
import com.roofapp.backend.data.entity.Machine;
import com.roofapp.backend.service.FilterableCrudService;
import com.vaadin.flow.data.provider.ListDataProvider;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Collection;
import java.util.Locale;
import java.util.Objects;

/**
 * Utility class that encapsulates filtering and CRUD operations for
 * {@link Machine} entities.
 * <p>
 */
public class GridDataProvider<T>  extends  ListDataProvider<AbstractEntity> {

    /**
     * Text filter that can be changed separately.
     */
    private String filterText = "";

    private  FilterableCrudService<AbstractEntity> filterableCrudService;

    @Autowired
    public GridDataProvider(FilterableCrudService<AbstractEntity> filterableCrudService) {
        super(filterableCrudService.findAll());
        this.filterableCrudService = filterableCrudService;
    }


    /**
     * Store given Machine to the backing data service.
     *
     * @param item the updated or new Machine
     */
    public void save(AbstractEntity item) {
        if (item.isNew()) {
            getItems().add(item);
            refreshAll();
        } else {
            refreshAll();
        }
        filterableCrudService.save(null,item);
    }

    /**
     * Delete given Machine from the backing data service.
     *
     * @param Machine the Machine to be deleted
     */
    public void delete(Machine Machine) {
        filterableCrudService.delete(null,Machine);
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

        setFilter(machine -> passesFilter(machine.getId(), this.filterText)
                //    || passesFilter(Machine.getCategory(), this.filterText)
        );
    }

    private boolean passesFilter(Object object, String filterText) {
        return object != null && object.toString().toLowerCase(Locale.ENGLISH)
                .contains(filterText);
    }
}
