CREATE DATABASE zymos;

USE zymos;

-- tabela com as informações da empresa
CREATE TABLE empresa (
	id_empresa INT PRIMARY KEY AUTO_INCREMENT,
    nome_empresa VARCHAR(100) NOT NULL,
    cnpj CHAR(14) UNIQUE,
    email_empresa VARCHAR(100) NOT NULL
); 

-- tabela com as informações da dorna
CREATE TABLE dorna (
	id_dorna INT PRIMARY KEY AUTO_INCREMENT,
    capacidade INT NOT NULL,
    lote VARCHAR(15) NOT NULL,
    status_dorna VARCHAR(15),
	CONSTRAINT chkStatus_dorna CHECK (status_dorna IN ('Disponível', 'Em uso', 'Em limpeza', 'Manutenção', 'Indisponível'))
);

-- tabela com as informações do tipo de cerveja
CREATE TABLE cerveja (
	id_cerveja INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(10) NOT NULL,
    levedura  VARCHAR(40) NOT NULL,
    temperatura_min DECIMAL (3,1) NOT NULL,
	temperatura_max DECIMAL (3,1) NOT NULL,
    temperatura_ideal DECIMAL (3,1) NOT NULL,
	tempo_fermentacao INT NOT NULL,
	CONSTRAINT chkTipo CHECK (tipo IN ('Ale', 'Lager')),
	CONSTRAINT chkLevedura CHECK (levedura IN ('Saccharomyces cerevisiae', 'Saccharomyces pastorianus', 'Saccharomyces carlsbergensis'))
);

-- tabela com as informações do sensor
CREATE TABLE sensor (
	id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(10) NOT NULL,
    temperatura DECIMAL (3,1) NOT NULL,
    status_sensor TINYINT(1) NOT NULL,
	CONSTRAINT chk_status_sensor CHECK (status_sensor IN (0,1))
);

-- tabela com as informações do lote
CREATE TABLE lote (
	id_lote INT PRIMARY KEY AUTO_INCREMENT,
    data_inicio DATETIME NOT NULL,
    data_fim DATETIME
) AUTO_INCREMENT = 100 ; 

-- tabela com as informações do relatorio dos dados coletados
CREATE TABLE log (
    id_log INT PRIMARY KEY AUTO_INCREMENT,
    temperatura DECIMAL(3,1) NOT NULL,
    sensor_responsavel INT,
    data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    tipo_alerta VARCHAR(40),
    lote_responsavel INT,
    CONSTRAINT check_alerta CHECK (tipo_alerta IN ('Temperatura acima do ideal','Temperatura abaixo da ideal'))
);
    
  -- População das tabelas para poder realizar Selects
INSERT INTO empresa (nome_empresa, cnpj, email_empresa) 
VALUES ('Itaipava', '12344321117897', 'Itaipava@gmail.com');

INSERT INTO cerveja ( tipo, levedura, temperatura_min, temperatura_max, temperatura_ideal, tempo_fermentacao) VALUES 
('Ale', 'Saccharomyces cerevisiae', 16, 24, 20, 14),
('Lager', 'Saccharomyces pastorianus', 8, 14, 10, 21);

INSERT INTO dorna (capacidade, lote, status_dorna) VALUES 
(5000, 101, 'Em uso'),
(2500, 102, 'Disponível'),
(2500, 103, 'Em limpeza');

INSERT INTO sensor (modelo, temperatura, status_sensor) VALUES 
('LM35', 29.1, 1),
('LM35', 12.8, 1),
('LM35', 0, 0);

INSERT INTO lote (data_inicio, data_fim) VALUES
 ('2026-04-23','2026-05-07' ),
 ('2026-07-12','2026-07-26'),
 ('2026-09-01', NULL);

INSERT INTO log (tipo_alerta, temperatura, sensor_responsavel, lote_responsavel, data_hora) VALUES
 ('Temperatura acima do ideal', 32.4, 3, 101, '2026-09-04'),
 ('Temperatura abaixo da ideal', 2.9, 2, 102, '2026-09-04'),
 ('Temperatura abaixo da ideal', 6.6, 1, 103, '2026-09-04');
 
 -- Select das informações da empresa
 SELECT * FROM empresa;

-- Selects exemplo para mostrar produção

SELECT  id_sensor, modelo, temperatura, 
	CASE 
		WHEN status_sensor = 0 THEN 'Desativado'
        ELSE 'Ativado'
	END  AS 'Estado do sensor'
    FROM sensor WHERE temperatura > 25; -- Mostra onde há uma fermentação com risco.

SELECT id_lote AS 'Número do lote', data_inicio AS 'Inicio Fermentação', IFNULL(data_fim, 'Em processo') AS 'Fim Fermentação'
FROM lote; -- Consulta os Lotes classificando eles em andamento ou finalizados


-- Exibe os status das dornas com as informações de produção atuais e futuras
SELECT id_dorna AS 'Dorna', status_dorna AS 'Status da Dorna',
CASE 
WHEN status_dorna = 'Disponível' 
THEN CONCAT('Lote a ser produzido: ', lote)
ELSE CONCAT(lote)
END AS 'Lote em Produção',
capacidade AS 'Capacidade (L)'
FROM dorna;

 -- select do tipo da cerveja
 
SELECT 
    id_cerveja AS 'ID',
    tipo AS 'Tipo de Fermentação',
    levedura AS 'Levedura utilizada',
    temperatura_ideal AS 'Temperatura Alvo (°C)',
    temperatura_min AS 'Temperatura mínima (°C)',
    temperatura_max AS 'Temperatura máxima (°C)'
FROM cerveja;

-- select do log

SELECT 
    id_log AS 'Nº do Registro',
    sensor_responsavel AS 'ID do Sensor',
    lote_responsavel AS 'Código do Lote Afetado',
    temperatura AS 'Temperatura Atual (°C)',
    tipo_alerta AS 'Severidade do Alerta',
    DATE_FORMAT(data_hora, '%d/%m/%Y às %H:%i:%s') AS 'Data e Hora da Ocorrência'
FROM log
WHERE tipo_alerta != 'Normal' 
  AND sensor_responsavel IN (
      SELECT id_sensor 
      FROM sensor 
      WHERE status_sensor = 'Ativo'
  )
ORDER BY data_hora DESC;