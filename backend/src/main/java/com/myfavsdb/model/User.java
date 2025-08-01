package com.myfavsdb.model;

import io.quarkus.hibernate.orm.panache.PanacheEntity;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

@Entity
@Table(name = "users")
public class User extends PanacheEntity {
    
    @NotBlank
    @Email
    @Column(unique = true, nullable = false)
    public String email;
    
    @NotBlank
    @Column(nullable = false)
    public String password;
    
    @Column(name = "created_at")
    public java.time.LocalDateTime createdAt;
    
    public User() {
        this.createdAt = java.time.LocalDateTime.now();
    }
    
    public User(String email, String password) {
        this.email = email;
        this.password = password;
        this.createdAt = java.time.LocalDateTime.now();
    }
    
    public static User findByEmail(String email) {
        return find("email", email).firstResult();
    }
    
    public static boolean authenticate(String email, String password) {
        User user = findByEmail(email);
        return user != null && user.password.equals(password);
    }
} 