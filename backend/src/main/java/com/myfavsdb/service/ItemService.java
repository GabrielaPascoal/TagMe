package com.myfavsdb.service;

import com.myfavsdb.dto.AddItemRequest;
import com.myfavsdb.dto.ItemRequest;
import com.myfavsdb.dto.ItemResponse;
import com.myfavsdb.dto.ResponseRequest;
import com.myfavsdb.model.Category;
import com.myfavsdb.model.Item;
import com.myfavsdb.model.User;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.transaction.Transactional;
import java.util.List;
import java.util.stream.Collectors;

@ApplicationScoped
public class ItemService {
    
    private final AuthService authService;
    
    public ItemService(AuthService authService) {
        this.authService = authService;
    }
    
    @Transactional
    public List<ItemResponse> getItemsByCategory(ItemRequest request) {
        User user = authService.authenticateUser(request.username, request.password);
        if (user == null) {
            throw new RuntimeException("Usuário não autenticado");
        }
        
        List<Item> items = Item.findByUserAndCategory(user.id, request.categoryId);
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
    
    @Transactional
    public ResponseRequest addItem(AddItemRequest request) {
        try {
            User user = authService.authenticateUser(request.username, request.password);
            if (user == null) {
                return ResponseRequest.error("Usuário não autenticado", 401);
            }
            
            Category category = Category.findById(request.categoryId);
            if (category == null) {
                return ResponseRequest.error("Categoria não encontrada", 404);
            }
            
            Item item = new Item(user, category, request.title, request.imgUrl, 
                               request.opinion, request.myRating);
            item.persist();
            
            return ResponseRequest.success("Item adicionado com sucesso!");
        } catch (Exception e) {
            return ResponseRequest.error("Erro ao adicionar item", 500);
        }
    }
    
    @Transactional
    public ResponseRequest updateItem(Long itemId, AddItemRequest request) {
        try {
            User user = authService.authenticateUser(request.username, request.password);
            if (user == null) {
                return ResponseRequest.error("Usuário não autenticado", 401);
            }
            
            Item item = Item.findById(itemId);
            if (item == null) {
                return ResponseRequest.error("Item não encontrado", 404);
            }
            
            // Verifica se o item pertence ao usuário
            if (!item.user.id.equals(user.id)) {
                return ResponseRequest.error("Usuário não tem permissão para editar este item", 403);
            }
            
            Category category = Category.findById(request.categoryId);
            if (category == null) {
                return ResponseRequest.error("Categoria não encontrada", 404);
            }
            
            // Atualiza os dados do item
            item.title = request.title;
            item.imgUrl = request.imgUrl;
            item.opinion = request.opinion;
            item.myRating = request.myRating;
            item.category = category;
            
            return ResponseRequest.success("Item atualizado com sucesso!");
        } catch (Exception e) {
            return ResponseRequest.error("Erro ao atualizar item", 500);
        }
    }
    
    @Transactional
    public ResponseRequest deleteItem(Long itemId, String username, String password) {
        try {
            User user = authService.authenticateUser(username, password);
            if (user == null) {
                return ResponseRequest.error("Usuário não autenticado", 401);
            }
            
            Item item = Item.findById(itemId);
            if (item == null) {
                return ResponseRequest.error("Item não encontrado", 404);
            }
            
            // Verifica se o item pertence ao usuário
            if (!item.user.id.equals(user.id)) {
                return ResponseRequest.error("Usuário não tem permissão para remover este item", 403);
            }
            
            item.delete();
            
            return ResponseRequest.success("Item removido com sucesso!");
        } catch (Exception e) {
            return ResponseRequest.error("Erro ao remover item", 500);
        }
    }
} 