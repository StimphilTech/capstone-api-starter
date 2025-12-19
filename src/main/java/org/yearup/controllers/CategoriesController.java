package org.yearup.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import org.yearup.data.CategoryDao;
import org.yearup.data.ProductDao;
import org.yearup.models.Category;
import org.yearup.models.Product;

import java.util.List;


@RestController
@RequestMapping("categories")
@CrossOrigin
public class CategoriesController {
    private CategoryDao categoryDao;
    private ProductDao productDao;


    @Autowired
    public CategoriesController(CategoryDao categorydao, ProductDao productDao) {
        this.categoryDao = categorydao;
        this.productDao = productDao;
    }

    // add the appropriate annotation for a get action
    @GetMapping
    @PreAuthorize("permitAll()")
    public List<Category> getAll() {
        try {
            return categoryDao.getAllCategories();
        } catch (Exception ex) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Oops... our bad.");

        }
    }

    @GetMapping("{id}")
    @PreAuthorize("permitAll()")
    public Category getById(@PathVariable int id) {

            var category = categoryDao.getById(id);

            if (category == null) {
                throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Category not found");
            }
            // get the category by id
            return category;

        }


    @GetMapping("{categoryId}/products")
    @PreAuthorize("permitAll()")
    public List<Product> getProductsById(@PathVariable int categoryId) {
        try {
            // get a list of product by categoryId
            if (categoryDao.getById(categoryId) == null) {
                throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Category not found");
            }

            return productDao.listByCategoryId(categoryId); // Assuming ProductDao has this method
        } catch (Exception ex) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Oops... our bad.");
        }

    }

    // add annotation to call this method for a POST action
    // add annotation to ensure that only an ADMIN can call this function
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public Category addCategory(@RequestBody Category category) {
        try {
            // insert the category
            return categoryDao.create(category);
        } catch (Exception ex) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Oops... our bad.");
        }
    }

    @PutMapping("{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public void updateCategory(@PathVariable int id, @RequestBody Category category) {
        try
        {

        if (categoryDao.getById(id) == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Category not found");
        }

        categoryDao.update(id, category);
    }
        catch(Exception ex)

    {
        throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Oops... our bad.");
    }
}



    @DeleteMapping("{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public void deleteCategory(@PathVariable int id)
    {
        try
        {
            // Check if the category exists before deleting
            var category = categoryDao.getById(id);

            if(category == null)
                throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Category not found");


            categoryDao.delete(id);
        }
        catch (Exception ex)
        {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Oops... our bad.");
        }
    }

}


