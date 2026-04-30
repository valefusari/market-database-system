DROP TRIGGER IF EXISTS tgr_check_caratteristica_categoria;

DELIMITER $$

CREATE TRIGGER tgr_check_caratteristica_categoria
BEFORE INSERT ON caratteristiche_acquisto
FOR EACH ROW
BEGIN
    DECLARE categoria_acquisto VARCHAR(20);

    -- Recupera la categoria associata all'acquisto
    SELECT nome_categoria
    INTO categoria_acquisto
    FROM acquisto
    WHERE ID = NEW.ID_acquisto;

    -- Verifica che la caratteristica sia compatibile con la categoria
    IF NOT EXISTS (
        SELECT 1
        FROM caratteristiche_categoria
        WHERE nome_categoria = categoria_acquisto
          AND nome_caratteristica = NEW.nome_caratteristica
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La caratteristica scelta non è valida per la categoria selezionata.';
    END IF;
END$$

DELIMITER ;
-- 'RAM' NON è associata alla categoria 'Monitor' → dovrebbe essere bloccata

INSERT INTO caratteristiche_acquisto (
    ID_acquisto, nome_caratteristica, specifica_caratteristica
) VALUES (
    2, 'RAM', '8GB'
);
-- ❌ Bloccato dal trigger
