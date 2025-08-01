package com.myfavsdb.client;

import com.myfavsdb.dto.RAWGResponse;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

@Path("/api")
@RegisterRestClient(configKey = "rawg-api")
public interface RAWGClient {
    
    @GET
    @Path("/games")
    @Produces(MediaType.APPLICATION_JSON)
    RAWGResponse searchGames(
        @QueryParam("key") String apiKey,
        @QueryParam("search") String query,
        @QueryParam("page_size") Integer pageSize,
        @QueryParam("ordering") String ordering
    );
} 