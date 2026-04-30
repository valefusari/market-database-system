DROP TRIGGER IF EXISTS tgr_motivazione_rifiuto;

DELIMITER $$

CREATE TRIGGER tgr_motivazione_rifiuto
BEFORE UPDATE ON prodotto_candidato
FOR EACH ROW
BEGIN
    -- Se approvato = 0 → motivazione_rifiuto obbligatoria
    IF NEW.approvato = 0 THEN
        IF NEW.motivazione_rifiuto IS NULL OR NEW.motivazione_rifiuto = '' THEN
            SIGNAL SQLSTATE '45000'
              SET MESSAGE_TEXT = 'Devi valorizzare motivazione_rifiuto quando approvato = FALSE';
        END IF;
    
    -- Se approvato ≠ 0 (cioè 1 o NULL) → motivazione_rifiuto deve essere NULL
    ELSE
        IF NEW.motivazione_rifiuto IS NOT NULL THEN
            SIGNAL SQLSTATE '45000'
              SET MESSAGE_TEXT = 'motivazione_rifiuto deve essere NULL se approvato non è FALSE';
        END IF;
    END IF;
END$$

DELIMITER ;

UPDATE prodotto_candidato
SET approvato = 0, motivazione_rifiuto = NULL
WHERE codice_prodotto = 'PC00000120';