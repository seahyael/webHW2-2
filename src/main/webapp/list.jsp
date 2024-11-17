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
<div class="jumbotron">
    <div class="container text-center">
        <h1>도서 목록</h1>
        <p><span class="blue">View,</span> Edit, Add, Delete</p>
    </div>
</div>

<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">도서 목록</a>
        </div>
        <div id="myNavbar">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="./write.jsp"> Add</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- 검색 폼 추가 -->
<form action="list.jsp" method="get">
    <div class="container">
        <div class="row">
            <div class="col-sm-4">
                <input type="text" class="form-control" name="search" placeholder="도서명 검색" value="${param.search}" />
            </div>
            <div class="col-sm-4">
                <input type="submit" class="btn btn-primary" value="검색" />
            </div>
        </div>
    </div>
</form>

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
                        <div class="panel-body">
                            <img src="https://th.bing.com/th/id/R.873a12bffe6b335eb54e370ae6b1a2b5?rik=7faTR4WHBPPrig&riu=http%3a%2f%2fimage.yes24.com%2fGoods%2f8157957%2fXL&ehk=lrp5zMEmhv%2fbAtSxQc2FNbS5Yb3I1dNFqaFn3GjuHMU%3d&risl=&pid=ImgRaw&r=0" class="img-responsive" style="width:100%" alt="${board.name}">
                        </div>
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
