package com.customermanager.service;

import com.customermanager.model.Customer;

import java.util.List;

public interface ICustomerService {
    List<Customer> findAll();
    List<Customer> findAll2();
//    List<Customer> findByName(String name);
    void save(Customer customer);
    Customer findById(long id);
    void update(long id, Customer customer);
    void remove(long id);
}
