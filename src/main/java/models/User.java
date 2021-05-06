package models;
import org.sql2o.*;

import java.util.Objects;


public class User {
    private String username;
    private int id;
  private  String password;
  private int product_id;

    public User(String username,String password ){
        this.username = username;
        this.password =password;


    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof User)) return false;
        User user = (User) o;
        return getId() == user.getId() && Objects.equals(getUsername(), user.getUsername()) && Objects.equals(getPassword(), user.getPassword());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getUsername(), getPassword());
    }

    public String getPassword() {
        return password;
    }

//this method logs in user into their profile,it can have product items specific to them
    public static User login(String name, String password) {
        try(Connection con = DB.sql2o.open()) {
            String sql = "SELECT * FROM users where name=:name and password=:password";
            User user = con.createQuery(sql)
                    .addParameter("name", name)
                    .addParameter("password", password)
                    .executeAndFetchFirst(User.class);
            return user;
        }
    }



}
