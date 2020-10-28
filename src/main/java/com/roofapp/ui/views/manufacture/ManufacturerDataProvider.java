package com.roofapp.ui.views.manufacture;

import com.roofapp.backend.dao.roofdb.entity.OrderItem;
import com.roofapp.backend.service.OrderItemsService;
import com.vaadin.flow.data.provider.ListDataProvider;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Collection;
import java.util.Locale;
import java.util.Objects;

/**
 * Utility class that encapsulates filtering and CRUD operations for
 * {@link OrderItem} entities.
 * <p>

 */
public class ManufacturerDataProvider extends ListDataProvider<OrderItem> {

    /**
     * Text filter that can be changed separately.
     */
    private String filterText = "";
   // private List<OrderItem> manufacturerss;


    private final OrderItemsService orderItemsService;

    @Autowired
    public ManufacturerDataProvider(Collection<OrderItem> items, OrderItemsService orderItemsService) {
        super(items);
        this.orderItemsService = orderItemsService;
    }


    /**
     * Store given Manufacturers to the backing data service.
     *
     * @param item the updated or new Manufacturers
     */
    public void save(OrderItem item) {
        if (item.isNew()) {
            getItems().add(item);
            refreshAll();
        } else {
          // refreshItem(Manufacturers);
            refreshAll();
        }
        orderItemsService.save(item);
    }

    /**
     * Delete given Manufacturers from the backing data service.
     *
     * @param item the Manufacturers to be deleted
     */
    public void delete(OrderItem item) {
     //   DataService.get().deleteManufacturers(Manufacturers.getId());
        orderItemsService.delete(item);
        getItems().remove(item);
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

        setFilter(Manufacturers -> passesFilter(Manufacturers.getId(), this.filterText)
                || passesFilter(Manufacturers.getProduct().getName(), this.filterText)
            /*    || passesFilter(Manufacturers.getOrder().getCustomer(), this.filterText)
                || passesFilter(Manufacturers.getOrder().getCreated(), this.filterText)
                || passesFilter(Manufacturers.getOrder().getDone(), this.filterText)
                || passesFilter(Manufacturers.getOrder().getId(), this.filterText)*/
                || passesFilter(Manufacturers.getHeight(), this.filterText)
                || passesFilter(Manufacturers.getQuantity(), this.filterText)
                || passesFilter(Manufacturers.getMaterialClass(), this.filterText)
                || passesFilter(Manufacturers.getMaterialColor(), this.filterText)
                || passesFilter(Manufacturers.getMaterialCover(), this.filterText)



        );
    }

    private boolean passesFilter(Object object, String filterText) {
        return object != null && object.toString().toLowerCase(Locale.ENGLISH)
                .contains(filterText);
    }
}
