package com.myfavsdb.dto;

public class ItemResponse {
    
    public Long id;
    public String title;
    public String imgUrl;
    public String opinion;
    public String myRating;
    public String category;
    
    public ItemResponse() {}
    
    public ItemResponse(Long id, String title, String imgUrl, String opinion, String myRating, String category) {
        this.id = id;
        this.title = title;
        this.imgUrl = imgUrl;
        this.opinion = opinion;
        this.myRating = myRating;
        this.category = category;
    }
} 