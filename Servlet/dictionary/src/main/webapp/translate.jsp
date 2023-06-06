<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 6/5/2023
  Time: 9:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>Dùng JSP</h1>
<form action="/translate" method="post">
    <input type="text" name="txtSearch" >
    <input type="submit" value="Translate" />
</form>
<h6>Result: ${value}</h6>
</body>
</html>
