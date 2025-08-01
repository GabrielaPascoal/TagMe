package com.myfavsdb.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.List;

public class BookSearchResult {
    @JsonProperty("id") public String id;
    @JsonProperty("volumeInfo") public VolumeInfo volumeInfo;
    @JsonProperty("searchInfo") public SearchInfo searchInfo;

    public String getTitle() {
        return volumeInfo != null ? volumeInfo.title : "";
    }

    public String getAuthors() {
        if (volumeInfo != null && volumeInfo.authors != null && !volumeInfo.authors.isEmpty()) {
            return String.join(", ", volumeInfo.authors);
        }
        return "";
    }

    public String getDescription() {
        if (volumeInfo != null && volumeInfo.description != null) {
            return volumeInfo.description.length() > 300 
                ? volumeInfo.description.substring(0, 300) + "..." 
                : volumeInfo.description;
        }
        return "";
    }

    public String getImageUrl() {
        if (volumeInfo != null && volumeInfo.imageLinks != null) {
            return volumeInfo.imageLinks.thumbnail;
        }
        return "";
    }

    public String getPublishedDate() {
        return volumeInfo != null ? volumeInfo.publishedDate : "";
    }

    public String getIsbn() {
        if (volumeInfo != null && volumeInfo.industryIdentifiers != null) {
            return volumeInfo.industryIdentifiers.stream()
                .filter(id -> "ISBN_13".equals(id.type) || "ISBN_10".equals(id.type))
                .findFirst()
                .map(id -> id.identifier)
                .orElse("");
        }
        return "";
    }

    public String getRating() {
        if (volumeInfo != null && volumeInfo.averageRating != null) {
            return String.format("%.1f", volumeInfo.averageRating);
        }
        return "N/A";
    }

    public String getCategories() {
        if (volumeInfo != null && volumeInfo.categories != null && !volumeInfo.categories.isEmpty()) {
            return String.join(", ", volumeInfo.categories);
        }
        return "";
    }

    public static class VolumeInfo {
        @JsonProperty("title") public String title;
        @JsonProperty("authors") public List<String> authors;
        @JsonProperty("description") public String description;
        @JsonProperty("publishedDate") public String publishedDate;
        @JsonProperty("imageLinks") public ImageLinks imageLinks;
        @JsonProperty("industryIdentifiers") public List<IndustryIdentifier> industryIdentifiers;
        @JsonProperty("averageRating") public Double averageRating;
        @JsonProperty("ratingsCount") public Integer ratingsCount;
        @JsonProperty("categories") public List<String> categories;
        @JsonProperty("pageCount") public Integer pageCount;
        @JsonProperty("language") public String language;
    }

    public static class ImageLinks {
        @JsonProperty("smallThumbnail") public String smallThumbnail;
        @JsonProperty("thumbnail") public String thumbnail;
    }

    public static class IndustryIdentifier {
        @JsonProperty("type") public String type;
        @JsonProperty("identifier") public String identifier;
    }

    public static class SearchInfo {
        @JsonProperty("textSnippet") public String textSnippet;
    }
} 