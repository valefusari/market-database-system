DELIMITER $
DROP procedure spesa_ordinante;
CREATE PROCEDURE spesa_ordinante(IN email_o VARCHAR(50), IN anno_solare INTEGER)
BEGIN
	IF NOT EXISTS (SELECT 1 from ordinante where email = email_o) THEN
		SELECT "L'ordinante inserito non è presente nel database." as messaggio;
	ELSE
		SELECT SUM(prezzo) as spesa_ordinante, email_ordinante
        from acquisto JOIN prodotto_candidato ON codice_prodotto_candidato = codice_prodotto
        WHERE email_ordinante = email_o AND stato = 'terminato' AND report_consegna = 'accettato' AND
			  spedito = true AND approvato = true AND YEAR(data_richiesta) = anno_solare
		GROUP BY email_ordinante;
	END IF;
END $
DELIMITER ;
CALL spesa_ordinante('luca.bianchi@gmail.com', 2025);