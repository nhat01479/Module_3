<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Simple Dictionary</title>
    <style>
        * {
            font-size: 14px;
        }
    </style>
</head>
<body>
<h1>Vietnames Dictionary</h1>
<form action="/translate" method="post">
    <input type="text" name="txtSearch" placeholder="Enter your word: ">
    <input type="submit" id="submit" value = "Search">
</form>
</body>
</html>