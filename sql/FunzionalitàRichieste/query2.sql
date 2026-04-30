DELIMITER $
CREATE PROCEDURE assegna_tecnico(IN id_acquisto INTEGER, IN codice_tecnico_incaricato VARCHAR(6))
BEGIN
	UPDATE acquisto
    SET codice_tecnico = codice_tecnico_incaricato
    WHERE ID = id_acquisto;
END $
DELIMITER ;
call assegna_tecnico(2,"334562");