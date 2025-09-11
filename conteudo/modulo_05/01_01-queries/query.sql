-- Trazer todas as colunas
SELECT * FROM loja.clientes;

-- Selecionar colunas específicas com alias
SELECT 
  id AS cliente_id, 
  nome AS cliente, 
  cidade
FROM loja.clientes;

-- Filtrar com WHERE
SELECT id, nome, cidade
FROM loja.clientes
WHERE cidade = 'São Paulo';

-- Filtro com operadores e LIKE
SELECT id, nome, email
FROM loja.clientes
WHERE email LIKE '%.com' AND nome ILIKE 'c%';  -- ILIKE = case-insensitive (PostgreSQL)

-- Ordenação e limite
SELECT id, nome, cidade
FROM loja.clientes
ORDER BY nome ASC
LIMIT 3;

-- Filtro por intervalo de datas (ex.: nascidos após 1990)
SELECT id, nome, data_nascimento
FROM loja.clientes
WHERE data_nascimento >= DATE '1990-01-01'
ORDER BY data_nascimento;
