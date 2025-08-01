package com.myfavsdb.service;

import com.myfavsdb.client.TMDBClient;
import com.myfavsdb.dto.MovieSearchResult;
import com.myfavsdb.dto.TMDBResponse;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.eclipse.microprofile.rest.client.inject.RestClient;

import java.util.List;
import java.util.stream.Collectors;

@ApplicationScoped
public class MovieService {
    
    @Inject
    @RestClient
    TMDBClient tmdbClient;
    
    @ConfigProperty(name = "tmdb.api.key")
    String apiKey;
    
    public List<MovieSearchResult> searchMovies(String query) {
        try {
            if (query == null || query.trim().isEmpty()) {
                return List.of();
            }
            
            TMDBResponse response = tmdbClient.searchMulti(
                apiKey,
                query.trim(),
                "pt-BR",
                1
            );
            
            if (response != null && response.results != null) {
                return response.results.stream()
                    .filter(movie -> "movie".equals(movie.mediaType) || "tv".equals(movie.mediaType))
                    .limit(20) // Limita a 20 resultados
                    .collect(Collectors.toList());
            }
            
            return List.of();
            
        } catch (Exception e) {
            System.err.println("Erro ao buscar filmes: " + e.getMessage());
            return List.of();
        }
    }
} 