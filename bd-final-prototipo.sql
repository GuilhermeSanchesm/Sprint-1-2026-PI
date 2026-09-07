CREATE DATABASE ZYMOS;

USE ZYMOS;

CREATE TABLE empresa (
	id_empresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    cnpj CHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100)
); 

CREATE TABLE dorna (
	id_dorna INT PRIMARY KEY AUTO_INCREMENT,
    capacidade INT,
    lote VARCHAR(15),
    status_dorna VARCHAR(15)
);

CREATE TABLE cerveja (
	id_cerveja INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(10),
    levedura  VARCHAR(40),
    temperatura_min DECIMAL (4,1),
	temperatura_max DECIMAL (4,1),
    temperatura_ideal DECIMAL (4,1)
);

CREATE TABLE sensor (
	id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    modelo CHAR(4),
    temperatura DECIMAL (4,1),
    status_sensor TINYINT(1),
	CONSTRAINT chk_status_sensor CHECK (status_sensor IN (0,1))
);

CREATE TABLE lote (

	id_lote INT PRIMARY KEY AUTO_INCREMENT,
    data_inicio DATETIME,
    data_fim DATETIME
    
);

CREATE TABLE log (
	
    id_log INT PRIMARY KEY AUTO_INCREMENT,
    temperatura DECIMAL(4,1),
    data_hora DATETIME,
    tipo_alerta VARCHAR(15)
    );