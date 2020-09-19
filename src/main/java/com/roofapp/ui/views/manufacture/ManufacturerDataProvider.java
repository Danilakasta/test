package com.roofapp.ui.views.manufacture;

import com.roofapp.backend.dao.roofdb.entity.Manufacturers;
import com.roofapp.backend.service.ManufacturerService;
import com.vaadin.flow.data.provider.ListDataProvider;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Collection;
import java.util.List;
import java.util.Locale;
import java.util.Objects;

/**
 * Utility class that encapsulates filtering and CRUD operations for
 * {@link Manufacturers} entities.
 * <p>

 */
public class ManufacturerDataProvider extends ListDataProvider<Manufacturers> {

    /**
     * Text filter that can be changed separately.
     */
    private String filterText = "";
    private List<Manufacturers> manufacturerss;


    private final ManufacturerService manufacturersService;

    @Autowired
    public ManufacturerDataProvider(Collection<Manufacturers> items, ManufacturerService manufacturersService) {
        super(items);
        this.manufacturersService = manufacturersService;
    }


    /**
     * Store given Manufacturers to the backing data service.
     *
     * @param Manufacturers the updated or new Manufacturers
     */
    public void save(Manufacturers Manufacturers) {
        if (Manufacturers.isNew()) {
            getItems().add(Manufacturers);
            refreshAll();
        } else {
          // refreshItem(Manufacturers);
            refreshAll();
        }
        manufacturersService.save(Manufacturers);
    }

    /**
     * Delete given Manufacturers from the backing data service.
     *
     * @param Manufacturers the Manufacturers to be deleted
     */
    public void delete(Manufacturers Manufacturers) {
     //   DataService.get().deleteManufacturers(Manufacturers.getId());
        manufacturersService.delete(Manufacturers);
        getItems().remove(Manufacturers);
        refreshAll();
    }

    /**
     * Sets the filter to use for this data provider and refreshes data.
     * <p>
     * Filter is compared for Manufacturers name, availability and category.
     *
     * @param filterText the text to filter by, never null
     */
    public void setFilter(String filterText) {
        Objects.requireNonNull(filterText, "Filter text cannot be null.");
        if (Objects.equals(this.filterText, filterText.trim())) {
            return;
        }
        this.filterText = filterText.trim().toLowerCase(Locale.ENGLISH);

        setFilter(Manufacturers -> passesFilter(Manufacturers.getName(), this.filterText)
                        || passesFilter(Manufacturers.getType(), this.filterText)
                //    || passesFilter(Manufacturers.getCategory(), this.filterText)
        );
    }

    private boolean passesFilter(Object object, String filterText) {
        return object != null && object.toString().toLowerCase(Locale.ENGLISH)
                .contains(filterText);
    }
}
