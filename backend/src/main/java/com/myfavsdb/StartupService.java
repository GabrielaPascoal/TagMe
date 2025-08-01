package com.myfavsdb;

import com.myfavsdb.service.CategoryService;
import io.quarkus.runtime.StartupEvent;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.event.Observes;
import jakarta.inject.Inject;

@ApplicationScoped
public class StartupService {
    
    @Inject
    CategoryService categoryService;
    
    void onStart(@Observes StartupEvent ev) {
        // Inicializa as categorias padrão quando o app inicia
        categoryService.initializeDefaultCategories();
    }
} 