-- Creazione della tabella Dipartimento
CREATE TABLE Dipartimento (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    Corsi_offerti VARCHAR(255)
);

-- Creazione della tabella Docente
CREATE TABLE Docente (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    ID_dipartimento INT,
    Data_di_nascita DATE,
    Specializzazione VARCHAR(100),
    FOREIGN KEY (ID_dipartimento) REFERENCES Dipartimento(ID)
);

-- Creazione della tabella Studente
CREATE TABLE Studente (
    Codice_matricola VARCHAR(10) PRIMARY KEY,
    Nome VARCHAR(100),
    Data_di_nascita DATE
);

-- Creazione della tabella Corso
CREATE TABLE Corso (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    ID_docente INT,
    Codice_identificativo VARCHAR(20),
    FOREIGN KEY (ID_docente) REFERENCES Docente(ID)
);

-- Creazione della tabella Esami
CREATE TABLE Esami (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Codice_matricola_studente VARCHAR(10),
	Rif_Docente INT,
    ID_Corso INT,
    Data_Esame DATE,
    Voto INT,
    FOREIGN KEY (Codice_matricola_studente) REFERENCES Studente (Codice_matricola),
	FOREIGN KEY (Rif_Docente) REFERENCES Docente(ID),
    FOREIGN KEY (ID_Corso) REFERENCES Corso(ID)
);
