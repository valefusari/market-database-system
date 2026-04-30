DELIMITER $
CREATE PROCEDURE approvazione_prodotto(IN codice VARCHAR(10), IN ID_acquisto INTEGER)
BEGIN
	UPDATE prodotto_candidato
    JOIN acquisto ON prodotto_candidato.codice_prodotto = acquisto.codice_prodotto_candidato
    SET approvato = true
    where prodotto_candidato.codice_prodotto = codice AND acquisto.ID = ID_acquisto;
END $
DELIMITER ;
CALL approvazione_prodotto("PC00000004",3);