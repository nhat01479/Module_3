<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 6/6/2023
  Time: 4:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="calculator" method="post">
    <h3>Simple Calculator</h3>
    <fieldset>
        <legend style="text-align: center;">Calculate</legend>
        <table>
            <tr>
                <td>First Operand:</td>
                <td><input type="text" name="number1"></td>
            </tr>
            <tr>
                <td>Operator:</td>
                <td>
                    <select name="operator">
                        <option value="+">+</option>
                        <option value="-">-</option>
                        <option value="*">*</option>
                        <option value="/">/</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Second Operand:</td>
                <td><input type="text" name="number2"></td>
            </tr>
        </table>
        <button type="submit">Calculator</button>
    </fieldset>
    <h3>Result: ${result}</h3>
</form>
</body>
</html>
