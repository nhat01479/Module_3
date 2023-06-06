package com.example.customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet(name = "CustomerServlet", value = "/customer")

public class CustomerServlet extends HttpServlet {


    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        ArrayList<Customer> customers = new ArrayList<>();
        customers.add(new Customer("Mai Văn Hoàn", "20-08-1983", "Hà Nội", "https://anhhd.com/wp-content/uploads/2021/11/anh-dai-dien-dep-cho-nam-cute-23.jpg"));
        customers.add(new Customer("John Doe", "20-08-1983", "Huế", "https://anhhd.com/wp-content/uploads/2021/11/anh-dai-dien-dep-cho-nam-cute-23.jpg"));
        customers.add(new Customer("David Beckham", "20-08-1983", "England", "https://i.imgur.com/PhC5n32.png"));

        request.setAttribute("customers", customers);
        request.getRequestDispatcher("customer.jsp").forward(request, response);
    }

    public void destroy() {
    }
}
