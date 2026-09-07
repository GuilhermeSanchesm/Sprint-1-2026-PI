CREATE DATABASE zymos;

USE zymos;

CREATE TABLE empresa (
id_empresa INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (50) NOT NULL,
cnpj CHAR (14) NOT NULL
);

CREATE TABLE dorna (
id_dorna INT PRIMARY KEY AUTO_INCREMENT,
dt_inicio DATETIME NOT NULL,
dt_fim DATETIME,
status_dorna TINYINT,
CONSTRAINT chk_status_d CHECK (status_dorna IN ( 1,0))
);

CREATE TABLE sensor (
id_sensor INT PRIMARY KEY AUTO_INCREMENT,
status_sensor TINYINT,
CONSTRAINT chk_status_s CHECK (status_sensor IN ( 1,0))
);

CREATE TABLE monitoramento(
id_monitoramento INT PRIMARY KEY AUTO_INCREMENT,
temperatura VARCHAR (5) NOT NULL,
dt_hora DATETIME NOT NULL
);

CREATE TABLE tipo_cerveja (
id_cerveja INT PRIMARY KEY AUTO_INCREMENT,
cerveja VARCHAR (10) NOT NULL,
min_temp VARCHAR (5) NOT NULL,
max_temp VARCHAR (5) NOT NULL,
CONSTRAINT chk_cerveja CHECK (cerveja IN ('Lager', 'Ale'))
);

INSERT INTO empresa (nome, cnpj) VALUES
('Itaipava','12341234123412'),
('Skoll','12312312312312');

INSERT INTO dorna (dt_inicio, dt_fim, status_dorna) VALUES
('2026-06-12 08:00:00', '2026-06-22 18:00:00', 0),
('2026-06-18 10:30:00', NULL, 1),
('2026-06-18 14:15:00', NULL, 1);

INSERT INTO sensor (status_sensor) VALUES
(0),
(1),
(1);

INSERT INTO monitoramento (temperatura, dt_hora) VALUES
('12.5', '2026-09-04 16:00:00'),
('19.2', '2026-09-04 16:05:00'),
('9.8', '2026-09-04 16:10:00');

INSERT INTO tipo_cerveja (cerveja, min_temp, max_temp) VALUES
('Lager', '8.0', '16.0'),
('Ale', '15.0', '24.0');

SELECT * FROM empresa;
SELECT * FROM dorna;
SELECT * FROM sensor;
SELECT * FROM monitoramento;
SELECT * FROM tipo_cerveja;

