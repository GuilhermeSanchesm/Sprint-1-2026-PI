CREATE DATABASE zymos;

USE zymos;

CREATE TABLE empresa(
	id_empresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cnpj CHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(8) NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO empresa (nome, cnpj, email, senha) VALUES
('Skol', '12345678901234', 'admin@skol.com.br', 'skol1234');

CREATE TABLE cerveja(
	id_cerveja INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(50) NOT NULL,
    levedura VARCHAR(100) NOT NULL,
    temperatura_min DECIMAL(4,2) NOT NULL,
    temperatura_max DECIMAL(4,2) NOT NULL
);

INSERT INTO cerveja (tipo, levedura, temperatura_min, temperatura_max) VALUES
('Ale', 'Saccharomyces cerevisiae', 15, 24);

INSERT INTO cerveja(tipo, levedura, temperatura_min, temperatura_max) VALUES
('Lager', 'Saccharomyces pastorianus', 8, 14);

CREATE TABLE dorna(
	id INT PRIMARY KEY AUTO_INCREMENT,
    cerveja INT,
    status_dorna VARCHAR(15) NOT NULL,
    CONSTRAINT chkStatusDorna 
    CHECK(status_dorna IN('Ativo', 'Inativo'))
);

INSERT INTO dorna (cerveja, status_dorna) VALUES
(1, 'Ativo'),
(1, 'Inativo'),
(2, 'Ativo'),
(2, 'Ativo');

CREATE TABLE sensor(
	id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    temperatura_celsius DECIMAL(4,2) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    dorna INT NOT NULL,
    status_sensor TINYINT(1) NOT NULL,
    data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT status_sensor 
    CHECK(status_sensor IN(0,1))
);

INSERT INTO sensor (modelo, temperatura_celsius, dorna, status_sensor) VALUES
('LM35', 15.2, 1, 1),
('LM35', 0.0, 2, 0),
('LM35', 13.8, 3, 1),
('LM35', 9.5, 4, 1);

CREATE TABLE monitoramento(
	id INT PRIMARY KEY AUTO_INCREMENT,
    sensor INT NOT NULL,
    situacao VARCHAR(15) NOT NULL,
    CONSTRAINT chkSituacao 
    CHECK(situacao IN('Bom', 'Aviso', 'Crítico'))
);

INSERT INTO monitoramento (sensor, situacao) VALUES
('1', 'Bom'),
('2', 'Crítico'),
('3', 'Aviso'),
('4', 'Bom');

SELECT
	modelo AS 'Modelo do sensor',
    temperatura_celsius AS 'Temperatura celsius',
    dorna AS 'Dorna',
    data_hora AS 'Data e hora',
    CASE
		WHEN status_sensor = 0 THEN 'Inativo'  
        ELSE 'Ativo'
	END AS 'Status do sensor'
FROM sensor;