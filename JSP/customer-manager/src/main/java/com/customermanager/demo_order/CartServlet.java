package com.customermanager.demo_order;

import com.customermanager.service.IProductService;
import com.customermanager.service.ProductServiceImplMySql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet (name="CartServlet", urlPatterns = "/cart")
public class CartServlet extends HttpServlet {
    private IProductService iProductService;

    @Override
    public void init() throws ServletException {
        iProductService = new ProductServiceImplMySql();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
