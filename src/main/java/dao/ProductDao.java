package dao;

import models.Product;


import java.util.List;

public interface ProductDao {
    // LIST
    List<Product> getAll();

    // CREATE
    void add(Product product);
    //FIND BY ID
    Product findById(int id);


    // UPDATE
    void update(int id, String product_name,Byte[] image,double price,int user_id,int product_id);

    // DELETE
    void deleteById(int id);
    void clearAllProducts();

}
