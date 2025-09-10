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

`describe loja.clientes;`

-- Alterando estrutura
ALTER TABLE `loja`.`clientes` 
ADD COLUMN `empresa` VARCHAR(45) NULL AFTER `criado_em`;

-- Conferindo estrutura da tabela

`describe loja.clientes;`

-- Conferir a estrutura criada:
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_schema = 'loja' AND table_name = 'clientes'
ORDER BY ordinal_position;

-- Inserção de dados

```
INSERT INTO `loja`.`clientes` (`nome`, `email`, `cidade`, `empresa`) VALUES ('thiago', 'thi', 'Campinas', 'tbx');
INSERT INTO `loja`.`clientes` (`nome`, `email`, `cidade`, `empresa`) VALUES ('diego', 'diego', 'Rio', 'tbx');
INSERT INTO `loja`.`clientes` (`nome`, `email`, `cidade`, `empresa`) VALUES ('gabriel', 'gabriel', 'Divi', 'tbx');
INSERT INTO `loja`.`clientes` (`nome`, `email`, `cidade`, `empresa`) VALUES ('lu', 'lu', 'Campinas', 'tbx');
```

-- Selecionando informações

SELECT * FROM loja.clientes;
SELECT nome,cidade FROM loja.clientes;

-- Usando predicados

SELECT * FROM loja.clientes WHERE cidade = 'Campinas' ;
SELECT * FROM loja.clientes WHERE empresa = 'tbx' AND cidade = 'Campinas';

-- Usando predicados com operadores

Comparison Operators: =, !=, <, >, <=, >=.
Logical Operators: AND, OR, NOT.
Special Operators: LIKE (for pattern matching), IN (for matching values in a list), BETWEEN (for values within a range), IS NULL, IS NOT NULL.

-- Atualização de dados

UPDATE `loja`.`clientes` SET `email` = 'lu-test' WHERE (`id` = '4');

SET SQL_SAFE_UPDATES = 0;
UPDATE `loja`.`clientes` SET `empresa` = 'Toolbox Tech';

-- Removeção de dados

DELETE FROM `loja`.`clientes` WHERE (`id` = '1');

-- Ordenação de pesquisa

SELECT * FROM loja.clientes order by email desc;

-- Colocando LIMIT

SELECT * FROM loja.clientes order by email desc LIMIT 1;

-- Criando cenário de Group By

ALTER TABLE `loja`.`clientes` 
ADD COLUMN `salario` INT NULL AFTER `empresa`;

SELECT cidade, avg(salario) "sal-ant",
avg(salario)*1.10 as "sal-aju"
FROM loja.clientes group by cidade

-- Filtrando com Having

SELECT cidade, avg(salario) "sal-ant",
avg(salario)*1.10 as "sal-aju"
FROM loja.clientes 
group by cidade HAVING AVG(salario) > 95