DELIMITER $
CREATE PROCEDURE richieste_gestite_tecnico(IN codice_t VARCHAR(6))
BEGIN
	select richieste_gestite
    from tecnico_incaricato
    where codice = codice_t;
END $
DELIMITER ;
CALL richieste_gestite_tecnico("123456")