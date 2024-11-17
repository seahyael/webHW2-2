<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.example.cruddb.BoardDAO, org.example.cruddb.BoardVO" %>
<%@ include file="./inc/top.jsp" %>


<%
    String bname = request.getParameter("bname");
    String bauthor = request.getParameter("bauthor");
    String bdate = request.getParameter("bdate");

    // DB 연결
    String url = "jdbc:mariadb://localhost:3306/your_database";
    String username = "your_username";
    String password = "your_password";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);
        String insertSQL = "INSERT INTO BOARD (name, author, date) VALUES (?, ?, ?)";

        pstmt = conn.prepareStatement(insertSQL);
        pstmt.setString(1, bname);
        pstmt.setString(2, bauthor);
        pstmt.setString(3, bdate);

        int result = pstmt.executeUpdate();

        if (result > 0) {
            System.out.println("<h3>게시물이 추가되었습니다.</h3>");
        } else {
           System.out.println("<h3>게시물 추가 실패</h3>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
<%@ include file="./inc/bottom.jsp" %>