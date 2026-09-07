-- BANCO DE DADOS - PESQUISA E INOVAÇÃO --

CREATE DATABASE monitoramento_temperatura;
USE monitoramento_temperatura;

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
	status_dorna TINYINT(1),
	CONSTRAINT chStatusDorna CHECK (status_dorna IN ('0','1')) -- 0 para inativo, 1 para ativo
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
    modelo VARCHAR(45) NOT NULL DEFAULT 'Arduino UNO - Sensor: LM35',
    temperatura FLOAT,
    statusSensor TINYINT(1) NOT NULL,
    CONSTRAINT chStatusSensor
    CHECK (statusSensor IN ('0', '1')) -- 0 para inativo, 1 para ativo
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
    tipo_alerta VARCHAR(50),
    CONSTRAINT ChkAlerta CHECK(tipo_alerta IN ('Alerta: Baixo', 'Normal', 'Alerta: Alto', 'Alerta: Alto - Critico', 'Alerta: Baixo - Critico')),
    lote INT
);

-- Inserts para a tabela 'empresa'
INSERT INTO empresa (nome_empresa, email, senha, CNPJ, data_cadastro) VALUES
('Cervejaria Artesanal Alpha', 'contato@alpha.com', 'SenhaAlpha123', '12345678000100', '2026-03-01 08:00:00'),
('BrewMaster Inovações', 'suporte@brewmaster.com', 'Brm@ster2026', '98765432000199', '2026-03-02 09:30:00');

-- Inserts para a tabela 'dorna'
INSERT INTO dorna (capacidade, lote, status_dorna) VALUES
(1000, 'LOTE-ALE-01', 1),
(2000, 'LOTE-LAGER-01', 1),
(1500, 'NENHUM', 0);

-- Inserts para a tabela 'cerveja' (Apenas Ale ou Lager)
INSERT INTO cerveja (tipo, levedura, temperatura_min, temperatura_max, temperatura_ideal) VALUES
('Ale', 'Saccharomyces cerevisiae', 15.0, 24.0, 18.5),
('Lager', 'Saccharomyces pastorianus', 7.0, 13.0, 10.0);

-- Inserts para a tabela 'sensor'
INSERT INTO sensor (modelo, temperatura, statusSensor) VALUES
('Arduino UNO - Sensor: LM35', 18.2, 1),
('Arduino UNO - Sensor: LM35', 9.8, 1),
('Arduino UNO - Sensor: LM35', NULL, 0);

-- Inserts para a tabela 'lote'
INSERT INTO lote (data_inicio, data_fim) VALUES
('2026-03-05 06:00:00', NULL),
('2026-03-05 07:00:00', NULL);

-- Inserts para a tabela 'log_producao'
-- Relacionando com os IDs gerados automaticamente (Sensor 1 e 2, Lote 1 e 2)
INSERT INTO log_producao (temperatura, sensor, data_hora, tipo_alerta, lote) VALUES
(18.5, 1, '2026-03-05 06:15:00', 'Normal', 1),
(25.1, 1, '2026-03-05 06:30:00', 'Alerta: Alto', 1),
(10.0, 2, '2026-03-05 07:15:00', 'Normal', 2),
(5.2, 2, '2026-03-05 07:30:00', 'Alerta: Baixo - Critico', 2);

-- Select para analisar o status do sensor
SELECT 
    id_sensor AS Codigo_Sensor,
    CONCAT(modelo, ' (Temp. Atual: ', IFNULL(temperatura, 'N/A'), '°C)') AS Detalhes_Sensor,
    CASE 
        WHEN statusSensor = 1 THEN 'Ativo e Operando'
        WHEN statusSensor = 0 THEN 'Inativo / Desconectado'
        ELSE 'Desconhecido'
    END AS Status_Formatado
FROM sensor;

-- select para analisar a temperatura ideal e status da temperatura atual
SELECT 
    id_cerveja AS Codigo,
    CONCAT(tipo, ' (Levedura: ', levedura, ')') AS Descricao_Cerveja,
    CONCAT(temperatura_ideal, '°C') AS Temp_Ideal,
    CASE 
        WHEN temperatura_min < 10.0 THEN 'Necessita de Refrigeração Intensa (Fria)'
        WHEN temperatura_min >= 10.0 AND temperatura_min <= 15.0 THEN 'Temperatura Moderada / Intermediária'
        ELSE 'Temperatura de Fermentação Mais Alta'
    END AS Categoria_Termica
FROM cerveja;


