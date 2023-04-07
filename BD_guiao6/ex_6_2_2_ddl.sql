CREATE TABLE PRODUTO(
    Codigo      CHAR(5) NOT NULL,
    Nome        VARCHAR(30) NOT NULL,
    Preco       DECIMAL(3, 1),
    Iva         INT,
    Unidades    INT,

    PRIMARY KEY (Codigo)
);

CREATE TABLE TIPO_FORNECEDOR(
    Codigo          CHAR(3) NOT NULL,
    Designacao      VARCHAR(30),

    PRIMARY KEY (Codigo)
);

CREATE TABLE FORNECEDOR(
    Nif         CHAR(9) NOT NULL,
    Nome        VARCHAR(15) NOT NULL,
    Fax         CHAR(9),
    Endereco    VARCHAR(30),
    CondPag     INT,
    Tipo        CHAR(3) NOT NULL,

    PRIMARY KEY (Nif),
    FOREIGN KEY (Tipo) REFERENCES TIPO_FORNECEDOR(Codigo)
);

CREATE TABLE ENCOMENDA(
    Numero         INT NOT NULL,
    [Data]          DATE NOT NULL,
    Fornecedor      CHAR(9) NOT NULL,

    PRIMARY KEY (Numero),
    FOREIGN KEY (Fornecedor) REFERENCES FORNECEDOR(Nif)
);

CREATE TABLE ITEM(
    numEnc      INT NOT NULL,
    codProd     CHAR(5) NOT NULL,
    Unidades    INT,

    PRIMARY KEY (numEnc, codProd),
    FOREIGN KEY (numEnc) REFERENCES ENCOMENDA(Numero),
    FOREIGN KEY (codProd) REFERENCES PRODUTO(Codigo)
);