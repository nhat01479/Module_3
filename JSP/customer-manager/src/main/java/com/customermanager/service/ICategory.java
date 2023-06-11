package com.customermanager.service;

import com.customermanager.model.Category;

import java.util.List;

public interface ICategory {
    List<Category> getAllCategory();

    Category findById(int id);
}
