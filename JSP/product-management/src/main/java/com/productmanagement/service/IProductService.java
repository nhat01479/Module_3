package com.productmanagement.service;

import com.productmanagement.model.Product;

import java.util.List;

public interface IProductService {
    List<Product> findAllProduct();
    void save(Product product);
    Product findById(int id);
    void update(int id, Product product);
    void remove(int id);
    void showProductDetail(Product product);
    Product findByName(String name);



}
