<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 6/11/2023
  Time: 9:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="/layout/head_css.jsp"></jsp:include>

</head>
<body>
<div class="container">
    <h1 class="text-center">User Management</h1>
    <div class="d-flex justify-content-between align-self-center">
        <div>
            <a href="/users?action=create " class="btn btn-success m-3"><i class="fa-solid fa-plus"></i> Create User</a>
        </div>
        <div class="m-3" style="height: 30px">
            <form action="/users?action=search" method="post">
                <div class="container-search mt-1 d-flex">
                    <input type="text" name="search" id="search" width="270px" value="${search}"
                           oninput="clickButton()">
                    <button type="submit" class="btn btn-primary ml-(-65px)" id="searchbtn"><i
                            class="fas fa-search"></i></button>
                </div>
            </form>
        </div>
    </div>
    <div>
        <table class="table table-striped table-hover ">
            <thead class="thead-dark">
            <tr>
                <th>ID</th>
                <th>FullName</th>
                <th>Address</th>
                <th>Date of birth</th>
                <th>Role</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${users}" var="user">
                <tr>
                    <td>${user.getId()}</td>
                    <td>${user.getFullName()}</td>
                    <td>${user.getAddress()}</td>
                    <td>${user.getDob()}</td>
                    <td>${user.getRole()}</td>
                    <td class="col-sm-3">
                        <div class="d-flex justify-content-around">
                            <a href="/users?action=view&id=${user.getId()}" class="btn btn-primary btn-sm">
                                <i class="bi bi-eye-fill"></i>View</a>
                            <a href="/users?action=edit&id=${user.getId()}" class="btn btn-primary btn-sm">
                                <i class="bi bi-eye-fill"></i>Edit</a>
                            <a href="/users?action=detele&id=${user.getId()}" class="btn btn-danger btn-sm">
                                <i class="fa-solid fa-trash-can"></i>Delete</a>
                        </div>
                    </td>
                </tr>
            </c:forEach>

            </tbody>
        </table>
    </div>
</div>
<jsp:include page="/layout/footer_js.jsp"></jsp:include>
</body>
</html>
<%--long id, String fullName, String address, LocalDate dob, LocalDate deleteAt, ERole role--%>