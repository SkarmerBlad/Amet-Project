DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Dipendente;
DROP TABLE IF EXISTS Socio;
DROP TABLE IF EXISTS Abbonamento;
DROP TABLE IF EXISTS Movimento_Magazzino;
DROP TABLE IF EXISTS Sottoscrive;
DROP TABLE IF EXISTS Prodotto;
DROP TABLE IF EXISTS Fornitore;
DROP TABLE IF EXISTS Evento;
DROP TABLE IF EXISTS Partecipa;

-- user table
CREATE TABLE User (
  Id INT PRIMARY KEY,
  Nome VARCHAR(50),
  Cognome VARCHAR(50),
  Cf CHAR(16),
  Email VARCHAR(50),
  Numero_Telefono VARCHAR(20),
  Indirizzo VARCHAR(50),
  Citta VARCHAR(20),
  Cap INT
);
INSERT INTO User (Id, Nome, Cognome, Cf, Email, Numero_Telefono, Indirizzo, Citta, Cap)
VALUES(1, 'Luca', 'Vicinanza', 'VCNLCU04E11H703K', 'luca.vicinanza04@gmail.com', '3457348443', 'Via Posidonia 165', 'Salerno', 84128);

SELECT * FROM User;
-- socio table
CREATE TABLE Socio(
  Id INT PRIMARY KEY,
  Id_Tessera VARCHAR(15) NOT NULL, -- PK logica per le altre tabelle

  CONSTRAINT unq_tessera UNIQUE(Id_Tessera),
  CONSTRAINT fk_id FOREIGN KEY (Id) REFERENCES User(Id)
);
INSERT INTO Socio(Id, Id_Tessera) VALUES(1, '123432');
SELECT * FROM Socio;

-- dipendente table
CREATE TABLE Dipendente(
  Id INT PRIMARY KEY,
  Matricola VARCHAR(15) NOT NULL,

  Stipendio DECIMAL(10,2),
  Iban CHAR(16),
  Ruolo VARCHAR(20),
  Scadenza_contratto DATE,

  CONSTRAINT unq_matricola UNIQUE (Matricola),
  CONSTRAINT fk_dip_id FOREIGN KEY (Id) REFERENCES User(Id)
);
-- Nota la data in formato YYYY-MM-DD
INSERT INTO Dipendente(Id, Matricola, Stipendio, Iban, Ruolo, Scadenza_contratto)
VALUES(1, 'Mat00', 1000.10, 'dfds2fds', 'salumiere', '2004-11-05');

SELECT * FROM Dipendente;

-- abbonamento table
CREATE TABLE Abbonamento(
  Id_Abbonamento INT PRIMARY KEY,
  Data_Inizio DATE,
  Data_FiNE DATE,
  Costo INT
);
INSERT INTO Abbonamento(Id_Abbonamento, Data_inizio, Data_Fine, Costo)
VALUES(1, '2004-11-25', '2005-11-25', 150);

SELECT * FROM Abbonamento;
-- MOVIMENTO MAGAZZINO
CREATE TABLE Movimento_Magazzino(
  Id_Movimento INT PRIMARY KEY,
  Matricola_Dipendente VARCHAR(15),
  Data DATE,
  Tipo VARCHAR(15),
  Quantita INT,
  CONSTRAINT fk_matricola_dip FOREIGN KEY (Matricola_Dipendente) REFERENCES Dipendente(Matricola)
);
-- CORRETTO: Uso 'Mat00' che esiste nella tabella Dipendente
INSERT INTO Movimento_Magazzino(Id_Movimento, Matricola_Dipendente, Data, Tipo, Quantita)
VALUES(1, 'Mat00', '2024-01-01', 'entrata', 19);

SELECT * FROM Abbonamento;
-- RELAZIONE SOTTOSCRIVE
CREATE TABLE Sottoscrive(
  Id_Abbonamento INT,
  Id_Tessera VARCHAR(15),
  Fattura VARCHAR(15),
  Data_Sottoscrizione DATE,

  PRIMARY KEY(Id_Abbonamento, Id_Tessera),

  CONSTRAINT fk_abbonamento FOREIGN KEY (Id_Abbonamento) REFERENCES Abbonamento(Id_Abbonamento),
  CONSTRAINT fk_tessera FOREIGN KEY (Id_Tessera) REFERENCES Socio(Id_Tessera)
);
-- CORRETTO: Uso '123432' che esiste nella tabella Socio
INSERT INTO Sottoscrive(Id_Abbonamento, Id_Tessera, Fattura, Data_Sottoscrizione)
VALUES(1, '123432', 'fattura', '2007-11-11');

-- tabella fornitore
CREATE TABLE Fornitore(
  P_iva VARCHAR(15) PRIMARY KEY,
  Ragione_Sociale VARCHAR(15),
  Email VARCHAR(30),
  Telefono VARCHAR(15)
);
INSERT INTO Fornitore(P_iva, Ragione_Sociale, Email, Telefono)
VALUES ('13451235', '342452342', 'l.vicinanza04#gmail.com', '3457348443');

SELECT * FROM Fornitore;
-- Tabella Prodotto
CREATE TABLE Prodotto(
  Id_Prod INT PRIMARY KEY,
  Id_Fornitore VARCHAR(15),
  Giacenza INT,
  Nome VARCHAR(15),
  Prezzo DECIMAL(10,2),
  CONSTRAINT fk_fornitore FOREIGN KEY(Id_Fornitore) REFERENCES Fornitore(P_iva)
);
-- CORRETTO: Uso la P_IVA '13451235' che esiste in Fornitore
INSERT INTO Prodotto(Id_Prod, Id_Fornitore, Giacenza, Nome, Prezzo)
VALUES(1, '13451235', 10, 'orco', 14.34);

SELECT * FROM Prodotto;
-- EVENTO
CREATE TABLE Evento(
  Id_Evento INT PRIMARY KEY,
  Nome VARCHAR(15),
  Luogo VARCHAR(30),
  Data DATE,
  Descrizione VARCHAR(1234)
);
INSERT INTO Evento(Id_Evento, Nome, Luogo, Data, Descrizione)
VALUES(1, 'AMET', 'BATTIPAGLIA', '2017-05-12', 'LOREM IPSUM');

SELECT * FROM Evento;

-- PARTECIPA
CREATE TABLE Partecipa(
  Id_Evento INT,
  Id_Tessera VARCHAR(15), -- CORRETTO: Era INT, ora è VARCHAR per combaciare con Socio
  Pagato INT,
  Data_Prenotazione DATE,

  PRIMARY KEY(Id_Evento, Id_Tessera),

  CONSTRAINT fk_event FOREIGN KEY(Id_Evento) REFERENCES Evento(Id_Evento),
  CONSTRAINT fk_tesser FOREIGN KEY(Id_Tessera) REFERENCES Socio(Id_Tessera)
);
-- CORRETTO: Uso la tessera corretta e il formato data YYYY-MM-DD
INSERT INTO Partecipa(Id_Evento, Id_Tessera, Pagato, Data_Prenotazione)
VALUES(1, '123432', 1, '2024-12-21');

SELECT * FROM Partecipa;