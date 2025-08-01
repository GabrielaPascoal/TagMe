package com.myfavsdb.controller;

import com.myfavsdb.dto.CategoryResponse;
import com.myfavsdb.service.CategoryService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

@Path("/api/category")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class CategoryController {
    
    @Inject
    CategoryService categoryService;
    
    @GET
    public Response getAllCategories() {
        try {
            List<CategoryResponse> categories = categoryService.getAllCategories();
            return Response.ok(categories).build();
        } catch (Exception e) {
            return Response.status(500).entity("Erro ao buscar categorias").build();
        }
    }
} 