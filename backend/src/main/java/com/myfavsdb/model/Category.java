package com.myfavsdb.model;

import io.quarkus.hibernate.orm.panache.PanacheEntity;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;

@Entity
@Table(name = "categories")
public class Category extends PanacheEntity {
    
    @NotBlank
    @Column(nullable = false)
    public String title;
    
    public Category() {}
    
    public Category(String title) {
        this.title = title;
    }
    
    public static void initializeDefaultCategories() {
        if (count() == 0) {
            persist(new Category("Movies"));
            persist(new Category("Series"));
            persist(new Category("Albums"));
            persist(new Category("Books"));
            persist(new Category("Games"));
        }
    }
} 