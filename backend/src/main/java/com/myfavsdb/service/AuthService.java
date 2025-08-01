package com.myfavsdb.service;

import com.myfavsdb.dto.LoginRequest;
import com.myfavsdb.dto.ResponseRequest;
import com.myfavsdb.model.User;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.transaction.Transactional;

@ApplicationScoped
public class AuthService {
    
    @Transactional
    public ResponseRequest login(LoginRequest request) {
        try {
            // Busca o usuário pelo email
            User existingUser = User.findByEmail(request.username);
            
            if (existingUser != null) {
                // Usuário existe - verifica a senha
                if (existingUser.password.equals(request.password)) {
                    return ResponseRequest.success("Login realizado com sucesso!");
                } else {
                    return ResponseRequest.error("Senha incorreta", 401);
                }
            } else {
                // Usuário não existe - cria um novo usuário
                User newUser = new User(request.username, request.password);
                newUser.persist();
                return ResponseRequest.success("Usuário criado e logado com sucesso!");
            }
        } catch (Exception e) {
            return ResponseRequest.error("Erro interno do servidor", 500);
        }
    }
    
    @Transactional
    public User authenticateUser(String email, String password) {
        if (User.authenticate(email, password)) {
            return User.findByEmail(email);
        }
        return null;
    }
} 