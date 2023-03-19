CREATE TABLE Prescricao.Paciente(
	Num_Utente	CHAR(9) NOT NULL,
	Nome		VARCHAR(30) NOT NULL,
	Data_Nasc	DATE,
	Endereco	VARCHAR(30),
	
	PRIMARY KEY (Num_Utente)
);

CREATE TABLE Prescricao.Medico(
	Numero	 		VARCHAR(9) NOT NULL,
	Nome	 		VARCHAR(30),
	Especialidade 	VARCHAR(20)
	
	PRIMARY KEY (Numero)
);


CREATE TABLE Prescricao.Prescricao(
	Numero	 	VARCHAR(10) NOT NULL,
	DataPres 	DATE,
	NumUtente 	CHAR(9) NOT NULL,
	NumMedico 	VARCHAR(9) NOT NULL,

	PRIMARY KEY (Numero),
	FOREIGN KEY (NumUtente) REFERENCES Prescricao.Paciente(Num_Utente),
	FOREIGN KEY (NumMedico) REFERENCES Prescricao.Medico(Numero)
);


CREATE TABLE Prescricao.Compainha(
	NumRegistro VARCHAR(10) NOT NULL,
	Nome		VARCHAR(20) NOT NULL,
	Endereco    VARCHAR(30),
	Telefone    CHAR(9),

	PRIMARY KEY (NumRegistro,Nome)
);


CREATE TABLE Prescricao.Farmaco(
	Nome				VARCHAR(20) NOT NULL,
	Formula				VARCHAR(20) NOT NULL,
	NumPrescricao		VARCHAR(10) NOT NULL,
	NumRegistroComp 	VARCHAR(10) NOT NULL,
	NomeCompainha   	VARCHAR(20) NOT NULL,
	

	PRIMARY KEY (Nome),
	UNIQUE (Formula),
	FOREIGN KEY(NumPrescricao) REFERENCES Prescricao.Prescricao(Numero),
	FOREIGN KEY(NumRegistroComp, NomeCompainha) REFERENCES Prescricao.Compainha(NumRegistro, Nome),
);

CREATE TABLE Prescricao.Farmacia(
	NIF			  	CHAR(9) NOT NULL,
	Nome		  	VARCHAR(20) NOT NULL,
	Endereco      	VARCHAR(30),
	Telefone	  	CHAR(9),
	NumPrescricao 	VARCHAR(10) NOT NULL,
	DataProces    	DATE,

	PRIMARY KEY(NIF,Nome),
	FOREIGN KEY (NumPrescricao) REFERENCES Prescricao.Prescricao(Numero)
);

CREATE TABLE Prescricao.Venda(
	NIFFarmacia 	CHAR(9) NOT NULL,
	NomeFarmacia 	VARCHAR(20) NOT NULL,
	NomeFarmaco 	VARCHAR(20) NOT NULL,

	PRIMARY KEY (NIFFarmacia,NomeFarmacia,NomeFarmaco),
	FOREIGN KEY (NIFFarmacia, NomeFarmacia) REFERENCES Prescricao.Farmacia(NIF, Nome),
	FOREIGN KEY (NomeFarmaco) REFERENCES Prescricao.Farmaco(Nome)
);






