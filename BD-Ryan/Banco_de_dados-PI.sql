-- BANCO DE DADOS - PESQUISA E INOVAÇÃO --

CREATE DATABASE sprint1;
USE sprint1;

CREATE TABLE empresa(
    idempresa INT PRIMARY KEY AUTO_INCREMENT,
    nome_empresa VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(15) NOT NULL,
    CNPJ CHAR(14) NOT NULL,
    data_cadastro DATETIME NOT NULL
);

CREATE TABLE dorna(
    id_dorna INT PRIMARY KEY AUTO_INCREMENT,
    capacidade INT NOT NULL,
    lote VARCHAR(45) NOT NULL,
	status_dorna VARCHAR(10) NOT NULL,
	CONSTRAINT chStatusDorna CHECK (status_dorna IN ('Ativo', 'Inativo'))
);

CREATE TABLE cerveja(
    id_cerveja INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(45) NOT NULL,
    levedura VARCHAR(30) NOT NULL,
    temperatura_min FLOAT NOT NULL,
    temperatura_max FLOAT NOT NULL,
    temperatura_ideal FLOAT NOT NULL
);

CREATE TABLE sensor(
    id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(45) NOT NULL,
    temperatura FLOAT,
    statusSensor VARCHAR(10) NOT NULL,
    CONSTRAINT chStatusSensor
    CHECK (statusSensor IN ('Ativo', 'Inativo'))
);

CREATE TABLE lote(
    id_lote INT PRIMARY KEY AUTO_INCREMENT,
    data_inicio DATETIME NOT NULL,
    data_fim DATETIME
);

CREATE TABLE log_producao(
    id_log INT PRIMARY KEY AUTO_INCREMENT,
    temperatura FLOAT,
    sensor INT,
    data_hora DATETIME,
    tipo_alerta VARCHAR(20),
    lote INT
);