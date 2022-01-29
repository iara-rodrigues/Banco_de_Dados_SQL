CREATE SCHEMA ex1;

CREATE TABLE categories (
	id numeric PRIMARY KEY, 
	name varchar(50)
);

CREATE TABLE products (
  id numeric PRIMARY KEY,
  name varchar(50),
  amount numeric,
  price numeric(7,2),
  id_categories numeric REFERENCES categories (id)
);

CREATE TABLE clients (
  id numeric PRIMARY KEY,
  name varchar(50),
  cpf numeric
);

CREATE TABLE orders (
  id numeric PRIMARY KEY,
  id_client numeric REFERENCES clients (id),
  date_order varchar(50),
  status varchar(50)
);


CREATE TABLE orders_products (
  order_id numeric PRIMARY KEY REFERENCES orders (id),
  product_id NUMERIC REFERENCES products (id),
  units_sold NUMERIC
);

INSERT INTO categories (id, name)
VALUES 
  (1,	'wood'),
  (2,	'luxury'),
  (3,	'vintage'),
  (4,	'modern'),
  (5,	'super luxury'),
  (6,	'futurist'),
  (7,	'sports'),
  (8,	'office'),
  (9,	'home office'),
  (10,	'gamer');
  
INSERT INTO products (id, name, amount, price, id_categories)
VALUES 
  (1,	'Two-doors wardrobe', 100,	800,	1),
  (2,	'Dining table',	1000,	560,	3),
  (3,	'Towel holder',	10000,	25.50,	4),
  (4,	'Computer Desk',	350,	320.50,	2),
  (5,	'Chair',	3000,	210.64,	4),
  (6,	'Single bed',	750,	460,	1),
  (7,	'Laser Gun', 38, 9999, 6),
  (8,	'RGB Led Strip', 200, 99, 10),
  (9,	'Gamer Chair', 200, 149, 10),
  (10,	'Office Desk', 3999, 70, 8),
  (11,	'Cheese trap', 0, 2, 1),
  (12,	'Synthetic grass 1x1m', 100, 20, 7);
  
INSERT INTO clients (id, name, cpf)
VALUES 
  (1,	'Lisa Simpson', 38263212006),
  (2,	'Rick', 78177938088),
  (3,	'Morty', 34529886000),
  (4,	'Tom', 93510630033),
  (5,	'Jerry', 13909436072),
  (6,	'Alexandre', 70913824046);
  
INSERT INTO orders (id, id_client, date_order, status)
VALUES 
  (1,	1, '17/01/2022', 'preparing shipment'),
  (2,	6, '17/01/2022', 'waiting payment'),
  (3,	6, '17/01/2022', 'waiting payment'),
  (4,	4, '17/01/2022', 'finish'),
  (5,	3, '17/01/2022', 'finish'),
  (6,	2, '17/01/2022', 'Order dispatched');
  
INSERT INTO orders_products (order_id, product_id, units_sold)
VALUES
  (1,	10, 1),
  (2,	09,  2),
  (3,	08,	180),
  (4,	11, 5000),
  (5,	12, 10),
  (6,	07, 3);
  
#Exercicio 1, Letra A
/*Retornar uma lista que apresente o nome das categorias e a quantidade de
produtos totais em cada categoria.*/

SELECT C.name, sum(P.amount) 
FROM products P JOIN categories C
ON P.id_categories = C.id
GROUP BY P.id_categories;  

/*Estou selecionando a coluna "name" da tabela categories e fazendo a soma 
da coluna "amount" da tabela products, o GROUP BY foi usado para que eu fizesse 
a soma da coluna "amount" somente de itens que possuem o mesmo id_categories,
que foi o que o exercício pediu. E o ON foi usado para alinhar as colunas onde
o P.id_categories for igual ao C.id, por isso conseguimos ver, na tabela, o valor
da soma em frente ao "wood" sendo exatamente a soma de produtos dessa categoria.*/

#Exercicio 1, Letra B
/*Apresentar um relatório com as 4 categorias que mais tiveram produtos
comprados.*/

SELECT C.id, C.name, sum(OP.units_sold)
FROM categories C
JOIN orders_products OP
JOIN products P
ON OP.product_id = P.id AND P.id_categories = C.id
GROUP BY P.id_categories
ORDER BY sum(OP.units_sold) DESC LIMIT 4; 

/*Nesse exercício eu selecionei para mostrar o C.id, C. nome e a soma das unidades
vendidas de cada categoria. Portanto, para isso, precisei acessar as tabelas categories,
orders_products e products. Pode-se perceber que na tabela, não foi exibido nada de 
products, mas precisei acessá-la para fazer a comparação dos ids. Com o ON coloquei 
que eu queria alinhar onde o  OP.product_id fosse igual ao P.id, para eu achar esse 
mesmo produto vendido na tabela de produtos existentes e, a partir daí, comparar 
P.id_categories e o C.id para eu achar de qual categoria aquele produto é.
O GROUP BY foi usado para que a soma fosse feita entre os produtos de id_categories
iguais e o ORDER BY foi para ordenar de maneira decrescente (DESC) o valor da soma e
mostrar somente os 4 primeiros (LIMIT 4). */