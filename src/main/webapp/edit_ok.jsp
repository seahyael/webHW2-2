<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="./inc/top.jsp" %>
<%
    String seq = request.getParameter("seq");
    String bookName = request.getParameter("bookName");
    String author = request.getParameter("author");
    String publishDate = request.getParameter("publishDate");

    Connection conn = null;
    Statement stmt = null;

    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/your_database", "your_username", "your_password");
        stmt = conn.createStatement();

        String query = "UPDATE BOARD SET name = '" + bookName + "', author = '" + author + "', date = '" + publishDate + "' WHERE seq = " + seq;
        int rowsUpdated = stmt.executeUpdate(query);

        if (rowsUpdated > 0) {
            System.out.println("<h3>도서 정보가 성공적으로 수정되었습니다.</h3>");
        } else {
            System.out.println("<h3>수정에 실패했습니다.</h3>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
<%@ include file="./inc/bottom.jsp" %>