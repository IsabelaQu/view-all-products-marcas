create table marcas (
	marca_id				int				primary key,
	marca_nome				varchar(50)		NOT NULL,
	marca_nacionalidade		varchar(50)
);

create table produtos (
	prod_id					int				primary key,
	prod_nome				varchar(50)		NOT NULL,
	prod_quant_estoque		int				NOT NULL			default 0,		
	prod_estoque_min		int				NOT NULL			default 0,
	prod_data_fabr			timestamp							default CURRENT_TIMESTAMP,
	prod_perecivel			boolean,
	prod_valor				DECIMAL (10,2),

	prod_marca_id			int,
	constraint fk_marcas	foreign key(prod_marca_id) references marcas(marca_id)
);


create table fornecedores (
	forn_id					int				AUTO_INCREMENT		primary key,
	forn_nome				varchar(50)		NOT NULL,
	forn_email				varchar(50)
);


create table produto_fornecedor (
	pf_prod_id					int				references produtos		(prod_id),
	pf_forn_id					int				references forncedores	(forn_id),

	primary key (pf_prod_id, pf_forn_id)
);

-- Inserir dados na tabela marcas
INSERT INTO marcas (marca_id, marca_nome, marca_nacionalidade) VALUES
(1, 'nike', 'EUA'),
(2, 'nescafe', 'Suiça'),
(3, 'oboticario', 'Alemanha'),
(4, 'vans', 'Canada'),
(5, 'heinz', 'Suiça');

-- Inserir dados na tabela produtos
INSERT INTO produtos (prod_id, prod_nome, prod_quant_estoque, prod_estoque_min, prod_data_fabr, prod_perecivel, prod_valor, prod_marca_id) VALUES
(1, 'tenis', 100, 20, '2023-04-21', FALSE, 580.90, 1),
(2, 'cafe', 50, 10, '2024-05-21', TRUE, 5.99, 2),
(3, 'hidratante', 200, 30, '2015-04-20', FALSE, 25.00, 3),
(4, 'tenis', 80, 15, '2009-04-20', FALSE, 79.89, 4),
(5, 'ketchup', 150, 25, '2024-10-05', TRUE, 12.99, 5);

-- Inserir dados na tabela fornecedores
INSERT INTO fornecedores (forn_id, forn_nome, forn_email) VALUES
(1, 'natura', 'opiniao@natura.net'),
(2, 'ambev', 'contato@ambevquersaber.com.br'),
(3, 'Ferrazo', 'consulte@ferrazanoatacado.com.br');
(4, 'vansci', 'contato@vasnci.com');
(5, 'Pepsico', 'assistencia@pepisico.com');

INSERT INTO produto_fornecedor (pf_prod_id, pf_forn_id) VALUES
(1, 1), 
(2, 2), 
(3, 3), 
(4, 4), 
(5, 5);

CREATE VIEW produtos_com_marcas AS
SELECT p.prod_id, p.prod_nome, p.prod_quant_estoque, p.prod_estoque_min, p.prod_data_fabr, p.prod_perecivel, p.prod_valor, p.marca_nome AS marca
FROM produtos p
JOIN marcas ON prod_marca_id = marca_id;


CREATE VIEW produtos_com_fornecedores AS
SELECT pf.pf_prod_id AS prod_id, f.forn_nome AS fornecedor
FROM produto_fornecedor pf
JOIN fornecedores f ON pf.pf_forn_id = f.forn_id;


CREATE VIEW produtos_com_marcas_e_fornecedores AS
SELECT p.prod_id, p.prod_nome, p.prod_quant_estoque, p.prod_estoque_min, p.prod_data_fabr, p.prod_perecivel, p.prod_valor, m.marca_nome AS marca, f.forn_nome AS fornecedor
FROM produtos p
JOIN marcas m ON p.prod_marca_id = m.marca_id
JOIN produto_fornecedor pf ON p.prod_id = pf.pf_prod_id
JOIN fornecedores f ON pf.pf_forn_id = f.forn_id;


CREATE VIEW produtos_com_estoque_abaixo_do_minimo AS
SELECT *
FROM produtos
WHERE prod_quant_estoque < prod_estoque_min;

SELECT * FROM produtos_com_marcas;

SELECT * FROM produtos_com_fornecedores;

SELECT * FROM produtos_com_fornecedores_e_marcas;

SELECT * FROM produtos_com_estoque_abaixo_minimo;

