package models;
import org.sql2o.*;

public class Password {
    public static int UserVerifier(String username, String password) {
        try(Connection con = DB.sql2o.open()) {
            String sql = "SELECT COUNT(*) FROM users where username=:username and password=:password";
            int count = con.createQuery(sql)
                    .addParameter("username", username)
                    .addParameter("password", password)
                    .executeScalar(Integer.class);
            return count;
        }
    }
}
