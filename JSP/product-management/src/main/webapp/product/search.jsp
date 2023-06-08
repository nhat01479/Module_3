<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 6/8/2023
  Time: 6:54 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

</head>
<h3>Search product</h3>
<body class="container">
<form method="post" >
  <div class="m-3">
    <input type="text" name="search" id="search">
    <button type="submit" class="btn btn-primary">Search</button>
  </div>
</form>
<table class="table table-striped table-hover">
  <thead>
  <tr>
    <th>ID</th>
    <th>Name</th>
    <th>Price</th>
    <th>Description</th>
    <th>Manufacturer</th>
    <th>Action</th>
  </tr>
  </thead>
  <tbody>
  <c:forEach items="${requestScope.products}" var="product">
    <tr>
      <td>${product.getId()}</td>
      <td>${product.getName()}</td>
      <td>${product.getPrice()}</td>
      <td>${product.getDescription()}</td>
      <td>${product.getManufacturer()}</td>
      <td>
        <a href="/products?action=edit&id=${product.getId()}" class="btn btn-primary"><i class="fa-solid fa-pen"></i>Edit</a>
        <a href="/products?action=delete&id=${product.getId()}" class="btn btn-danger"><i class="fa-solid fa-trash-can"></i>Delete</a>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>
</body>
</html>
