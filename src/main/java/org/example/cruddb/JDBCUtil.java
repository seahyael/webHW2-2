package org.example.cruddb;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCUtil {
    private static Connection conn = null;
    public static Connection getConnection(){
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            if(conn == null){

                String url = "jdbc:mariadb://walab.handong.edu:3306/OSS24_22300045";
                String username = "OSS24_22300045";
                String password = "ohL7beic";
                conn = DriverManager.getConnection(url, username, password);
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return conn;
    }

    public static void closeConnection(){
       try {
           conn.close();
       } catch (SQLException e) {
           throw new RuntimeException(e);
       }
   }

}
