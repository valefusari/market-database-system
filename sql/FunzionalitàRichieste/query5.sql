DELIMITER $
CREATE PROCEDURE richieste_in_corso(IN ordinante VARCHAR(50))
BEGIN
	DECLARE possibili_richieste INTEGER;
	SELECT COUNT(*) INTO possibili_richieste from acquisto where email_ordinante = ordinante;
    IF possibili_richieste = 0 THEN
		SELECT "Non ci sono richieste attive o l'email inserita non è presente" as messaggio;
	ELSE
		SELECT * 
        from acquisto JOIN prodotto_candidato ON acquisto.codice_prodotto_candidato = prodotto_candidato.codice_prodotto
        where acquisto.stato = "in corso" AND acquisto.email_ordinante = ordinante AND prodotto_candidato.approvato IS NULL;
	END IF;
END $
DELIMITER ;