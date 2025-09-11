-- Inserir uma linha
INSERT INTO loja.clientes (nome, email, cidade, data_nascimento)
VALUES ('Ana Souza', 'ana.souza@example.com', 'Campinas', '1995-03-12');

-- Inserir várias linhas de uma vez
INSERT INTO loja.clientes (nome, email, cidade, data_nascimento)
VALUES 
  ('Bruno Lima', 'bruno.lima@example.com', 'São Paulo', '1988-11-02'),
  ('Carla Mendes', 'carla.mendes@example.com', 'Rio de Janeiro', '1992-07-25'),
  ('Diego Alves', 'diego.alves@example.com', 'Curitiba', NULL);

-- Conferir
SELECT * FROM loja.clientes ORDER BY id;
