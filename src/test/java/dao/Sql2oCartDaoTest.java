package dao;

import models.Cart;
import models.Cart;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.sql2o.Connection;
import org.sql2o.Sql2o;

import static org.junit.jupiter.api.Assertions.*;

class Sql2oCartDaoTest {
    private static Sql2oCartDao cartDao; //these variables are now static.
    private static Connection conn; //these variables are now static.

    @BeforeAll //changed to @BeforeClass (run once before running any tests in this file)
    public static void setUp() throws Exception { //changed to static
        String connectionString = "jdbc:postgresql://localhost:5432/thriftshop_test"; // connect to postgres test database
        Sql2o sql2o = new Sql2o(connectionString, "sherry", "password"); // changed user and pass to null
        cartDao = new Sql2oCartDao(sql2o);
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
        Cart Cart = setupNewCart();
        int originalCartId = Cart.getId();
        cartDao.add(Cart);
        assertNotEquals(originalCartId, Cart.getId()); //how does this work?
    }

    @Test
    public void existingCartCanBeFoundById() throws Exception {
        Cart Cart = setupNewCart();
        cartDao.add(Cart); //add to dao (takes care of saving)
        Cart foundTask = cartDao.findById(Cart.getId()); //retrieve
        assertEquals(Cart, foundTask); //should be the same
    }
    @Test
    public void addedCartsAreReturnedFromgetAll() throws Exception {
        Cart Cart = setupNewCart();
        cartDao.add(Cart);
        assertEquals(1, cartDao.getAll().size());
    }

    @Test
    public void noCartsReturnsEmptyList() throws Exception {
        assertEquals(0, cartDao.getAll().size());
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
        return new Cart(2,3,"image","shirt",600,5);
    }

}