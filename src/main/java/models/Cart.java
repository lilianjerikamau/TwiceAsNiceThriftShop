package models;

import java.util.Arrays;
import java.util.Objects;

public class Cart {
    private int id;
    private int user_id;
    private int product_id;
    private String image;
    private String product_name;
    private double price;
    private int quantity;

    public  Cart (int user_id, int product_id, String image, String product_name, int price,int quantity){
        this.price = price;
        this.user_id = user_id;
        this.product_id = product_id;
        this.image =image;
        this.product_name = product_name;

    }

    public double getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
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
        return getId() == cart.getId() && getUser_id() == cart.getUser_id() && getProduct_id() == cart.getProduct_id() && getPrice() == cart.getPrice() && getQuantity() == cart.getQuantity() && Objects.equals(getImage(), cart.getImage()) && Objects.equals(getProduct_name(), cart.getProduct_name());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getUser_id(), getProduct_id(), getImage(), getProduct_name(), getPrice(), getQuantity());
    }
}
