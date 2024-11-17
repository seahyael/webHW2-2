package org.example.cruddb;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class MariaDBManager {
    public static void main(String[] args) {
        String url = "jdbc:mariadb://localhost:3306/your_database";
        String username = "your_username";
        String password = "your_password";

        String createTableSQL =
            "CREATE TABLE BOARD (" +
                "seq INT AUTO_INCREMENT PRIMARY KEY," +
                "name VARCHAR(255) NOT NULL," +
                "author VARCHAR(255) NOT NULL," +
                "date INT NOT NULL" +
            ");";

        try (Connection conn = DriverManager.getConnection(url, username, password);
             Statement stmt = conn.createStatement()) {

            stmt.execute(createTableSQL);
            System.out.println("BOARD 테이블이 성공적으로 생성되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}


