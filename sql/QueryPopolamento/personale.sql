delete from personale;
INSERT INTO personale (email, password, nome, cognome, data_nascita, data_assunzione) VALUES
('admin1@email.com', SHA2('adminpass1',256), 'Laura', 'Rossi', '1985-04-10', '2020-01-15'),
('tecnico1@email.com', SHA2('tecnicopass1',256), 'Marco', 'Bianchi', '1990-07-22', '2021-05-20'),
('tecnico2@email.com', SHA2('tecnicopass2',256), 'Giulia', 'Verdi', '1995-02-12', '2022-03-10');

-- Un membro del personale può essere eliminato solo se ha data_licenziamento diversa a NULL
-- Le date di nascita sono scelte in modo che il personale tecnico sia maggiorenne.
-- Il vincolo dell’età ≥ 18 anni non è espresso direttamente nel DDL, ma deve essere verificato (es. via trigger ...)