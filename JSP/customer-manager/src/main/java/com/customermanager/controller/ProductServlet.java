package com.customermanager.controller;

import com.customermanager.model.Category;
import com.customermanager.model.Customer;
import com.customermanager.model.CustomerType;
import com.customermanager.model.Product;
import com.customermanager.service.CategoryServiceImplMySql;
import com.customermanager.service.ICategory;
import com.customermanager.service.IProductService;
import com.customermanager.service.ProductServiceImplMySql;
import com.customermanager.utils.ValidateUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet(name = "ProductServlet", urlPatterns = "/products")
public class ProductServlet extends HttpServlet {
    private static final String PRODUCT_PATH = "/product/";
    private IProductService iProductService;
    private ICategory iCategory;

    @Override
    public void init() throws ServletException {
        iProductService = new ProductServiceImplMySql();
        iCategory = new CategoryServiceImplMySql();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                showFormCreateProduct(req, resp);
                break;
            case "edit":
                showFormEditProduct(req, resp);
                break;
            case "delete":
                showDeleteForm(req, resp);
                break;
            case "view":
                showProductDetails(req, resp);
                break;
            default:
                showProducts(req, resp);
                break;
        }
    }

    private void showProductDetails(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long id = Long.parseLong(req.getParameter("id"));
        Product product = iProductService.findById(id);

        req.setAttribute("product", product);
        req.getRequestDispatcher(PRODUCT_PATH + "view.jsp").forward(req, resp);
    }

    private void showDeleteForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long idEdit = Long.parseLong(req.getParameter("id"));
        Product product = iProductService.findById(idEdit);
        List<Category> categoryList = iCategory.getAllCategory();
        req.setAttribute("product", product);
        req.setAttribute("categoryList", categoryList);
        req.getRequestDispatcher(PRODUCT_PATH + "delete.jsp").forward(req, resp);
    }

    private void showFormEditProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long idEdit = Long.parseLong(req.getParameter("id"));
        Product product = iProductService.findById(idEdit);
        List<Category> categoryList = iCategory.getAllCategory();
        req.setAttribute("product", product);
        req.setAttribute("categoryList", categoryList);
        req.getRequestDispatcher(PRODUCT_PATH + "edit.jsp").forward(req, resp);
    }

    private void showProducts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> products = iProductService.findAll();
         req.setAttribute("products", products);
         req.getRequestDispatcher(PRODUCT_PATH + "list.jsp").forward(req, resp);
    }

    private void showFormCreateProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> categoryList = iCategory.getAllCategory();

        req.setAttribute("categoryList", categoryList);
        req.getRequestDispatcher(PRODUCT_PATH + "create.jsp").forward(req, resp);

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
                updateProduct(req, resp);
                break;
            case "delete":
                deleteProduct(req, resp);
                break;
            case "search":
                searchProduct(req, resp);
                break;
            default:
                break;
        }
    }

    private void searchProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String nameSearch = req.getParameter("search");
        List<Product> products = iProductService.findAll();
        List<Product> productsSearch = new ArrayList<>();
        for (Product p: products) {
            if (p.getName().toLowerCase().contains(nameSearch.toLowerCase())) {
                productsSearch.add(p);
            }
        }
        req.setAttribute("products", productsSearch);
        req.setAttribute("search", nameSearch);
        req.getRequestDispatcher(PRODUCT_PATH + "list.jsp").forward(req, resp);
    }

    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        long idRemove = Long.parseLong(req.getParameter("id"));
//        Product product = iProductService.findById(idRemove);
        iProductService.remove(idRemove);
        resp.sendRedirect("products");
    }

    private void updateProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<String> errors = new ArrayList<>();

        long id = Long.parseLong(req.getParameter("id"));
        Product product = iProductService.findById(id);

        validateInputNameProduct(req, errors, product);
        validateInputDescription(req, errors, product);
        validateInputPrice(req, errors, product);
        validateInputProductCategory(req, errors, product);

        if (errors.isEmpty()) {
            iProductService.update(id, product);
            resp.sendRedirect("/products");
        } else {
            req.setAttribute("errors", errors);
            req.setAttribute("product", product);
            List<Category> categoryList = iCategory.getAllCategory();
            req.setAttribute("categoryList", categoryList);
            req.getRequestDispatcher(PRODUCT_PATH + "edit.jsp").forward(req, resp);

        }
    }

    private void createProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<String> errors = new ArrayList<>();
        Product product = new Product();

        validateInputNameProduct(req, errors, product);
        validateInputDescription(req, errors, product);
        validateInputPrice(req, errors, product);
        validateInputProductCategory(req, errors, product);

        long id = System.currentTimeMillis() % 100000;
        product.setId(id);
        LocalDate createAt = LocalDate.now();
        product.setCreateAt(createAt);

        if (errors.isEmpty()){
            iProductService.save(product);
            req.setAttribute("message", "Thêm sản phẩm thành công");
        } else {
            req.setAttribute("errors", errors);
            req.setAttribute("product", product);
            List<Category> categoryList = iCategory.getAllCategory();
            req.setAttribute("categoryList", categoryList);
        }

        req.getRequestDispatcher(PRODUCT_PATH + "create.jsp").forward(req, resp);
    }

    private void validateInputNameProduct(HttpServletRequest req, List<String> errors, Product product) {
        String name = req.getParameter("name");
        if (!ValidateUtils.isNameValid(name)) {
            errors.add("Tên sản pẩm không hợp lệ. Tên phải từ 8-20 kí tự và bắt đầu là chữ cái");
        }
        product.setName(name);
    }
    private void validateInputDescription(HttpServletRequest req, List<String> errors, Product product) {
        String description = req.getParameter("description");
        if (!ValidateUtils.isNameValid(description)) {
            errors.add("Mô tả không hợp lệ. Mô tả sản phẩm phải từ 8-20 kí tự và bắt đầu là chữ cái");
        }
        product.setDescription(description);
    }
    private void validateInputProductCategory(HttpServletRequest req, List<String> errors, Product product) {
        try {
            int idCategory = Integer.parseInt(req.getParameter("category"));
            Category category = iCategory.findById(idCategory);

            if (category == null) {
                errors.add("Không tìm thấy loại sản phẩm");
                Category cDefault = iCategory.findById(1);
                product.setCategory(cDefault);
            }else {
                product.setCategory(category);
            }
        } catch (NumberFormatException numberFormatException) {
            errors.add("Loại sản phẩm không hợp lệ");
        }

    }
    private void validateInputPrice(HttpServletRequest req, List<String> errors, Product product) {
        String price = req.getParameter("price");
        if (!ValidateUtils.isPriceValid(price)) {
            errors.add("Giá không hợp lệ. Giá phải lớn hơn hoặc bằng 1.000 và nhỏ hơn 100.000.000.\n Phần thập phân tối đa 2 chữ số.");
        }
        product.setPrice(Float.parseFloat(price));
    }
}
