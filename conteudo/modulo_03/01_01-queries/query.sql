-- 1) Criar um schema para o curso
CREATE SCHEMA IF NOT EXISTS loja AUTHORIZATION CURRENT_USER;

-- 2) Criar a tabela clientes
-- Obs: usamos "GENERATED ALWAYS AS IDENTITY" (PostgreSQL 10+)
CREATE TABLE IF NOT EXISTS loja.clientes (
  id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nome            VARCHAR(120)        NOT NULL,
  email           VARCHAR(120)        NOT NULL UNIQUE,
  cidade          VARCHAR(80),
  criado_em       TIMESTAMPTZ         NOT NULL DEFAULT NOW()
);

-- Conferir a estrutura criada:
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_schema = 'loja' AND table_name = 'clientes'
ORDER BY ordinal_position;
