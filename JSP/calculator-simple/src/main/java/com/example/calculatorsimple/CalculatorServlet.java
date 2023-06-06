package com.example.calculatorsimple;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "CalculatorServlet", value = "/calculator")

public class CalculatorServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        double number_1 = Double.parseDouble(request.getParameter("number1"));
        double number_2 = Double.parseDouble(request.getParameter("number2"));
        String operator = request.getParameter("operator");

        Calculator calculator = new Calculator();

        try {
            double result = calculator.calculate(number_1, number_2, operator);
            request.setAttribute("result", result);
        } catch (ArithmeticException ae) {
            request.setAttribute("result", "Phép chia không hợp lệ");
        }


        request.getRequestDispatcher("calculator.jsp").forward(request, response);

    }
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        request.getRequestDispatcher("calculator.jsp").forward(request, response);

    }

}
