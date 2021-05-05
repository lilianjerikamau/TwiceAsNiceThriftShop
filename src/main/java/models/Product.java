package models;

import java.util.Objects;

public class Product {
    private int id;
    private String product_name;
    private double price;


    public Product(int price,String product_name){

        this.product_name = product_name;
        this.price = price;

    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public double getPrice() {
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
        return getId() == product.getId() && Double.compare(product.getPrice(), getPrice()) == 0 && Objects.equals(getProduct_name(), product.getProduct_name());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getProduct_name(), getPrice());
    }


}
