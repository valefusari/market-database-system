# Database Market - Sistema di Acquisti Online

## Descrizione del Progetto
Il database **Market** è stato progettato per alimentare un sistema di acquisti online pensato per essere usato all'interno di un'organizzazione pubblica. 
Il sistema gestisce due tipologie principali di utenza: ordinanti (che definiscono le richieste di acquisto) e tecnici (che ricercano e ordinano i prodotti).

## Funzionalità Principali
Il sistema permette di:
* Definire richieste di acquisto basate su categorie e caratteristiche specifiche.
* Gestire la ricerca e l'associazione di "prodotti candidati" da parte del personale tecnico.
* Gestire l'approvazione, il rifiuto o la chiusura degli ordini da parte dell'ordinante, inclusa la gestione di resi per non conformità o malfunzionamenti.

## Struttura del Repository
* `/sql/`: Contiene gli script DDL per la creazione del database relazionale, i trigger per il rispetto dei vincoli e le procedure.
* `/docs/`: Contiene la relazione completa con progettazione concettuale (Modello ER) e progettazione logica.

