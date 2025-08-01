package com.myfavsdb.client;

import com.myfavsdb.dto.GoogleBooksResponse;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

@Path("/books/v1")
@RegisterRestClient(configKey = "google-books-api")
public interface GoogleBooksClient {
    
    @GET
    @Path("/volumes")
    @Produces(MediaType.APPLICATION_JSON)
    GoogleBooksResponse searchBooks(
        @QueryParam("q") String query,
        @QueryParam("key") String apiKey,
        @QueryParam("maxResults") Integer maxResults,
        @QueryParam("startIndex") Integer startIndex,
        @QueryParam("orderBy") String orderBy
    );
} 