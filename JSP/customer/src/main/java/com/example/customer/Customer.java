package com.example.customer;

public class Customer {
    private String name;
    private String dob;
    private String add;
    private String img;

    public Customer() {
    }

    public Customer(String name, String dob, String add, String img) {
        this.name = name;
        this.dob = dob;
        this.add = add;
        this.img = img;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getAdd() {
        return add;
    }

    public void setAdd(String add) {
        this.add = add;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }
}

