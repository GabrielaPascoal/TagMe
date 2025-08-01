package com.myfavsdb.service;

import com.myfavsdb.client.RAWGClient;
import com.myfavsdb.dto.GameSearchResult;
import com.myfavsdb.dto.RAWGResponse;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.eclipse.microprofile.rest.client.inject.RestClient;

import java.util.List;
import java.util.stream.Collectors;

@ApplicationScoped
public class GameService {
    
    @Inject @RestClient RAWGClient rawgClient;
    
    @ConfigProperty(name = "rawg.api.key", defaultValue = "your-rawg-api-key")
    String apiKey;
    
    public List<GameSearchResult> searchGames(String query) {
        try {
            RAWGResponse response = rawgClient.searchGames(
                apiKey,
                query,
                20, // page_size
                "-rating" // ordering by rating (highest first)
            );
            
            if (response != null && response.results != null) {
                return response.results.stream()
                    .filter(game -> game.name != null && !game.name.isEmpty())
                    .collect(Collectors.toList());
            }
            
            return List.of();
        } catch (Exception e) {
            System.err.println("Erro ao buscar jogos: " + e.getMessage());
            return List.of();
        }
    }
} 