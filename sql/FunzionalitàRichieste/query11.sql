-- timestampdiff esegue la differenza tra due ore nella forma YYYY-MM-DD HH:MM:SS, il primo parametro indica la precisione, se la voglio in secondi second, minuti minute, hour ore ecc...
SELECT 
    a.codice_tecnico,
    AVG(TIMESTAMPDIFF(HOUR, a.data_richiesta, p.data_spedizione)) AS tempo_medio_evasione_ore,
    AVG(TIMESTAMPDIFF(DAY, a.data_richiesta, p.data_spedizione)) AS tempo_medio_evasione_giorni,
    COUNT(*) AS numero_ordini_elaborati
FROM 
    acquisto a
    JOIN prodotto_candidato p ON a.codice_prodotto_candidato = p.codice_prodotto
WHERE 
    a.codice_tecnico IS NOT NULL 
    AND a.codice_prodotto_candidato IS NOT NULL 
    AND a.approvato = TRUE 
    AND p.spedito = TRUE
    AND p.data_spedizione IS NOT NULL
GROUP BY 
    a.codice_tecnico
ORDER BY 
    tempo_medio_evasione_ore;