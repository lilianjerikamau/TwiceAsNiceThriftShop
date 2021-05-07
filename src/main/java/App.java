import static spark.Spark.*;

import dao.Sql2oCartDao;
import dao.Sql2oProductDao;
import dao.Sql2oUserDao;

import models.Cart;
import models.Product;
import models.User;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.sql2o.Sql2o;
import spark.ModelAndView;
import spark.template.handlebars.HandlebarsTemplateEngine;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class App {
    public static Sql2o sql2o;

    static {
        Logger logger = LoggerFactory.getLogger(App.class);

        try {
            URI dbUri;
            if (System.getenv("DATABASE_URL") == null) {
                dbUri = new URI("postgres://localhost:5432/thriftshop");
            } else {
                dbUri = new URI(System.getenv("DATABASE_URL"));
            }
            int port = dbUri.getPort();
            String host = dbUri.getHost();
            String path = dbUri.getPath();
            String username = (dbUri.getUserInfo() == null) ? DatabaseProps.username : dbUri.getUserInfo().split(":")[0];
            String password = (dbUri.getUserInfo() == null) ? DatabaseProps.password : dbUri.getUserInfo().split(":")[1];
            sql2o = new Sql2o("jdbc:postgresql://" + host + ":" + port + path, username, password);
        } catch (URISyntaxException e) {
            logger.error("Unable to connect to database.");
        }
    }
    static int getHerokuAssignedPort() {
        ProcessBuilder processBuilder = new ProcessBuilder();
        if (processBuilder.environment().get("PORT") != null) {
            return Integer.parseInt(processBuilder.environment().get("PORT"));
        }
        return 4567;
    }
    public static void main(String[] args) { //type “psvm + tab” to autocreate this
        port(getHerokuAssignedPort());
        staticFileLocation("/public");
        Sql2oUserDao userDao = new Sql2oUserDao(sql2o);
        Sql2oCartDao cartDao = new Sql2oCartDao(sql2o);
        Sql2oProductDao productDao = new Sql2oProductDao(sql2o);


        //Routes

        get("/", (request, response) -> {
            Map<String, Object> model = new HashMap<>();
            return new ModelAndView(model, "index.hbs");
        }, new HandlebarsTemplateEngine());

        get("/dahboard", (request, response) -> {
            Map<String, Object> model = new HashMap<>();
            return new ModelAndView(model, "index.hbs");
        }, new HandlebarsTemplateEngine());

        get("/product", (request, response) -> {
            Map<String, Object> model = new HashMap<>();
            return new ModelAndView(model, "product.hbs");
        }, new HandlebarsTemplateEngine());

        get("/sell", (request, response) -> {
            Map<String, Object> model = new HashMap<>();
            return new ModelAndView(model, "sellForm.hbs");
        }, new HandlebarsTemplateEngine());

        // process form for signup
        post("/login", (req, res) -> {
            Map<String, Object> model = new HashMap<>();
            String username = req.queryParams("name");
            String password = req.queryParams("password");
            List<User> user = userDao.getAll();
            model.put("user", user);
            User newUser = new User(username,password);
            userDao.add(newUser);
            return new ModelAndView(model, "index.hbs");
        }, new HandlebarsTemplateEngine());
        get("/products", (request, response) -> {
            Map<String, Object> model = new HashMap<>();
            List<Product> products = productDao.getAll();
            model.put("products", products);
            return new ModelAndView(model, "product.hbs");
        }, new HandlebarsTemplateEngine());

    }
}
