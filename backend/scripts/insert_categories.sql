-- Script para inserir categorias padrão
-- Execute este script após criar as tabelas

INSERT INTO categories (title) VALUES 
  ('Movies'),
  ('Series'), 
  ('Albums'),
  ('Books'),
  ('Games')
ON CONFLICT (id) DO NOTHING;

-- Verificar se foram inseridas
SELECT * FROM categories ORDER BY id; 