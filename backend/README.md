# MyFavsDB Backend

Backend em Java + Quarkus para o app Flutter MyFavsDB.

## Pré-requisitos

- Java 17+
- Maven 3.6+
- PostgreSQL

## Configuração do Banco de Dados

1. Crie um banco PostgreSQL chamado `myfavsdb`
2. Execute os seguintes comandos SQL:

```sql
-- Tabela de usuários
CREATE TABLE users (
  id BIGSERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de categorias
CREATE TABLE categories (
  id BIGSERIAL PRIMARY KEY,
  title VARCHAR(100) NOT NULL
);

-- Tabela de itens
CREATE TABLE items (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL,
  category_id BIGINT NOT NULL,
  title VARCHAR(255) NOT NULL,
  img_url TEXT,
  opinion TEXT,
  my_rating VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (category_id) REFERENCES categories(id)
);
```

## Configuração

1. Edite `src/main/resources/application.properties` com suas credenciais do PostgreSQL
2. As categorias padrão serão criadas automaticamente na primeira execução

## Executando o Projeto

### Desenvolvimento
```bash
./mvnw quarkus:dev
```

### Produção
```bash
./mvnw clean package
java -jar target/quarkus-app/quarkus-run.jar
```

## Endpoints

### Swagger UI
- **Swagger UI**: `http://localhost:8080/swagger-ui`
- **OpenAPI JSON**: `http://localhost:8080/openapi`

### Autenticação
- **POST** `/api/user`
  - Body: `{"username": "email", "password": "senha"}`
  - **Lógica:**
    - Se o usuário existir e a senha estiver correta → **200** (Login realizado com sucesso)
    - Se o usuário existir mas a senha estiver incorreta → **401** (Senha incorreta)
    - Se o usuário não existir → **200** (Usuário criado e logado com sucesso)

### Categorias
- **GET** `/api/category`
  - Retorna todas as categorias

### Itens
- **POST** `/api/item/get-by-category`
  - Body: `{"username": "email", "password": "senha", "categoryId": 1}`

- **POST** `/api/item/add-item`
  - Body: `{"username": "email", "password": "senha", "title": "...", "categoryId": 1, "imgUrl": "...", "opinion": "...", "myRating": "..."}`

- **PUT** `/api/item/update-item/{itemId}`
  - Atualiza um item existente
  - Body: `{"username": "email", "password": "senha", "title": "...", "categoryId": 1, "imgUrl": "...", "opinion": "...", "myRating": "..."}`

- **DELETE** `/api/item/delete-item/{itemId}?username=email&password=senha`
  - Remove um item existente

### Busca de Conteúdo

#### Filmes/Séries (TMDB)
- **GET** `/api/search/movies?query=nome_do_filme`
  - Busca filmes e séries na API do TMDB
  - Retorna lista com posters, títulos, sinopses e informações

#### Jogos (RAWG)
- **GET** `/api/search/games?query=nome_do_jogo`
  - Busca jogos na API do RAWG
  - Retorna lista com capas, descrições, plataformas, gêneros e avaliações

#### Livros (Google Books)
- **GET** `/api/search/books?query=nome_do_livro`
  - Busca livros na API do Google Books
  - Retorna lista com capas, autores, sinopses, ISBN e avaliações

#### Álbuns de Música (iTunes)
- **GET** `/api/search/albums?query=nome_do_album`
  - Busca álbuns na API do iTunes
  - Retorna lista com capas, artistas, faixas, preços e avaliações

#### Busca Global
- **GET** `/api/search/global?query=termo&username=email&password=senha`
  - Busca itens em todas as categorias do usuário por título
  - Retorna lista de itens que contêm o termo buscado

### Perfis de Usuários
- **GET** `/api/user/search?query=email_parcial`
  - Busca usuários por email (busca parcial)
  - Retorna lista de usuários com estatísticas

- **GET** `/api/user/profile/{email}`
  - Busca perfil completo de um usuário pelo email
  - Retorna todos os itens do usuário com categorias e avaliações

## Testando

1. Crie um usuário no banco:
```sql
INSERT INTO users (email, password) VALUES ('teste@email.com', 'senha123');
```

2. Teste o login:
```bash
curl -X POST http://localhost:8080/api/user \
  -H "Content-Type: application/json" \
  -d '{"username": "teste@email.com", "password": "senha123"}'
```

3. Teste buscar categorias:
```bash
curl http://localhost:8080/api/category
```

## Estrutura do Projeto

```
src/main/java/com/myfavsdb/
├── controller/          # Controllers REST
├── dto/                # Data Transfer Objects
├── model/              # Entidades JPA
├── service/            # Lógica de negócio
└── StartupService.java # Inicialização
``` 