DROP TRIGGER IF EXISTS tgr_cancellazione_prodotto;
DELIMITER $$
CREATE TRIGGER tgr_cancellazione_prodotto
BEFORE DELETE ON prodotto_candidato
FOR EACH ROW
BEGIN
  DECLARE count_incompleti INT;

  -- Se 'approvato' è NULL → blocca
  IF OLD.approvato IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Errore: non puoi cancellare un prodotto se "approvato" è NULL.';
  END IF;

  -- Se 'approvato' è TRUE
  IF OLD.approvato = TRUE THEN

    -- Se non è stato spedito → blocca
    IF OLD.spedito = FALSE THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Errore: non puoi cancellare un prodotto approvato se non è stato spedito.';
    END IF;

    -- Conta quante richieste d'acquisto associate NON sono terminate
    SELECT COUNT(*)
    INTO count_incompleti
    FROM acquisto
    WHERE codice_prodotto_candidato = OLD.codice_prodotto
      AND stato != 'terminato';

    -- Se ci sono richieste aperte → blocca
    IF count_incompleti > 0 THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Errore: non puoi cancellare un prodotto approvato se ci sono richieste d\'acquisto non terminate.';
    END IF;

  END IF;

END$$

DELIMITER ;
