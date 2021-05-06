package models;
import org.sql2o.*;

public class Password {
    public static int UserVerifier(String name, String password) {
        try(Connection con = DB.sql2o.open()) {
            String sql = "SELECT COUNT(*) FROM users where name=:name and password=:password";
            int count = con.createQuery(sql)
                    .addParameter("name", name)
                    .addParameter("password", password)
                    .executeScalar(Integer.class);
            return count;
        }
    }
}
