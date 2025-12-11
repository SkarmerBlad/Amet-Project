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

-- socio table
CREATE TABLE Socio(
  Id INT PRIMARY KEY,
  Id_Tessera VARCHAR(15) NOT NULL, -- PK logica per le altre tabelle

  CONSTRAINT unq_tessera UNIQUE(Id_Tessera),
  CONSTRAINT fk_id FOREIGN KEY (Id) REFERENCES User(Id)
);

-- dipendente table
CREATE TABLE Dipendente(
  Id INT PRIMARY KEY,
  Matricola VARCHAR(15) NOT NULL,

  Stipendio DECIMAL(10,2),
  Iban CHAR(27),
  Ruolo VARCHAR(20),
  Scadenza_contratto DATE,

  CONSTRAINT unq_matricola UNIQUE (Matricola),
  CONSTRAINT fk_dip_id FOREIGN KEY (Id) REFERENCES User(Id)
);
-- Nota la data in formato YYYY-MM-DD

-- abbonamento table
CREATE TABLE Abbonamento(
  Id_Abbonamento INT PRIMARY KEY,
  Data_Inizio DATE,
  Data_FiNE DATE,
  Costo INT
);

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

-- tabella fornitore
CREATE TABLE Fornitore(
  P_iva VARCHAR(15) PRIMARY KEY,
  Ragione_Sociale VARCHAR(15),
  Email VARCHAR(30),
  Telefono VARCHAR(15)
);

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

-- EVENTO
CREATE TABLE Evento(
  Id_Evento INT PRIMARY KEY,
  Nome VARCHAR(15),
  Luogo VARCHAR(30),
  Data DATE,
  Descrizione VARCHAR(1234)
);

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
-- =============================================
-- 3. POPOLAMENTO DATI (INSERTS)
-- =============================================

-- 3.1 Popolamento USER (Base per Soci e Dipendenti)
-- Creo 10 utenti: ID 1-4 saranno Dipendenti, ID 5-10 saranno Soci
INSERT INTO User (Id, Nome, Cognome, Cf, Email, Numero_Telefono, Indirizzo, Citta, Cap) VALUES
(1, 'Luca', 'Vicinanza', 'VCNLCU04E11H703K', 'luca.vic@gmail.com', '3457348443', 'Via Posidonia 165', 'Salerno', 84128),
(2, 'Marco', 'Rossi', 'RSSMRC80A01H501Z', 'marco.rossi@gym.it', '3331234567', 'Via Roma 10', 'Roma', 00100),
(3, 'Giulia', 'Verdi', 'VRDGLI90B45F205A', 'giulia.verdi@gym.it', '3339876543', 'Corso Italia 5', 'Milano', 20100),
(4, 'Sofia', 'Bianchi', 'BNCSFO85M50H703Q', 'sofia.b@gym.it', '3334567890', 'Piazza Dante 1', 'Napoli', 80100),
(5, 'Paolo', 'Neri', 'NRIPLA95C15F205W', 'paolo.neri@email.com', '3381112233', 'Via Mazzini 20', 'Torino', 10100),
(6, 'Anna', 'Gialli', 'GLLNNA00H60A944E', 'anna.gialli@email.com', '3384445566', 'Via Garibaldi 33', 'Bologna', 40100),
(7, 'Francesco', 'Blu', 'BLUFNC99T20H501L', 'fra.blu@email.com', '3397778899', 'Viale dei Mille 2', 'Firenze', 50100),
(8, 'Elena', 'Viola', 'VLILNA92R55H703U', 'elena.viola@email.com', '3201231234', 'Via dei Mercanti 8', 'Salerno', 84121),
(9, 'Giorgio', 'Marroni', 'MRRGRG88P10F205X', 'gio.marr@email.com', '3289990000', 'Lungomare 100', 'Napoli', 80122),
(10, 'Chiara', 'Rosa', 'RSACHR01D41H501J', 'chiara.rosa@email.com', '3475556677', 'Via Veneto 12', 'Roma', 00187);

-- 3.2 Popolamento DIPENDENTE (Colleghiamo User 1, 2, 3, 4)
INSERT INTO Dipendente (Id, Matricola, Stipendio, Iban, Ruolo, Scadenza_contratto) VALUES
(1, 'DIP001', 1200.00, 'IT60X1234567890123456789001', 'Manutentore', '2025-12-31'),
(2, 'DIP002', 1800.50, 'IT60X1234567890123456789002', 'Direttore', NULL), -- Contratto indeterminato
(3, 'DIP003', 1400.00, 'IT60X1234567890123456789003', 'Receptionist', '2024-06-30'),
(4, 'DIP004', 1600.00, 'IT60X1234567890123456789004', 'Personal Trainer', '2025-01-01');

-- 3.3 Popolamento SOCIO (Colleghiamo User 5, 6, 7, 8, 9, 10)
INSERT INTO Socio (Id, Id_Tessera) VALUES
(5, 'TESS001'),
(6, 'TESS002'),
(7, 'TESS003'),
(8, 'TESS004'),
(9, 'TESS005'),
(10, 'TESS006');

-- 3.4 Popolamento ABBONAMENTO (Creiamo le tipologie disponibili)
INSERT INTO Abbonamento (Id_Abbonamento, Data_Inizio, Data_FiNE, Costo) VALUES
(1, '2024-01-01', '2024-01-31', 50),   -- Mensile Gennaio
(2, '2024-01-01', '2024-12-31', 450),  -- Annuale 2024
(3, '2024-06-01', '2024-08-31', 120),  -- Trimestrale Estivo
(4, '2024-09-01', '2025-06-30', 350);  -- Stagionale Studenti

-- 3.5 Popolamento SOTTOSCRIVE (Chi ha comprato cosa)
INSERT INTO Sottoscrive (Id_Abbonamento, Id_Tessera, Fattura, Data_Sottoscrizione) VALUES
(2, 'TESS001', 'FATT-001', '2023-12-28'), -- Paolo Neri fa l'annuale
(1, 'TESS002', 'FATT-002', '2024-01-02'), -- Anna Gialli fa il mensile
(2, 'TESS003', 'FATT-003', '2024-01-10'), -- Francesco Blu fa l'annuale
(3, 'TESS004', 'FATT-150', '2024-05-20'), -- Elena Viola fa l'estivo
(4, 'TESS005', 'FATT-200', '2024-08-30'), -- Giorgio Marroni fa lo studenti
(2, 'TESS006', 'FATT-201', '2024-01-15'); -- Chiara Rosa fa l'annuale

-- 3.6 Popolamento FORNITORE
INSERT INTO Fornitore (P_iva, Ragione_Sociale, Email, Telefono) VALUES
('12345678901', 'TechnoGym Italia', 'sales@technogym.it', '0547123456'),
('09876543210', 'Integratori Plus', 'info@integraplus.com', '0234567890'),
('11223344556', 'Pulizie Rapide Srl', 'amm@pulizierapide.it', '0698765432');

-- 3.7 Popolamento PRODOTTO
INSERT INTO Prodotto (Id_Prod, Id_Fornitore, Giacenza, Nome, Prezzo) VALUES
(1, '09876543210', 50, 'Barretta Proteica', 2.50),
(2, '09876543210', 20, 'Gatorade Limone', 1.80),
(3, '12345678901', 10, 'Asciugamano Gym', 12.00),
(4, '12345678901', 5, 'Borraccia Termica', 15.50),
(5, '11223344556', 30, 'Spray Igienizzante', 5.00);

-- 3.8 Popolamento MOVIMENTO_MAGAZZINO
INSERT INTO Movimento_Magazzino (Id_Movimento, Matricola_Dipendente, Data, Tipo, Quantita) VALUES
(1, 'DIP003', '2024-01-10', 'entrata', 50), -- La receptionist carica le barrette
(2, 'DIP003', '2024-01-12', 'uscita', 5),   -- Vendute 5 barrette
(3, 'DIP001', '2024-02-01', 'uscita', 2),   -- Il manutentore usa 2 spray
(4, 'DIP002', '2024-02-15', 'entrata', 20), -- Il direttore ordina nuove borracce
(5, 'DIP004', '2024-03-01', 'entrata', 100); -- Il PT porta nuovi integratori

-- 3.9 Popolamento EVENTO
INSERT INTO Evento (Id_Evento, Nome, Luogo, Data, Descrizione) VALUES
(1, 'Gara Powerlifting', 'Sala Pesi', '2024-05-15', 'Gara amatoriale di panca piana'),
(2, 'Maratona Notturna', 'Lungomare', '2024-07-20', 'Corsa di 10km in notturna'),
(3, 'Cena Sociale', 'Ristorante La Perla', '2024-12-20', 'Cena di Natale per tutti i soci');

-- 3.10 Popolamento PARTECIPA
INSERT INTO Partecipa (Id_Evento, Id_Tessera, Pagato, Data_Prenotazione) VALUES
(1, 'TESS001', 1, '2024-05-01'), -- Paolo partecipa alla gara (Pagato)
(1, 'TESS003', 0, '2024-05-05'), -- Francesco partecipa alla gara (Non ancora pagato)
(2, 'TESS002', 1, '2024-06-15'), -- Anna corre la maratona
(2, 'TESS004', 1, '2024-06-20'), -- Elena corre la maratona
(3, 'TESS001', 1, '2024-12-01'), -- Paolo va a cena
(3, 'TESS005', 1, '2024-12-02'), -- Giorgio va a cena
(3, 'TESS006', 1, '2024-12-05'); -- Chiara va a cena