package com.myfavsdb.controller;

import com.myfavsdb.dto.AddItemRequest;
import com.myfavsdb.dto.ItemRequest;
import com.myfavsdb.dto.ItemResponse;
import com.myfavsdb.dto.ResponseRequest;
import java.util.List;
import com.myfavsdb.service.ItemService;
import jakarta.inject.Inject;
import jakarta.validation.Valid;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.responses.APIResponse;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;

@Path("/api/item")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@Tag(name = "Items", description = "Endpoints para gerenciamento de itens")
public class ItemController {
    
    @Inject
    ItemService itemService;
    
    @POST
    @Path("/get-by-category")
    @Operation(summary = "Buscar itens por categoria", description = "Retorna todos os itens de uma categoria para o usuário")
    @APIResponse(responseCode = "200", description = "Lista de itens retornada com sucesso")
    @APIResponse(responseCode = "401", description = "Usuário não autenticado")
    public Response getItemsByCategory(@Valid ItemRequest request) {
        try {
            List<ItemResponse> items = itemService.getItemsByCategory(request);
            return Response.ok(items).build();
        } catch (Exception e) {
            return Response.status(401).entity("Usuário não autenticado").build();
        }
    }
    
    @POST
    @Path("/add-item")
    @Operation(summary = "Adicionar item", description = "Adiciona um novo item para o usuário")
    @APIResponse(responseCode = "200", description = "Item adicionado com sucesso")
    @APIResponse(responseCode = "400", description = "Dados inválidos")
    public Response addItem(@Valid AddItemRequest request) {
        ResponseRequest response = itemService.addItem(request);
        return Response.status(response.statusCode).entity(response).build();
    }
    
    @PUT
    @Path("/update-item/{itemId}")
    @Operation(summary = "Editar item", description = "Atualiza um item existente")
    @APIResponse(responseCode = "200", description = "Item atualizado com sucesso")
    @APIResponse(responseCode = "404", description = "Item não encontrado")
    @APIResponse(responseCode = "403", description = "Usuário não tem permissão para editar este item")
    public Response updateItem(@PathParam("itemId") Long itemId, @Valid AddItemRequest request) {
        ResponseRequest response = itemService.updateItem(itemId, request);
        return Response.status(response.statusCode).entity(response).build();
    }
    
    @DELETE
    @Path("/delete-item/{itemId}")
    @Operation(summary = "Remover item", description = "Remove um item existente")
    @APIResponse(responseCode = "200", description = "Item removido com sucesso")
    @APIResponse(responseCode = "404", description = "Item não encontrado")
    @APIResponse(responseCode = "403", description = "Usuário não tem permissão para remover este item")
    public Response deleteItem(@PathParam("itemId") Long itemId, @QueryParam("username") String username, @QueryParam("password") String password) {
        ResponseRequest response = itemService.deleteItem(itemId, username, password);
        return Response.status(response.statusCode).entity(response).build();
    }
} 