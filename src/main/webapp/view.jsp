<%@ page import="java.sql.*, java.io.*" %>
<%@ include file="./inc/top.jsp" %>
<%
    // seq 값 받아오기
    String seq = request.getParameter("seq");
    String bookName = "", author = "", publishDate = "";

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // MariaDB JDBC 드라이버 로딩
        Class.forName("org.mariadb.jdbc.Driver");

        // DB 연결
        conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/your_database", "your_username", "your_password");

        // SQL 쿼리 작성
        String query = "SELECT * FROM BOARD WHERE seq = " + seq;
        stmt = conn.createStatement();
        rs = stmt.executeQuery(query);

        if (rs.next()) {
            bookName = rs.getString("name");
            author = rs.getString("author");
            publishDate = rs.getString("date");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>View</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h2>도서 상세 정보</h2>
    <table class="table">
        <tr>
            <th>도서명</th>
            <td><%= bookName %></td>
        </tr>
        <tr>
            <th>작가</th>
            <td><%= author %></td>
        </tr>
        <tr>
            <th>출판년도</th>
            <td><%= publishDate %></td>
        </tr>
    </table>

    <!-- 삭제 버튼 -->
    <form action="delete_ok.jsp" method="POST" onsubmit="return confirm('정말 삭제하시겠습니까?');">
        <input type="hidden" name="seq" value="<%= seq %>" />
        <input type="submit" class="btn btn-danger" value="삭제">
    </form>

    <!-- 수정 버튼 -->
    <a href="edit.jsp?seq=<%= seq %>" class="btn btn-warning">수정</a>
</div>
</body>
<%@ include file="./inc/bottom.jsp" %>
</html>
