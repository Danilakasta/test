package com.roofapp.backend;

import java.io.Serializable;
import java.util.Collection;

import com.roofapp.backend.dao.roofdb.entity.Category;
import com.roofapp.backend.dao.roofdb.entity.Product;

/**
 * Back-end service interface for retrieving and updating product data.
 */
public abstract class DataService implements Serializable {

    public  abstract Collection<Product> getAllProducts() ;

    public abstract Collection<Category> getAllCategories();

    public abstract void updateProduct(Product p);

    public abstract void deleteProduct(int productId);

    public abstract Product getProductById(int productId);

    public abstract void updateCategory(Category category);

    public abstract void deleteCategory(int categoryId);

   // public static DataService get() {
   //     return MockDataService.getInstance();
   // }

}
