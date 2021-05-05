package dao;

import models.Cart;
import models.Cart;
import models.Product;
import models.User;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.sql2o.Connection;
import org.sql2o.Sql2o;

import static org.junit.jupiter.api.Assertions.*;

class Sql2oCartDaoTest {
    private static Sql2oCartDao cartDao; //these variables are now static.
    private static Sql2oProductDao productDao;
    private static Connection conn; //these variables are now static.

    @BeforeAll //changed to @BeforeClass (run once before running any tests in this file)
    public static void setUp() throws Exception { //changed to static
        String connectionString = "jdbc:postgresql://localhost:5432/thriftshop_test"; // connect to postgres test database
        Sql2o sql2o = new Sql2o(connectionString, "sherry", "password"); // changed user and pass to null
        cartDao = new Sql2oCartDao(sql2o);
        productDao = new Sql2oProductDao(sql2o);
        conn = sql2o.open(); // open connection once before this test file is run
    }

    @AfterEach // run after every test
    public void tearDown() throws Exception { //I have changed
        System.out.println("clearing database");
        cartDao.clearAllCarts(); // clear all tasks after every test
    }

    @AfterAll // changed to @AfterClass (run once after all tests in this file completed)
    public static void shutDown() throws Exception { //changed to static and shutDown
        conn.close(); // close connection once after this entire test file is finished
        System.out.println("connection closed");
    }
    @Test
    public void addingCartSetsId() throws Exception {
        Cart category = setupNewCart();
        int originalCartId = category.getId();
        cartDao.add(category);
        assertNotEquals(originalCartId, category.getId());
    }
    @Test
    public void existingCartsCanBeFoundById() throws Exception {
        Cart cart = setupNewCart();
        cartDao.add(cart);
        Cart foundCart = cartDao.findById(cart.getId());
        assertEquals(cart, foundCart);
    }
    @Test
    public void existingCartsCanDeletedById() throws Exception {
        Cart cart = setupNewCart();
        cartDao.add(cart);
        Cart foundCart = cartDao.findById(cart.getId());
        assertEquals(cart, foundCart);
    }

@Test
    public void getAllProductsByCartReturnsProductsCorrectly() throws Exception {
        Cart category = setupNewCart();
        cartDao.add(category);
        int product_id = category.getProduct_id();
//        User newUser = category.getUser_id();
        Product newProduct= new Product(500 ,"shirt");
        Product otherProduct = new Product( 50,"short");
        Product thirdProduct = new Product( 43,"skirt");
        productDao.add(newProduct);
        productDao.add(otherProduct); //we are not adding task 3 so we can test things precisely.
        assertEquals(2, cartDao.getProductsByCartId(product_id).size());
        assertTrue(cartDao.getProductsByCartId(product_id).contains(newProduct));
        assertTrue(cartDao.getProductsByCartId(product_id).contains(otherProduct));
        assertFalse(cartDao.getProductsByCartId(product_id).contains(thirdProduct)); //things are accurate!
    }






    //define the following once and then call it as above in your tests.


    @Test
    public void userIdIsReturnedCorrectly() throws Exception {
        Cart Cart = setupNewCart();
        int originalCartId = Cart.getUser_id();
        cartDao.add(Cart);
        assertEquals(originalCartId, cartDao.findById(Cart.getId()).getUser_id());
    }

    //define the following once and then call it as above in your tests.

    public Cart setupNewCart(){
        return new Cart(5,10);
    }
    public User setupNewUser(){
        return new User("Kamau","sherry");
    }

}