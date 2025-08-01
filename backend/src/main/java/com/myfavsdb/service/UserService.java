package com.myfavsdb.service;

import com.myfavsdb.dto.UserProfileResponse;
import com.myfavsdb.dto.UserSearchResponse;
import com.myfavsdb.model.Category;
import com.myfavsdb.model.Item;
import com.myfavsdb.model.User;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.transaction.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@ApplicationScoped
public class UserService {

    @Transactional
    public UserProfileResponse getUserProfile(String email) {
        User user = User.findByEmail(email);
        if (user == null) {
            return null;
        }

        List<Item> userItems = Item.find("user.id", user.id).list();
        
        List<UserProfileResponse.ItemResponse> itemResponses = userItems.stream()
            .map(item -> {
                Category category = item.category;
                return new UserProfileResponse.ItemResponse(
                    item.id,
                    item.title,
                    item.opinion,
                    item.myRating,
                    item.imgUrl,
                    category != null ? category.title : "Unknown",
                    "category" // Default icon
                );
            })
            .collect(Collectors.toList());

        return new UserProfileResponse(email, itemResponses);
    }

    @Transactional
    public UserSearchResponse searchUsers(String query) {
        List<User> users = User.find("email like ?1", "%" + query + "%").list();
        
        List<UserSearchResponse.UserInfo> userInfos = users.stream()
            .map(user -> {
                List<Item> userItems = Item.find("user.id", user.id).list();
                int totalCategories = (int) userItems.stream()
                    .map(item -> item.category.id)
                    .distinct()
                    .count();
                
                return new UserSearchResponse.UserInfo(
                    user.email,
                    userItems.size(),
                    totalCategories
                );
            })
            .collect(Collectors.toList());

        return new UserSearchResponse(userInfos);
    }
} 