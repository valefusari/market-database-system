-- Inserimento di una richiesta di acquisto --
INSERT INTO acquisto(note,nome_categoria,email_ordinante) VALUES ("Può essere anche leggermente più piccolo delle dimensioni indicate","Monitor","luca.bianchi@gmail.com");
-- Per ogni caratteristica specificata dall'utente verrà inserito un record in caratteristiche acquisto --
-- In questo caso per quanto riguarda il Monitor si hanno solo colore e la grandezza del monitor --
INSERT INTO caratteristiche_acquisto(ID_acquisto,nome_caratteristica,specifica_caratteristica) VALUES (last_insert_id(),"Colore","Nero");
INSERT INTO caratteristiche_acquisto(ID_acquisto,nome_caratteristica,specifica_caratteristica) VALUES (last_insert_id(),"Dimensione","40 pollici");
	
    
    










