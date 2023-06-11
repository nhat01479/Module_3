package com.customermanager.model;

import java.time.LocalDate;

public class Product {
    private long id;
    private String name;
    private String description;
    private LocalDate createAt;
    private LocalDate deleteAt;

    private float price;

//    private long idCategory;
    private Category category;

    public Product() {
    }
    public Product(long id, String name, String description, LocalDate createAt, float price, Category category) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.createAt = createAt;
        this.price = price;
        this.category = category;
    }
    public Product(long id, String name, String description, LocalDate createAt, LocalDate deleteAt, float price, Category category) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.createAt = createAt;
        this.deleteAt = deleteAt;
        this.price = price;
        this.category = category;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDate getCreateAt() {
        return createAt;
    }

    public void setCreateAt(LocalDate createAt) {
        this.createAt = createAt;
    }

    public LocalDate getDeleteAt() {
        return deleteAt;
    }

    public void setDeleteAt(LocalDate deleteAt) {
        this.deleteAt = deleteAt;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }
}
