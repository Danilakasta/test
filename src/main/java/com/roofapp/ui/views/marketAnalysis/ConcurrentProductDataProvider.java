package com.roofapp.ui.views.marketAnalysis;

import com.roofapp.backend.data.entity.Product;
import com.roofapp.backend.data.entity.parser.SiteProduct;
import com.roofapp.backend.service.SiteProductService;
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
public class ConcurrentProductDataProvider extends ListDataProvider<SiteProduct> {

    /**
     * Text filter that can be changed separately.
     */
    private String filterText = "";
    private List<Product> products;


    private final SiteProductService productService;

    @Autowired
    public ConcurrentProductDataProvider(Collection<SiteProduct> items, SiteProductService productService) {
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
    public void save(SiteProduct product) {
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
    public void delete(SiteProduct product) {
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

        setFilter(product -> passesFilter(product.getSiteName(), this.filterText)
                || passesFilter(product.getCategory().getTitle(), this.filterText)
                || passesFilter(product.getTitle(), this.filterText)
                || passesFilter(product.getFullPrice(), this.filterText)
        );
    }


    private boolean passesFilter(Object object, String filterText) {
        return object != null && object.toString().toLowerCase(Locale.ENGLISH)
                .contains(filterText);
    }
}
