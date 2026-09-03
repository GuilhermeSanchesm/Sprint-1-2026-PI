CREATE DATABASE ZYMOS;
USE ZYMOS;

CREATE TABLE empresa (
	id_empresa INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    CNPJ CHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE dorna (
	id_dorna INT AUTO_INCREMENT PRIMARY KEY,
    capacidade_litros INT NOT NULL,
    
    /* identificação: dorna 1*/
    identificacao VARCHAR(30) NOT NULL UNIQUE,
    estatus VARCHAR(20) NOT NULL,
    CONSTRAINT chk_estatus_dorna CHECK (estatus IN ('Ativo', 'Inativo'))
);

CREATE TABLE sensor (
	id_sensor INT AUTO_INCREMENT PRIMARY KEY,
    
    /*tipo: temperatura*/
    tipo VARCHAR(30) NOT NULL,
    
    /* identificação: sensor 1*/
    identificacao VARCHAR(50) NOT NULL UNIQUE,
	modelo VARCHAR(20) NOT NULL,
    estatus VARCHAR(20) NOT NULL,
    CONSTRAINT chkestatus CHECK (estatus IN('Ativo', 'Inativo' ))
); 

CREATE TABLE fermentacao (
    id_fermentacao INT PRIMARY KEY,
    tipo_cerveja VARCHAR(50) NOT NULL,
    data_inicio DATETIME NOT NULL,
    data_fim DATETIME,
    estatus VARCHAR(20) NOT NULL,
    CONSTRAINT chk_status_fermentacao CHECK (estatus IN ('Em_andamento', 'Finalizada'))
);

CREATE TABLE leitura_temperatura (
    id_leitura INT PRIMARY KEY,
    temperatura DECIMAL(4,1) NOT NULL,
    data_hora DATETIME NOT NULL
);

CREATE TABLE alerta (
    id_alerta INT PRIMARY KEY,
    nivel VARCHAR(20) NOT NULL,
    CONSTRAINT chk_nivel_alerta CHECK (nivel IN ('Normal','Atenção', 'Critico')),
    
    /* Exemplo: "Temperatura acima do ideal" */
    mensagem VARCHAR(255) NOT NULL,
    data_hora DATETIME NOT NULL
);