-- DROP SCHEMA IF EXISTS Encomenda;
-- GO;
-- CREATE SCHEMA Encomenda;
-- GO;

CREATE TABLE Encomenda.FORNECEDOR(
    NIF                     CHAR(9) NOT NULL,
    Nome                    VARCHAR(30) NOT NULL,
    Endereco                VARCHAR(50),
    FAX                     INT,
    CondicoesDePagamento    VARCHAR(20),
    CodigoInterno           INT,
    Designacao              VARCHAR(20),

    PRIMARY KEY (NIF),
    UNIQUE (Nome)
);

CREATE TABLE Encomenda.PRODUTO(
    Codigo      INT NOT NULL,
    IVA         INT,
    Nome        VARCHAR(20) NOT NULL,
    Preco       INT,
    Quantidade  INT,

    PRIMARY KEY (Codigo),
    UNIQUE (Nome)
);

CREATE TABLE Encomenda.ENCOMENDA(
    Numero              INT NOT NULL,
    NIF_Fornecedor      CHAR(9) NOT NULL,
    CodigoProduto       INT NOT NULL,
    DataDaEncomenda     DATE,
    NItens              INT,

    PRIMARY KEY (Numero, NIF_Fornecedor, CodigoProduto),
    FOREIGN KEY (NIF_Fornecedor) REFERENCES ENCOMENDA.FORNECEDOR(NIF),
    FOREIGN KEY (CodigoProduto) REFERENCES ENCOMENDA.PRODUTO(Codigo)
);