<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 6/11/2023
  Time: 10:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
  <jsp:include page="/layout/head_css.jsp"></jsp:include>

</head>
<body>
<div class="container justify-center" style="align-items: center;">
  <div>
    <a href="products" class="btn btn-primary">Back</a>
  </div>
  <form method="post">
    <fieldset>
      <legend class="text-center"><h4>User Details</h4></legend>
      <table class="table table-striped table-hover">
        <tr>
          <td>ID: </td>
          <td>${requestScope.user.getId()}</td>
        </tr>
        <tr>
          <td>FullName: </td>
          <td>${requestScope.user.getFullName()}</td>
        </tr>
        <tr>
          <td>Address: </td>
          <td>${requestScope.user.getAddress()}</td>
        </tr>
        <tr>
          <td>Date of birth: </td>
          <td>${requestScope.user.getDob()}</td>
        </tr>
        <tr>
          <td>Role: </td>
          <td>${requestScope.user.getRole()}</td>
        </tr>
      </table>
    </fieldset>
  </form>

  <jsp:include page="/layout/footer_js.jsp"></jsp:include>
</div>
</body>
</html>
