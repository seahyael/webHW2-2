<%@ page import="java.sql.*, java.io.*" %>
<%@ include file="./inc/top.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    // seq 값을 받아오기
    String seq = request.getParameter("seq");
    if (seq == null || seq.isEmpty()) {
        System.out.println("<h3>잘못된 요청입니다. seq 값이 없습니다.</h3>");
        return;
    }

    // DB 연결 변수 선언
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // 도서 정보 변수 선언
    String bookName = "", author = "", publishDate = "";

    try {
        // MariaDB JDBC 드라이버 로딩
        Class.forName("org.mariadb.jdbc.Driver");

        // 데이터베이스 연결
        conn = DriverManager.getConnection("jdbc:mariadb://walab.handong.edu:3306/OSS24_22300045", "OSS24_22300045", "ohL7beic");
        // SQL 쿼리 준비 (PreparedStatement 사용)
        String query = "SELECT * FROM BOARD WHERE seq = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, seq); // seq 값을 안전하게 바인딩

        // 쿼리 실행
        rs = pstmt.executeQuery();

        if (rs.next()) {
            bookName = rs.getString("name");
            author = rs.getString("author");
            publishDate = rs.getString("date");
        } else {
            System.out.println("<h3>해당 도서를 찾을 수 없습니다.</h3>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        System.out.println("<h3>오류가 발생했습니다: " + e.getMessage() + "</h3>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<!-- HTML 내용 -->
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Edit</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <div class="jumbotron text-center">
        <h1>도서 수정</h1>
    </div>

    <form action="edit_ok.jsp" method="POST">
        <h2>도서명:
            <input type="text" class="form-control" name="bookName" value="<%= bookName %>" />
        </h2>
        <p>작가:
            <input type="text" class="form-control" name="author" value="<%= author %>" />
        </p>
        <p>출판년도:
            <input type="date" class="form-control" name="publishDate" value="<%= publishDate %>" />
        </p>

        <!-- seq 값도 hidden 필드로 전달 -->
        <input type="hidden" name="seq" value="<%= seq %>" />

        <input type="submit" class="btn btn-danger" value="수정">
    </form>
</div>
</body>
<%@ include file="./inc/bottom.jsp" %>
</html>

