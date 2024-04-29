/* Ultima esercitazione di SQL per il Corso Epicode: Creazione Schema
ToysGroup è un’azienda che distribuisce articoli (giocattoli) in diverse aree geografiche del mondo. I prodotti sono classificati in categorie e i mercati di riferimento dell’azienda sono classificati in regioni di vendita. 
In particolare: 
	Entità
Product -> classificati in categorie 
		- Category (aggiunta 
Region
Sales
Per 
	Relazioni
Product e Sales 
	Un prodotto può essere venduto tante volte (o nessuna) per cui è contenuto in una o più transazioni di vendita. 
	Ciascuna transazione di vendita è riferita ad uno solo prodotto 
Region e Sales 
	Possono esserci molte o nessuna transazione per ciascuna regione 
	Ciascuna transazione di vendita è riferita ad una sola regione  */

-- Procedere con lo script per la generazione dello Schema

DROP SCHEMA IF EXISTS Epicode_ToysGroup;
CREATE SCHEMA Epicode_ToysGroup;
USE Epicode_ToysGroup;

--
-- Creazione tabella Category	
--
CREATE TABLE Category (
ID_Categoria INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
Nome_Categoria VARCHAR(45) NOT NULL
);

--
-- Creazione tabella Product	
--
	
CREATE TABLE Product (
  ID_Prodotto INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Nome_Prodotto VARCHAR(45) NOT NULL,
  ID_Categoria INT,
  Costo_acquisto DECIMAL(4,1) NOT NULL,
  Prezzo_vendita DECIMAL(4,1) NOT NULL,
FOREIGN KEY (ID_Categoria) REFERENCES Category (ID_Categoria)
  );
	

--
-- Creazione tabella Regioni
--

CREATE TABLE Region (
ID_regione INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
Nome_regione VARCHAR(45) NOT NULL
);

--
-- Creazione tabella Sales
--	
CREATE TABLE Sales (
  ID_transazione INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ID_prodotto INT UNSIGNED NOT NULL,
  ID_regione INT UNSIGNED NOT NULL,
  Quantità INT NOT NULL,
  Data_Transazione DATE NOT NULL,
  FOREIGN KEY (ID_prodotto) REFERENCES Product (ID_prodotto),
  FOREIGN KEY (ID_regione) REFERENCES Region (ID_regione)
);





