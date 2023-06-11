<%--
  Editd by IntelliJ IDEA.
  User: LENOVO
  Date: 6/10/2023
  Time: 9:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Product</title>
  <jsp:include page="/layout/head_css.jsp"></jsp:include>
</head>
<body>

<div class="container justify-center" style="align-items: center;">
  <div>
    <a href="products" class="btn btn-primary">Back</a>
  </div>
  <form method="post">
    <fieldset>
      <legend class="text-center"><h4>Product Information</h4></legend>
      <c:if test="${requestScope.errors != null}">
        <div class="alert alert-danger">
          <ul>
            <c:forEach items="${requestScope.errors}" var="error">
              <li>${error}</li>
            </c:forEach>
          </ul>
        </div>
      </c:if>

      <c:if test="${requestScope.message != null}">
        <div class="alert alert-success text-center">
          <span class="message">${requestScope.message}</span>
        </div>
      </c:if>

      <table class="table table-striped table-hover">
        <tr>
          <td>Name: </td>
          <td><input type="text" name="name" id="name" class="form-control" value="${requestScope.product.getName()}"></td>
        </tr>
        <tr>
          <td>Description: </td>
          <td><input type="text" name="description" id="description" class="form-control" value="${requestScope.product.getDescription()}"></td>
        </tr>
        <tr>
          <td>Price </td>
          <td><input type="text" name="price" id="price" class="form-control" value="${requestScope.product.getPrice()}"></td>
        </tr>
        <tr>
          <td>Category </td>
          <td>
            <select name="category" class="form-control">
              <c:forEach items="${requestScope.categoryList}" var="ct">
                <option
                        <c:if test="${ct.getId() == requestScope.product.getCategory().getId()}">selected</c:if>
                        value="${ct.getId()}">${ct.getName()}</option>
              </c:forEach>
            </select>
          </td>
        </tr>
        <tr>
          <td></td>
          <td><input type="submit" value="Edit Product" class="btn btn-primary"></td>
        </tr>
      </table>
    </fieldset>
  </form>
</div>

<jsp:include page="/layout/footer_js.jsp"></jsp:include>
</body>
</html>
