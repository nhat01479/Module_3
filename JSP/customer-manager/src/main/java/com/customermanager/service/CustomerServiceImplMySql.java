package com.customermanager.service;

import com.customermanager.model.Customer;
import com.customermanager.model.CustomerType;
import com.customermanager.model.Pageable;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class CustomerServiceImplMySql extends DBContext implements ICustomerService {
    private static  String SQL_ADVANCED_CUSTOMER = "select c.*, ct.typeName, ct.delete_at\n" +
            "from customers c left join customer_type ct on c.typeId = ct.typeId\n" +
            "where c.name like ? or c.email like ? or c.address like ? \n" +
            "order by %s %s\n" +
            "limit ?, ?;";
    private static String SQL_ADVANCED_CUSTOMER_TOTAL = "select count(*) as total\n" +
            "from customers c left join customer_type ct on c.typeId = ct.typeId\n" +
            "where c.name like ? or c.email like ? or c.address like ?";
    private static String SQL_ADVANCED_CUSTOMER_FILTER = "select c.*, ct.typeName, ct.delete_at\n" +
            "from customers c left join customer_type ct on c.typeId = ct.typeId\n" +
            "where (c.name like ? or c.email like ? or c.address like ?) and ct.typeId = ?\n" +
            "order by %s %s\n" +
            "limit ?, ?;";
    private static String SQL_ADVANCED_CUSTOMER_TOTAL_FILTER = "select count(*) as total\n" +
            "from customers c left join customer_type ct on c.typeId = ct.typeId\n" +
            "where (c.name like ? or c.email like ? or c.address like ?) and ct.typeId = ?";

    private ICustomerType iCustomerType = new CustomerTypeImplMySql();


    /*
        @Override
        public List<Customer> findAll() {
            List<Customer> customers = new ArrayList<>();
            try {
                // Lấy kết nối
                Connection connection = getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement("select * from customers;");

                // Thực thi: executeQuery - select, executeUpdate - them/xoa/sua
                ResultSet resultSet = preparedStatement.executeQuery();

                while (resultSet.next()){
                    // getLong, getString : lấy giá trị theo tên cột hoặc chỉ số cột (bắt đầu từ 1)
                    long id = resultSet.getLong("id");
                    String name = resultSet.getString("name");
                    String email = resultSet.getString("email");
                    String address = resultSet.getString("address");

                    Customer customer = new Customer(id, name, email, address);

                    customers.add(customer);
                }

                connection.close();

            } catch (SQLException e) {
                printSQLException(e);
            }
            return customers;
        }

     */
    @Override
    public List<Customer> findAdvanced(Pageable pageable) {
        List<Customer> customers = new ArrayList<>();
        String sql = "";
        try {
            // Xử lý chỗ `o order by asc`: "order by %s %s"
            Connection connection = getConnection();
            if (pageable.getType() == -1) {
                getAllCustomer(connection, customers, pageable);
            }  else {
                getAllCustomerFilter(connection, customers, pageable);
            }
            connection.close();
        } catch (SQLException e) {
            printSQLException(e);
        }
        return customers;
    }
    private void getAllCustomer(Connection connection, List<Customer> customers, Pageable pageable) throws SQLException {
        String sql = "";
        // Truyền vào "order by %s %s"
        sql = String.format(SQL_ADVANCED_CUSTOMER, pageable.getSortField(), pageable.getOrder());
        PreparedStatement pS = connection.prepareStatement(sql);
        // "select c.*, ct.typeName, ct.delete_at\n" +
        //            "from customers c left join customer_type ct on c.typeId = ct.typeId\n" +
        //            "where c.name like ? or c.email like ? or c.address like ? \n" +
        //            "order by %s %s\n" +
        //            "limit ?, ?;";
        // Tìm kiếm theo name, email, address theo cùng dữ liệu nhập vào
        pS.setString(1, "%" + pageable.getKeyword() + "%");
        pS.setString(2, "%" + pageable.getKeyword() + "%");
        pS.setString(3, "%" + pageable.getKeyword() + "%");
        pS.setInt(4, (pageable.getPage() - 1) * pageable.getLimit());
        pS.setInt(5, pageable.getLimit());
        System.out.println("function findAdvanced:" + pS);

        ResultSet rS = pS.executeQuery();
        while (rS.next()) {
            Customer customer = getCustomerFromResultSet2(rS);
            customers.add(customer);
        }
        // Tính tổng số trang
        pS = connection.prepareStatement(SQL_ADVANCED_CUSTOMER_TOTAL);
        pS.setString(1, "%" + pageable.getKeyword() + "%");
        pS.setString(2, "%" + pageable.getKeyword() + "%");
        pS.setString(3, "%" + pageable.getKeyword() + "%");

        rS = pS.executeQuery();
        while (rS.next()) {
            //SQL_ADVANCED_CUSTOMER_TOTAL: count(*) as total
            int total = rS.getInt("total");
            // total * 1.0 để thành số thực vì'/' sẽ ra số nguyên
            pageable.setTotalPage((int)Math.ceil(total * 1.0 / pageable.getLimit()));
        }
    }
    private void getAllCustomerFilter(Connection connection, List<Customer> customers, Pageable pageable) throws SQLException {
        String sql = "";
        // Truyền vào "order by %s %s"
        sql = String.format(SQL_ADVANCED_CUSTOMER_FILTER, pageable.getSortField(), pageable.getOrder());
        PreparedStatement pS = connection.prepareStatement(sql);
        // "select c.*, ct.typeName, ct.delete_at\n" +
        //            "from customers c left join customer_type ct on c.typeId = ct.typeId\n" +
        //            "where (c.name like ? or c.email like ? or c.address like ?) and ct.typeId = ?\n" +
        //            "order by %s %s\n" +
        //            "limit ?, ?;";
        // Tìm kiếm theo name, email, address theo cùng dữ liệu nhập vào
        pS.setString(1, "%" + pageable.getKeyword() + "%");
        pS.setString(2, "%" + pageable.getKeyword() + "%");
        pS.setString(3, "%" + pageable.getKeyword() + "%");
        pS.setInt(4, pageable.getType());

        pS.setInt(5, (pageable.getPage() - 1) * pageable.getLimit());
        pS.setInt(6, pageable.getLimit());
        System.out.println("function findAdvanced:" + pS);

        ResultSet rS = pS.executeQuery();
        while (rS.next()) {
            Customer customer = getCustomerFromResultSet2(rS);
            customers.add(customer);
        }
        // Tính tổng số trang
        pS = connection.prepareStatement(SQL_ADVANCED_CUSTOMER_TOTAL_FILTER);
        pS.setString(1, "%" + pageable.getKeyword() + "%");
        pS.setString(2, "%" + pageable.getKeyword() + "%");
        pS.setString(3, "%" + pageable.getKeyword() + "%");
        pS.setInt(4, pageable.getType()); //type customer nhập vào

        rS = pS.executeQuery();
        while (rS.next()) {
            //SQL_ADVANCED_CUSTOMER_TOTAL: count(*) as total
            int total = rS.getInt("total");
            // total * 1.0 để thành số thực vì'/' sẽ ra số nguyên
            pageable.setTotalPage((int)Math.ceil(total * 1.0 / pageable.getLimit()));
        }
    }
    @Override
    public List<Customer> findAll2() {
        List<Customer> customers = new ArrayList<>();
        try {
            // lấy kết nối
            Connection connection = getConnection();
            // Dùng preparedStatement để boc cau lenh
            PreparedStatement preparedStatement = connection.prepareStatement(
                    "SELECT c.*, ct.typeName, ct.delete_at FROM customers c join customer_type ct on c.typeId = ct.typeId;");
            System.out.println("Function findAll2 " + preparedStatement);

            // Thuc thi cau lenh: executeQuery - select, executeUpdate - them/xoa/sua
            ResultSet rs = preparedStatement.executeQuery();
            // rs.next(): đọc qua từng dòng
            while (rs.next()) {
                // getInt, getString : lấy giá trị theo tên cột hoặc chỉ số cột (bat dau tu 1)
                Customer c = getCustomerFromResultSet2(rs);
                customers.add(c);
            }

        } catch (SQLException sqlException) {
            printSQLException(sqlException);
        }
        return customers;
    }

    //Them khach hang moi
    @Override
    public void save(Customer customer) {       //Them khach hang moi
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO `duan_banhang`.`customers` (`name`, `email`, `address`, `create_at`, `typeId`) VALUES (?, ?, ?, ?, ?);");
            preparedStatement.setString(1, customer.getName());
            preparedStatement.setString(2, customer.getEmail());
            preparedStatement.setString(3, customer.getAddress());
            preparedStatement.setDate(4, new java.sql.Date(customer.getCreateAt().getTime()));
            preparedStatement.setInt(5  , customer.getCustomerType().getTypeId());
            // Hien thi cau lenh truy van
            System.out.println("Function save " + preparedStatement);
            preparedStatement.executeUpdate();

            connection.close();

        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    @Override
    public Customer findById(long id) {
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("select * from customers where id = ?");

            preparedStatement.setLong(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();

            System.out.println("function findByID: " + preparedStatement);
            while (resultSet.next()){
                long idCustomer = resultSet.getLong("id");
                String name = resultSet.getString("name");
                String email = resultSet.getString("email");
                String address = resultSet.getString("address");

                Date sqlCreateAt = resultSet.getDate("create_at");
                java.util.Date createAt = null;
                if (sqlCreateAt != null) {
                    createAt = new java.util.Date(sqlCreateAt.getTime());
                }
                int typeId = resultSet.getInt("typeId");
                CustomerType customerType = iCustomerType.findById(typeId);

                Customer customer = new Customer(idCustomer, name, email, address, createAt, customerType);
                connection.close();

                return customer;
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return null;
    }
    /**
    public List<Customer> findByName(String name) {
        List<Customer> customers = new ArrayList<>();

        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("select * from `customers` where lower(`name`) like ?");

            preparedStatement.setString(1, "%" + name.toLowerCase() + "%");
            ResultSet resultSet = preparedStatement.executeQuery();

            System.out.println("function findByID: " + preparedStatement);
            while (resultSet.next()){
                long idCustomer = resultSet.getLong("id");
                String nameCustomer = resultSet.getString("name");
                String email = resultSet.getString("email");
                String address = resultSet.getString("address");
                java.sql.Date sqlCreateAt = resultSet.getDate("create_at");
                java.util.Date createAt = new Date(sqlCreateAt.getTime());
                int typeId = resultSet.getInt("typeId");
                CustomerType customerType = iCustomerType.findById(typeId);

                Customer customer = new Customer(idCustomer, name, email, address, createAt, customerType);
                customers.add(customer);
            }
            connection.close();

        } catch (SQLException e) {
            printSQLException(e);
        }
        return customers;
    }
     **/
    @Override
    public void update(long id, Customer customer) {
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE `duan_banhang`.`customers` SET `name` = ?, `email` = ?, `address` = ?, `typeId` = ? WHERE (`id` = ?);");

            preparedStatement.setString(1, customer.getName());
            preparedStatement.setString(2, customer.getEmail());
            preparedStatement.setString(3, customer.getAddress());
            preparedStatement.setInt(4, customer.getCustomerType().getTypeId());
            preparedStatement.setLong(5, customer.getId());
            preparedStatement.executeUpdate();

            System.out.println("function update"+ preparedStatement);
            connection.close();


        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    @Override
    public void remove(long id) {
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM `duan_banhang`.`customers` WHERE (`id` = ?);");

            preparedStatement.setLong(1, id);
            preparedStatement.executeUpdate();
            connection.close();

        } catch (SQLException e) {
            printSQLException(e);
        }
    }



    private Customer getCustomerFromResultSet2(ResultSet rs) throws SQLException {
        long id = rs.getLong("id");
        String name = rs.getString("name");
        String address = rs.getString("address");
        String email = rs.getString("email");
        Date createAt = rs.getDate("create_at");
        int typeId = rs.getInt("typeId");

        String typeName = rs.getString("typeName");
        java.sql.Date sqlDeleteAt = rs.getDate("delete_at");

        LocalDate deleteAt = null;
        if (sqlDeleteAt != null) {
            deleteAt = sqlDeleteAt.toLocalDate();
        }

        CustomerType customerType = new CustomerType(typeId, typeName, deleteAt);
        Customer c = new Customer(id, name, email, address, createAt, customerType);
        c.setCustomerType(customerType);
        return  c;
    }
/** DUng voi typeId
    private Customer getCustomerFromResultSet(ResultSet rs) throws SQLException {
        long id= rs.getLong("id");
        String name = rs.getString("name");
        String address = rs.getString("address");
        String email = rs.getString("email");
        Date createAt = rs.getDate("date");
        long typeId = rs.getLong("type_id");
        Customer c = new Customer(id, name, email, address, createAt, typeId);
        return  c;
    }
 **/
}
