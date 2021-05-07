package models;

import java.util.Arrays;
import java.util.Objects;

public class Cart {
    private int id;
    private int user_id;
   private int quantity;
   private  int product_id;



    public  Cart (int product_id,int quantity){

        this.user_id = user_id;
        this.product_id = product_id;



    }



    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Cart)) return false;
        Cart cart = (Cart) o;
        return getId() == cart.getId() && getUser_id() == cart.getUser_id() && getQuantity() == cart.getQuantity() && getProduct_id() == cart.getProduct_id();
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getUser_id(), getQuantity(), getProduct_id());
    }
}
