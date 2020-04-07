package com.roofapp.ui.views.contractors;

import com.roofapp.backend.data.entity.Contractor;
import com.roofapp.backend.data.entity.Product;
import com.roofapp.backend.service.ContractorService;
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
public class ContractorDataProvider extends ListDataProvider<Contractor> {

    /**
     * Text filter that can be changed separately.
     */
    private String filterText = "";
    private List<Contractor> contractors;


    private final ContractorService contractorService;

    @Autowired
    public ContractorDataProvider(Collection<Contractor> items, ContractorService contractorService) {
        super(items);
        this.contractorService = contractorService;
    }


   /* public ProductDataProvider() {

        super(DataService.getAllProducts());
    }
*/

    /**
     * Store given product to the backing data service.
     *
     * @param item the updated or new product
     */
    public void save(Contractor item) {
        if (item.isNew()) {
            getItems().add(item);
            refreshAll();
        } else {
          // refreshItem(product);
            refreshAll();
        }
        contractorService.save(item);
    }

    /**
     * Delete given product from the backing data service.
     *
     * @param item the product to be deleted
     */
    public void delete(Contractor item) {
     //   DataService.get().deleteProduct(product.getId());
        contractorService.delete(item);
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

        setFilter(contractor -> passesFilter(contractor.getName(), this.filterText)
                        || passesFilter(contractor.getType(), this.filterText)
                //    || passesFilter(product.getCategory(), this.filterText)
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
