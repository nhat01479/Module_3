<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <style>
        input, select {
            width: 100px;
        }
        div {
            display: flex;
        }

        fieldset {
            width: 250px;
        }

    </style>
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
</form>
</body>
</html>