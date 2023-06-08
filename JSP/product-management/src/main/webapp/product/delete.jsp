<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 6/7/2023
  Time: 2:42 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Delete product</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

</head>
<body>
<form method="post">
    <fieldset class="container col-3">
        <legend>Product Information</legend>
        <table class="table">
            <tr>
                <td class="col-1">Name</td>
                <td><input type="text" name="name" id="name" value="${requestScope.product.getName()}"></td>
            </tr>
            <tr>
                <td>Price</td>
                <td><input type="text" name="price" id="price" value="${requestScope.product.getPrice()}"></td>
            </tr>
            <tr>
                <td>Description</td>
                <td><input type="text" name="description" id="description" value="${requestScope.product.getDescription()}"></td>
            </tr>
            <tr>
                <td>Manufacturer</td>
                <td><input type="text" name="manufacturer" id="manufacturer" value="${requestScope.product.getManufacturer()}"></td>
            </tr>
            <tr>
                <td><input type="submit" value="Delete product" class="btn btn-danger">Delete product</td>
                <td><a href="/products" class="btn btn-success">Back to Product List</a></td>
            </tr>
        </table>
    </fieldset>
</form>
</body>
</html>
