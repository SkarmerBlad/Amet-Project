DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Dipendente;
DROP TABLE IF EXISTS Socio;


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
  Id_Tessera VARCHAR(15) NOT NULL,

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
  Scadenza_contratto VARCHAR(20),

  CONSTRAINT unq_matricola UNIQUE (Matricola),
  CONSTRAINT fk_dip_id FOREIGN KEY (Id) REFERENCES User(Id)
);
INSERT INTO Dipendente(Id, Matricola, Stipendio, Iban, Ruolo, Scadenza_contratto)
VALUES(1, 'Mat00', 1000.10, 'dfds2fds', 'salumiere', '11/05/2004');

SELECT * FROM Dipendente;


-- abbonamento table
CREATE TABLE Abbonamento(
  Id_Abbonamento INT PRIMARY KEY,
  Data_Inizio VARCHAR(20),
  Data_FiNE VARCHAR(20),
  Costo INT
);

INSERT INTO Abbonamento(Id_Abbonamento, Data_inizio, Data_Fine, Costo)
VALUES(1, '25/25/2004', '25/25/2005', 150);

SELECT * FROM Abbonamento;


-- MOVIMENTO MAGAZZINO
CREATE TABLE Movimento_Magazzino(
  Id_Movimento INT PRIMARY KEY,
  Matricola_Dipendente VARCHAR(15),
  CONSTRAINT fk_matricola_dip FOREIGN KEY (Matricola_Dipendente) REFERENCES FROM Dipendente(Matricola)