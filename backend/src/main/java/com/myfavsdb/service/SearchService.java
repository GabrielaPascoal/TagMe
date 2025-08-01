package com.myfavsdb.service;

import com.myfavsdb.dto.ItemResponse;
import com.myfavsdb.model.Item;
import com.myfavsdb.model.User;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.util.List;
import java.util.stream.Collectors;

@ApplicationScoped
public class SearchService {
    
    @Inject
    AuthService authService;
    
    public List<ItemResponse> globalSearch(String query, String username, String password) {
        User user = authService.authenticateUser(username, password);
        if (user == null) {
            throw new RuntimeException("Usuário não autenticado");
        }
        
        // Busca itens do usuário que contenham a query no título (case insensitive)
        List<Item> items = Item.find("user.id = ?1 and LOWER(title) LIKE LOWER(?2)", 
                                    user.id, "%" + query + "%").list();
        
        return items.stream()
                .map(item -> new ItemResponse(
                    item.id, 
                    item.title, 
                    item.imgUrl, 
                    item.opinion, 
                    item.myRating,
                    item.category.title))
                .collect(Collectors.toList());
    }
} 