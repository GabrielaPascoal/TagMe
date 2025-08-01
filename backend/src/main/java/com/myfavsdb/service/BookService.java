package com.myfavsdb.service;

import com.myfavsdb.client.GoogleBooksClient;
import com.myfavsdb.dto.BookSearchResult;
import com.myfavsdb.dto.GoogleBooksResponse;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.eclipse.microprofile.rest.client.inject.RestClient;

import java.util.List;
import java.util.stream.Collectors;

@ApplicationScoped
public class BookService {
    
    @Inject @RestClient GoogleBooksClient googleBooksClient;
    
    @ConfigProperty(name = "google.books.api.key", defaultValue = "your-google-books-api-key")
    String apiKey;
    
    public List<BookSearchResult> searchBooks(String query) {
        try {
            GoogleBooksResponse response = googleBooksClient.searchBooks(
                query,
                apiKey,
                20, // maxResults
                0,  // startIndex
                "relevance" // orderBy
            );
            
            if (response != null && response.items != null) {
                return response.items.stream()
                    .filter(book -> book.getTitle() != null && !book.getTitle().isEmpty())
                    .collect(Collectors.toList());
            }
            
            return List.of();
        } catch (Exception e) {
            System.err.println("Erro ao buscar livros: " + e.getMessage());
            return List.of();
        }
    }
} 