package com.myfavsdb.dto;

import java.util.List;

public class UserSearchResponse {
    public List<UserInfo> users;
    public int totalUsers;

    public UserSearchResponse() {}

    public UserSearchResponse(List<UserInfo> users) {
        this.users = users;
        this.totalUsers = users != null ? users.size() : 0;
    }

    public static class UserInfo {
        public String email;
        public int totalItems;
        public int totalCategories;

        public UserInfo() {}

        public UserInfo(String email, int totalItems, int totalCategories) {
            this.email = email;
            this.totalItems = totalItems;
            this.totalCategories = totalCategories;
        }
    }
} 