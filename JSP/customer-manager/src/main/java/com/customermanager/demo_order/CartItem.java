package com.customermanager.demo_order;

import com.customermanager.model.Product;

public class CartItem {
    private int id;
    private int idCart;
    private int idProduct;
    private int quantity;

    public CartItem() {
    }

    public CartItem(int id, int idCart, int idProduct, int quantity) {
        this.id = id;
        this.idCart = idCart;
        this.idProduct = idProduct;
        this.quantity = quantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdCart() {
        return idCart;
    }

    public void setIdCart(int idCart) {
        this.idCart = idCart;
    }

    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
