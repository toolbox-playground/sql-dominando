-- Qual banco estou usando?
SELECT current_database();

-- Qual usuário estou usando?
SELECT current_user;

-- Quais schemas existem?
SELECT schema_name FROM information_schema.schemata ORDER BY schema_name;

-- Quais tabelas existem neste banco (todas)?
SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_type = 'BASE TABLE'
ORDER BY table_schema, table_name;
