package com.myfavsdb.dto;

public class CategoryResponse {
    
    public Long id;
    public String title;
    
    public CategoryResponse() {}
    
    public CategoryResponse(Long id, String title) {
        this.id = id;
        this.title = title;
    }
} 