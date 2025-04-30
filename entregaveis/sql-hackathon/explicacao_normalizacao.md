
# 📘 Processo de Normalização da Base de Dados - Concessionária

Este documento descreve o passo a passo realizado para normalizar a base de dados original (`tb_locacao`) até a Terceira Forma Normal (3FN), e a modelagem do esquema dimensional com tabelas fato e dimensões.

---

## 🔍 1. Análise da Tabela Original (`tb_locacao`)

A tabela `tb_locacao` concentrava informações de várias entidades em uma única estrutura:

- Informações do cliente (nome, cidade, estado, país)
- Informações do carro (marca, modelo, ano, combustível)
- Informações do vendedor
- Informações da locação (datas, valores, etc.)

---

## ✅ 2. Aplicação das Formas Normais

### 📗 Primeira Forma Normal (1FN)
- **Requisito:** Todos os campos devem conter apenas valores atômicos (sem listas ou repetições).
- **Resultado:** A tabela já estava em 1FN. Nenhum campo violava esse princípio.

---

### 📘 Segunda Forma Normal (2FN)
- **Requisito:** Eliminar dependências parciais. Todos os atributos não-chave devem depender da chave primária completa.
- **Problemas Identificados:**
  - Campos como `nomeCliente`, `cidadeCliente`, etc., dependem apenas de `idCliente`, não de `idLocacao`.
  - O mesmo ocorre com os dados de carro (`idCarro`, `modeloCarro`, etc.), vendedor (`idVendedor`, `nomeVendedor`, etc.) e combustível.
- **Solução:** Criamos tabelas separadas para cada entidade, mantendo apenas chaves estrangeiras na tabela de locação.

---

### 📙 Terceira Forma Normal (3FN)
- **Requisito:** Eliminar dependências transitivas.
- **Problema Identificado:** `estadoCliente` e `paisCliente` dependem de `cidadeCliente`, que por sua vez depende de `idCliente`.
- **Solução:** Mantivemos essas colunas na tabela `Cliente` já que `cidadeCliente` é apenas um atributo da entidade Cliente.

---

## 🏗️ 3. Tabelas Criadas Após Normalização

### 🧑‍💼 Cliente
```sql
CREATE TABLE Cliente (
    idCliente INTEGER PRIMARY KEY,
    nomeCliente VARCHAR(100),
    cidadeCliente VARCHAR(40),
    estadoCliente VARCHAR(40),
    paisCliente VARCHAR(40)
);
```

### 🚗 Carro
```sql
CREATE TABLE Carro (
    idCarro INTEGER PRIMARY KEY,
    classiCarro VARCHAR(50),
    marcaCarro VARCHAR(80),
    modeloCarro VARCHAR(80),
    anoCarro INT,
    idCombustivel INTEGER
);
```

### ⛽ Combustível
```sql
CREATE TABLE Combustivel (
    idCombustivel INTEGER PRIMARY KEY,
    tipoCombustivel VARCHAR(20)
);
```

### 🧍 Vendedor
```sql
CREATE TABLE Vendedor (
    idVendedor INTEGER PRIMARY KEY,
    nomeVendedor VARCHAR(15),
    sexoVendedor SMALLINT,
    estadoVendedor VARCHAR(40)
);
```

### ⏱️ Tempo
```sql
CREATE TABLE Tempo (
    idTempo INTEGER PRIMARY KEY AUTOINCREMENT,
    dataLocacao DATE,
    horaLocacao TIME,
    dataEntrega DATE,
    horaEntrega TIME
);
```

### 📊 Locação (Fato)
```sql
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
```

---

## 📐 4. Modelo Dimensional

Baseado nas tabelas normalizadas, foi criado um modelo dimensional no formato estrela:

- **Tabela Fato:** `Locacao`
- **Tabelas Dimensão:** `Cliente`, `Carro`, `Vendedor`, `Tempo`

---

## 🔍 5. Views Criadas

### Fato
```sql
CREATE VIEW vw_fato_locacao AS
SELECT idLocacao, idCliente, idCarro, kmCarro, qtdDiaria, vlrDiaria, idVendedor, idTempo
FROM Locacao;
```

### Dimensões
```sql
CREATE VIEW vw_dim_cliente AS SELECT * FROM Cliente;

CREATE VIEW vw_dim_carro AS
SELECT c.*, comb.tipoCombustivel
FROM Carro c
JOIN Combustivel comb ON c.idCombustivel = comb.idCombustivel;

CREATE VIEW vw_dim_vendedor AS SELECT * FROM Vendedor;

CREATE VIEW vw_dim_tempo AS SELECT * FROM Tempo;
```

---

## ✅ Conclusão

A estrutura original foi devidamente decomposta em entidades independentes, com relacionamentos claros e sem redundância. O modelo dimensional facilita a análise OLAP e a criação de dashboards analíticos.
