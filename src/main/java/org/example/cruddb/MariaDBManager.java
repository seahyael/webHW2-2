package org.example.cruddb;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.SQLException;

public class MariaDBManager {
    public static void main(String[] args) {
        String createTableSQL =
                "CREATE TABLE IF NOT EXISTS BOARD (" +
                        "seq INT AUTO_INCREMENT PRIMARY KEY," +
                        "name VARCHAR(255) NOT NULL," +
                        "author VARCHAR(255) NOT NULL," +
                        "date INT NOT NULL" +
                        ");";

        try (Connection conn = JDBCUtil.getConnection();
             Statement stmt = conn.createStatement()) {
            // SQL 쿼리 실행
            stmt.execute(createTableSQL);
            System.out.println("BOARD 테이블이 성공적으로 생성되었습니다.");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.closeConnection();
        }
    }
}
