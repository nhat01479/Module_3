<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.customer.Customer" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <style>
        img {
            width: 100px;
            height: 100px;
        }

        td {
            line-height: 100px;
        }
    </style>
</head>
<body>
<form  class="container" >
    <h3 class="text-center">Danh sách khách hàng</h3>

    <table class="table table-striped table-hover">
        <thead>
        <tr>
            <th>Tên</th>
            <th>Ngày sinh</th>
            <th>Địa chỉ</th>
            <th>Ảnh</th>
        </tr>
        </thead>
        <tbody>
        <%
            ArrayList<Customer> customers = new ArrayList<>();
            customers.add(new Customer("Mai Văn Hoàn", "20-08-1983", "Hà Nội", "https://anhhd.com/wp-content/uploads/2021/11/anh-dai-dien-dep-cho-nam-cute-23.jpg"));
            customers.add(new Customer("John Doe", "20-08-1983", "Huế", "https://anhhd.com/wp-content/uploads/2021/11/anh-dai-dien-dep-cho-nam-cute-23.jpg"));
            customers.add(new Customer("David Beckham", "20-08-1983", "England", "https://i.imgur.com/PhC5n32.png"));
        %>

        <%-- Dùng JSP   --%>
        <% for (Customer customer : customers) { %>
        <tr>
          <td><%= customer.getName() %></td>
          <td><%= customer.getDob() %></td>
          <td><%= customer.getAdd() %></td>
          <td><img src="<%= customer.getImg() %>" /></td>
        </tr>
        <% } %>


        </tbody>
    </table>

</form>
</body>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
        crossorigin="anonymous"></script>
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
</html>