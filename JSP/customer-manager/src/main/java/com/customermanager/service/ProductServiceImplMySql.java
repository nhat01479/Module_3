package com.customermanager.service;

import com.customermanager.model.Category;
import com.customermanager.model.Customer;
import com.customermanager.model.Product;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ProductServiceImplMySql extends DBContext implements IProductService{
    private ICategory iCategory = new CategoryServiceImplMySql();
    @Override
    public List<Product> findAll() {
        List<Product> products = new ArrayList<>();
        Connection connection = getConnection();
        try {
            PreparedStatement pS = connection.prepareStatement(
                    "SELECT p.*, c.name_category, c.delete_at FROM duan_banhang.products p join duan_banhang.category c on p.id_category = c.id_category;");
            ResultSet rS = pS.executeQuery();

            while (rS.next()) {
               Product product = getProductFromRS(rS);
                products.add(product);
            }
            connection.close();
        } catch (SQLException e) {
            printSQLException(e);
        }
        return products;
    }

    private Product getProductFromRS(ResultSet rS) throws SQLException {
        long id = rS.getLong("id_product");
        String name = rS.getString("name_product");
        String description = rS.getString("description");
        Date sqlCreateAt = rS.getDate("create_at");
        LocalDate lCreateAt = null;
        if (sqlCreateAt != null) {
            lCreateAt = sqlCreateAt.toLocalDate();
        }
        Date sqlDeleteAt = rS.getDate("delete_at");
        LocalDate lDeleteAt = null;
        if (sqlDeleteAt != null) {
            lDeleteAt = sqlDeleteAt.toLocalDate();
        }
        float price = rS.getFloat("price");
        int idCategory = rS.getInt("id_category");
//                String nameCategory = rS.getString("name_category");

        Category category = iCategory.findById(idCategory);

        return new Product(id, name, description, lCreateAt, lDeleteAt, price, category);
    }


    @Override
    public void save(Product product) {
        Connection connection = getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO `duan_banhang`.`products` (`name_product`, `description`, `create_at`, `price`, `id_category`) VALUES (?, ?, ?, ?, ?);");
            preparedStatement.setString(1, product.getName());
            preparedStatement.setString(2, product.getDescription());
            preparedStatement.setDate(3, Date.valueOf(product.getCreateAt()));
            preparedStatement.setFloat(4, product.getPrice());
            preparedStatement.setInt(5, product.getCategory().getId());

            System.out.println("function save product " + preparedStatement);
            preparedStatement.executeUpdate();
            connection.close();


        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    @Override
    public Product findById(long id) {
        Connection connection = getConnection();
        try {
            PreparedStatement pS = connection.prepareStatement("select * from products where id_product = ?");
            pS.setLong(1, id);
            ResultSet rS = pS.executeQuery();

            while (rS.next()) {
                Product product = getProductFromRS(rS);
                return product;
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return null;
    }

    @Override
    public void update(long id, Product product) {
        Connection connection = getConnection();
        try {
            PreparedStatement pS = connection.prepareStatement(
                    "UPDATE `duan_banhang`.`products` SET `name_product` = ?, `description` = ?, `price` = ?, `id_category` = ? WHERE (`id_product` = ?);");
            pS.setString(1, product.getName());
            pS.setString(2, product.getDescription());
            pS.setFloat(3, product.getPrice());
            pS.setInt(4, product.getCategory().getId());
            pS.setLong(5, id);

            System.out.println("Function update " + pS);
            pS.executeUpdate();

            connection.close();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    @Override
    public void remove(long id) {
        Connection connection = getConnection();
        try {
            PreparedStatement pS = connection.prepareStatement("delete from `duan_banhang`.`products` WHERE (`id_product` = ?);");
            pS.setLong(1, id);

            System.out.println("Function remove " + pS);
            pS.executeUpdate();

            connection.close();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }
}
