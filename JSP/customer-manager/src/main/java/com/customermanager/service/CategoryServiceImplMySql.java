package com.customermanager.service;

import com.customermanager.model.Category;
import com.customermanager.model.CustomerType;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class CategoryServiceImplMySql extends DBContext implements ICategory{
    @Override
    public List<Category> getAllCategory() {
        List<Category> categoryList = new ArrayList<>();

        try {
            Connection connection = getConnection();
            PreparedStatement pS = connection.prepareStatement("SELECT * FROM `duan_banhang`.`category`;");

            ResultSet rS = pS.executeQuery();

            while (rS.next()) {
                int idCategory = rS.getInt("id_category");
                String nameCategory = rS.getString("name_category");

                java.sql.Date sqlDeleteAt = rS.getDate("delete_at");
                LocalDate lDeleteAt = null;
                if (sqlDeleteAt != null) {
                    lDeleteAt = sqlDeleteAt.toLocalDate();
                }
                Category category = new Category(idCategory, nameCategory, lDeleteAt);
//                CustomerType customerType = getCustomerTypeFromResultSet(rS);
                categoryList.add(category);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return categoryList;
    }

    @Override
    public Category findById(int id) {
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM category where `id_category`= ?;");
            preparedStatement.setInt(1, id);
            ResultSet rS = preparedStatement.executeQuery();

            while (rS.next()) {
//                CustomerType customerType = getCustomerFromRs(resultSet);
                int idCategory = rS.getInt("id_category");
                String nameCategory = rS.getString("name_category");

                java.sql.Date sqlDeleteAt = rS.getDate("delete_at");
                LocalDate lDeleteAt = null;
                if (sqlDeleteAt != null) {
                    lDeleteAt = sqlDeleteAt.toLocalDate();
                }
                Category category = new Category(idCategory, nameCategory, lDeleteAt);
                return category;
            }
            connection.close();

        } catch (SQLException sqlException) {
            printSQLException(sqlException);
        }
        return null;
    }
}
