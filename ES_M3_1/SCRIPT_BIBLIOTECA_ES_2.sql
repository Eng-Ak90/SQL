-- Creazione della tabella Autore
CREATE TABLE Autore (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    Data_di_nascita DATE,
    Luogo_di_nascita VARCHAR(100)
);

-- Creazione della tabella Libro
CREATE TABLE Libro (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Titolo VARCHAR(255),
    ID_autore INT,
    Casa_editrice VARCHAR(255),
    Genere VARCHAR(100),
    ISBN VARCHAR(20),
    Numero_di_copie_in_possesso INT,
    FOREIGN KEY (ID_autore) REFERENCES Autore(ID)
);

-- Creazione della tabella Utente
CREATE TABLE Utente (
    Codice_fiscale VARCHAR(16) PRIMARY KEY,
    Nome VARCHAR(100),
    Recapito VARCHAR(255)
);

-- Creazione della tabella Prestito
CREATE TABLE Prestito (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Codice_fiscale_utente VARCHAR(16),
    ID_libro INT,
    Data_di_inizio_prestito DATE,
    Data_di_consegna DATE,
    Ritardo_nella_consegna BOOLEAN,
    FOREIGN KEY (Codice_fiscale_utente) REFERENCES Utente(Codice_fiscale),
    FOREIGN KEY (ID_libro) REFERENCES Libro(ID)
);

-- Creazione della tabella Collocazione_libro
CREATE TABLE CollocazioneLibro (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ID_libro INT,
    Sezione VARCHAR(100),
    Scaffale VARCHAR(100),
    Ripiano VARCHAR(100),
    FOREIGN KEY (ID_libro) REFERENCES Libro(ID)
);