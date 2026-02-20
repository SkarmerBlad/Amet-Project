CREATE TABLE Prodotti IF NOT EXISTS (
    id_prodotto INT PRIMARY KEY,
    nome_prodotto VARCHAR(100) NOT NULL,
    prezzo DECIMAL(10, 2),
    quantita_magazzino INT DEFAULT 0,
    data_inserimento DATE
);

INSERT INTO Prodotti (id_prodotto, nome_prodotto, prezzo, quantita_magazzino, data_inserimento)
VALUES 
(1, 'Laptop Gaming', 1200.50, 10, '2024-05-20'),
(2, 'Mouse Wireless', 25.99, 50, '2024-05-21'),
(3, 'Tastiera Meccanica', 89.00, 15, '2024-05-21'),
(4, 'Monitor 4K', 350.00, 5, '2024-05-22');

SELECT * FROM Prodotti;