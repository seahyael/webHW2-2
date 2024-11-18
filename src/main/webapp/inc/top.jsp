<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
</head>
<body>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
    /* Remove the navbar's default rounded borders and increase the bottom margin */
    .navbar {
        margin-bottom: 50px;
        border-radius: 0;
    }

    /* Remove the jumbotron's default bottom margin */
    .jumbotron {
        margin-bottom: 0;
    }

    /* Add a gray background color and some padding to the footer */
    footer {
        background-color: #f2f2f2;
        padding: 25px;
    }

    .pink {
        background-color: #ebccd1;
        border-radius: 5px;
    }

    .green{
        background-color: #d6e9c6;
        border-radius: 5px;
    }

    .blue{
        background-color: #337ab7;
        border-radius: 5px;
    }
</style>

<div class="jumbotron">
    <div class="container text-center">
        <h1>도서 목록</h1>
        <p><span class="blue">View,</span><span class="green">Edit, </span><span class="pink">Add, </span>Delete</p>
    </div>
</div>

</body>