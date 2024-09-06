CREATE DATABASE restaurantelibbs;

USE restaurantelibbs;



CREATE TABLE Categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100)
);


CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(20)
);


CREATE TABLE Produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    preco VARCHAR(20),
    categoriaId INT,
    FOREIGN KEY (categoriaId) REFERENCES Categorias(id_categoria)
);


CREATE TABLE Pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    data_pedido DATE,
    clienteId INT,
    FOREIGN KEY (clienteId) REFERENCES Clientes(id_cliente)
);


CREATE TABLE ItensPedidos (
    id_item_pedido INT PRIMARY KEY AUTO_INCREMENT,
    quantidade INT,
    preco_unitario INT,
    pedidoId INT,
    produtoId INT,
    FOREIGN KEY (pedidoId) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (produtoId) REFERENCES Produtos(id_produto)
);


CREATE TABLE Pagamentos (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    metodo_pagamento VARCHAR(255),
    valor_pago DECIMAL(10, 2),
    data_pagamento DATE,
    pedidoId INT,
    FOREIGN KEY (pedidoId) REFERENCES Pedidos(id_pedido)
);


INSERT INTO Categorias (nome) VALUES 
('Bebidas'), 
('Comidas');


INSERT INTO Clientes (nome, email, telefone) VALUES 
('João', 'joao@email.com', '123456789'), 
('Maria', 'maria@email.com', '987654321');


INSERT INTO Produtos (nome, preco, categoriaId) VALUES 
('Coca-Cola', '5.00', 1), 
('Hambúrguer', '15.00', 2);


INSERT INTO Pedidos (data_pedido, clienteId) VALUES 
('2024-09-06', 1), 
('2024-09-07', 2);


INSERT INTO ItensPedidos (quantidade, preco_unitario, pedidoId, produtoId) VALUES 
(2, 5, 1, 1), 
(1, 15, 2, 2);

INSERT INTO Pagamentos (metodo_pagamento, valor_pago, data_pagamento, pedidoId) VALUES 
('Cartão', 10.00, '2024-09-06', 1), 
('Dinheiro', 15.00, '2024-09-07', 2);

-- Produtos -> Categorias
SELECT prod.nome, prod.preco FROM produtos AS prod
INNER JOIN categorias ON prod.categoriaId = categorias.id_categoria;

-- Clientes -> Pedidos
SELECT cli.nome, cli.email, cli.telefone, Pedidos.data_pedido
FROM clientes AS cli
INNER JOIN pedidos ON Pedidos.clienteId = cli.id_cliente;

-- Pedidos -> Clientes
SELECT ped.id_pedido, ped.data_pedido, Clientes.nome
FROM pedidos AS ped
INNER JOIN clientes ON ped.clienteId = Clientes.id_cliente;

-- itensPedidos -> Pedidos
SELECT ipe.quantidade, ipe.preco_unitario, pedidos.data_pedido
FROM ItensPedidos AS ipe
INNER JOIN pedidos ON ipe.pedidoId = pedidos.id_pedido;

-- itensPedidos -> Pedidos -> Produtos
SELECT ipe.quantidade, ipe.preco_unitario, pedidos.data_pedido, produtos.nome
FROM ItensPedidos AS ipe
INNER JOIN pedidos ON ipe.pedidoId = pedidos.id_pedido
INNER JOIN produtos ON ipe.produtoId = produtos.id_produto;



-- Categorias -> Produtos -> ItensPedidos -> Pedidos
SELECT cat.nome AS categoria_nome, 
       prod.nome AS produto_nome, 
       itens.quantidade, 
       itens.preco_unitario, 
       ped.id_pedido, 
       ped.data_pedido
FROM Categorias AS cat
INNER JOIN Produtos AS prod ON cat.id_categoria = prod.categoriaId
INNER JOIN ItensPedidos AS itens ON prod.id_produto = itens.produtoId
INNER JOIN Pedidos AS ped ON itens.pedidoId = ped.id_pedido;



 
 
