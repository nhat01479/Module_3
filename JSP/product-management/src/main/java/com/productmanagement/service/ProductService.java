package com.productmanagement.service;

import com.productmanagement.model.Product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductService implements IProductService {
    private static Map<Integer, Product> products;
    static {
        products = new HashMap<>();
        products.put(1, new Product(1, "Coca cola", 7000, "Ngon, mát", "Coca"));
        products.put(2, new Product(2, "Huda", 10000, "Ngon, mát", "Carlsberg"));
        products.put(3, new Product(3, "Redbull", 12000, "Ngon, mát", "Redbull"));
        products.put(4, new Product(4, "Pepsi", 7000, "Ngon, mát", "Pepsi"));
        products.put(5, new Product(5, "Sữa chua vinamilk", 7000, "Ngon, mát", "Vinamilk"));
//        int id, String name, float price, String description, String manufacturer
    }

    @Override
    public List<Product> findAllProduct() {
        return new ArrayList<>(products.values());
    }

    @Override
    public void save(Product product) {
        products.put(product.getId(), product);
    }

    @Override
    public Product findById(int id) {
        return products.get(id);
    }

    @Override
    public void update(int id, Product product) {
        products.put(id, product);
    }

    @Override
    public void remove(int id) {
        products.remove(id);
    }

    @Override
    public void showProductDetail(Product product) {

    }

    @Override
    public Product findByName(String name) {
        return null;
    }
}

