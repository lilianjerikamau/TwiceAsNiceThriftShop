package dao;
import models.Cart;
import models.Product;
import models.User;

import java.util.List;

public interface CartDao {
    // LIST
    List<Product> getAll();

    // CREATE
    void add(Product product);
    void add(Cart cart);

    // READ
    Cart findById(int id);
    List<Product> getProductsByCartId(int product_id);

    // UPDATE

    // DELETE
    void deleteByProductId(int product_id);


}
