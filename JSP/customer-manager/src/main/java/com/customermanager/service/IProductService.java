package com.customermanager.service;

import com.customermanager.model.Customer;
import com.customermanager.model.Product;

import java.util.List;

public interface IProductService {
    List<Product> findAll();
    void save(Product product);
    Product findById(long id);
    void update(long id, Product product);
    void remove(long id);
}
