package com.customermanager.service;

import com.customermanager.model.CustomerType;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CustomerTypeImplMySql extends DBContext implements ICustomerType {
    @Override
    public List<CustomerType> getAllCustomerTypes() {
        List<CustomerType> customerTypes = new ArrayList<>();

        try {
            Connection connection = getConnection();
            PreparedStatement pS = connection.prepareStatement("SELECT * FROM `duan_banhang`.`customer_type`;");

            ResultSet rS = pS.executeQuery();

            while (rS.next()) {
                CustomerType customerType = getCustomerTypeFromResultSet(rS);
                customerTypes.add(customerType);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return customerTypes;

    }

    @Override
    public CustomerType findById(long id) {
        try {
            Connection connection = getConnection();
            PreparedStatement pS = connection.prepareStatement("select * from `duan_banhang`.`customer_type` where typeId = ?;");
            pS.setLong(1, id);

            System.out.println("Function find type customer " + pS);
            ResultSet rS = pS.executeQuery();

            while (rS.next()) {
                CustomerType customerType = getCustomerTypeFromResultSet(rS);
                return customerType;
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return null;
    }
    private CustomerType getCustomerTypeFromResultSet(ResultSet rS) throws SQLException {
        int typeId = rS.getInt("typeId");
        String typeName = rS.getString("typeName");
        java.sql.Date sqlDeleteAt = rS.getDate("delete_at");
        LocalDate lDeleteAt = null;
        if (sqlDeleteAt != null) {
            lDeleteAt = sqlDeleteAt.toLocalDate();
        }
        CustomerType customerType = new CustomerType(typeId, typeName, lDeleteAt);
        return customerType;
    }
}
