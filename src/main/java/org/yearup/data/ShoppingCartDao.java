package org.yearup.data;

import org.yearup.models.Product;
import org.yearup.models.ShoppingCart;

public interface ShoppingCartDao
{
    ShoppingCart getByUserId(int userId);
    // add additional method signatures here
    ShoppingCart create(ShoppingCart shoppingCart);
    void update(int productId, ShoppingCart shoppingCart);
    void delete(int productId);
}
