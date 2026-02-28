-- ==========================================================
-- PROJETO: SISTEMA DE GERENCIAMENTO DE LOJA DE ELETRÔNICOS
-- Autor: Ricardo Sousa
-- Data: 2026
-- ==========================================================

-- 1. LIMPEZA E CRIAÇÃO DO BANCO (Reseta tudo para começar do zero)
DROP DATABASE IF EXISTS loja_eletronicos;
CREATE DATABASE loja_eletronicos;
USE loja_eletronicos;

-- ==========================================================
-- 2. CRIAÇÃO DAS TABELAS (ESTRUTURA)
-- ==========================================================

-- Tabela de Clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    cidade VARCHAR(50),
    email VARCHAR(100)
);

-- Tabela de Produtos (O Estoque)
CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100),
    preco DECIMAL(10,2)
);

-- Tabela de Pedidos (O Cabeçalho da Nota Fiscal)
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE,
    valor_total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Tabela de Itens (Detalhes: Quem comprou o quê)
CREATE TABLE itens_pedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_produto INT,
    quantidade INT,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

-- ==========================================================
-- 3. INSERÇÃO DE DADOS (POPULANDO O BANCO)
-- ==========================================================

-- Cadastrando Clientes
INSERT INTO clientes (nome, cidade, email) VALUES
('Ana Silva', 'São Paulo', 'ana@email.com'),
('Bruno Souza', 'Rio de Janeiro', 'bruno@email.com'),
('Carlos Lima', 'São Paulo', 'carlos@email.com'),
('Daniela Martins', 'Belo Horizonte', 'dani@email.com'),
('Eduardo Pereira', 'Curitiba', 'edu@email.com'),
('Fernanda Costa', 'São Paulo', 'fer@email.com'),
('Gabriel Santos', 'Salvador', 'gabriel@email.com'),
('Helena Silva', 'Porto Alegre', 'helena@email.com'),
('Igor Santos', 'Brasília', 'igor@email.com'),
('Julia Oliveira', 'Recife', 'julia@email.com');

-- Cadastrando Produtos
INSERT INTO produtos (nome_produto, preco) VALUES
('Notebook Dell', 3500.00),      -- ID 1
('Mouse Logi', 150.00),          -- ID 2
('Monitor LG 27', 1200.00),      -- ID 3
('Cabo HDMI', 50.00),            -- ID 4
('PC Gamer Ultra', 5000.00),     -- ID 5
('Fone Bluetooth', 250.00),      -- ID 6
('Teclado Mecânico', 300.00);    -- ID 7

-- Gerando Pedidos (Notas Fiscais)
INSERT INTO pedidos (id_cliente, data_pedido, valor_total) VALUES
(1, '2026-02-01', 3500.00), -- Pedido 1 (Ana)
(1, '2026-02-05', 150.00),  -- Pedido 2 (Ana)
(2, '2026-02-02', 1200.00), -- Pedido 3 (Bruno)
(3, '2026-02-03', 50.00),   -- Pedido 4 (Carlos)
(2, '2026-02-10', 5000.00); -- Pedido 5 (Bruno)

-- Detalhando os Itens (Conectando Pedido ao Produto)
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES 
(1, 1, 1), -- Pedido 1 levou Notebook
(2, 2, 1), -- Pedido 2 levou Mouse
(3, 3, 1), -- Pedido 3 levou Monitor
(4, 4, 1), -- Pedido 4 levou Cabo HDMI
(5, 5, 1); -- Pedido 5 levou PC Gamer

-- ==========================================================
-- 4. RELATÓRIOS E VIEWS (BUSINESS INTELLIGENCE)
-- ==========================================================

-- Criando o "Atalho" (VIEW) para o relatório completo
CREATE VIEW relatorio_vendas AS
SELECT 
    c.nome AS Cliente,
    c.cidade,
    p.data_pedido,
    prod.nome_produto AS Produto,
    prod.preco AS Preco_Unitario,
    i.quantidade,
    (prod.preco * i.quantidade) AS Total_Item
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
JOIN itens_pedido i ON p.id_pedido = i.id_pedido
JOIN produtos prod ON i.id_produto = prod.id_produto
ORDER BY p.data_pedido;

-- ==========================================================
-- 5. TESTE FINAL
-- ==========================================================

-- Exibir o relatório 
SELECT * FROM relatorio_vendas;