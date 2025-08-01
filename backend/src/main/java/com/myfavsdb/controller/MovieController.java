package com.myfavsdb.controller;

import com.myfavsdb.dto.MovieSearchResult;
import com.myfavsdb.service.MovieService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.responses.APIResponse;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;

import java.util.List;

@Path("/api/movie")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@Tag(name = "Movie Search", description = "Endpoints para busca de filmes e séries")
public class MovieController {
    
    @Inject
    MovieService movieService;
    
    @GET
    @Path("/search")
    @Operation(summary = "Buscar filmes e séries", description = "Busca filmes e séries na API do TMDB")
    @APIResponse(responseCode = "200", description = "Lista de filmes e séries encontrados")
    @APIResponse(responseCode = "400", description = "Query inválida")
    public Response searchMovies(@QueryParam("query") String query) {
        if (query == null || query.trim().isEmpty()) {
            return Response.status(400).entity("Query é obrigatória").build();
        }
        
        List<MovieSearchResult> results = movieService.searchMovies(query);
        return Response.ok(results).build();
    }
} 