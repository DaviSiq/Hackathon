-- View de Dimensão Cliente
CREATE VIEW dim_cliente AS
SELECT
    idCliente,
    nomeCliente,
    cpfCliente,
    telCliente
FROM tb_cliente;

-- View de Dimensão Vendedor
CREATE VIEW dim_vendedor AS
SELECT
    idVendedor,
    nomeVendedor,
    cpfVendedor,
    telVendedor
FROM tb_vendedor;

-- View de Dimensão Combustível
CREATE VIEW dim_combustivel AS
SELECT
    idCombustivel,
    dsCombustivel
FROM tb_combustivel;

-- View de Dimensão Carro
CREATE VIEW dim_carro AS
SELECT
    idCarro,
    modeloCarro,
    marcaCarro,
    anoCarro,
    idCombustivel
FROM tb_carro;

-- View de Fato Locação
CREATE VIEW fato_locacao AS
SELECT
    idLocacao,
    idCliente,
    idCarro,
    idVendedor,
    dataLocacao,
    vlrDiaria
FROM tb_locacao_nor;
