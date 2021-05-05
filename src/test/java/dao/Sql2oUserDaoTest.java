package dao;

import models.User;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.sql2o.Connection;
import org.sql2o.Sql2o;

import static org.junit.jupiter.api.Assertions.*;

class Sql2oUserDaoTest {
    private static Sql2oUserDao userDao; //these variables are now static.
    private static Connection conn; //these variables are now static.

    @BeforeAll //changed to @BeforeClass (run once before running any tests in this file)
    public static void setUp() throws Exception { //changed to static
        String connectionString = "jdbc:postgresql://localhost:5432/thriftshop_test"; // connect to postgres test database
        Sql2o sql2o = new Sql2o(connectionString, "sherry", "password"); // changed user and pass to null
        userDao = new Sql2oUserDao(sql2o);
        conn = sql2o.open(); // open connection once before this test file is run
    }

    @AfterEach // run after every test
    public void tearDown() throws Exception { //I have changed
        System.out.println("clearing database");
        userDao.clearAllUsers(); // clear all tasks after every test
    }

    @AfterAll // changed to @AfterClass (run once after all tests in this file completed)
    public static void shutDown() throws Exception { //changed to static and shutDown
        conn.close(); // close connection once after this entire test file is finished
        System.out.println("connection closed");
    }
    @Test
    public void addingUserSetsId() throws Exception {
        User User = setupNewUser();
        int originalUserId = User.getId();
        userDao.add(User);
        assertNotEquals(originalUserId, User.getId()); //how does this work?
    }

    @Test
    public void existingUserCanBeFoundById() throws Exception {
        User User = setupNewUser();
        userDao.add(User); //add to dao (takes care of saving)
        User foundTask = userDao.findById(User.getId()); //retrieve
        assertEquals(User, foundTask); //should be the same
    }
    @Test
    public void addedUsersAreReturnedFromgetAll() throws Exception {
        User User = setupNewUser();
        userDao.add(User);
        assertEquals(1, userDao.getAll().size());
    }

    @Test
    public void noUsersReturnsEmptyList() throws Exception {
        assertEquals(0, userDao.getAll().size());
    }




    //define the following once and then call it as above in your tests.


    @Test
    public void userIdIsReturnedCorrectly() throws Exception {
        User User = setupNewUser();
        int originalUserId = User.getProduct_id();
        userDao.add(User);
        assertEquals(originalUserId, userDao.findById(User.getId()).getProduct_id());
    }

    //define the following once and then call it as above in your tests.

    public User setupNewUser(){
        return new User("lilian","kamau");
    }

}