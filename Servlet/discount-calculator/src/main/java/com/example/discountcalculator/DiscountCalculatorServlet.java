package com.example.discountcalculator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DiscountCalculatorServlet", value = "/display-discount")

public class DiscountCalculatorServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        float price = Float.parseFloat(request.getParameter("price"));
        float discount = Float.parseFloat(request.getParameter("discount"));

        double discountAmount = price * discount * 0.01;
        double discountPrice = price - discountAmount;

        request.setAttribute("discountAmount", String.format("%s", discountAmount));
        request.setAttribute("discountPrice", String.format("%s", discountPrice));

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/discount.jsp");
        requestDispatcher.forward(request, response);

    }
}
