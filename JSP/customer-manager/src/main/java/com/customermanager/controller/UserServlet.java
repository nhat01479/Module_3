package com.customermanager.controller;

import com.customermanager.model.ERole;
import com.customermanager.model.User;
import com.customermanager.service.IUser;
import com.customermanager.service.UserServiceImplMySql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "UserServlet", urlPatterns = "/users")

public class UserServlet extends HttpServlet {
    private static final String USER_PATH = "/user/";
    private IUser iUser;

    @Override
    public void init() throws ServletException {
        iUser = new UserServiceImplMySql();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                showFormCreateUser(req, resp);
                break;
            default:
                showUsers(req, resp);
        }
    }

    private void showFormCreateUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ERole[] roles = ERole.values();
        req.setAttribute("roles", roles);
        req.getRequestDispatcher(USER_PATH + "create.jsp").forward(req, resp);
    }

    private void showUsers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<User> users = iUser.findAll();
        req.setAttribute("users", users);
        req.getRequestDispatcher(USER_PATH + "list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                createUser(req, resp);
                break;
            default:
                break;
        }
    }
//long id, String fullName, String address, LocalDate dob, LocalDate deleteAt, ERole role
    private void createUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long id = System.currentTimeMillis() % 100000;
        String fullName = req.getParameter("fullname");
        String address = req.getParameter("address");
        LocalDate dob = LocalDate.parse(req.getParameter("dob"));
        String role = req.getParameter("role");
        ERole eRole = ERole.getEroleByName(role);

        User user = new User(id, fullName, address, dob, eRole);
        iUser.save(user);
        req.getRequestDispatcher(USER_PATH + "create.jsp").forward(req, resp);
    }
}
