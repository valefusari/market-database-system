DELIMITER $

CREATE PROCEDURE eliminazione_richiesta(IN id_richiesta INTEGER)
BEGIN
    DECLARE stato_richiesta VARCHAR(10);
    DECLARE codice_t VARCHAR(6);
    DECLARE richiesta_esiste INTEGER;

    -- Verifica se la richiesta esiste
    SELECT COUNT(*) INTO richiesta_esiste
    FROM acquisto
    WHERE ID = id_richiesta;

    IF richiesta_esiste = 0 THEN
        SELECT CONCAT('Errore: la richiesta ', id_richiesta, ' non esiste') AS messaggio;
    ELSE
        -- Prende stato e codice tecnico della richiesta
        SELECT stato, codice_tecnico
        INTO stato_richiesta, codice_t
        FROM acquisto
        WHERE ID = id_richiesta
        LIMIT 1;

        IF stato_richiesta = 'terminato' THEN
            -- Elimina la richiesta e aggiorna il contatore del tecnico
            DELETE FROM acquisto WHERE ID = id_richiesta;
            UPDATE tecnico_incaricato
            SET richieste_gestite = richieste_gestite + 1
            WHERE codice = codice_t;

            SELECT 'Richiesta eliminata con successo' AS messaggio;
        ELSE
            SELECT CONCAT('Richiesta non eliminata: stato attuale "', stato_richiesta, '" (richiesto "terminato")') AS messaggio;
        END IF;
    END IF;
END $
DELIMITER ;
CALL eliminazione_richiesta(1);

