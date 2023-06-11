<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>View customer</title>
    <jsp:include page="/layout/head_css.jsp"></jsp:include>

</head>
<body>
<%--<h1>Customer details</h1>--%>
<%--<p>--%>
<%--    <a href="/customers">Back to customer list</a>--%>
<%--</p>--%>
<%--<table class="table table-striped table-hover">--%>
<%--    <tr>--%>
<%--        <td>Name: </td>--%>
<%--        <td>${requestScope["customer"].getName()}</td>--%>
<%--    </tr>--%>
<%--    <tr>--%>
<%--        <td>Email: </td>--%>
<%--        <td>${requestScope["customer"].getEmail()}</td>--%>
<%--    </tr>--%>
<%--    <tr>--%>
<%--        <td>Address: </td>--%>
<%--        <td>${requestScope["customer"].getAddress()}</td>--%>
<%--    </tr>--%>
<%--</table>--%>
<div class="container justify-center" style="align-items: center;">
    <div>
        <a href="/customers" class="btn btn-primary">Back</a>
    </div>
    <form method="post">
        <fieldset>
            <legend class="text-center"><h4>Customer Details</h4></legend>
            <table class="table table-striped table-hover">
                <tr>
                    <td>ID</td>
                    <td>${requestScope.customer.getId()}</td>
                </tr>
                <tr>
                    <td>Name</td>
                    <td>${requestScope.customer.getName()}</td>
                </tr>
                <tr>
                    <td>Email</td>
                    <td>${requestScope.customer.getEmail()}</td>
                </tr>
                <tr>
                    <td>Address</td>
                    <td>${requestScope.customer.getAddress()}</td>
                </tr>
                <tr>
                    <td>Type</td>
                    <td>${requestScope.customer.getCustomerType().getTypeName()}</td>
                </tr><tr>
                    <td>Create At</td>
                    <td>${requestScope.customer.getCreateAt()}</td>
                </tr>
            </table>
        </fieldset>
    </form>
</div>
</body>
</html>