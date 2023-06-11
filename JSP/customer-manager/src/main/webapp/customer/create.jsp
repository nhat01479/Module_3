<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create new customer</title>
    <style>
        .message{
            color:green;
        }
    </style>
    <jsp:include page="/layout/head_css.jsp"></jsp:include>

</head>
<body>
<div class="container justify-center" style="align-items: center;">
<%--    <h1 class="text-center">Create new customer</h1>--%>

    <div>
        <a href="customers" class="btn btn-primary">Back</a>
    </div>
    <form method="post">
        <fieldset>
            <legend class="text-center"><h4>Customer information</h4></legend>
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
                    <td><input type="text" name="name" id="name" class="form-control" value="${requestScope.customer.getName()}"></td>
                </tr>
                <tr>
                    <td>Email: </td>
                    <td><input type="text" name="email" id="email" class="form-control" value="${requestScope.customer.getEmail()}"></td>
                </tr>
                <tr>
                    <td>Address: </td>
                    <td><input type="text" name="address" id="address" class="form-control" value="${requestScope.customer.getAddress()}"></td>
                </tr>
                <tr>
                    <td>Customer Type: </td>
                    <td>
                        <select name="customertype" class="form-control">
                            <c:forEach items="${requestScope.customerTypes}" var="ct">
                                <option
                                        <c:if test="${ct.getTypeId() == requestScope.customer.getCustomerType().getTypeId()}">selected</c:if>
                                        value="${ct.getTypeId()}">${ct.getTypeName()}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Create customer" class="btn btn-primary"></td>
                </tr>
            </table>
        </fieldset>
    </form>
</div>


<jsp:include page="/layout/footer_js.jsp"></jsp:include>
</body>
</html>