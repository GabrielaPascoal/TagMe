package com.myfavsdb.client;

import com.myfavsdb.dto.TMDBResponse;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;
import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

@Path("/search")
@RegisterRestClient(configKey = "tmdb-api")
public interface TMDBClient {
    
    @GET
    @Path("/multi")
    @Produces(MediaType.APPLICATION_JSON)
    TMDBResponse searchMulti(
        @QueryParam("api_key") String apiKey,
        @QueryParam("query") String query,
        @QueryParam("language") String language,
        @QueryParam("page") Integer page
    );
} 