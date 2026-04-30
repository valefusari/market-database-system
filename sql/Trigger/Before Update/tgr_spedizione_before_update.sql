DROP TRIGGER IF EXISTS tgr_spedizione_before_update;

DELIMITER $$
CREATE TRIGGER tgr_spedizione_before_update
BEFORE UPDATE ON acquisto
FOR EACH ROW
BEGIN
      DECLARE spedito_flag BOOLEAN;
  -- Controlla se si sta tentando di impostare lo stato a 'terminato'
  IF NEW.stato = 'terminato' THEN
    -- Se è specificato un prodotto candidato
    IF NEW.codice_prodotto_candidato IS NOT NULL THEN
      -- Verifica che il prodotto sia stato spedito
      SELECT spedito
      INTO spedito_flag
      FROM prodotto_candidato
      WHERE codice_prodotto = NEW.codice_prodotto_candidato;

      IF spedito_flag = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Errore: impossibile impostare lo stato a "terminato" perché il prodotto non è stato spedito.';
      END IF;
    ELSE
      -- Se non è specificato alcun prodotto, non si può concludere l'acquisto
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Errore: impossibile impostare lo stato a "terminato" senza un prodotto candidato associato.';
    END IF;
  END IF;
END$$

DELIMITER ;
UPDATE acquisto
SET stato         = 'terminato',
    data_chiusura = NOW(),
    report_consegna = 'accettato'
WHERE ID = 9;