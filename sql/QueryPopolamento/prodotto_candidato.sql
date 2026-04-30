delete from prodotto_candidato;
INSERT INTO prodotto_candidato (codice_prodotto, nome_prodotto, prezzo, produttore, spedito, motivazione_rifiuto, approvato, URL) VALUES
('PC00000001', 'Scrivania Angolare', 199.99, 'Ikea', TRUE, NULL, TRUE, 'https://ikea.com/scrivania1'),
('PC00000002', 'Stampante Laser HP 1200', 149.50, 'HP', FALSE, 'Prezzo troppo alto', FALSE, 'https://hp.com/stampante1200'),
('PC00000003', 'Notebook ASUS', 749.99, 'ASUS', TRUE, NULL, TRUE, 'https://asus.com/notebookPC003');



-- 'spedito' può essere TRUE solo se 'approvato' = TRUE
-- 'motivazione_rifiuto' va valorizzata solo se 'approvato' = FALSE
-- Il prezzo deve essere ≥ 0 per evitare valori negativi
--  L'attributo 'approvato' non può essere modificato una volta impostato
--  Un prodotto può essere eliminato solo se rifiutato (trigger)
