<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Edit customer</title>
    <jsp:include page="/layout/head_css.jsp"></jsp:include>

</head>
<body>
<div class="container">
    <div>
        <a href="/customers" class="btn btn-primary">Back</a>
    </div>
    <form method="post">
        <fieldset>
            <legend class="text-center"><h4>Edit Customer Information</h4></legend>
            <c:if test="${requestScope.errors != null}">
                <div class="alert alert-danger">
                    <ul>
                        <c:forEach items="${requestScope.errors}" var="error">
                            <li>${error}</li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>
            <c:if test='${requestScope["message"] != null}'>
                <div class="alert alert-success text-center">
                    <span class="message">${requestScope["message"]}</span>
                </div>
            </c:if>
            <table class="table table-striped table-hover">
                <tr>
                    <td>ID: </td>
                    <td><input type="text" class="form-control" name="id" id="id" value="${requestScope.customer.getId()}"  disabled></td>
                </tr>
                <tr>
                    <td>Name: </td>
                    <td><input type="text" class="form-control" name="name" id="name" value="${requestScope.customer.getName()}"></td>
                </tr>
                <tr>
                    <td>Email: </td>
                    <td><input type="text" class="form-control" name="email" id="email" value="${requestScope.customer.getEmail()}"></td>
                </tr>
                <tr>
                    <td>Address: </td>
                    <td><input type="text" class="form-control" name="address" id="address" value="${requestScope.customer.getAddress()}" ></td>
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
                    <td><input type="submit" value="Update customer" class="btn btn-primary"></td>
                </tr>
            </table>
        </fieldset>
    </form>
</div>


<jsp:include page="/layout/footer_js.jsp"></jsp:include>
</body>
</html>