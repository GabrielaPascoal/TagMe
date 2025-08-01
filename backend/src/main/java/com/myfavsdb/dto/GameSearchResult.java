package com.myfavsdb.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.List;

public class GameSearchResult {
    @JsonProperty("id") public Long id;
    @JsonProperty("name") public String name;
    @JsonProperty("released") public String released;
    @JsonProperty("background_image") public String backgroundImage;
    @JsonProperty("rating") public Double rating;
    @JsonProperty("rating_top") public Integer ratingTop;
    @JsonProperty("metacritic") public Integer metacritic;
    @JsonProperty("description") public String description;
    @JsonProperty("genres") public List<GameGenre> genres;
    @JsonProperty("platforms") public List<GamePlatform> platforms;
    @JsonProperty("publishers") public List<GamePublisher> publishers;
    @JsonProperty("developers") public List<GameDeveloper> developers;
    @JsonProperty("short_screenshots") public List<GameScreenshot> shortScreenshots;

    public String getFullImageUrl() {
        if (backgroundImage != null && !backgroundImage.isEmpty()) {
            return backgroundImage;
        }
        return null;
    }

    public String getDisplayRating() {
        if (rating != null) {
            return String.format("%.1f", rating);
        }
        return "N/A";
    }

    public String getDisplayMetacritic() {
        if (metacritic != null) {
            return metacritic.toString();
        }
        return "N/A";
    }

    public String getDisplayGenres() {
        if (genres != null && !genres.isEmpty()) {
            return genres.stream()
                .map(genre -> genre.name)
                .limit(3)
                .reduce((a, b) -> a + ", " + b)
                .orElse("");
        }
        return "";
    }

    public String getDisplayPlatforms() {
        if (platforms != null && !platforms.isEmpty()) {
            return platforms.stream()
                .map(platform -> platform.platform.name)
                .limit(3)
                .reduce((a, b) -> a + ", " + b)
                .orElse("");
        }
        return "";
    }

    public static class GameGenre {
        @JsonProperty("id") public Long id;
        @JsonProperty("name") public String name;
    }

    public static class GamePlatform {
        @JsonProperty("platform") public PlatformInfo platform;
    }

    public static class PlatformInfo {
        @JsonProperty("id") public Long id;
        @JsonProperty("name") public String name;
    }

    public static class GamePublisher {
        @JsonProperty("id") public Long id;
        @JsonProperty("name") public String name;
    }

    public static class GameDeveloper {
        @JsonProperty("id") public Long id;
        @JsonProperty("name") public String name;
    }

    public static class GameScreenshot {
        @JsonProperty("id") public Long id;
        @JsonProperty("image") public String image;
    }
} 