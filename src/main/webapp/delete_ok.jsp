<%@ page import="java.sql.*, java.io.*" %>
<%@ include file="./inc/top.jsp" %>
<%
    String seq = request.getParameter("seq");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // MariaDB JDBC 드라이버 로딩
        Class.forName("org.mariadb.jdbc.Driver");

        // DB 연결
        conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/your_database", "your_username", "your_password");

        // SQL 쿼리 작성 (PreparedStatement 사용하여 SQL 인젝션 방지)
        String query = "DELETE FROM BOARD WHERE seq = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, seq); // seq 값을 안전하게 바인딩

        // 쿼리 실행
        int result = pstmt.executeUpdate();

        if (result > 0) {
            System.out.println("<h3>도서가 삭제되었습니다.</h3>");
        } else {
            System.out.println("<h3>해당 도서를 찾을 수 없습니다.</h3>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        System.out.println("<h3>오류가 발생했습니다: " + e.getMessage() + "</h3>");
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<!-- 삭제 후 목록 페이지로 리다이렉트 (예: list.jsp) -->
<script>
    setTimeout(function() {
        window.location.href = "list.jsp";  // 삭제 후 목록 페이지로 리다이렉트
    }, 1500); // 1.5초 후 리다이렉트
</script>
<%@ include file="./inc/bottom.jsp" %>