package com.roofapp.ui.views.warehouse;

import com.roofapp.backend.dao.roofdb.entity.Product;
import com.roofapp.backend.dao.roofdb.entity.WarehouseItem;
import com.roofapp.backend.service.ProductService;
import com.roofapp.backend.service.WarehouseItemService;
import com.vaadin.flow.data.provider.ListDataProvider;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Collection;
import java.util.List;
import java.util.Locale;
import java.util.Objects;

/**
 * Utility class that encapsulates filtering and CRUD operations for
 * {@link Product} entities.
 * <p>

 */
public class WarehouseDataProvider extends ListDataProvider<WarehouseItem> {

    /**
     * Text filter that can be changed separately.
     */
    private String filterText = "";
    private List<WarehouseItem> items;


    private final WarehouseItemService warehouseItemService;

    @Autowired
    public WarehouseDataProvider(Collection<WarehouseItem> items, WarehouseItemService warehouseItemService) {
        super(items);
        this.warehouseItemService = warehouseItemService;
    }


   /* public ProductDataProvider() {

        super(DataService.getAllProducts());
    }
*/

    /**
     * Store given product to the backing data service.
     *
     * @param  item  the updated or new product
     */
    public void save(WarehouseItem item) {
        if (item.isNew()) {
            getItems().add(item);
            refreshAll();
        } else {
          // refreshItem(product);
            refreshAll();
        }
        warehouseItemService.save(item);
    }

    /**
     * Delete given product from the backing data service.
     *
     * @param item the product to be deleted
     */
    public void delete(WarehouseItem item) {
     //   DataService.get().deleteProduct(product.getId());
        warehouseItemService.delete(item);
        getItems().remove(item);
        refreshAll();
    }

    /**
     * Sets the filter to use for this data provider and refreshes data.
     * <p>
     * Filter is compared for product name, availability and category.
     *
     * @param filterText the text to filter by, never null
     */
    public void setFilter(String filterText) {
        Objects.requireNonNull(filterText, "Filter text cannot be null.");
        if (Objects.equals(this.filterText, filterText.trim())) {
            return;
        }
        this.filterText = filterText.trim().toLowerCase(Locale.ENGLISH);
        setFilter(item -> passesFilter(item.getProduct().getName(), this.filterText)
                ||passesFilter(item.getWarehouseType().getName(), this.filterText)
                ||passesFilter(item.getQuantity(), this.filterText)
                ||passesFilter(item.getComment(), this.filterText)
                ||passesFilter(item.getState().getDisplayName(), this.filterText)
                ||passesFilter(item.getMachine().getName(), this.filterText)
                ||passesFilter(item.getMaterial().toString(), this.filterText)
                ||passesFilter(item.getOrderItem().toString(), this.filterText)
                ||passesFilter(item, this.filterText)


        );
    }

  /*  @Override
    public Integer getId(Product product) {
        Objects.requireNonNull(product,
                "Cannot provide an id for a null product.");

        return product.getId();
    }
*/
    private boolean passesFilter(Object object, String filterText) {
        return object != null && object.toString().toLowerCase(Locale.ENGLISH)
                .contains(filterText);
    }
}
