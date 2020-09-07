package com.roofapp.ui.views.ProductAmount;

import com.roofapp.backend.dao.roofdb.entity.ProductAmount;
import com.roofapp.backend.service.ProductAmountService;
import com.vaadin.flow.data.provider.ListDataProvider;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Collection;
import java.util.List;
import java.util.Locale;
import java.util.Objects;

/**
 * Utility class that encapsulates filtering and CRUD operations for
 * {@link ProductAmount} entities.
 * <p>

 */
public class ProductAmountDataProvider extends ListDataProvider<ProductAmount> {

    /**
     * Text filter that can be changed separately.
     */
    private String filterText = "";
    private List<ProductAmount> products;


    private final ProductAmountService productService;

    @Autowired
    public ProductAmountDataProvider(Collection<ProductAmount> items, ProductAmountService productService) {
        super(items);
        this.productService = productService;
    }


   /* public ProductDataProvider() {

        super(DataService.getAllProducts());
    }
*/

    /**
     * Store given product to the backing data service.
     *
     * @param product the updated or new product
     */
    public void save(ProductAmount product) {
        if (product.isNew()) {
            getItems().add(product);
            refreshAll();
        } else {
          // refreshItem(product);
            refreshAll();
        }
        productService.save(product);
    }

    /**
     * Delete given product from the backing data service.
     *
     * @param product the product to be deleted
     */
    public void delete(ProductAmount product) {
     //   DataService.get().deleteProduct(product.getId());
        productService.delete(product);
        getItems().remove(product);
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

        setFilter(product -> passesFilter(product.getProduct().getName(), this.filterText)
                        || passesFilter(product.getProduct().getType(), this.filterText)
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
