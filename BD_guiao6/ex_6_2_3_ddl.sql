CREATE TABLE medico(
    numSNS              INT         PRIMARY KEY NOT NULL,
    nome                VARCHAR(60) NOT NULL,
    especialidade       VARCHAR(60),                      
);

CREATE TABLE paciente(
    numUtente           INT         PRIMARY KEY NOT NULL,
    nome                VARCHAR(60) NOT NULL,
    dataNasc            DATE        NOT NULL,
    endereco            TEXT,
);

CREATE TABLE farmacia(
    nome                VARCHAR(60) PRIMARY KEY NOT NULL,
    telefone            INT         UNIQUE,
    endereco            TEXT,                      
);

CREATE TABLE farmaceutica(
    numReg              INT         PRIMARY KEY NOT NULL,
    nome                VARCHAR(60) UNIQUE,
    endereco            TEXT,                      
);

CREATE TABLE farmaco(
    numRegFarm          INT         NOT NULL REFERENCES farmaceutica(numReg)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    nome                VARCHAR(60) NOT NULL,
    formula             TEXT,                      
    PRIMARY KEY (numRegFarm, nome),
);

CREATE TABLE prescricao(
    numPresc            INT         PRIMARY KEY NOT NULL,
    numUtente           INT         NOT NULL REFERENCES paciente(numUtente)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    numMedico           INT         NOT NULL REFERENCES medico(numSNS)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    farmacia            VARCHAR(60) REFERENCES farmacia(nome)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    dataProc            DATE,
);

CREATE TABLE presc_farmaco(
    numPresc            INT         NOT NULL REFERENCES prescricao(numPresc)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    numRegFarm          INT         NOT NULL,
    nomeFarmaco         VARCHAR(60) NOT NULL,
    FOREIGN KEY (numRegFarm, nomeFarmaco) REFERENCES farmaco(numRegFarm, nome)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    PRIMARY KEY (numPresc, numRegFarm, nomeFarmaco),
);