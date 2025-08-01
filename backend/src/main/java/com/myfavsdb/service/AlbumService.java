package com.myfavsdb.service;

import com.myfavsdb.client.iTunesClient;
import com.myfavsdb.dto.AlbumSearchResult;
import com.myfavsdb.dto.iTunesResponse;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.eclipse.microprofile.rest.client.inject.RestClient;

import java.util.List;
import java.util.stream.Collectors;

@ApplicationScoped
public class AlbumService {
    
    @Inject @RestClient iTunesClient iTunesClient;
    
    public List<AlbumSearchResult> searchAlbums(String query) {
        try {
            iTunesResponse response = iTunesClient.searchAlbums(
                query,
                "album", // entity
                20,      // limit
                "US",    // country
                "music"  // media
            );
            
            if (response != null && response.results != null) {
                return response.results.stream()
                    .filter(album -> album.collectionName != null && !album.collectionName.isEmpty())
                    .collect(Collectors.toList());
            }
            
            return List.of();
        } catch (Exception e) {
            System.err.println("Erro ao buscar álbuns: " + e.getMessage());
            return List.of();
        }
    }
} 