package com.productmanagement.controller;

import com.productmanagement.model.Product;
import com.productmanagement.service.IProductService;
import com.productmanagement.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ProductServlet", urlPatterns = "/products")

public class ProductServlet extends HttpServlet {
    private IProductService iProductService = new ProductService();


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                showCreateForm(req, resp);
                break;
            case "edit":
                showEditForm(req, resp);
                break;
            case "delete":
                showDeleteForm(req, resp);
                break;
//            case "search":
//                showSearchProduct(req, resp);
//                break;
            default:
                showProducts(req, resp);
        }
    }

//    private void showSearchProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        req.getRequestDispatcher(Config.URL_VIEW_PRODUCT + "search.jsp").forward(req, resp);
//    }

    private void showDeleteForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idRemove = Integer.parseInt(req.getParameter("id"));
        Product product = iProductService.findById(idRemove);

        req.setAttribute("product", product);
        req.getRequestDispatcher(Config.URL_VIEW_PRODUCT + "delete.jsp").forward(req, resp);

    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Product product = iProductService.findById(id);

        req.setAttribute("product", product);
        req.getRequestDispatcher(Config.URL_VIEW_PRODUCT + "edit.jsp").forward(req, resp);

    }

    private void showCreateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher(Config.URL_VIEW_PRODUCT + "create.jsp").forward(req, resp);

    }


    private void showProducts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> products = iProductService.findAllProduct();

        req.setAttribute("products", products);
        req.getRequestDispatcher(Config.URL_VIEW_PRODUCT + "list.jsp").forward(req, resp);
    }



    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                createProduct(req, resp);
                break;
            case "edit":
                editProduct(req, resp);
                break;
            case "delete":
                deleteProduct(req, resp);
                break;
            case "search":
                searchProduct(req, resp);
                break;
            default:
                showProducts(req, resp);
        }
    }

    private void searchProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> products = iProductService.findAllProduct();
        String name = req.getParameter("search");

        List<Product> searchProducts = new ArrayList<>();
        for (Product product: products){
            if (product.getName().toLowerCase().contains(name.toLowerCase())) {
                searchProducts.add(product);
            }
        }
        req.setAttribute("products", searchProducts);

        req.getRequestDispatcher(Config.URL_VIEW_PRODUCT +  "list.jsp").forward(req, resp);

    }

    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int idProduct = Integer.parseInt(req.getParameter("id"));
//        Product product = iProductService.findById(idProduct);

        iProductService.remove(idProduct);
//        List<Product> customers = iProductService.findAllProduct();


        resp.sendRedirect("/products");

    }

    private void editProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int idProduct = Integer.parseInt(req.getParameter("id"));

        Product product = iProductService.findById(idProduct);
        String newName = req.getParameter("name");
        float newPrice = Float.parseFloat(req.getParameter("price"));
        String newDescription = req.getParameter("description");
        String newManufacturer = req.getParameter("manufacturer");

        product.setName(newName);
        product.setPrice(newPrice);
        product.setDescription(newDescription);
        product.setManufacturer(newManufacturer);

        iProductService.update(product.getId(), product);
        req.setAttribute("product", product);
        req.setAttribute("message", "Sửa thành công");

        req.getRequestDispatcher(Config.URL_VIEW_PRODUCT +  "edit.jsp").forward(req, resp);

    }

    private void createProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        float price = Float.parseFloat(req.getParameter("price"));
        String description = req.getParameter("description");
        String manufacturer = req.getParameter("manufacturer");
        int id = (int) (System.currentTimeMillis() % 100000);
        Product product = new Product(id, name, price, description, manufacturer);

        iProductService.save(product);
        req.setAttribute("message", "Thêm thành công");

        req.getRequestDispatcher(Config.URL_VIEW_PRODUCT +  "create.jsp").forward(req, resp);
    }


}
