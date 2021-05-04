package dao;

import models.User;

import java.util.List;
import com.google.common.collect.*;
import java.util.*;
import java.util.stream.*;


public interface UserDao {




    // LIST
    List<User> getAll();

    // CREATE
    void add(User user);

    // READ
    User findById(int id);


    // UPDATE
    void update(int id, String username,String password);

    // DELETE
    void deleteById(int id);
    void clearAllUsers();






}
