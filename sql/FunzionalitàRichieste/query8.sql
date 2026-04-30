DELIMITER $
CREATE PROCEDURE estrazione_dati_richiesta(IN id_richiesta INTEGER)
BEGIN
	IF NOT EXISTS (SELECT 1 from acquisto where ID = id_richiesta) THEN
		SELECT "La richiesta inserita non esiste." as messaggio;
	ELSE
		SELECT email_ordinante,data_richiesta,note,nome_categoria,codice_prodotto_candidato,prezzo,
        group_concat(CONCAT(nome_caratteristica, ':', specifica_caratteristica) SEPARATOR ', ') as caratteristiche_scelte ,approvato,motivazione_rifiuto
        from acquisto JOIN prodotto_candidato ON codice_prodotto_candidato = codice_prodotto LEFT JOIN caratteristiche_acquisto ON ID_acquisto = ID -- utilizziamo il left join nel caso l'ordinante non abbia voluto specificare alcune caratteristiche --
        where ID = id_richiesta
        GROUP BY email_ordinante,data_richiesta,note,nome_categoria,codice_prodotto_candidato,prezzo,approvato,motivazione_rifiuto;
	END IF;
END $
DELIMITER ;
CALL estrazione_dati_richiesta(3);