-- Criação das tabelas normalizadas conforme estrutura atual

-- Tabela de Clientes
CREATE TABLE tb_cliente (
    idCliente INTEGER PRIMARY KEY,
    nomeCliente TEXT NOT NULL,
    cpfCliente TEXT NOT NULL,
    telCliente TEXT NOT NULL
);

-- Tabela de Vendedores
CREATE TABLE tb_vendedor (
    idVendedor INTEGER PRIMARY KEY,
    nomeVendedor TEXT NOT NULL,
    cpfVendedor TEXT NOT NULL,
    telVendedor TEXT NOT NULL
);

-- Tabela de Combustíveis
CREATE TABLE tb_combustivel (
    idCombustivel INTEGER PRIMARY KEY,
    dsCombustivel TEXT NOT NULL
);

-- Tabela de Carros
CREATE TABLE tb_carro (
    idCarro INTEGER PRIMARY KEY,
    modeloCarro TEXT NOT NULL,
    marcaCarro TEXT NOT NULL,
    anoCarro INTEGER NOT NULL,
    idCombustivel INTEGER NOT NULL,
    FOREIGN KEY (idCombustivel) REFERENCES tb_combustivel(idCombustivel)
);

-- Tabela de Locações Normalizada
CREATE TABLE tb_locacao_nor (
    idLocacao INTEGER PRIMARY KEY,
    idCliente INTEGER NOT NULL,
    idCarro INTEGER NOT NULL,
    idVendedor INTEGER NOT NULL,
    dataLocacao TEXT NOT NULL,
    vlrDiaria REAL NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES tb_cliente(idCliente),
    FOREIGN KEY (idCarro) REFERENCES tb_carro(idCarro),
    FOREIGN KEY (idVendedor) REFERENCES tb_vendedor(idVendedor)
);
