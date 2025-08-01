package com.myfavsdb.controller;

import com.myfavsdb.dto.AlbumSearchResult;
import com.myfavsdb.dto.BookSearchResult;
import com.myfavsdb.dto.GameSearchResult;
import com.myfavsdb.dto.MovieSearchResult;
import com.myfavsdb.service.AlbumService;
import com.myfavsdb.service.BookService;
import com.myfavsdb.service.GameService;
import com.myfavsdb.service.MovieService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.responses.APIResponse;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;

import java.util.List;
import com.myfavsdb.dto.ItemResponse;
import com.myfavsdb.service.SearchService;

@Path("/api/search")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@Tag(name = "Search", description = "Endpoints para busca em diferentes APIs")
public class SearchController {

    @Inject GameService gameService;
    @Inject BookService bookService;
    @Inject AlbumService albumService;
    @Inject MovieService movieService;
    @Inject SearchService searchService;

    @GET
    @Path("/games")
    @Operation(summary = "Buscar jogos", description = "Busca jogos na API do RAWG")
    @APIResponse(responseCode = "200", description = "Lista de jogos encontrados")
    @APIResponse(responseCode = "400", description = "Query inválida")
    public Response searchGames(@QueryParam("query") String query) {
        if (query == null || query.trim().isEmpty()) {
            return Response.status(400)
                .entity("Query de busca é obrigatória")
                .build();
        }

        List<GameSearchResult> games = gameService.searchGames(query);
        return Response.ok(games).build();
    }

    @GET
    @Path("/books")
    @Operation(summary = "Buscar livros", description = "Busca livros na API do Google Books")
    @APIResponse(responseCode = "200", description = "Lista de livros encontrados")
    @APIResponse(responseCode = "400", description = "Query inválida")
    public Response searchBooks(@QueryParam("query") String query) {
        if (query == null || query.trim().isEmpty()) {
            return Response.status(400)
                .entity("Query de busca é obrigatória")
                .build();
        }

        List<BookSearchResult> books = bookService.searchBooks(query);
        return Response.ok(books).build();
    }

    @GET
    @Path("/albums")
    @Operation(summary = "Buscar álbuns", description = "Busca álbuns na API do iTunes")
    @APIResponse(responseCode = "200", description = "Lista de álbuns encontrados")
    @APIResponse(responseCode = "400", description = "Query inválida")
    public Response searchAlbums(@QueryParam("query") String query) {
        if (query == null || query.trim().isEmpty()) {
            return Response.status(400)
                .entity("Query de busca é obrigatória")
                .build();
        }

        List<AlbumSearchResult> albums = albumService.searchAlbums(query);
        return Response.ok(albums).build();
    }

    @GET
    @Path("/movies")
    @Operation(summary = "Buscar filmes/séries", description = "Busca filmes e séries na API do TMDB")
    @APIResponse(responseCode = "200", description = "Lista de filmes/séries encontrados")
    @APIResponse(responseCode = "400", description = "Query inválida")
    public Response searchMovies(@QueryParam("query") String query) {
        if (query == null || query.trim().isEmpty()) {
            return Response.status(400)
                .entity("Query de busca é obrigatória")
                .build();
        }

        List<MovieSearchResult> movies = movieService.searchMovies(query);
        return Response.ok(movies).build();
    }

    @GET
    @Path("/global")
    @Operation(summary = "Busca global", description = "Busca itens em todas as categorias por título")
    @APIResponse(responseCode = "200", description = "Lista de itens encontrados")
    @APIResponse(responseCode = "401", description = "Usuário não autenticado")
    public Response globalSearch(@QueryParam("query") String query, 
                                @QueryParam("username") String username, 
                                @QueryParam("password") String password) {
        try {
            List<ItemResponse> items = searchService.globalSearch(query, username, password);
            return Response.ok(items).build();
        } catch (Exception e) {
            return Response.status(401).entity("Usuário não autenticado").build();
        }
    }
} 