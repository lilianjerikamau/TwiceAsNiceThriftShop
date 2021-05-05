package dao;

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
        String sql = "INSERT INTO products (product_name, price) VALUES (:product_name, :price)"; //raw sql
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
            return con.createQuery("SELECT * FROM products") //raw sql
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
    public void update(int id, String product_name, double price) {
            String sql =  "UPDATE carts SET  product_name = :product_name, price = :price WHERE id=:id";
            try(Connection con = sql2o.open()){
                con.createQuery(sql)
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
    public void clearAllProducts() {
        String sql = "DELETE from products";
        try (Connection con = sql2o.open()) {
            con.createQuery(sql)
                    .executeUpdate();
        } catch (Sql2oException ex){
            System.out.println(ex);
        }
    }
}
