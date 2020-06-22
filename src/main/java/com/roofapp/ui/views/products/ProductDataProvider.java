package com.roofapp.ui.views.products;

import java.util.Collection;
import java.util.List;
import java.util.Locale;
import java.util.Objects;

import com.roofapp.backend.service.ProductService;
import com.roofapp.backend.service.SiteProductService;
import com.vaadin.flow.data.provider.ListDataProvider;
import com.roofapp.backend.data.entity.Product;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Utility class that encapsulates filtering and CRUD operations for
 * {@link Product} entities.
 * <p>

 */
public class ProductDataProvider extends ListDataProvider<Product> {

    /**
     * Text filter that can be changed separately.
     */
    private String filterText = "";
    private List<Product> products;


    private final ProductService productService;

    @Autowired
    public ProductDataProvider(Collection<Product> items, ProductService productService) {
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
    public void save(Product product) {
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
    public void delete(Product product) {
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

        setFilter(product -> passesFilter(product.getName(), this.filterText)
                        || passesFilter(product.getType(), this.filterText)
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
