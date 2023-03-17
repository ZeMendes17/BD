CREATE TABLE RentACar.CLIENTE(
    NIF         CHAR(9),
    Nome        VARCHAR(30) NOT NULL,
    Endereco    VARCHAR(30),
    NumCarta    CHAR(10) NOT NULL,

    PRIMARY KEY (NIF),
    UNIQUE (NumCarta)
);

CREATE TABLE RentACar.BALCAO(
    Numero      INT NOT NULL,
    Nome        VARCHAR(15) NOT NULL,
    Endereco    VARCHAR(30),

    PRIMARY KEY (Numero),
    UNIQUE (Nome)
);

CREATE TABLE RentACar.TIPO_VEICULO(
    Codigo          INT NOT NULL,
    Designacao      VARCHAR(15),
    ArCondicionado  BIT,

    PRIMARY KEY (Codigo)
);

CREATE TABLE RentACar.VEICULO(
    Matricula           CHAR(6) NOT NULL,
    Ano                 CHAR(4),
    Marca               VARCHAR(10),
    CodigoTipoVeiculo   INT NOT NULL,

    PRIMARY KEY (Matricula),
    FOREIGN KEY (CodigoTipoVeiculo) REFERENCES RentACar.TIPO_VEICULO(Codigo)
);

CREATE TABLE RentACar.ALUGUER(
    Numero              INT NOT NULL,
    Duracao             TIME,
    DataAluguer         DATE,
    NIFCliente          CHAR(9) NOT NULL,
    NumeroBalcao        INT NOT NULL,
    MatriculaVeiculo    CHAR(6) NOT NULL

    PRIMARY KEY (Numero),
    FOREIGN KEY (NIFCliente) REFERENCES RentACar.CLIENTE(NIF),
    FOREIGN KEY (NumeroBalcao) REFERENCES RentACar.BALCAO(Numero),
    FOREIGN KEY (MatriculaVeiculo) REFERENCES RentACar.VEICULO(Matricula)
);

CREATE TABLE RentACar.LIGEIRO(
    CodigoTipoVeiculo   INT NOT NULL,
    NumLugares          INT,
    Portas              INT,
    Combustivel         VARCHAR(15)

    PRIMARY KEY (CodigoTipoVeiculo),
    FOREIGN KEY (CodigoTipoVeiculo) REFERENCES RentACar.TIPO_VEICULO(Codigo)
);

CREATE TABLE RentACar.PESADO(
    CodigoTipoVeiculo   INT NOT NULL,
    Peso                DECIMAL(6, 2),
    Passageiros         INT,

    PRIMARY KEY (CodigoTipoVeiculo),
    FOREIGN KEY (CodigoTipoVeiculo) REFERENCES RentACar.TIPO_VEICULO(Codigo)
);

CREATE TABLE RentACar.SIMILARIDADE(
    CodigoVeiculoA  INT NOT NULL,
    CodigoVeiculoB  INT NOT NULL

    PRIMARY KEY (CodigoVeiculoA, CodigoVeiculoB)
    FOREIGN KEY (CodigoVeiculoA) REFERENCES RentACar.TIPO_VEICULO(Codigo),
    FOREIGN KEY (CodigoVeiculoB) REFERENCES RentACar.TIPO_VEICULO(Codigo),
);