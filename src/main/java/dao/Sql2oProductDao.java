package dao;

import models.Product;
import models.Product;
import org.sql2o.Connection;
import org.sql2o.Sql2o;
import org.sql2o.Sql2oException;

import java.util.List;

public class Sql2oProductDao  implements ProductDao{
    private final Sql2o sql2o;

    public Sql2oProductDao(Sql2o sql2o){
        this.sql2o = sql2o; //making the sql2o object available everywhere so we can call methods in it
    }

    @Override
    public void add(Product product) {
        String sql = "INSERT INTO products (product_name, user_id, image, price) VALUES (:product_name, :user_id, :image, :price)"; //raw sql
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
    public List<Product> getAll() {
        try(Connection con = sql2o.open()){
            return con.createQuery("SELECT * FROM users") //raw sql
                    .executeAndFetch(Product.class); //fetch a list
        }
    }

    @Override
    public Product findById(int id) {
        try(Connection con = sql2o.open()){
            return con.createQuery("SELECT * FROM products WHERE id = :id")
                    .addParameter("id", id) //key/value pair, key must match above
                    .executeAndFetchFirst(Product.class); //fetch an individual item
        }
    }

    @Override
    public void update(int id, String product_name, Byte[] image, int price, int user_id,int product_id) {
            String sql =  "UPDATE carts SET user_id = :user_id, product_name = :product_name, product_id = :product_id,image = :image, price = :price WHERE id=:id";
            try(Connection con = sql2o.open()){
                con.createQuery(sql)
                        .addParameter("user_id", user_id)
                        .addParameter("image", image)
                        .addParameter("price", price)
                        .addParameter("product_name", product_name)
                        .addParameter("product_id", product_id)
                        .addParameter("id", id)
                        .executeUpdate();
            } catch (Sql2oException ex) {
                System.out.println(ex);
            }

    }

    @Override
    public void deleteById(int id) {
        String sql = "DELETE from products WHERE id=:id";
        try (Connection con = sql2o.open()) {
            con.createQuery(sql)
                    .addParameter("id", id)
                    .executeUpdate();
        } catch (Sql2oException ex){
            System.out.println(ex);
        }
    }

    @Override
    public void clearAllUsers() {
        String sql = "DELETE from products";
        try (Connection con = sql2o.open()) {
            con.createQuery(sql)
                    .executeUpdate();
        } catch (Sql2oException ex){
            System.out.println(ex);
        }
    }
}
