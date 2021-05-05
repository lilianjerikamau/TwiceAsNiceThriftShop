package dao;

import models.Cart;
import models.Cart;
import org.sql2o.Connection;
import org.sql2o.Sql2o;
import org.sql2o.Sql2oException;

import java.util.List;

public class Sql2oCartDao  implements CartDao{
    private final Sql2o sql2o;

    public Sql2oCartDao(Sql2o sql2o){
        this.sql2o = sql2o; //making the sql2o object available everywhere so we can call methods in it
    }

    @Override
    public void add(Cart cart) {
        String sql = "INSERT INTO carts (product_name, user_id, image, price, product_id, quantity) VALUES (:product_name, :user_id, :image, :price, :product_id, :quantity)";
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
    public List<Cart> getAll() {
        try(Connection con = sql2o.open()){
            return con.createQuery("SELECT * FROM carts") //raw sql
                    .executeAndFetch(Cart.class); //fetch a list
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
    public void update(int id, int user_id, String image, String product_name, int price, int product_id) {
        String sql =  "UPDATE carts SET user_id = :user_id, product_name = :product_name, product_id = :product_id ,image = :image, price = :price ,quantity = :quantity WHERE id=:id";
        try(Connection con = sql2o.open()){
            con.createQuery(sql)
                    .addParameter("user_id", user_id)
                    .addParameter("product_id", product_id)
                    .addParameter("image", image)
                    .addParameter("price", price)
                    .addParameter("product_name", product_name)
                    .addParameter("id", id)
                    .executeUpdate();
        } catch (Sql2oException ex) {
            System.out.println(ex);
        }
    }



    @Override
    public void deleteById(int id) {
        String sql = "DELETE from carts WHERE id=:id";
        try (Connection con = sql2o.open()) {
            con.createQuery(sql)
                    .addParameter("id", id)
                    .executeUpdate();
        } catch (Sql2oException ex){
            System.out.println(ex);
        }
    }

    @Override
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
