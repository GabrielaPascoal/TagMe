package com.myfavsdb.dto;

import java.util.List;

public class UserProfileResponse {
    public String email;
    public List<ItemResponse> items;
    public int totalItems;
    public int totalCategories;

    public UserProfileResponse() {}

    public UserProfileResponse(String email, List<ItemResponse> items) {
        this.email = email;
        this.items = items;
        this.totalItems = items != null ? items.size() : 0;
        this.totalCategories = items != null ? 
            (int) items.stream().map(item -> item.categoryName).distinct().count() : 0;
    }

    public static class ItemResponse {
        public Long id;
        public String title;
        public String opinion;
        public String myRating;
        public String imgUrl;
        public String categoryName;
        public String categoryIcon;

        public ItemResponse() {}

        public ItemResponse(Long id, String title, String opinion, String myRating, 
                          String imgUrl, String categoryName, String categoryIcon) {
            this.id = id;
            this.title = title;
            this.opinion = opinion;
            this.myRating = myRating;
            this.imgUrl = imgUrl;
            this.categoryName = categoryName;
            this.categoryIcon = categoryIcon;
        }
    }
} 