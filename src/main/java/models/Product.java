package models;

import java.util.Objects;

public class Product {
    private int id;
    private String image;
    private int user_id;
    private String product_name;
    private int price;

    public Product(int user_id,int price,String image,String product_name){
        this.image = image;
        this.product_name =product_name;
        this.price = price;
        this.user_id = user_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Product)) return false;
        Product product = (Product) o;
        return getId() == product.getId() && getUser_id() == product.getUser_id() && getPrice() == product.getPrice() && Objects.equals(getImage(), product.getImage()) && Objects.equals(getProduct_name(), product.getProduct_name());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getImage(), getUser_id(), getProduct_name(), getPrice());
    }
}
