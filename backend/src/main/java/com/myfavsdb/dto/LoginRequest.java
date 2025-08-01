package com.myfavsdb.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public class LoginRequest {
    
    @NotBlank(message = "Username is required")
    @Email(message = "Invalid email format")
    public String username;
    
    @NotBlank(message = "Password is required")
    public String password;
    
    public LoginRequest() {}
    
    public LoginRequest(String username, String password) {
        this.username = username;
        this.password = password;
    }
} 