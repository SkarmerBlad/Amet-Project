SELECT
  U.Nome,
  U.Cognome
FROM EVENTO E
JOIN PARTECIPA P
  ON E.Id_Evento = P.Id_Evento
JOIN SOCIO S
  ON P.Id_Tessera = S.Id_Tessera
Join USER U
  ON S.Id = U.Id
WHERE E.Nome = 'AMET';









