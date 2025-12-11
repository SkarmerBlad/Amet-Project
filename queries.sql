-- Scrivi una query che restituisca nome cognome ruolo e numero di telefono
SELECT U.Nome, U.Cognome, U.Numero_Telefono, D.Ruolo
FROM User U
JOIN Dipendente D ON U.Id = D.Id;


-- Trova i prodotti con una giacenza inferiore o uguale a 10
SELECT P.Nome, P.Id_Fornitore, P.Giacenza
FROM Prodotto P
WHERE P.Giacenza <= 10
ORDER BY P.Giacenza ASC;


-- Recupera nome cognome email dei soci che hanno abbonamento id = 4
SELECT U.Nome, U.Cognome, U.Email
FROM USER U
JOIN SOCIO S ON U.Id = S.Id
JOIN SOTTOSCRIVE SO ON S.Id_Tessera = SO.Id_Tessera
WHERE SO.Id_Abbonamento = 4;


--Seleziona nome e cognome e colonna pagato di utenti evento id 3
SELECT U.Nome, U.Cognome, P.Pagato
FROM User U
JOIN Socio S ON U.Id = S.Id
JOIN Partecipa P ON S.Id_Tessera = P.Id_Tessera
WHERE P.Id_Evento = 3;


--Test Group By
SELECT E.Nome, COUNT(*) as Totale_Partecipanti
FROM EVENTO E
JOIN PARTECIPA P ON E.Id_Evento = P.Id_Evento
GROUP BY E.Nome;


--Trova nome e cognome delle persone iscritte ad eventi non avendo pagato
SELECT U.Nome, U.Cognome, E.Nome
FROM User U
JOIN Socio S ON U.Id = S.Id
JOIN PARTECIPA P ON S.Id_Tessera = P.Id_Tessera
JOIN Evento E ON P.Id_Evento = E.Id_Evento
WHERE P.Pagato = 0;


--Seleziona il totale da ciascun abbonamento
SELECT A.Id_Abbonamento, SUM(COSTO)
FROM SOTTOSCRIVE S
JOIN Abbonamento A ON A.Id_Abbonamento = S.Id_Abbonamento
GROUP BY A.Id_Abbonamento;


--Incasso Totale
SELECT SUM(COSTO) as Totale
FROM SOTTOSCRIVE S
JOIN Abbonamento A ON S.Id_Abbonamento = A.Id_Abbonamento;



--Valore Economico della merca uscita divisa per nome
