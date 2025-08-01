package com.myfavsdb.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public class AlbumSearchResult {
    @JsonProperty("collectionId") public Long collectionId;
    @JsonProperty("collectionName") public String collectionName;
    @JsonProperty("artistName") public String artistName;
    @JsonProperty("collectionPrice") public Double collectionPrice;
    @JsonProperty("artworkUrl100") public String artworkUrl100;
    @JsonProperty("artworkUrl60") public String artworkUrl60;
    @JsonProperty("releaseDate") public String releaseDate;
    @JsonProperty("trackCount") public Integer trackCount;
    @JsonProperty("primaryGenreName") public String primaryGenreName;
    @JsonProperty("collectionExplicitness") public String collectionExplicitness;
    @JsonProperty("country") public String country;
    @JsonProperty("currency") public String currency;
    @JsonProperty("collectionViewUrl") public String collectionViewUrl;
    @JsonProperty("collectionCensoredName") public String collectionCensoredName;
    @JsonProperty("artistViewUrl") public String artistViewUrl;
    @JsonProperty("artistId") public Long artistId;
    @JsonProperty("amgArtistId") public Long amgArtistId;
    @JsonProperty("copyright") public String copyright;
    @JsonProperty("description") public String description;

    public String getFullImageUrl() {
        if (artworkUrl100 != null && !artworkUrl100.isEmpty()) {
            // Substituir 100x100 por 300x300 para melhor qualidade
            return artworkUrl100.replace("100x100", "300x300");
        }
        return null;
    }

    public String getDisplayPrice() {
        if (collectionPrice != null && collectionPrice > 0) {
            return String.format("%.2f %s", collectionPrice, currency != null ? currency : "USD");
        }
        return "Gratuito";
    }

    public String getDisplayReleaseDate() {
        if (releaseDate != null && releaseDate.length() >= 4) {
            return releaseDate.substring(0, 4); // Apenas o ano
        }
        return "";
    }

    public String getDisplayTrackCount() {
        if (trackCount != null) {
            return trackCount + " faixa" + (trackCount > 1 ? "s" : "");
        }
        return "";
    }
} 