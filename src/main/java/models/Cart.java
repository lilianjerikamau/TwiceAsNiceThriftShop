package models;

import java.util.Arrays;
import java.util.Objects;

public class Cart {
    private int id;
    private int user_id;
    private int product_id;
    private byte[] image;
    private String product_name;
    private int price;

    public  Cart (int user_id, int product_id, byte[]image, String product_name,int price){
        this.price = price;
        this.user_id = user_id;
        this.product_id = product_id;
        this.image =image;
        this.product_name = product_name;

    }

    public int getPrice() {
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

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Cart)) return false;
        Cart cart = (Cart) o;
        return getId() == cart.getId() && getUser_id() == cart.getUser_id() && getProduct_id() == cart.getProduct_id() && Arrays.equals(getImage(), cart.getImage()) && Objects.equals(getProduct_name(), cart.getProduct_name());
    }

    @Override
    public int hashCode() {
        int result = Objects.hash(getId(), getUser_id(), getProduct_id(), getProduct_name());
        result = 31 * result + Arrays.hashCode(getImage());
        return result;
    }
}
