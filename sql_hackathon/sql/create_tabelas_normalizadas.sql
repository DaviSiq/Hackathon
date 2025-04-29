
-- Tabela de Clientes
CREATE TABLE Cliente (
    idCliente INTEGER PRIMARY KEY,
    nomeCliente VARCHAR(100),
    cidadeCliente VARCHAR(40),
    estadoCliente VARCHAR(40),
    paisCliente VARCHAR(40)
);

-- Tabela de Carros
CREATE TABLE Carro (
    idCarro INTEGER PRIMARY KEY,
    classiCarro VARCHAR(50),
    marcaCarro VARCHAR(80),
    modeloCarro VARCHAR(80),
    anoCarro INT,
    idCombustivel INTEGER
);

-- Tabela de Combustíveis
CREATE TABLE Combustivel (
    idCombustivel INTEGER PRIMARY KEY,
    tipoCombustivel VARCHAR(20)
);

-- Tabela de Vendedores
CREATE TABLE Vendedor (
    idVendedor INTEGER PRIMARY KEY,
    nomeVendedor VARCHAR(15),
    sexoVendedor SMALLINT,
    estadoVendedor VARCHAR(40)
);

-- Tabela de Tempo
CREATE TABLE Tempo (
    idTempo INTEGER PRIMARY KEY AUTOINCREMENT,
    dataLocacao DATE,
    horaLocacao TIME,
    dataEntrega DATE,
    horaEntrega TIME
);

-- Tabela Fato: Locação
CREATE TABLE Locacao (
    idLocacao INTEGER PRIMARY KEY,
    idCliente INTEGER,
    idCarro INTEGER,
    kmCarro INTEGER,
    qtdDiaria INTEGER,
    vlrDiaria DECIMAL(18,2),
    idVendedor INTEGER,
    idTempo INTEGER,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idCarro) REFERENCES Carro(idCarro),
    FOREIGN KEY (idVendedor) REFERENCES Vendedor(idVendedor),
    FOREIGN KEY (idTempo) REFERENCES Tempo(idTempo)
);
