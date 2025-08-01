package com.myfavsdb.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.List;

public class RAWGResponse {
    @JsonProperty("count") public Integer count;
    @JsonProperty("next") public String next;
    @JsonProperty("previous") public String previous;
    @JsonProperty("results") public List<GameSearchResult> results;
} 