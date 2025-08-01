package com.myfavsdb.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.List;

public class TMDBResponse {
    
    @JsonProperty("page")
    public Integer page;
    
    @JsonProperty("results")
    public List<MovieSearchResult> results;
    
    @JsonProperty("total_pages")
    public Integer totalPages;
    
    @JsonProperty("total_results")
    public Integer totalResults;
    
    public TMDBResponse() {}
} 