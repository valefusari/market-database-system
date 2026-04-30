DELIMITER $
CREATE PROCEDURE lista_tecnico(IN codice_t VARCHAR(6))
BEGIN
	DECLARE numero_richieste INTEGER;
    SELECT COUNT(*) INTO numero_richieste from acquisto where codice_tecnico = codice_t;
    IF numero_richieste = 0 THEN
		SELECT "Non ci sono richieste di acquisto relative al tecnico inserito." as messaggio;
	ELSE 
		SELECT *
        from acquisto JOIN prodotto_candidato ON acquisto.codice_prodotto_candidato = prodotto_candidato.codice_prodotto
        where acquisto.codice_tecnico = codice_t AND prodotto_candidato.approvato = true AND prodotto_candidato.spedito = false;
	END IF;
END $
DELIMITER ;
