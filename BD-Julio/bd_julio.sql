CREATE DATABASE zymos_sprint1;
USE zymos_sprint1;

CREATE TABLE empresa (
    idempresa INT PRIMARY KEY AUTO_INCREMENT,
    nome_empresa VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    CNPJ CHAR(14) NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE dorna (
    id_dorna INT PRIMARY KEY AUTO_INCREMENT,
    capacidade INT NOT NULL,
    lote VARCHAR(45) NOT NULL,
    status_dorna VARCHAR(10) NOT NULL,
    CONSTRAINT chStatusDorna CHECK (status_dorna IN ('Ativo', 'Inativo'))
);

CREATE TABLE cerveja (
    id_cerveja INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(10) NOT NULL,
    levedura VARCHAR(45) NOT NULL,
    temperatura_min DECIMAL(4,2) NOT NULL,
    temperatura_max DECIMAL(4,2) NOT NULL,
    temperatura_ideal DECIMAL(4,2) NOT NULL,
    CONSTRAINT chTipoCerveja CHECK (tipo IN ('Ale', 'Lager'))
);

CREATE TABLE sensor (
    id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(45) NOT NULL,
    temperatura DECIMAL(4,2),
    statusSensor VARCHAR(10) NOT NULL,
    CONSTRAINT chStatusSensor CHECK (statusSensor IN ('Ativo', 'Inativo'))
);

CREATE TABLE lote (
    id_lote INT PRIMARY KEY AUTO_INCREMENT,
    data_inicio DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_fim DATETIME
);

CREATE TABLE log_producao (
    id_log INT PRIMARY KEY AUTO_INCREMENT,
    temperatura DECIMAL(4,2) NOT NULL,
    sensor INT NOT NULL,
    data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    tipo_alerta VARCHAR(20),
    lote INT NOT NULL,
    CONSTRAINT chTipoAlerta CHECK (tipo_alerta IN ('Normal', 'Alerta Baixo', 'Alerta Alto'))
);

USE zymos_sprint1;

INSERT INTO empresa (nome_empresa, email, senha, CNPJ) VALUES 
('Zymos Cervejaria Matriz', 'contato@zymos.com', 'senhaCripto123', '12345678000199'),
('Zymos Filial SP', 'sp@zymos.com', 'senhaCripto456', '98765432000188');

INSERT INTO dorna (capacidade, lote, status_dorna) VALUES 
(500, 'LOTE-IPA-001', 'Ativo'),
(1000, 'LOTE-PIL-002', 'Ativo'),
(500, 'LOTE-WEISS-003', 'Inativo');

INSERT INTO cerveja (tipo, levedura, temperatura_min, temperatura_max, temperatura_ideal) VALUES 
('Ale', 'IPA', 18.00, 22.00, 20.00),
('Lager', 'W-34/70', 9.00, 13.00, 11.00),
('Ale', 'IPA', 16.00, 20.00, 18.00);

INSERT INTO sensor (modelo, temperatura, statusSensor) VALUES 
('LM35', 20.50, 'Ativo'),
('LM35', 11.20, 'Ativo'),
('LM35', NULL, 'Inativo');

INSERT INTO lote (data_fim) VALUES 
(NULL),
('2026-03-06 18:00:00');

INSERT INTO log_producao (temperatura, sensor, tipo_alerta, lote) VALUES 
(20.10, 1, 'Normal', 1),
(23.50, 1, 'Alerta Alto', 1),
(11.00, 2, 'Normal', 2),
(8.20, 2, 'Alerta Baixo', 2);

-- 1 SELECT

SELECT 
    id_cerveja AS 'ID',
    tipo AS 'Tipo de Fermentação',
    levedura AS 'Estilo e Cepa',
    temperatura_ideal AS 'Temperatura Alvo (°C)'
FROM cerveja
WHERE tipo = 'Lager';

-- 2 SELECT

SELECT 
    id_log AS 'Nº do Registro',
    sensor AS 'ID do Sensor',
    lote AS 'Código do Lote Afetado',
    temperatura AS 'Temperatura Atual (°C)',
    tipo_alerta AS 'Severidade do Alerta',
    DATE_FORMAT(data_hora, '%d/%m/%Y às %H:%i:%s') AS 'Data e Hora da Ocorrência'
FROM log_producao
WHERE tipo_alerta != 'Normal' 
  AND sensor IN (
      SELECT id_sensor 
      FROM sensor 
      WHERE statusSensor = 'Ativo'
  )
ORDER BY data_hora DESC;

