package com.roofapp.ui.views.materials;

import com.roofapp.backend.data.entity.Material;
import com.roofapp.backend.service.MaterialService;
import com.vaadin.flow.data.provider.ListDataProvider;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Collection;
import java.util.List;
import java.util.Locale;
import java.util.Objects;

/**
 * Utility class that encapsulates filtering and CRUD operations for
 * {@link Material} entities.
 * <p>

 */
public class MaterialDataProvider extends ListDataProvider<Material> {

    /**
     * Text filter that can be changed separately.
     */
    private String filterText = "";
    private List<Material> materials;


    private final MaterialService MaterialService;

    @Autowired
    public MaterialDataProvider(Collection<Material> items, MaterialService MaterialService) {
        super(items);
        this.MaterialService = MaterialService;
    }


   /* public MaterialDataProvider() {

        super(DataService.getAllMaterials());
    }
*/

    /**
     * Store given Material to the backing data service.
     *
     * @param material the updated or new Material
     */
    public void save(Material material) {
        if (material.isNew()) {
            getItems().add(material);
            refreshAll();
        } else {
           //refreshItem(material);
            refreshAll();
        }
        MaterialService.save(material);
    }

    /**
     * Delete given Material from the backing data service.
     *
     * @param material the Material to be deleted
     */
    public void delete(Material material) {
     //   DataService.get().deleteMaterial(Material.getId());
        MaterialService.delete(material);
        getItems().remove(material);
        refreshAll();
    }

    /**
     * Sets the filter to use for this data provider and refreshes data.
     * <p>
     * Filter is compared for Material name, availability and category.
     *
     * @param filterText the text to filter by, never null
     */
    public void setFilter(String filterText) {
        Objects.requireNonNull(filterText, "Filter text cannot be null.");
        if (Objects.equals(this.filterText, filterText.trim())) {
            return;
        }
        this.filterText = filterText.trim().toLowerCase(Locale.ENGLISH);

        setFilter(Material -> passesFilter(Material.getName(), this.filterText)
                        || passesFilter(Material.getType(), this.filterText)
                //    || passesFilter(Material.getCategory(), this.filterText)
        );
    }

  /*  @Override
    public Integer getId(Material Material) {
        Objects.requireNonNull(Material,
                "Cannot provide an id for a null Material.");

        return Material.getId();
    }
*/
    private boolean passesFilter(Object object, String filterText) {
        return object != null && object.toString().toLowerCase(Locale.ENGLISH)
                .contains(filterText);
    }
}
