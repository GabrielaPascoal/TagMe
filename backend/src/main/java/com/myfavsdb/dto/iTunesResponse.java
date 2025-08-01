package com.myfavsdb.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.List;

public class iTunesResponse {
    @JsonProperty("resultCount") public Integer resultCount;
    @JsonProperty("results") public List<AlbumSearchResult> results;
} 