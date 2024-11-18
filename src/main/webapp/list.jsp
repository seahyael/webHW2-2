<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.example.cruddb.BoardDAO, org.example.cruddb.BoardVO" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="./inc/top.jsp" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <title>도서 목록</title>
</head>

<body>

<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">도서 목록</a>
        </div>
        <div id="myNavbar">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="./write.html"> Add</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row">
        <!-- 검색 폼 -->
        <form action="list.jsp" method="get" class="col-sm-8">
            <div class="input-group">
                <input type="text" class="form-control" name="search" placeholder="도서명 검색" value="${param.search}" />
                <span class="input-group-btn">
                    <input type="submit" class="btn btn-primary" value="검색" />
                </span>
            </div>
        </form>
        <!-- 도서 추가 버튼 -->
        <div class="col-sm-4 text-right">
            <form action="write.html" method="post">
                <input type="submit" class="btn btn-success" style="background-color: #ff69b4; color: white; border-color: #ff69b4;" value="도서 추가" />
            </form>
        </div>
    </div>
</div>



<%
    // BoardDAO 객체 생성 후 검색어가 있으면 검색한 도서 목록 조회
    String search = request.getParameter("search");
    BoardDAO boardDAO = new BoardDAO();
    List<BoardVO> boardList = (search == null || search.isEmpty()) ?
            boardDAO.getBoardList() :
            boardDAO.searchBoardList(search);  // 검색된 도서 목록 가져오기
    request.setAttribute("boardList", boardList);  // 목록을 request에 저장
%>

<div class="container">
    <div class="row">
        <c:forEach var="board" items="${boardList}">
            <div class="col-sm-4">
                <div class="panel panel-primary">
                    <div class="panel-heading">${board.name}</div>
                    <a href="view.jsp?seq=${board.seq}">
                        <div class="panel-footer">작가: ${board.author}, 출판년도: ${board.date}</div>
                    </a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<%@ include file="./inc/bottom.jsp" %>
</body>

</html>
