-- 1) Adicionar coluna data_nascimento
ALTER TABLE loja.clientes
  ADD COLUMN IF NOT EXISTS data_nascimento DATE;

-- 2) Ajustar o tipo da coluna cidade para aumentar o limite
ALTER TABLE loja.clientes
  ALTER COLUMN cidade TYPE VARCHAR(100);

-- 3) Adicionar uma validação (CHECK) na data de nascimento
--    (não permitir datas futuras)
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_constraint
    WHERE conname = 'ck_clientes_data_nasc'
  ) THEN
    ALTER TABLE loja.clientes
      ADD CONSTRAINT ck_clientes_data_nasc
      CHECK (data_nascimento IS NULL OR data_nascimento <= CURRENT_DATE);
  END IF;
END$$;

-- 4) (Opcional) Remover uma coluna, se existir
-- ALTER TABLE loja.clientes DROP COLUMN IF EXISTS apelido;

-- Conferir resultado
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_schema = 'loja' AND table_name = 'clientes'
ORDER BY ordinal_position;
