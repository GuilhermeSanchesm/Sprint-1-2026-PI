-- Criação do BD Zymos
CREATE DATABASE Zymos;
USE Zymos;

-- Criação das tabelas definidas 
CREATE TABLE  Empresa(
id_empresa INT PRIMARY KEY AUTO_INCREMENT,
nome_empresa VARCHAR (60) NOT NULL,
cnpj CHAR(14) UNIQUE NOT NULL,
email_empresa VARCHAR(60) UNIQUE NOT NULL,
senha_empresa VARCHAR (60) NOT NULL,
contato_responsavel VARCHAR (20) NOT NULL,
dt_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Cervejas (
id_cerveja INT PRIMARY KEY AUTO_INCREMENT,
nome_cerveja VARCHAR (45),
tipo_cerveja VARCHAR (60) NOT NULL,
levedura VARCHAR (45) NOT NULL,
temperatura_min FLOAT NOT NULL,
temperatura_max FLOAT NOT NULL,
temperatura_ideal FLOAT NOT NULL,
tempo_fermentacao INT NOT NULL,
CONSTRAINT chkTipo CHECK (tipo_cerveja IN ('Ale', 'Lager')),
CONSTRAINT chkLevedura CHECK (levedura IN ('Saccharomyces cerevisiae', 'Saccharomyces pastorianus', 'Saccharomyces carlsbergensis'))
);

CREATE TABLE Dorna (
id_dorna INT PRIMARY KEY AUTO_INCREMENT,
capacidade INT NOT NULL,
lote INT NOT NULL,
status_fermentacao VARCHAR (100) NOT NULL,
status_dorna VARCHAR(60) NOT NULL,
CONSTRAINT chkStatus_fermentacao CHECK (status_fermentacao IN('Sem Cerveja', 'Fermentando', 'Maturando', 'Pronta')),
CONSTRAINT chkStatus_dorna CHECK (status_dorna IN ('Disponível', 'Em uso', 'Em limpeza', 'Manutenção', 'Indisponível'))
) AUTO_INCREMENT = 100;


CREATE TABLE Sensor (
id_sensor INT PRIMARY KEY AUTO_INCREMENT,
modelo_sensor VARCHAR (60),
temperatura_maior FLOAT NOT NULL,
temperatura_menor FLOAT NOT NULL,
CONSTRAINT chkModelo_sensor CHECK(modelo_sensor = 'LM35')
);

CREATE TABLE Lote (
id_lote INT PRIMARY KEY AUTO_INCREMENT,
data_inicio DATETIME DEFAULT CURRENT_TIMESTAMP,
data_fim DATETIME DEFAULT NULL
);

CREATE TABLE Aviso(
id_aviso INT PRIMARY KEY AUTO_INCREMENT,
data_aviso DATETIME DEFAULT CURRENT_TIMESTAMP,
tipo_aviso VARCHAR (45),
CONSTRAINT chkAviso CHECK (tipo_aviso IN('Temperatura abaixo do ideal', 'Temperatura acima do ideal'))
);

-- População das tabelas para poder realizar Selects
INSERT INTO Empresa (nome_empresa, cnpj, email_empresa, senha_empresa, contato_responsavel) 
VALUES ('Itaipava', '12344321117897', 'Itaipava@gmail.com', 'Senha123', '11 9321-98653');

INSERT INTO Cervejas (nome_cerveja, tipo_cerveja, levedura, temperatura_min, temperatura_max, temperatura_ideal, tempo_fermentacao) VALUES 
('IPA Tradicional','Ale', 'Saccharomyces cerevisiae', 18, 22, 20, 14),
('German Pilsner', 'Lager', 'Saccharomyces pastorianus', 8, 12, 10, 21);

INSERT INTO Dorna (capacidade, lote, status_fermentacao, status_dorna) VALUES 
(5000, 101, 'Fermentando', 'Em uso'),
(2500, 102, 'Sem Cerveja', 'Disponível');

INSERT INTO Sensor (modelo_sensor, temperatura_maior, temperatura_menor) VALUES 
('LM35', 29.1, 5.4);

INSERT INTO Lote (data_inicio, data_fim) VALUES ('2026-09-01', NULL);

INSERT INTO Aviso (tipo_aviso) VALUES ('Temperatura acima do ideal');

-- Selects exemplo para mostrar produção

SELECT * FROM Sensor WHERE temperatura_maior > 25; -- Mostra onde há uma fermentação com risco.

SELECT id_lote AS 'Número do lote', data_inicio AS 'Inicio Fermentação', IFNULL(data_fim, 'Em processo') AS 'Fim Fermentação'
FROM Lote; -- Consulta os Lotes classificando eles em andamento ou finalizados


-- Exibe os status das dornas com as informações de produção atuais e futuras
SELECT id_dorna AS 'Dorna', status_dorna AS 'Status da Dorna', status_fermentacao AS 'Etapa do Processo',
CASE 
WHEN status_dorna = 'Disponível' AND status_fermentacao = 'Sem Cerveja' 
THEN CONCAT('Lote a ser produzido: ', lote)
ELSE CONCAT(lote)
END AS 'Lote em Produção',
capacidade AS 'Capacidade (L)'
FROM Dorna;