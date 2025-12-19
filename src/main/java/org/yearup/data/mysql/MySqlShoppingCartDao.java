package org.yearup.data.mysql;

import org.springframework.stereotype.Component;
import org.yearup.data.ShoppingCartDao;
import org.yearup.models.Product;
import org.yearup.models.ShoppingCart;
import org.yearup.models.ShoppingCartItem;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static java.sql.DriverManager.getConnection;

@Component
public class MySqlShoppingCartDao extends MySqlDaoBase implements ShoppingCartDao {
    public MySqlShoppingCartDao(DataSource dataSource) {
        super(dataSource);
    }

    @Override
    public ShoppingCart getByUserId(int userId) {
        ShoppingCart cart = new ShoppingCart();
        // Join with products table to get all product details (name, price, etc.)
        String sql = "SELECT * FROM shopping_cart " +
                "JOIN products ON shopping_cart.product_id = products.product_id " +
                "WHERE user_id = ?;";

        try (Connection connection = getConnection()) {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, userId);

            ResultSet row = statement.executeQuery();

            while (row.next()) {
                // Reusing the static mapRow from MySqlProductDao to build the Product object
                Product product = MySqlProductDao.mapRow(row);
                int quantity = row.getInt("quantity");

                ShoppingCartItem item = new ShoppingCartItem();
                item.setProduct(product);
                item.setQuantity(quantity);

                cart.add(item);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving shopping cart", e);
        }

        return cart;
    }

    @Override
    public ShoppingCart create(ShoppingCart shoppingCart) {


        return null;


    }

    @Override
    public void update(int productId, ShoppingCart shoppingCart) {

    }


    @Override
    public void delete(int productId) {
    }
}


