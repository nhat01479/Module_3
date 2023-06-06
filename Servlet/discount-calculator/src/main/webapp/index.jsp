<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <style>

    </style>
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
</body>
</html>