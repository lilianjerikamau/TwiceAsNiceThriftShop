package dao;

import models.Product;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.sql2o.Connection;
import org.sql2o.Sql2o;

import static org.junit.jupiter.api.Assertions.*;

class Sql2oProductDaoTest {
    private static Sql2oProductDao productDao; //these variables are now static.
    private static Connection conn; //these variables are now static.

    @BeforeAll //changed to @BeforeClass (run once before running any tests in this file)
    public static void setUp() throws Exception { //changed to static
        String connectionString = "jdbc:postgresql://localhost:5432/thriftshop_test"; // connect to postgres test database
        Sql2o sql2o = new Sql2o(connectionString, "sherry", "password"); // changed user and pass to null
        productDao = new Sql2oProductDao(sql2o);
        conn = sql2o.open(); // open connection once before this test file is run
    }

    @AfterEach // run after every test
    public void tearDown() throws Exception { //I have changed
        System.out.println("clearing database");
        productDao.clearAllProducts(); // clear all tasks after every test
    }

    @AfterAll // changed to @AfterClass (run once after all tests in this file completed)
    public static void shutDown() throws Exception { //changed to static and shutDown
        conn.close(); // close connection once after this entire test file is finished
        System.out.println("connection closed");
    }
    @Test
    public void addingProductSetsId() throws Exception {
        Product Product = setupNewProduct();
        int originalProductId = Product.getId();
        productDao.add(Product);
        assertNotEquals(originalProductId, Product.getId()); //how does this work?
    }

    @Test
    public void existingProductCanBeFoundById() throws Exception {
        Product Product = setupNewProduct();
        productDao.add(Product); //add to dao (takes care of saving)
        Product foundTask = productDao.findById(Product.getId()); //retrieve
        assertEquals(Product, foundTask); //should be the same
    }
    @Test
    public void addedProductsAreReturnedFromgetAll() throws Exception {
        Product Product = setupNewProduct();
        productDao.add(Product);
        assertEquals(1, productDao.getAll().size());
    }

    @Test
    public void noProductsReturnsEmptyList() throws Exception {
        assertEquals(0, productDao.getAll().size());
    }




    //define the following once and then call it as above in your tests.


    @Test
    public void userIdIsReturnedCorrectly() throws Exception {
        Product Product = setupNewProduct();
        int originalProductId = Product.getUser_id();
        productDao.add(Product);
        assertEquals(originalProductId, productDao.findById(Product.getId()).getUser_id());
    }

    //define the following once and then call it as above in your tests.

    public Product setupNewProduct(){
        return new Product(1,20,"image","shirt");
    }


}