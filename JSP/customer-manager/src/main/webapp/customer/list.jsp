<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Customer List</title>
    <jsp:include page="/layout/head_css.jsp"></jsp:include>
</head>
<body>
<div class="container">
    <h1 class="text-center">Customers Management</h1>
    <div class="d-flex justify-content-between align-self-center">
        <div>
            <a href="/customers?action=create " class="btn btn-success m-3"><i class="fa-solid fa-plus"></i> Create new
                customer</a>
        </div>
        <div class="m-3" style="height: 30px">
            <form action="/customers?action=search" method="post">
                <div class="container-search mt-1 d-flex">
                    <input type="text" name="search" id="search" width="270px" value="${search}" oninput="clickButton()">
                    <button type="submit" class="btn btn-primary ml-(-65px)" id="searchbtn"><i class="fas fa-search"></i></button>
                </div>
            </form>
        </div>
    </div>

    <div class="table-responsive">
        <table border="1" class="table table-striped table-hover ">
            <thead class="thead-dark">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Address</th>
                <th>Type</th>
                <th class="text-center">Action</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items='${requestScope.customers}' var="customer">
                <tr>
                    <td>${customer.getId()}</td>
                    <td>${customer.getName()}</td>
                    <td>${customer.getEmail()}</td>
                    <td>${customer.getAddress()}</td>
                    <td>
                            <%--                    <c:forEach items="${requestScope.customerTypes}" var="ct">--%>
                            <%--                        <c:if test="${c.getTypeId() == ct.getId()}">--%>
                            <%--                            ${ct.getName()}--%>
                            <%--                        </c:if>--%>
                            <%--                    </c:forEach>--%>
                            ${customer.getCustomerType().getTypeName()}
                    </td>
                    <td class="col-sm-3">
                        <div class="d-flex justify-content-around">
                            <a href="/customers?action=view&id=${customer.getId()}" class="btn btn-primary btn-sm"><i
                                    class="bi bi-eye-fill"></i>View</a>
                            <a href="/customers?action=edit&id=${customer.getId()}" class="btn btn-primary btn-sm"><i
                                    class="fa-solid fa-pen"></i>Edit</a>
                            <a href="/customers?action=delete&id=${customer.getId()}" class="btn btn-danger btn-sm"><i
                                    class="fa-solid fa-trash-can"></i>Delete</a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="clearfix d-flex justify-content-center">
            <div>
                <nav aria-label="Page navigation example">
                    <ul class="pagination">
                        <li class="page-item">
                            <a class="page-link" href="#" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <li class="page-item"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item page-link">...</li>
                        <li class="page-item"><a class="page-link" href="#">Last Page</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>


<jsp:include page="/layout/footer_js.jsp"></jsp:include>
<script>
    window.onload = function () {
        var searchInput = document.getElementById('search');
        searchInput.focus();
        searchInput.setSelectionRange(searchInput.value.length, searchInput.value.length);
    };

    function clickButton() {
        // var inputText = document.getElementById("search").value;
        var button = document.getElementById("searchbtn");
        button.click();
        document.getElementById("search").focus();
    }

</script>
</body>
</html>