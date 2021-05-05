package dao;
import models.Cart;
import models.User;

import java.util.List;

public interface CartDao {
    // LIST
    List<Cart> getAll();

    // CREATE
    void add(Cart cart);

    // READ
    Cart findById(int id);


    // UPDATE
    void update(int id, int user_id,String image,String product_name,double price,int product_id);

    // DELETE
    void deleteById(int id);
    void clearAllCarts();

}
