package com.myfavsdb.model;

import io.quarkus.hibernate.orm.panache.PanacheEntity;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "items")
public class Item extends PanacheEntity {
    
    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    public User user;
    
    @NotNull
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id", nullable = false)
    public Category category;
    
    @NotBlank
    @Column(nullable = false)
    public String title;
    
    @Column(name = "img_url")
    public String imgUrl;
    
    @Column(columnDefinition = "TEXT")
    public String opinion;
    
    @Column(name = "my_rating")
    public String myRating;
    
    @Column(name = "created_at")
    public java.time.LocalDateTime createdAt;
    
    public Item() {
        this.createdAt = java.time.LocalDateTime.now();
    }
    
    public Item(User user, Category category, String title, String imgUrl, String opinion, String myRating) {
        this.user = user;
        this.category = category;
        this.title = title;
        this.imgUrl = imgUrl;
        this.opinion = opinion;
        this.myRating = myRating;
        this.createdAt = java.time.LocalDateTime.now();
    }
    
    public static java.util.List<Item> findByUserAndCategory(Long userId, Long categoryId) {
        return find("user.id = ?1 and category.id = ?2", userId, categoryId).list();
    }
} 