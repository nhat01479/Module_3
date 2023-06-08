<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 6/7/2023
  Time: 2:25 PM
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

<body class="container">
<div  class="d-flex justify-content-between align-self-center">
        <div>
            <a href="products?action=create" class="btn btn-success m-3"><i class="fa-solid fa-plus"></i> Create Product</a>
        </div>
        <div class="m-3" style="height: 30px">
            <form action="/products?action=search" method="post" >
                <div class="container-search mt-1 d-flex">
                    <input type="text" name="search" id="search" width="270px">
                    <button type="submit" class="btn btn-primary" margin-left="-65px">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </form>
        </div>
</div>

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
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>

</html>
