package com.myfavsdb.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.List;

public class GoogleBooksResponse {
    @JsonProperty("kind") public String kind;
    @JsonProperty("totalItems") public Integer totalItems;
    @JsonProperty("items") public List<BookSearchResult> items;
} 