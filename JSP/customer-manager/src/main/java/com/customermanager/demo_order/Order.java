package com.customermanager.demo_order;

import java.util.Date;
import java.util.List;

public class Order {
    private int id;
    private Date createAt;
    private long idCustomer;
    private float discount;
    private float subTotal;
    private boolean isPaid = false;
    private List<OrderItem> orderItems;

    public Order() {
    }

    public Order(int id, Date createAt, long idCustomer, float discount, float subTotal, List<OrderItem> orderItems) {
        this.id = id;
        this.createAt = createAt;
        this.idCustomer = idCustomer;
        this.discount = discount;
        this.subTotal = subTotal;
        this.orderItems = orderItems;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    public long getIdCustomer() {
        return idCustomer;
    }

    public void setIdCustomer(long idCustomer) {
        this.idCustomer = idCustomer;
    }

    public float getDiscount() {
        return discount;
    }

    public void setDiscount(float discount) {
        this.discount = discount;
    }

    public float getSubTotal() {
        return subTotal;
    }

    public void setSubTotal(float subTotal) {
        this.subTotal = subTotal;
    }

    public Boolean getIsPaid() {
        return isPaid;
    }

    public void setIsPaid(Boolean isPaid) {
        this.isPaid = isPaid;
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }
}
