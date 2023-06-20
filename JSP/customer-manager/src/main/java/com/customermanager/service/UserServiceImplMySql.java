package com.customermanager.service;

import com.customermanager.model.ERole;
import com.customermanager.model.User;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class UserServiceImplMySql extends DBContext implements IUser{
    @Override
    public List<User> findAll() {
        List<User> users = new ArrayList<>();
        Connection connection = getConnection();
        try {
            PreparedStatement pS = connection.prepareStatement("SELECT * FROM duan_banhang.users;");
            ResultSet rS = pS.executeQuery();
            while (rS.next()) {
                long id = rS.getLong("id_user");
                String name = rS.getString("fullname");
                String address = rS.getString("address");
                java.sql.Date sqlDob = rS.getDate("dob");
                LocalDate lDob = null;
                if (sqlDob != null) {
                    lDob = sqlDob.toLocalDate();
                }
                java.sql.Date sqlDeleteAt = rS.getDate("delete_at");
                LocalDate lDeleteAt = null;
                if (sqlDeleteAt != null) {
                    lDeleteAt = sqlDob.toLocalDate();
                }
                String role = rS.getString("role");
                ERole eRole = ERole.getEroleByName(role);

                User user = new User(id, name, address, lDob, lDeleteAt, eRole);
                users.add(user);
            }
            connection.close();
        } catch (SQLException e) {
            printSQLException (e);
        }
        return users;
    }

    @Override
    public void save(User user) {
        Connection connection = getConnection();
        try {
            PreparedStatement pS = connection.prepareStatement("INSERT INTO `duan_banhang`.`users` (`fullname`, `address`, `dob`, `role`) VALUES (?, ?, ?, ?)");
            pS.setString(1, user.getFullName());
            pS.setString(2, user.getAddress());
            pS.setDate(3, Date.valueOf(user.getDob()));
            pS.setString(4, user.getRole().getName().toUpperCase());

            System.out.println("function save" + pS);
            pS.executeUpdate();
            connection.close();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    @Override
    public User findById(long id) {
        return null;
    }

    @Override
    public void update(long id, User user) {

    }

    @Override
    public void remove(long id) {

    }
}
