# Progetto-Basi-di-Dati-e-Sistemi-Informativi

Progetto didattico per il corso Basi di Dati e Sistemi Informativi finalizzato allo sviluppo di competenze nella modellazione concettuale e logica dei dati, nella scrittura avanzata di SQL, nell'utilizzo di MySQL e nella documentazione tecnica, applicate alla progettazione e gestione di un sistema informativo relazionale completo per la gestione dei teatri.

## 📘 Progetto BDSI – Gestione Teatri

Il progetto ha l'obiettivo di progettare e implementare una base di dati relazionale per la **gestione dei teatri** comunali. Il sistema consente di:

* Gestire informazioni sui teatri, amministratori, dipendenti e sale.
* Organizzare la **programmazione teatrale giornaliera**.
* Gestire **spettacoli**, **attori**, **produttori** e **generi teatrali**.
* Tracciare l'**impiego attuale e passato** dei dipendenti.

---

## 🧱 Struttura del Database

Il database si chiama `DBTeatri` ed è composto dalle seguenti tabelle:

| Tabella          | Descrizione                                                      |
| ---------------- | ---------------------------------------------------------------- |
| `Amministratore` | Dati anagrafici e identificativi degli amministratori dei teatri |
| `Teatro`         | Informazioni anagrafiche e strutturali dei teatri                |
| `Sala`           | Sale presenti nei teatri                                         |
| `Dipendenti`     | Personale attualmente in servizio                                |
| `ImpiegoPassato` | Impieghi precedenti dei dipendenti                               |
| `Genere`         | Classificazione dei generi teatrali                              |
| `Produttore`     | Informazioni sui produttori degli spettacoli                     |
| `Spettacoli`     | Dettagli delle opere teatrali                                    |
| `Programmazione` | Programmazione giornaliera degli spettacoli                      |
| `Attori`         | Anagrafiche e ruoli degli attori                                 |

---

## 🗄️ Esempio di Popolamento

Sono presenti:

* **5 teatri**, ciascuno con diverse **sale** (es. ASTORIA, ODEON, etc.)
* **Diversi amministratori** e **dipendenti**, alcuni con **impieghi passati**
* Spettacoli con **titolo, genere, durata e produttore**
* Programmazione per ogni spettacolo e sala
* Attori con **ruolo (protagonista, coprotagonista, comparsa)** e **stipendio**

I file di caricamento dati esterni (`dipendenti.in`, `produttori.in`) sono gestiti tramite `LOAD DATA`.

---

## 🔍 Interrogazioni SQL Implementate

1. Attori protagonisti che vivono a Firenze o Prato
2. Attori che hanno recitato in una tragedia
3. Produttori di tragedie
4. Produttori con più di uno spettacolo
5. Attori negli spettacoli in sala dopo le 21:00
6. Dipendenti il cui nome inizia con "E" e che hanno lavorato in più teatri
7. Spettacoli gestiti da amministratori il cui cognome finisce per "i"
8. Attore più pagato nel teatro con più sale
9. Attori con stipendio superiore alla media
10. Attore più pagato e nome del teatro in cui si esibisce

---

## 👁️‍🗨️ Viste Create

* `DipendentiAriston`: contiene i dipendenti del teatro Ariston
* `Protagonisti`: attori con ruolo protagonista
* `ProtagonistiTragedie`: protagonisti che recitano in tragedie
* `XIXAttori`: attori nati nel XIX secolo

---

## ⚙️ Procedure Memorizzate

* `RicercaInformazioniSpettacolo(titolo)`
* `RicercaAttoriSpettacolo(titolo)`
* `OrdinaSpettacoliPerGenereEOrario()`
* `RicercaMansioneDipendentiTeatro(ruolo, teatro)`
* `RicercaImpiegati(teatro)`

---

## 🚨 Trigger Implementati

* `CodiceGenere`: corregge il formato del codice del genere se necessario (`'0XX'`)

---

## 🧩 Modellazione Concettuale

Realizzata mediante schema E-R (entità, relazioni, attributi):

* Teatri composti da più sale
* Amministratori possono gestire più teatri
* Dipendenti e i loro impieghi storici
* Spettacoli associati a genere, produttore, e attori

---

## 💾 Modellazione Logica

Implementazione relazionale:

* Attributi composti e generalizzazioni eliminati
* Chiavi esterne per assicurare integrità referenziale
* Normalizzazione fino alla **terza forma normale**

---

## 🧪 Esecuzione & Test

Le query, le viste, le procedure e i trigger sono **testati con dati di esempio**. Il file `.sql` include comandi `SELECT` per verificare il corretto popolamento ed esecuzione.

---

## 🛠️ Requisiti Tecnici

* RDBMS: **MySQL**
* File esterni: `dipendenti.in`, `produttori.in`
* Attivare il supporto per `LOCAL INFILE` se necessario

---

## 📤 Istruzioni per l’Esecuzione

1. Creare il database:

   ```sql
   DROP DATABASE IF EXISTS DBTeatri;
   CREATE DATABASE DBTeatri;
   USE DBTeatri;
   ```
2. Eseguire l’intero file `ProgettoBDSI.sql` in ambiente MySQL
3. Caricare i file `.in` ove specificato
4. Testare interrogazioni, viste, procedure e trigger
