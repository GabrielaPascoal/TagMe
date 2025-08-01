package com.myfavsdb.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public class ItemRequest {
    
    @NotBlank(message = "Username is required")
    @Email(message = "Invalid email format")
    public String username;
    
    @NotBlank(message = "Password is required")
    public String password;
    
    @NotNull(message = "Category ID is required")
    public Long categoryId;
    
    public ItemRequest() {}
    
    public ItemRequest(String username, String password, Long categoryId) {
        this.username = username;
        this.password = password;
        this.categoryId = categoryId;
    }
} 