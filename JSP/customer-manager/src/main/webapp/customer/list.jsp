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
            <form action="/customers?action=search" method="get">
                <div class="container-search mt-1 d-flex">
                    <input type="text" name="keyword"  width="270px" value="${requestScope.pageable.getKeyword()}">
                    <select name="customertype" oninput="demo(${pageable.getType()})">
                        <option value="-1">All</option>
                        <c:forEach items="${requestScope.customerTypes}" var="ct">
                            <option
                                    <c:if test="${ct.getTypeId() == requestScope.pageable.getType()}">selected</c:if>
                                    value="${ct.getTypeId()}">${ct.getTypeName()}</option>
                        </c:forEach>
                    </select>
<%--                    <button class="btn btn-primary ml-(-65px)" id="searchbtn"><i class="fas fa-search"></i></button>--%>
                </div>
            </form>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-striped table-hover ">
            <thead class="thead-dark">
            <tr>
                <th>ID</th>
                <th>Name <a class="link-danger"><i <c:if test="${pageable.getSortField() == 'name'}">style="color: red;"</c:if>
                               onclick="handleSort('name','${pageable.getOrder()}', '${pageable.getKeyword()}', ${pageable.getType()} )"
                               class="bi bi-sort-alpha-down"></i></a></th>
                <th>Email <a><i <c:if test="${pageable.getSortField() == 'email'}">style="color: red"</c:if>
                                onclick="handleSort('email','${pageable.getOrder()}', '${pageable.getKeyword()}', ${pageable.getType()} )"
                                class="bi bi-sort-alpha-down"></i></a></th>
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
                        <%--
                                                <c:forEach items="${requestScope.customerTypes}" var="ct">
                                                    <c:if test="${c.getTypeId() == ct.getId()}">
                                                        ${ct.getName()}
                                                    </c:if>
                                                </c:forEach>
                        --%>
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
                    <ul class="pagination">
                        <c:if test="${pageable.getPage() > 1}">
                            <li class="page-item">
<%-- let url = '/customers?sortfield=' + sortfield + '&order=' + newOrder + '&keywork=' + keywork + '&customertype' + customertype;--%>

                                <a class="page-link" href="/customers?keyword=${pageable.getKeyword()}&customertype=${pageable.getType()}&page=${pageable.getPage() - 1}">Previous</a>
                            </li>
                        </c:if>
                        <c:forEach begin="1" end="${pageable.getTotalPage()}" var="page">
                            <c:choose>
                                <c:when test="${page == pageable.getPage()}">
                                    <li class="page-item active"><a class="page-link" href="#">${page}</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item"><a class="page-link" href="/customers?keyword=${pageable.getKeyword()}&customertype=${pageable.getType()}&page=${page}">${page}</a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:if test="${pageable.getPage() < pageable.getTotalPage()}">
                            <li class="page-item">
                                <a class="page-link" href="/customers?keyword=${pageable.getKeyword()}&customertype=${pageable.getType()}&page=${pageable.getPage() + 1}">Next</a>
                            </li>
                        </c:if>
                    </ul>
            </div>
        </div>
    </div>
</div>


<jsp:include page="/layout/footer_js.jsp"></jsp:include>
<script>
    /**
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
   **/
function handleSort(sortfield, order, keywork, customertype) {
    let newOrder = order == 'asc' ? 'desc' : 'asc';
    let url = '/customers?sortfield=' + sortfield + '&order=' + newOrder + '&keywork=' + keywork + '&customertype=' + customertype;
    window.location.href(url);
}
function demo(customertype) {
    window.location.href = '/customers?customertype=' + customertype;

}
</script>
</body>
</html>