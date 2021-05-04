package two.factor.auth;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.Sql2oUserDao;
import models.User;
import org.sql2o.Sql2o;
import spark.ModelAndView;
import spark.template.handlebars.HandlebarsTemplateEngine;
import static spark.Spark.*;
public class App {

    public static void main(String[] args) {

        staticFiles.location("/public");
        String connectionString = "jdbc:h2:~/thriftshop.db;INIT=RUNSCRIPT from 'classpath:db/create.sql'";
        Sql2o sql2o = new Sql2o(connectionString, "", "");
        Sql2oUserDao userDao = new Sql2oUserDao(sql2o);


        get("/", (request, response) -> {
            Map<String, Object> model = new HashMap<>();
            return new ModelAndView(model, "login.hbs");
        }, new HandlebarsTemplateEngine());
        post("/user/new", (req, res) -> { //URL to make new animal on POST route
            Map<String, Object> model = new HashMap<>();
            String name = req.queryParams("username");
            String password = req.queryParams("password");
            User newUser = new User( name, password);
            userDao.add(newUser);
            return new ModelAndView(model, "login.hbs");
        }, new HandlebarsTemplateEngine());
    }
}