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
    ResultSet rs = null;

    // 수정 후 갱신된 데이터 저장
    String updatedName = null;
    String updatedAuthor = null;
    String updatedDate = null;

    try {
        // 데이터베이스 연결
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mariadb://walab.handong.edu:3306/OSS24_22300045", "OSS24_22300045", "ohL7beic");
        stmt = conn.createStatement();

        // UPDATE 실행
        String updateQuery = "UPDATE BOARD SET name = '" + bookName + "', author = '" + author + "', date = '" + publishDate + "' WHERE seq = " + seq;
        int rowsUpdated = stmt.executeUpdate(updateQuery);

        if (rowsUpdated > 0) {
            // 갱신된 데이터 조회
            String selectQuery = "SELECT name, author, date FROM BOARD WHERE seq = " + seq;
            rs = stmt.executeQuery(selectQuery);
            if (rs.next()) {
                updatedName = rs.getString("name");
                updatedAuthor = rs.getString("author");
                updatedDate = rs.getString("date");
            }
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

<div class="container">
    <%
        if (updatedName != null && updatedAuthor != null && updatedDate != null) {
    %>
    <h3>도서 정보가 성공적으로 수정되었습니다.</h3>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>도서명</th>
            <th>작가</th>
            <th>출판일</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td><%= updatedName %></td>
            <td><%= updatedAuthor %></td>
            <td><%= updatedDate %></td>
        </tr>
        </tbody>
    </table>
    <%
    } else {
    %>
    <h3>도서 정보를 수정하는 데 실패했습니다.</h3>
    <%
        }
    %>
    <a href="list.jsp" class="btn btn-primary">목록으로 돌아가기</a>
</div>

<%@ include file="./inc/bottom.jsp" %>
