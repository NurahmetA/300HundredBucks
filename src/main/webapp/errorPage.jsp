<%--
  Created by IntelliJ IDEA.
  User: alemh
  Date: 27.09.2020
  Time: 20:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Error</title>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:700,900" rel="stylesheet">
    <link type="text/css" rel="stylesheet" href="style.css" />
</head>
<body>
<div id="notfound">
    <div class="notfound">
        <div class="notfound-404">
            <h1>OOPS!</h1>
            <h2><%=(String)request.getAttribute("error")%></h2>
        </div>
        <a href="index.jsp">Homepage</a>
    </div>
</div>
</body>
