package com.customermanager.model;

import java.util.Date;

public class Customer {
    private long id;
    private String name;
    private String email;
    private String address;
    private Date createAt;

   private int typeId;
    private CustomerType customerType;



    public CustomerType getCustomerType() {
        return customerType;
    }

    public void setCustomerType(CustomerType customerType) {
        this.customerType = customerType;
    }

    public Customer() {
    }
    public Customer(long id, String name, String email, String address) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.address = address;
    }

    public Customer(long id, String name, String email, String address, int typeId) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.address = address;
        this.typeId = typeId;
    }

    public Customer(long id, String name, String email, String address, Date createAt, CustomerType customerType) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.address = address;
        this.createAt = createAt;
        this.customerType = customerType;
    }

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
