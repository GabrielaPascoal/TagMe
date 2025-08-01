package com.myfavsdb.client;

import com.myfavsdb.dto.iTunesResponse;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

@Path("/search")
@RegisterRestClient(configKey = "itunes-api")
public interface iTunesClient {
    
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    iTunesResponse searchAlbums(
        @QueryParam("term") String query,
        @QueryParam("entity") String entity,
        @QueryParam("limit") Integer limit,
        @QueryParam("country") String country,
        @QueryParam("media") String media
    );
} 