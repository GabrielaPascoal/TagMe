package com.myfavsdb.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public class MovieSearchResult {
    
    @JsonProperty("id")
    public Long id;
    
    @JsonProperty("title")
    public String title;
    
    @JsonProperty("name")
    public String name; // Para séries
    
    @JsonProperty("original_title")
    public String originalTitle;
    
    @JsonProperty("original_name")
    public String originalName; // Para séries
    
    @JsonProperty("overview")
    public String overview;
    
    @JsonProperty("poster_path")
    public String posterPath;
    
    @JsonProperty("media_type")
    public String mediaType;
    
    @JsonProperty("vote_average")
    public Double voteAverage;
    
    @JsonProperty("release_date")
    public String releaseDate;
    
    @JsonProperty("first_air_date")
    public String firstAirDate; // Para séries
    
    public MovieSearchResult() {}
    
    public String getDisplayTitle() {
        return title != null ? title : name;
    }
    
    public String getDisplayOriginalTitle() {
        return originalTitle != null ? originalTitle : originalName;
    }
    
    public String getDisplayDate() {
        return releaseDate != null ? releaseDate : firstAirDate;
    }
    
    public String getFullPosterUrl() {
        if (posterPath != null && !posterPath.isEmpty()) {
            return "https://image.tmdb.org/t/p/w500" + posterPath;
        }
        return null;
    }
    
    public String getMediaTypeDisplay() {
        if ("movie".equals(mediaType)) {
            return "Filme";
        } else if ("tv".equals(mediaType)) {
            return "Série";
        }
        return mediaType;
    }
} 