<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 6/10/2023
  Time: 9:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create Product</title>
  <jsp:include page="/layout/head_css.jsp"></jsp:include>
</head>
<body>

<div class="container justify-center" style="align-items: center;">
  <div>
    <a href="products" class="btn btn-primary">Back</a>
  </div>
  <form method="post">
    <fieldset>
      <legend class="text-center"><h4>Product Details</h4></legend>
      <table class="table table-striped table-hover">
        <tr>
          <td>ID</td>
          <td>${requestScope.product.getId()}</td>
        </tr>
        <tr>
          <td>Name: </td>
          <td>${requestScope.product.getName()}</td>
        </tr>
        <tr>
          <td>Description: </td>
          <td>${requestScope.product.getDescription()}</td>
        </tr>
        <tr>
          <td>Price </td>
          <td>${requestScope.product.getPrice()}</td>
        </tr>
        <tr>
          <td>Category </td>
          <td>${requestScope.product.getCategory().getName()}</td>
        </tr>
        <tr>
          <td>Create At</td>
          <td>${requestScope.product.getCreateAt()}</td>
        </tr>
      </table>
    </fieldset>
  </form>
</div>

<jsp:include page="/layout/footer_js.jsp"></jsp:include>
</body>
</html>
