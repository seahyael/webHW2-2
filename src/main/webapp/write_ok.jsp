<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.example.cruddb.BoardDAO, org.example.cruddb.BoardVO" %>
<%@ include file="./inc/top.jsp" %>

<%
    String bname = request.getParameter("bname");
    String bauthor = request.getParameter("bauthor");
    String bdate = request.getParameter("bdate");

    BoardDAO boardDAO = new BoardDAO();
    BoardVO boardVO = new BoardVO();
    boardVO.setName(bname);
    boardVO.setAuthor(bauthor);

    String[] dateParts = bdate.split("-");
    int dateAsInt = Integer.parseInt(dateParts[0] + dateParts[1] + dateParts[2]);
    boardVO.setDate(dateAsInt);

    int newSeq = boardDAO.insertBoard(boardVO);
    BoardVO insertedBoard = (newSeq > 0) ? boardDAO.getBoard(newSeq) : null;
%>

<div class="container">
    <h3 class="text-center">추가 결과</h3>
    <%
        if (insertedBoard != null) {
    %>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>제목</th>
            <th>작가</th>
            <th>출판년도</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td><%= insertedBoard.getName() %></td>
            <td><%= insertedBoard.getAuthor() %></td>
            <td><%= insertedBoard.getDate() %></td>
        </tr>
        </tbody>
    </table>
    <%
    } else {
    %>
    <p>추가된 게시물을 가져오는 데 실패했습니다.</p>
    <%
        }
    %>
    <a href="list.jsp" class="btn btn-primary">목록으로 돌아가기</a>
</div>

<%@ include file="./inc/bottom.jsp" %>
