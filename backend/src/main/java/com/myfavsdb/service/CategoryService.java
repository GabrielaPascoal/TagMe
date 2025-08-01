package com.myfavsdb.service;

import com.myfavsdb.dto.CategoryResponse;
import com.myfavsdb.model.Category;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.transaction.Transactional;
import java.util.List;
import java.util.stream.Collectors;

@ApplicationScoped
public class CategoryService {
    
    @Transactional
    public List<CategoryResponse> getAllCategories() {
        List<Category> categories = Category.listAll();
        return categories.stream()
                .map(category -> new CategoryResponse(category.id, category.title))
                .collect(Collectors.toList());
    }
    
    @Transactional
    public void initializeDefaultCategories() {
        Category.initializeDefaultCategories();
    }
} 