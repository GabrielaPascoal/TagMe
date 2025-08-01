package com.myfavsdb.controller;

import com.myfavsdb.dto.ResponseRequest;
import com.myfavsdb.dto.UserProfileResponse;
import com.myfavsdb.model.User;
import com.myfavsdb.service.UserService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.responses.APIResponse;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;

@Path("/api/user")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@Tag(name = "User Profile", description = "Endpoints para busca de perfis de usuários")
public class UserController {

    @Inject
    UserService userService;

    @GET
    @Path("/profile/{email}")
    @Operation(summary = "Buscar perfil de usuário", description = "Busca o perfil e itens de um usuário pelo email")
    @APIResponse(responseCode = "200", description = "Perfil encontrado com sucesso")
    @APIResponse(responseCode = "404", description = "Usuário não encontrado")
    public Response getUserProfile(@PathParam("email") String email) {
        try {
            UserProfileResponse profile = userService.getUserProfile(email);
            if (profile != null) {
                return Response.ok(profile).build();
            } else {
                return Response.status(404)
                    .entity(new ResponseRequest("Usuário não encontrado", 404))
                    .build();
            }
        } catch (Exception e) {
            return Response.status(500)
                .entity(new ResponseRequest("Erro interno do servidor: " + e.getMessage(), 500))
                .build();
        }
    }

    @GET
    @Path("/search")
    @Operation(summary = "Buscar usuários", description = "Busca usuários por email (parcial)")
    @APIResponse(responseCode = "200", description = "Lista de usuários encontrados")
    public Response searchUsers(@QueryParam("query") String query) {
        try {
            if (query == null || query.trim().isEmpty()) {
                return Response.status(400)
                    .entity(new ResponseRequest("Query de busca é obrigatória", 400))
                    .build();
            }
            
            var users = userService.searchUsers(query);
            return Response.ok(users).build();
        } catch (Exception e) {
            return Response.status(500)
                .entity(new ResponseRequest("Erro interno do servidor: " + e.getMessage(), 500))
                .build();
        }
    }
} 