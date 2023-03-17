-- DROP SCHEMA IF EXISTS ATL;
-- GO;
-- CREATE SCHEMA ATL;
-- GO;

CREATE TABLE ATL.TURMA(
    ID              INT NOT NULL,
    AnoLetivo       CHAR(4),
    Designacao      VARCHAR(15),
    NMaxAlunos      INT,
    Escolaridade    INT,

    PRIMARY KEY (ID)
);

CREATE TABLE ATL.ATIVIDADE(
    Identificador   INT NOT NULL,
    IDTurma         INT NOT NULL,
    Frequencia      INT,
    Custo           INT,
    Designacao      VARCHAR(30),

    PRIMARY KEY (Identificador, IDTurma),
    FOREIGN KEY (IDTurma) REFERENCES ATL.TURMA(ID)
);

CREATE TABLE ATL.PESSOA(
    NumeroCC        CHAR(9) NOT NULL,
    Nome            VARCHAR(30) NOT NULL,
    Morada          VARCHAR(30),
    DataNascimento  DATE,

    PRIMARY KEY (NumeroCC)
);

CREATE TABLE ATL.MORADA(
    NumeroCC        CHAR(9) NOT NULL,
    MoradaPessoa    VARCHAR(30),

    PRIMARY KEY (NumeroCC),
    FOREIGN KEY (NumeroCC) REFERENCES ATL.PESSOA(NumeroCC)
);

CREATE TABLE ATL.DATANASCIMENTO(
    NumeroCC                CHAR(9) NOT NULL,
    DataNascimentoPessoa    DATE,

    PRIMARY KEY (NumeroCC),
    FOREIGN KEY (NumeroCC) REFERENCES ATL.PESSOA(NumeroCC)
);

CREATE TABLE ATL.PROFESSOR(
    NumeroCC        CHAR(9) NOT NULL,
    Email           VARCHAR(50) NOT NULL,
    NFuncionario    INT NOT NULL,

    PRIMARY KEY (NumeroCC),
    UNIQUE (Email),
    FOREIGN KEY (NumeroCC) REFERENCES ATL.PESSOA(NumeroCC)
);

CREATE TABLE ATL.ALUNO(
    NumeroCC                    CHAR(9) NOT NULL,
    TurmaID                     INT NOT NULL,
    ListaPessoasAutorizadas     VARCHAR(1000),

    PRIMARY KEY (NumeroCC, TurmaID),
    FOREIGN KEY (NumeroCC) REFERENCES ATL.PESSOA(NumeroCC),
    FOREIGN KEY (TurmaID) REFERENCES ATL.TURMA(ID)
);

CREATE TABLE ATL.ENCARREGADO_DE_EDUCACAO(
    NumeroCC        CHAR(9) NOT NULL,
    Email           VARCHAR(50) NOT NULL,

    PRIMARY KEY (NumeroCC),
    FOREIGN KEY (NumeroCC) REFERENCES ATL.PESSOA(NumeroCC)
);