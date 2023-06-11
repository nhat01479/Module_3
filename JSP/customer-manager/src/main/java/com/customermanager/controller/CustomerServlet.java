package com.customermanager.controller;
import com.customermanager.model.Customer;
import com.customermanager.model.CustomerType;
import com.customermanager.service.ICustomerService;
//import com.customermanager.service.CustomerServiceImpl;
import com.customermanager.service.CustomerServiceImplMySql;
import com.customermanager.service.CustomerTypeImplMySql;
import com.customermanager.service.ICustomerType;
import com.customermanager.utils.ValidateUtils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
@WebServlet(name = "CustomerServlet", urlPatterns = "/customers")
public class CustomerServlet extends HttpServlet {
    private ICustomerService iCustomerService = new CustomerServiceImplMySql();
    private ICustomerType iCustomerType = new CustomerTypeImplMySql();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null){
            action = "";
        }
        switch (action) {
            case "create":
                showCreatForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                showDeleteForm(request, response);
                break;
            case "view":
                viewCustomer(request, response);
                break;
            default:
                listCustomers(request, response);
                break;
        }
    }

    private void viewCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long id = Integer.parseInt(request.getParameter("id"));
        Customer customer = iCustomerService.findById(id);

        request.setAttribute("customer", customer);
        request.getRequestDispatcher("customer/view.jsp").forward(request, response);
    }
    private void showDeleteForm(HttpServletRequest request, HttpServletResponse response) {
        long id = Integer.parseInt(request.getParameter("id"));
        Customer customer = this.iCustomerService.findById(id);
        RequestDispatcher dispatcher;
        if(customer == null){
            dispatcher = request.getRequestDispatcher("customer/error-404.jsp");
        } else {
            request.setAttribute("customer", customer);
            dispatcher = request.getRequestDispatcher("customer/delete.jsp");
        }
        try {
            dispatcher.forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long id = Integer.parseInt(request.getParameter("id"));
        Customer customer = iCustomerService.findById(id);
        List<CustomerType> customerTypes = iCustomerType.getAllCustomerTypes();

        request.setAttribute("customer", customer);
        request.setAttribute("customerTypes", customerTypes);
        request.getRequestDispatcher("customer/edit.jsp").forward(request, response);
//        RequestDispatcher dispatcher;
//        if(customer == null){
//            dispatcher = request.getRequestDispatcher("customer/error-404.jsp");
//        } else {
//            request.setAttribute("customer", customer);
//            request.setAttribute("customerTypes", customerTypes);
//            dispatcher = request.getRequestDispatcher("customer/edit.jsp");
//        }
//        try {
//            dispatcher.forward(request, response);
//        } catch (ServletException e) {
//            e.printStackTrace();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
    }
    private void showCreatForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Gửi danh sách loại khách hàng tới trang create
        List<CustomerType> customerTypes = iCustomerType.getAllCustomerTypes();
        request.setAttribute("customerTypes", customerTypes);

        RequestDispatcher dispatcher = request.getRequestDispatcher("customer/create.jsp");
        dispatcher.forward(request, response);

    }
    private void listCustomers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Customer> customers = iCustomerService.findAll2();
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("customer/list.jsp").forward(request, response);

//        List<Customer> customers = customerService.findAll2();
////        List<CustomerType> customerTypes = iCustomerType.getAllCustomerTypes();
//
//
//        request.setAttribute("customers", customers);
////        req.setAttribute("customerTypes", customerTypes);
//        request.getRequestDispatcher("/customer/list.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null){
            action = "";
        }
        switch (action) {
            case "create":
                createCustomer(request, response);
                break;
            case "edit":
                updateCustomer(request, response);
                break;
            case "delete":
                deleteCustomer(request, response);
                break;
            case "search":
                searchCustomer(request, response);
                break;
            default:
                break;
        }
    }
    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) {
        long id = Integer.parseInt(request.getParameter("id"));
        Customer customer = this.iCustomerService.findById(id);

        RequestDispatcher dispatcher;
        if(customer == null){
            dispatcher = request.getRequestDispatcher("customer/error-404.jsp");
        } else {
            this.iCustomerService.remove(id);
            try {
                response.sendRedirect("/customers");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private void updateCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        List<String> errors = new ArrayList<>();

        long id = Integer.parseInt(request.getParameter("id"));
        Customer customer = iCustomerService.findById(id);

        validateInputName(request, errors, customer);
        validateInputEmail(request, errors, customer);
        validateInputAddress(request, errors, customer);
        validateInputCustomerType(request, errors, customer);


        if (errors.isEmpty()) {
            iCustomerService.update(customer.getId(), customer);
            request.setAttribute("message", "Cập nhật khách hàng thành công");
            response.sendRedirect("/customers");
        } else  {
            request.setAttribute("customer", customer);
            request.setAttribute("errors", errors);
            List<CustomerType> customerTypes = iCustomerType.getAllCustomerTypes();
            request.setAttribute("customerTypes", customerTypes);
            request.getRequestDispatcher("customer/edit.jsp").forward(request, response);

        }


    }
    private void createCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> errors = new ArrayList<>();
        Customer customer = new Customer();

        validateInputName(request, errors, customer);
        validateInputEmail(request, errors, customer);
        validateInputAddress(request, errors, customer);
        validateInputCustomerType(request, errors, customer);
        long id = System.currentTimeMillis() %100000;
        customer.setId(id);
        customer.setCreateAt(new Date());

        if (errors.isEmpty()){
            iCustomerService.save(customer);
            request.setAttribute("message", "Thêm khách hàng thành công");
        } else {
            // Nếu nhập không đúng thì trả thông tin đã nhập về trang và kèm thông báo lỗi
            request.setAttribute("customer", customer);
            request.setAttribute("errors", errors);
            List<CustomerType> customerTypes = iCustomerType.getAllCustomerTypes();
            request.setAttribute("customerTypes", customerTypes);
        }

        // Gửi customer type cho trang create

        request.getRequestDispatcher("customer/create.jsp").forward(request, response);


    }
    private void searchCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Customer> customers = iCustomerService.findAll2();
        String name = req.getParameter("search");
//        List<Customer> customers = customerService.findByName(name);

        List<Customer> searchCustomer = new ArrayList<>();
        for (Customer customer: customers){
            if (customer.getName().toLowerCase().contains(name.toLowerCase())) {
                searchCustomer.add(customer);
            }
        }
        req.setAttribute("customers", searchCustomer);
        req.setAttribute("search", name);
        req.getRequestDispatcher("customer/list.jsp").forward(req, resp);

    }

    //--------------------------Validate------------------------------
    private void validateInputCustomerType(HttpServletRequest req, List<String> errors, Customer customer) {
        try {
            int customerType = Integer.parseInt(req.getParameter("customertype"));
            CustomerType ct = iCustomerType.findById(customerType);

            if (ct == null) {
                errors.add("Không tìm thấy loại khách hàng");
                CustomerType ctDefault = iCustomerType.findById(1);
                customer.setCustomerType(ctDefault);
            }else {
                customer.setCustomerType(ct);
            }
        } catch (NumberFormatException numberFormatException) {
            errors.add("Loại khách hàng không hợp lệ");
        }

    }
    private void validateInputEmail(HttpServletRequest req, List<String> errors, Customer customer) {
        String email = req.getParameter("email");
        if (!ValidateUtils.isEmailValid(email)) {
            errors.add("Email không hợp lệ");
        }
        customer.setEmail(email);
    }

    private void validateInputName(HttpServletRequest req, List<String> errors, Customer customer) {
        String name = req.getParameter("name");
        if (!ValidateUtils.isNameValid(name)) {
            errors.add("Tên không hợp lệ. Tên phải từ 8-20 kí tự và bắt đầu là chữ cái");
        }
        customer.setName(name);
    }
    private void validateInputAddress(HttpServletRequest req, List<String> errors, Customer customer) {
        String address = req.getParameter("address");
        if (!ValidateUtils.isAddressValid(address)) {
            errors.add("Địa chỉ không hợp lệ. Địa chỉ phải từ 8-20 kí tự và bắt đầu là chữ cái");
        }
        customer.setAddress(address);
    }
}