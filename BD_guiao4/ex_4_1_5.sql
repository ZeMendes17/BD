-- CREATE SCHEMA Conferencia;
-- GO;

CREATE TABLE Conferencia.Participante(
	Nome			VARCHAR(30) NOT NULL,
	Email			VARCHAR(30),
	Instituicao 	VARCHAR(15),

	PRIMARY KEY (Nome)
);	

CREATE TABLE Conferencia.Morada_Participante(
	NomeParticipante	VARCHAR(30) NOT NULL,
	MoradaParticipante  VARCHAR(30) NOT NULL,

	PRIMARY KEY (NomeParticipante,MoradaParticipante),
	FOREIGN KEY (NomeParticipante) REFERENCES Conferencia.Participante (Nome)
);

CREATE TABLE Conferencia.Data_Insc_Participante(
	NomeParticipante	VARCHAR(30) NOT NULL,
	DataInscricao		DATE NOT NULL,

	PRIMARY KEY (NomeParticipante,DataInscricao),
	FOREIGN KEY (NomeParticipante) REFERENCES Conferencia.Participante (Nome)
);

CREATE TABLE Conferencia.Estudante(
	Nome			VARCHAR(30) NOT NULL,
	Comprovativo	VARCHAR(10),
	LocEletronica	VARCHAR(10) NOT NULL,

	PRIMARY KEY (Nome),
	UNIQUE (LocEletronica),
	FOREIGN KEY (Nome) REFERENCES Conferencia.Participante (Nome))
;

CREATE TABLE Conferencia.Nao_Estudante(
	Nome			VARCHAR(30) NOT NULL,
	REFTransacao	VARCHAR(10) NOT NULL,
	ValorInscricao	DECIMAL(5,2),

	PRIMARY KEY (Nome),
	UNIQUE (REFTransacao),
	FOREIGN KEY (Nome) REFERENCES Conferencia.Participante (Nome)
);


CREATE TABLE Conferencia.Pessoa(
	Nome VARCHAR(30) NOT NULL,

	PRIMARY KEY(Nome)
);

CREATE TABLE Conferencia.Artigo(
	NumRegistro		INT NOT NULL,
	Titulo			VARCHAR(30),
	NomeAutor		VARCHAR(30) NOT NULL,

	PRIMARY KEY (NumRegistro),
	FOREIGN KEY (NomeAutor) REFERENCES Conferencia.Pessoa(Nome)
);

CREATE TABLE Conferencia.Autor(
	Nome				VARCHAR(30) NOT NULL,
	Email				VARCHAR(30) NOT NULL,
	NomeInst			VARCHAR(30),
	EnderecoInst		VARCHAR(30),
	NumRegistroArtigo	INT NOT NULL,

	PRIMARY KEY (Nome),
	UNIQUE(Email),
	FOREIGN KEY (Nome) REFERENCES Conferencia.Pessoa (Nome),
	FOREIGN KEY (NumRegistroArtigo) REFERENCES Conferencia.Artigo (NumRegistro)
);

