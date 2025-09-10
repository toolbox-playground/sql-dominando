
## 🏗️ Estrutura do Banco

O banco simula uma plataforma de e-commerce com streaming de conteúdo digital.

### Tabelas principais

| Tabela                     | Descrição |
|---------------------------|-----------|
| `customers`               | Clientes cadastrados |
| `products`                | Produtos vendidos pela plataforma |
| `orders`                  | Pedidos realizados |
| `order_items`             | Itens de cada pedido |
| `media_content`           | Conteúdo de mídia disponível (filmes, séries, podcasts) |
| `customer_streaming_history` | Histórico de visualização de conteúdo digital |

## 📦 Volume de Dados Gerados

| Tabela                     | Registros |
|---------------------------|-----------|
| `customers`               | 10.000    |
| `products`                | 2.000     |
| `orders`                  | 50.000    |
| `order_items`             | 200.000   |
| `media_content`           | 1.000     |
| `customer_streaming_history` | 50.000 |

## 📁 Estrutura dos Arquivos

```bash
📁 modulo_02/
├── estrutura.sql         # Criação das tabelas
├── dados.sql           # Massa de dados em SQL
├── queries.sql           # Consultas propositalmente não otimizadas
├── optimized_queries.sql     # Consultas otimizadas (opcional)
```