-- 1) Schema do exercício integrador
CREATE SCHEMA IF NOT EXISTS vendas AUTHORIZATION CURRENT_USER;

-- 2) Tabelas principais
CREATE TABLE IF NOT EXISTS vendas.clientes (
  id        BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nome      VARCHAR(120) NOT NULL,
  email     VARCHAR(120) NOT NULL UNIQUE,
  cidade    VARCHAR(100),
  criado_em TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS vendas.produtos (
  id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nome        VARCHAR(150) NOT NULL,
  preco       NUMERIC(12,2) NOT NULL CHECK (preco >= 0),
  ativo       BOOLEAN NOT NULL DEFAULT TRUE,
  criado_em   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS vendas.pedidos (
  id             BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  cliente_id     BIGINT NOT NULL REFERENCES vendas.clientes(id),
  data_pedido    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  status         VARCHAR(20) NOT NULL DEFAULT 'ABERTO',  -- ABERTO | FECHADO | CANCELADO
  valor_total    NUMERIC(14,2) NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS vendas.itens_pedido (
  id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  pedido_id    BIGINT NOT NULL REFERENCES vendas.pedidos(id) ON DELETE CASCADE,
  produto_id   BIGINT NOT NULL REFERENCES vendas.produtos(id),
  quantidade   INTEGER NOT NULL CHECK (quantidade > 0),
  preco_unit   NUMERIC(12,2) NOT NULL CHECK (preco_unit >= 0),
  subtotal     NUMERIC(14,2) NOT NULL
);

-- 3) Dados de exemplo
INSERT INTO vendas.clientes (nome, email, cidade) VALUES
  ('Alice',  'alice@example.com',  'Campinas'),
  ('Bruno',  'bruno@example.com',  'São Paulo'),
  ('Carla',  'carla@example.com',  'Rio de Janeiro')
ON CONFLICT (email) DO NOTHING;

INSERT INTO vendas.produtos (nome, preco) VALUES
  ('Camiseta', 59.90),
  ('Calça Jeans', 129.90),
  ('Tênis', 279.90)
ON CONFLICT DO NOTHING;

-- 4) Criar um pedido (Alice) e itens
-- 4.1) Criar o pedido (valor_total será recalculado após inserir itens)
INSERT INTO vendas.pedidos (cliente_id, status)
SELECT id, 'ABERTO' FROM vendas.clientes WHERE email = 'alice@example.com'
RETURNING id;

-- Suponha que o ID retornado seja 1 (confira com SELECT):
-- SELECT * FROM vendas.pedidos ORDER BY id DESC LIMIT 1;

-- 4.2) Inserir itens (usando os preços atuais dos produtos)
INSERT INTO vendas.itens_pedido (pedido_id, produto_id, quantidade, preco_unit, subtotal)
SELECT 
  p.id AS pedido_id,
  pr.id AS produto_id,
  2     AS quantidade,
  pr.preco AS preco_unit,
  (2 * pr.preco) AS subtotal
FROM vendas.pedidos p
JOIN vendas.clientes c ON c.id = p.cliente_id
JOIN vendas.produtos pr ON pr.nome = 'Camiseta'
WHERE p.id = 1 AND c.email = 'alice@example.com';

INSERT INTO vendas.itens_pedido (pedido_id, produto_id, quantidade, preco_unit, subtotal)
SELECT 
  p.id,
  pr.id,
  1,
  pr.preco,
  (1 * pr.preco)
FROM vendas.pedidos p
JOIN vendas.clientes c ON c.id = p.cliente_id
JOIN vendas.produtos pr ON pr.nome = 'Tênis'
WHERE p.id = 1 AND c.email = 'alice@example.com';

-- 4.3) Recalcular valor_total do pedido
UPDATE vendas.pedidos ped
SET valor_total = COALESCE((
  SELECT SUM(subtotal) FROM vendas.itens_pedido ip WHERE ip.pedido_id = ped.id
), 0)
WHERE ped.id = 1;

-- 5) Consultas de verificação (JOINs básicos)

-- 5.1) Listar pedidos com nome do cliente e valor total
SELECT 
  p.id AS pedido_id,
  c.nome AS cliente,
  p.data_pedido,
  p.status,
  p.valor_total
FROM vendas.pedidos p
JOIN vendas.clientes c ON c.id = p.cliente_id
ORDER BY p.id;

-- 5.2) Itens do pedido 1 com nomes de produtos
SELECT 
  ip.id AS item_id,
  pr.nome AS produto,
  ip.quantidade,
  ip.preco_unit,
  ip.subtotal
FROM vendas.itens_pedido ip
JOIN vendas.produtos pr ON pr.id = ip.produto_id
WHERE ip.pedido_id = 1;

-- 5.3) Total de pedidos por cidade (exemplo de agregação)
SELECT c.cidade, COUNT(*) AS qtd_pedidos, SUM(p.valor_total) AS soma_valor
FROM vendas.pedidos p
JOIN vendas.clientes c ON c.id = p.cliente_id
GROUP BY c.cidade
ORDER BY soma_valor DESC NULLS LAST;

-- 5.4) Fechar um pedido
UPDATE vendas.pedidos
SET status = 'FECHADO'
WHERE id = 1;
