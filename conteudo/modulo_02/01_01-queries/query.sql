-- 1) Criar um schema para o curso
CREATE SCHEMA IF NOT EXISTS loja;

SHOW SCHEMAS;

USE loja;

SELECT DATABASE();

-- 2) Criar a tabela clientes
-- Obs: usamos "GENERATED ALWAYS AS IDENTITY" (PostgreSQL 10+)
CREATE TABLE IF NOT EXISTS loja.clientes (
  id              BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome            VARCHAR(120)        NOT NULL,
  email           VARCHAR(120)        NOT NULL UNIQUE,
  cidade          VARCHAR(80),
  criado_em       TIMESTAMP           NOT NULL DEFAULT NOW()
);

-- Conferindo estrutura da tabela

`describe loja.clientes`


-- Alterando estrutura
ALTER TABLE `loja`.`clientes` 
ADD COLUMN `empresa` VARCHAR(45) NULL AFTER `criado_em`;

-- Conferir a estrutura criada:
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_schema = 'loja' AND table_name = 'clientes'
ORDER BY ordinal_position;
