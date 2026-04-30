DROP TRIGGER IF EXISTS tgr_delete_personale;

DELIMITER $$

CREATE TRIGGER tgr_delete_personale
BEFORE DELETE ON personale
FOR EACH ROW
BEGIN
    IF OLD.data_licenziamento IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Non è possibile eliminare un membro del personale attivo: manca la data di licenziamento.';
    END IF;
END$$

DELIMITER ;
