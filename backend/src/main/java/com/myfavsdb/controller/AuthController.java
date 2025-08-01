package com.myfavsdb.controller;

import com.myfavsdb.dto.LoginRequest;
import com.myfavsdb.dto.ResponseRequest;
import com.myfavsdb.service.AuthService;
import jakarta.inject.Inject;
import jakarta.validation.Valid;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.responses.APIResponse;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;

@Path("/api/user")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@Tag(name = "Authentication", description = "Endpoints para autenticação")
public class AuthController {
    
    @Inject
    AuthService authService;
    
    @POST
    @Operation(summary = "Fazer login", description = "Autentica um usuário com email e senha. Se o usuário não existir, cria um novo usuário automaticamente.")
    @APIResponse(responseCode = "200", description = "Login realizado com sucesso ou usuário criado e logado")
    @APIResponse(responseCode = "401", description = "Senha incorreta")
    public Response login(@Valid LoginRequest request) {
        ResponseRequest response = authService.login(request);
        return Response.status(response.statusCode).entity(response).build();
    }
} 