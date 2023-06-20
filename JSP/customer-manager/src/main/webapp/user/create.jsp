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
    <a href="users" class="btn btn-primary">Back</a>
  </div>
  <form method="post">
    <fieldset>
      <legend class="text-center"><h4>User Information</h4></legend>
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
          <td>FullName: </td>
          <td><input type="text" name="fullname" id="fullname" class="form-control" value="${requestScope.user.getFullName()}"></td>
        </tr>
        <tr>
          <td>Address: </td>
          <td><input type="text" name="address" id="address" class="form-control" value="${requestScope.user.getAddress()}"></td>
        </tr>
        <tr>
          <td>Date of birth: </td>
          <td><input type="text" name="dob" id="dob" class="form-control" value="${requestScope.user.getDob()}"></td>
        </tr>
        <tr>
          <td>Role </td>
          <td>
            <select name="role" class="form-control">
              <c:forEach items="${requestScope.roles}" var="role">
                <option
                        <c:if test="${role.getId() == (requestScope.user.getRole().getId)}">selected</c:if>
                        value="${role}">${role}</option>
              </c:forEach>
            </select>
          </td>
        </tr>
        <tr>
          <td></td>
          <td><input type="submit" value="Create User" class="btn btn-primary"></td>
        </tr>
      </table>
    </fieldset>
  </form>
</div>

<jsp:include page="/layout/footer_js.jsp"></jsp:include>
</body>
</html>
