package dao;

import models.Cart;
import models.Cart;
import models.Product;
import org.sql2o.Connection;
import org.sql2o.Sql2o;
import org.sql2o.Sql2oException;

import java.util.List;

public class Sql2oCartDao  implements CartDao{
    private final Sql2o sql2o;

    public Sql2oCartDao(Sql2o sql2o){
        this.sql2o = sql2o; //making the sql2o object available everywhere so we can call methods in it
    }
//
    @Override
    public List<Product> getProductsByCartId(int product_id) {
        try (Connection con = sql2o.open()) {
            return con.createQuery("SELECT * FROM carts WHERE product_id = :product_id")
                    .addParameter("product_id", product_id)
                    .executeAndFetch(Product.class);
        }
    }
    @Override
    public void add(Product product) {
        String sql = "INSERT INTO carts (product_name,price) VALUES (:product_name, :price)";
        try(Connection con = sql2o.open()){ //try to open a connection
            int id = (int) con.createQuery(sql, true) //make a new variable
                    .bind(product)
                    .executeUpdate() //run it all
                    .getKey(); //int id is now the row number (row “key”) of db
            product.setId(id); //update object to set id now from database
        } catch (Sql2oException ex) {
            System.out.println(ex); //oops we have an error!
        }
    }
    @Override
    public void add(Cart cart) {
        String sql = "INSERT INTO carts (quantity, user_id, product_id) VALUES (:quantity, :user_id, :product_id)";
        try(Connection con = sql2o.open()){ //try to open a connection
            int id = (int) con.createQuery(sql, true) //make a new variable
                    .bind(cart)
                    .executeUpdate() //run it all
                    .getKey(); //int id is now the row number (row “key”) of db
            cart.setId(id); //update object to set id now from database
        } catch (Sql2oException ex) {
            System.out.println(ex); //oops we have an error!
        }
    }
    @Override
    public List<Product> getAll() {
        try(Connection con = sql2o.open()){
            return con.createQuery("SELECT * FROM carts") //raw sql
                    .executeAndFetch(Product.class); //fetch a list
        }
    }

    @Override
    public Cart findById(int id) {
        try(Connection con = sql2o.open()){
            return con.createQuery("SELECT * FROM carts WHERE id = :id")
                    .addParameter("id", id) //key/value pair, key must match above
                    .executeAndFetchFirst(Cart.class); //fetch an individual item
        }
    }


    @Override
    public void deleteByProductId(int product_id) {
        String sql = "DELETE from carts WHERE product_id=:product_id";
        try (Connection con = sql2o.open()) {
            con.createQuery(sql)
                    .addParameter("product_id", product_id)
                    .executeUpdate();
        } catch (Sql2oException ex){
            System.out.println(ex);
        }
    }
    public void clearAllCarts() {
        String sql = "DELETE from carts";
        try (Connection con = sql2o.open()) {
            con.createQuery(sql)
                    .executeUpdate();
        } catch (Sql2oException ex){
            System.out.println(ex);
        }
    }


}
