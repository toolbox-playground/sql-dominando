-- Boas práticas: verifique antes
SELECT * FROM loja.clientes WHERE email = 'diego.alves@example.com';

-- UPDATE: alterar a cidade de um cliente
UPDATE loja.clientes
SET cidade = 'Belo Horizonte'
WHERE email = 'diego.alves@example.com';

-- Conferir
SELECT * FROM loja.clientes WHERE email = 'diego.alves@example.com';

-- DELETE: excluir um cliente específico
DELETE FROM loja.clientes
WHERE email = 'carla.mendes@example.com';

-- Conferir exclusão
SELECT * FROM loja.clientes WHERE email = 'carla.mendes@example.com';
