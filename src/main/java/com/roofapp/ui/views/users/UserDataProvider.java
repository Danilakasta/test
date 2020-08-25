package com.roofapp.ui.views.users;

import com.roofapp.backend.dao.roofdb.entity.User;
import com.roofapp.backend.service.UserService;
import com.vaadin.flow.data.provider.ListDataProvider;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Collection;
import java.util.List;
import java.util.Locale;
import java.util.Objects;

/**
 * Utility class that encapsulates filtering and CRUD operations for
 * {@link User} entities.
 * <p>

 */
public class UserDataProvider extends ListDataProvider<User> {

    /**
     * Text filter that can be changed separately.
     */
    private String filterText = "";
    private List<User> Users;


    private final UserService userService;

    @Autowired
    public UserDataProvider(Collection<User> items, UserService userService) {
        super(items);
        this.userService = userService;
    }


   /* public UserDataProvider() {

        super(DataService.getAllUsers());
    }
*/

    /**
     * Store given User to the backing data service.
     *
     * @param item the updated or new User
     */
    public void save(User item) {
        if (item.isNew()) {
            getItems().add(item);
            refreshAll();
        } else {
           //refreshItem(User);
            refreshAll();
        }
        userService.save(null,item);
    }

    /**
     * Delete given User from the backing data service.
     *
     * @param item the User to be deleted
     */
    public void delete(User item) {
     //   DataService.get().deleteUser(User.getId());
        userService.delete(null,item);
        getItems().remove(item);
        refreshAll();
    }

    /**
     * Sets the filter to use for this data provider and refreshes data.
     * <p>
     * Filter is compared for User name, availability and category.
     *
     * @param filterText the text to filter by, never null
     */
    public void setFilter(String filterText) {
        Objects.requireNonNull(filterText, "Filter text cannot be null.");
        if (Objects.equals(this.filterText, filterText.trim())) {
            return;
        }
        this.filterText = filterText.trim().toLowerCase(Locale.ENGLISH);

        setFilter(User -> passesFilter(User.getFirstName(), this.filterText)
                        || passesFilter(User.getFirstName(), this.filterText)
                //    || passesFilter(User.getCategory(), this.filterText)
        );
    }

  /*  @Override
    public Integer getId(User User) {
        Objects.requireNonNull(User,
                "Cannot provide an id for a null User.");

        return User.getId();
    }
*/
    private boolean passesFilter(Object object, String filterText) {
        return object != null && object.toString().toLowerCase(Locale.ENGLISH)
                .contains(filterText);
    }
}
