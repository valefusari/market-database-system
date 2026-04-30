DROP TRIGGER IF EXISTS tgr_set_data_spedizione;
DELIMITER $$

CREATE TRIGGER tgr_set_data_spedizione


DELIMITER $$

CREATE TRIGGER tgr_set_data_spedizione
BEFORE UPDATE ON prodotto_candidato
FOR EACH ROW
BEGIN
    DECLARE richiesta DATETIME;

    -- Verifica che spedito sia appena diventato TRUE
    IF NEW.spedito = TRUE AND OLD.spedito = FALSE THEN

        -- Recupera la data_richiesta dell'acquisto associato
        SELECT a.data_richiesta
        INTO richiesta
        FROM acquisto a
        WHERE a.codice_prodotto_candidato = NEW.codice_prodotto
        LIMIT 1;

        -- Imposta la data di spedizione a NOW()
        SET NEW.data_spedizione = NOW();

        -- Controlla che la data di spedizione sia >= data_richiesta
        IF NEW.data_spedizione < richiesta THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Errore: la data di spedizione deve essere maggiore o uguale alla data della richiesta di acquisto.';
        END IF;
    END IF;
END$$

DELIMITER ;
