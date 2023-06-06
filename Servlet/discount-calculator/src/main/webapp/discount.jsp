<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 6/5/2023
  Time: 10:42 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="/display-discount" method="post">
  <label>Product Description</label><br>
  <input type="text" placeholder="Mô tả"><br>
  <label>List Price</label><br>
  <input type="number" name="price" placeholder="Giá niêm yết"><br>
  <label>Discount Percent: </label><br>
  <input type="number" name="discount" placeholder="Chiết khấu (%)"><br>
  <button type="submit">Calculate Discount</button><br>
</form>
<h3>Discount Amount: ${discountAmount}</h3>
<h3>Discount Price: ${discountPrice}</h3>
</body>
</html>
