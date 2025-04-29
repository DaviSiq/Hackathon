
-- View da Tabela Fato: Locacao
CREATE VIEW vw_fato_locacao AS
SELECT
    l.idLocacao,
    l.idCliente,
    l.idCarro,
    l.kmCarro,
    l.qtdDiaria,
    l.vlrDiaria,
    l.idVendedor,
    l.idTempo
FROM Locacao l;

-- View Dimensão Cliente
CREATE VIEW vw_dim_cliente AS
SELECT *
FROM Cliente;

-- View Dimensão Carro
CREATE VIEW vw_dim_carro AS
SELECT c.*, comb.tipoCombustivel
FROM Carro c
JOIN Combustivel comb ON c.idCombustivel = comb.idCombustivel;

-- View Dimensão Vendedor
CREATE VIEW vw_dim_vendedor AS
SELECT *
FROM Vendedor;

-- View Dimensão Tempo
CREATE VIEW vw_dim_tempo AS
SELECT *
FROM Tempo;
