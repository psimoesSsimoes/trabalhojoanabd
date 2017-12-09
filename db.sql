Create table  Consumidor  (
	numero	int(9),
	email	varchar(30)	not null,
	sexo	char(1)	not null,
	nascimento	date	not null,
	constraint Consumidor_sexo_RI001	 check (sexo in ('F','M')),
	constraint Consumidor_unique_RI002	unique(email),
	constraint pk_Consumidor	 primary key (numero)
);

Create table Dependente (
	consumidor	int(9),
	numero	int(2),
	sexo	char(1)	not null,
	nascimento	date	not null,
	constraint Dependente_sexo_RI003 check (sexo in ('F','M')),
	constraint fk_Dependente_consumidor	 foreign key (consumidor) references Consumidor(numero) on delete cascade,
	constraint pk_Dependente	 primary key (consumidor,numero)
);


Create table  Elemento  (
	codigo	char(3),
	nome	varchar(25) not null,
	pegadaEcologica	int(2) not null,
	saude	int(2) not null,
	constraint pk_Elemento	 primary key (codigo)
);

Create table  Marca  (
	numero	int(7),
	nome	varchar(30) not null,
	constraint pk_Marca	 primary key (numero)
);

Create table  Produto  (
	codigo	int(6),
	marca	int(7),
	nome	varchar(50) not null,
	tipo	char(10),
	comercioJusto	char(1),
	constraint Produto_tipo_RI004	check (tipo in ('alimentac','lar','jardim','automov','viagem','electrodom')),
	constraint Produto_comercioJusto_RI005	 check (comercioJusto in ('A','B','C','D')),
	constraint fk_Produto_marca	 foreign key (marca) references Marca(numero) on delete cascade,
	constraint pk_Produto	 primary key (codigo,marca)
);


Create table  compra  (
	produto	int(6),
	prodMarca	int(7),
	consumidor	int(9),
	quantidade	decimal(10,3)	not null,
	constraint compra_quantidade_RI006	check (quantidade>0),
	constraint fk_compra_produto	 foreign key (produto,prodMarca) references Produto(codigo,marca) on delete cascade,
	constraint fk_compra_consumidor	 foreign key (consumidor) references Consumidor(numero) on delete cascade,
	constraint pk_compra	 primary key (produto,prodMarca,consumidor)
);


Create table  composto  (
	produto	int(6),
	prodMarca	int(7),
	elemento	char(3),
	percentagem	decimal(4,1)	not null,
	constraint composto_percentagem_RI007	check (percentagem>0 and percentagem<=100),
	constraint fk_composto_produto	 foreign key (produto,prodMarca) references Produto(codigo,marca) on delete cascade,
	constraint fk_composto_elemento	 foreign key (elemento) references Elemento(codigo) on delete cascade,
	constraint pk_composto	 primary key (produto,prodMarca,elemento)
);

Insert into Consumidor ( numero, email, sexo, nascimento) values
(123456789,'sandokan@gmail.com','M','1968-07-22'),
(121212121,'marcolina@hotmail.com','F','1954-11-14'),
(987654321,'pikachu@hotmail.com','F','1972-05-24');


Insert into Dependente ( consumidor, numero, sexo, nascimento) values
(987654321,1,'F','2015-10-21'),
(987654321,2,'F','2007-08-15'),
(987654321,3,'F','1999-09-19');


Insert into Marca ( numero, nome) values
( 1, 'Rovex'),
( 2, 'Contilua'),
( 3, 'Matacao'),
( 4, 'Electrina'),
( 5, 'Medicala'),
( 6, 'Aprima'),
( 7, 'MacKing'),
( 8, 'Avax'),
( 9, 'Peskanov'),
( 10, 'Oleitao'),
( 11, 'Oscosse'),
( 12, 'Tidao'),
( 13, 'QtaMateus'),
( 14, 'Fonavoz'),
( 15, 'Carrilona'),
( 16, 'Galpina');

Insert into Produto ( codigo, marca, nome, tipo, comercioJusto) values
( 1, 1, 'lixivia', 'lar', 'B'),
( 1, 2, 'makeup', 'lar', 'C'),
( 1, 3, 'insecticida', 'lar', 'C'),
( 1, 4, 'pilhas-NICd-AA', 'lar', 'C'),
( 2, 4, 'pilhas-alcalinas-AAA', 'lar', 'C'),
( 1, 5, 'shampoo', 'lar', 'B'),
( 2, 5, 'termometro', 'lar', 'D'),
( 1, 6, 'fiambre', 'alimentac', 'C'),
( 1, 7, 'hamburger', 'alimentac', 'C'),
( 1, 8, 'fosforos', 'lar', 'D'),
( 1, 9, 'carapaus', 'alimentac', 'A'),
( 1, 10, 'azeite', 'alimentac', 'B'),
( 1, 11, 'lampada-led-10W', 'lar', 'B'),
( 1, 12, 'sabao', 'lar', 'C'),
( 1, 13, 'pato', 'alimentac', 'B'),
( 1, 14, '4ZR56', 'electrodom', 'C'),
( 1, 15, 'autocarro', 'viagem', 'B'),
( 1, 16, 'gasolina', 'viagem', 'B');


Insert into Elemento ( codigo, nome, pegadaEcologica, saude) values
( 'MER', 'mercúrio', 12, 15),
( 'CHU', 'chumbo', 7, 12),
( 'COB', 'cobre', 3, 7),
( 'CDM', 'cádmio', 8, 8),
( 'PVC', 'PVC', 4, 7),
( 'BHA', 'BHA', 10, 7),
( 'BHT', 'BHT', 11, 6),
( 'DBP', 'DBP', 10, 8),
( 'SIL', 'Silicones', 9, 3),
( 'BRM', 'brómio', 7, 9),
( 'PDF', 'PDF', 6, 7),
( 'CO2', 'CO2', 15, 7),
( 'FTA', 'Ftalatos', 8, 6),
( 'BIF', 'Bifenilos-policlorados', 5, 12),
( 'FRA', 'fragâncias-sintécticas', 11, 4);

Insert  into compra ( produto, prodMarca, consumidor, quantidade) values
( 1, 1, 123456789, 1.5),
( 1, 2, 123456789, 0.5),
( 1, 3, 123456789, 0.5),
( 1, 4, 123456789, 4),
( 2, 4, 123456789, 8),
( 1, 5, 123456789, 1),
( 2, 5, 123456789, 2),
( 1, 6, 123456789, 4),
( 1, 7, 123456789, 1),
( 1, 8, 123456789, 3),
( 1, 9, 123456789, 2),
( 1, 10, 123456789, 2),
( 1, 11, 123456789, 2),
( 1, 12, 987654321, 2),
( 1, 13, 987654321, 3),
( 1, 14, 987654321, 2),
( 1, 15, 987654321, 30),
( 1, 16, 987654321, 40),
( 1, 1, 987654321, 1.5),
( 1, 2, 987654321, 5),
( 1, 3, 987654321, 9),
( 1, 4, 987654321, 2),
( 2, 4, 987654321, 3),
( 1, 5, 987654321, 5),
( 2, 5, 987654321, 2),
( 1, 6, 121212121, 5),
( 1, 7, 121212121, 2),
( 1, 8, 121212121, 4),
( 1, 9, 121212121, 3),
( 1, 10, 121212121, 3),
( 1, 11, 121212121, 4),
( 1, 12, 121212121, 3),
( 1, 13, 121212121, 31),
( 1, 14, 121212121, 41),
( 1, 15, 121212121, 20),
( 1, 16, 121212121, 153);

Insert into composto ( produto, prodMarca, elemento, percentagem) values
( 1, 1, 'PDF', 3),
( 1, 1, 'FTA', 5),
( 1, 1, 'BIF', 4),
( 1, 1, 'FRA', 2),
( 1, 2, 'PVC', 3),
( 1, 2, 'BHA', 4),
( 1, 2, 'BHT', 5),
( 1, 2, 'DBP', 4),
( 1, 2, 'SIL', 2),
( 1, 2, 'FRA', 2),
( 1, 3, 'MER', 3),
( 1, 3, 'CHU', 4),
( 1, 3, 'PVC', 2),
( 1, 3, 'BRM', 5),
( 1, 3, 'FTA', 5),
( 1, 3, 'FRA', 5),
( 1, 4, 'CDM', 20),
( 1, 4, 'PVC', 2),
( 1, 4, 'SIL', 1),
( 1, 4, 'BRM', 2),
( 2, 4, 'PVC', 2),
( 2, 4, 'SIL', 1),
( 2, 4, 'BRM', 2),
( 1, 5, 'PVC', 8),
( 1, 5, 'BHT', 3),
( 1, 5, 'SIL', 3),
( 1, 5, 'BRM', 2),
( 1, 5, 'FRA', 5),
( 2, 5, 'MER', 10),
( 2, 5, 'COB', 3),
( 2, 5, 'PVC', 4),
( 1, 6, 'PVC', 2),
( 1, 6, 'SIL', 1),
( 1, 6, 'PDF', 2),
( 1, 6, 'FRA', 2),
( 1, 7, 'PVC', 10),
( 1, 7, 'SIL', 1),
( 1, 7, 'FTA', 5),
( 1, 7, 'BIF', 6),
( 1, 7, 'FRA', 1),
( 1, 8, 'CHU', 2),
( 1, 8, 'PVC', 1),
( 1, 8, 'BRM', 2),
( 1, 9, 'PVC', 1),
( 1, 10, 'PVC', 2),
( 1, 11, 'CHU', 2),
( 1, 11, 'COB', 4),
( 1, 11, 'PVC', 3),
( 1, 12, 'PVC', 2),
( 1, 12, 'SIL', 4),
( 1, 13, 'PVC', 1),
( 1, 14, 'MER', 3),
( 1, 14, 'COB', 4),
( 1, 14, 'CDM', 2),
( 1, 14, 'PVC', 4),
( 1, 14, 'SIL', 2),
( 1, 14, 'BRM', 2),
( 1, 15, 'MER', 1),
( 1, 15, 'CHU', 2),
( 1, 15, 'PVC', 5),
( 1, 15, 'BHA', 3),
( 1, 15, 'BRM', 2),
( 1, 15, 'CO2', 5),
( 1, 16, 'MER', 1),
( 1, 16, 'CHU', 6),
( 1, 16, 'PVC', 20),
( 1, 16, 'BHA', 3),
( 1, 16, 'BRM', 2),
( 1, 16, 'CO2', 20),
( 1, 16, 'PDF', 1);
