package com.myfavsdb.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public class AddItemRequest {
    
    @NotBlank(message = "Username is required")
    @Email(message = "Invalid email format")
    public String username;
    
    @NotBlank(message = "Password is required")
    public String password;
    
    @NotBlank(message = "Title is required")
    public String title;
    
    @NotNull(message = "Category ID is required")
    public Long categoryId;
    
    public String imgUrl;
    public String opinion;
    public String myRating;
    
    public AddItemRequest() {}
    
    public AddItemRequest(String username, String password, String title, Long categoryId, 
                         String imgUrl, String opinion, String myRating) {
        this.username = username;
        this.password = password;
        this.title = title;
        this.categoryId = categoryId;
        this.imgUrl = imgUrl;
        this.opinion = opinion;
        this.myRating = myRating;
    }
} 