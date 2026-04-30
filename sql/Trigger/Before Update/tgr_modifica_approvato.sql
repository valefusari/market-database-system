DROP TRIGGER IF EXISTS tgr_modifica_approvato;

DELIMITER $$

CREATE TRIGGER tgr_modifica_approvato
BEFORE UPDATE ON prodotto_candidato
FOR EACH ROW
BEGIN
    -- Impedisce modifiche a 'approvato' se era già stato impostato
    IF OLD.approvato IS NOT NULL AND NEW.approvato <> OLD.approvato THEN
        SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Il campo approvato non può essere modificato una volta impostato';
    END IF;
END$$

DELIMITER ;
-- 1. Inseriamo un prodotto con approvato = NULL (non valutato ancora)
INSERT INTO prodotto_candidato (
    codice_prodotto, nome_prodotto, prezzo, produttore,
    spedito, approvato, URL, data_spedizione
) VALUES (
    'PC00000110', 'Prodotto neutro', 59.99, 'Test',
    0, NULL, 'https://test.com', NULL
);
-- Questo DEVE funzionare (prima impostazione)
UPDATE prodotto_candidato
SET approvato = 1
WHERE codice_prodotto = 'PC00000110';
-- Questo DEVE FALLIRE (modifica non permessa)
UPDATE prodotto_candidato
SET approvato = 0
WHERE codice_prodotto = 'PC00000110';

