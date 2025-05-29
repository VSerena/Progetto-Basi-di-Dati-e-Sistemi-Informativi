############################################################################
########################      Progetto BSDI        #########################
##################      7030223 Vannacci Serena       ######################
############################################################################


############################################################################
########################     Creazione database     ########################
############################################################################


DROP DATABASE IF EXISTS DBTeatri;
CREATE DATABASE DBTeatri;
USE DBTeatri;


#####################     Tabella Amministratore     #######################


CREATE TABLE IF NOT EXISTS Amministratore(
nome varchar(15) not null,
cognome varchar(15) not null,
id char(15) primary key
) ENGINE=INNODB;


#########################     Tabella Teatro     ###########################


CREATE TABLE IF NOT EXISTS Teatro(
nome varchar(20) primary key,
indirizzo varchar(25),
numeroDiTelefono int,
amministratore char(15),
foreign key (amministratore) references Amministratore(id)
) ENGINE=INNODB;


########################     Tabella Dipendenti     ##########################


CREATE TABLE IF NOT EXISTS Dipendenti(
nome varchar(15),
cognome varchar(15),
mansione enum('Cassiere','Addetto alle pulizie'),
CF_dipendente char(16) primary key,
nominativo_teatro varchar(20),
data_assunzione date,
foreign key (nominativo_teatro) references Teatro(nome) 
) ENGINE=INNODB;


###########################     Tabella Sala     #############################


CREATE TABLE IF NOT EXISTS Sala(
cod_sala int,
numeroPosti int,
nome_teatro varchar(20),
primary key(cod_sala, nome_teatro),
foreign key (nome_teatro) references Teatro(nome) 
) ENGINE=INNODB;


########################     Tabella Produttore     ##########################


CREATE TABLE IF NOT EXISTS Produttore(
cod varchar(25) primary key,
nome varchar(20),
cognome varchar(20),
dataDiNascita date
) ENGINE=INNODB;


##########################     Tabella Genere     ############################


CREATE TABLE IF NOT EXISTS Genere(
cod varchar(3) primary key,
nome varchar(30) unique
) ENGINE=INNODB;


########################     Tabella Spettacoli     ##########################


CREATE TABLE IF NOT EXISTS Spettacoli(
titolo varchar(30) primary key,
produttore varchar(20),
genere varchar(10),
durata int,
foreign key (produttore) references Produttore(cod) ,
foreign key (genere) references Genere(cod) 
) ENGINE=INNODB;


#####################     Tabella Programmazione     #######################


CREATE TABLE IF NOT EXISTS Programmazione(
titolo varchar(30),
sala int,
teatro varchar(20),
orarioDiInizio time,
primary key(sala, orarioDiInizio, teatro),
foreign key (teatro) references Teatro(nome) ,
foreign key (sala) references Sala(cod_sala) ,
foreign key (titolo) references Spettacoli(titolo) 
) ENGINE=INNODB;


##########################     Tabella Attori     ############################


CREATE TABLE IF NOT EXISTS Attori(
CF varchar(16) primary key,
nome varchar(20),
cognome varchar(20),
data date,
via varchar(50),
provincia varchar(5),
numeroDiTelefono int,
stipendio int,
ruolo enum('protagonista','coprotagonista','comparsa'),
titolo varchar(30),
foreign key (titolo) references Spettacoli(titolo)
) ENGINE=INNODB;


########################     Tabella ImpiegoPassato     ##########################


CREATE TABLE IF NOT EXISTS ImpiegoPassato(
  CF_dipendente char(16),
  teatro varchar(20),
  data_inizio date,
  data_fine date,
  primary key(CF_dipendente, teatro),
  FOREIGN KEY(CF_dipendente) REFERENCES Dipendenti(CF_dipendente),
  FOREIGN KEY(teatro) REFERENCES Teatro(nome)
)ENGINE=INNODB;


#############################################################################
#########################  Popolamento Database  ############################
#############################################################################


INSERT INTO Amministratore VALUES
('Daniele', 'Rossi', 'DNBPCED4A89VOO6'),
('Matteo','Cambi', 'MCIV63P4DZ32SN0'),
('Alice', 'Bianchi', 'ABQUDDU8YSGZRCO'),
('Teresa', 'Bianco', 'TB02QVRDFL6FTQY');

select * from Amministratore;

INSERT INTO Teatro VALUES
('ODEON', 'Viale Morgagni', 055987855, 'DNBPCED4A89VOO6'),
('ASTORIA', 'Viale Adua', 057377654, 'MCIV63P4DZ32SN0' ),
('ARISTON', 'Via Monterosa', 050378654, 'ABQUDDU8YSGZRCO' ),
('KURSAAL',  'Viale dei mille', 057799653, 'MCIV63P4DZ32SN0' ),
('TEATRO TRAETTA', 'Via Galilei', 057587267, 'TB02QVRDFL6FTQY' );

select * from Teatro;

LOAD DATA LOCAL INFILE 'dipendenti.in'
INTO TABLE Dipendenti
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '|'
LINES TERMINATED BY '\r\n';

select * from Dipendenti;

INSERT INTO ImpiegoPassato VALUES   
('8YFANK814W9OZUS','ODEON', '2018-01-24', '2018-07-28'), #Fabio Tesi
('NV8Q2G88NLQ9PMF', 'KURSAAL', '2018-01-24', '2019-05-05'), #Elisa Vienni
('UDG9O7QEZ4M4SF3', 'TEATRO TRAETTA', '2018-11-07', '2019-03-27'), #Erika Lenzi
('F12RWJEHZPBA9J6', 'ODEON', '2018-01-14','2018-03-10'), #Davide Maccione
('0SWZY0I39PL99WU','KURSAAL', '2019-01-20', '2020-01-30' ), #Camilla Gori
('BR2HAEIRK0SIRSH', 'TEATRO TRAETTA', '2016-01-11' , '2018-07-27'), #Mattia Spinelli
('I2C0BR3F50C16LL', 'TEATRO TRAETTA', '2017-01-08', '2018-10-24'), #Lorenzo Bruni
('I2C0BR3F50C16LL', 'KURSAAL', '2015-01-08', '2017-01-08'),  #Lorenzo Bruni
('FIQC7WPOQ0618ZI', 'KURSAAL', '2014-02-14', '2018-11-05'); #Valerio Cirino

select * from ImpiegoPassato;

INSERT INTO Sala VALUES
('1', '100', 'KURSAAL'),
('2', '50', 'KURSAAL'),
('1', '200', 'TEATRO TRAETTA'),
('2', '150', 'TEATRO TRAETTA'),
('1', '300', 'ASTORIA'),
('2', '300', 'ASTORIA'),
('1', '450', 'ODEON'),
('2 ','300', 'ODEON'),
('3 ','250','ODEON'),
('1', '900', 'ARISTON'),
('2', '500', 'ARISTON'),
('3', '450', 'ARISTON'),
('4 ','300', 'ARISTON');

select * from Sala;

INSERT INTO Genere VALUES
('001', 'Animazione teatrale'),
('002', 'Balletto'),
('003', 'Burlesque'),
('004', 'Cabaret'),
('005', 'Café-concert'),
('006', 'Closet drama'),
('007', 'Commedia'),
('008','Commedia romantica'),
('009', 'Improvvisazione teatrale'),
('010','Melodramma'),
('011', 'Mimo'),
('012','Monologo'),
('013', 'Musical'),
('014','Performance art'),
('015','Tragedia');

select * from Genere;

LOAD DATA LOCAL INFILE 'produttori.in'
INTO TABLE Produttore
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '|'
LINES TERMINATED BY '\r\n';

select * from Produttore;


INSERT INTO Spettacoli VALUES
('Le Danaidi', '20510', '009', '2'),
('The Baltimore Waltz', '30782', '004', '1'),
('Peter and Alice', '45861', '002', '1'),
('LA GAIA SCIENZA', '10790', '014', '2'),
('QUANDO SARÒ CAPACE DI AMARE', '21182', '003', '1'),
('DA ROMA A BUENOS AIRES', '72044', '010', '1'),
('LA CLASSE', '30782', '001', '2'),
('SE QUESTO E’ UN UOMO', '72044', '015', '2'),
('IL DELITTO DI VIA DELL’ORSINA', '96614', '003', '1'),
('SERVO DI SCENA', '15248', '010', '1'),
('IL REGNO DELLE OMBRE', '19768', '015', '2'),
('IL MALATO IMMAGINARIO', '19768', '015', '2'),
('UNA VITA PER UN’IDEA', '29651', '012', '1');

select * from Spettacoli;

INSERT INTO  Programmazione VALUES
('Le Danaidi', '1', 'ODEON', '20:00'),
('The Baltimore Waltz', '1', 'ODEON', '22:00'),
('Peter and Alice', '2', 'ODEON', '20:00'),
('LA GAIA SCIENZA', '1', 'ASTORIA', '21:00'),
('QUANDO SARÒ CAPACE DI AMARE', '2', 'ASTORIA', '21:00'),
('DA ROMA A BUENOS AIRES', '1', 'TEATRO TRAETTA', '19:00'),
('LA CLASSE', '2', 'KURSAAL', '21:00'),
('SE QUESTO E’ UN UOMO', '2', 'TEATRO TRAETTA', '21:30'),
('IL DELITTO DI VIA DELL’ORSINA', '1', 'KURSAAL', '20:00'),
('SERVO DI SCENA', '1', 'KURSAAL', '22:00'),
('IL REGNO DELLE OMBRE', '1', 'ARISTON', '21:00'),
('IL MALATO IMMAGINARIO', '3', 'ARISTON', '20:00'),
('UNA VITA PER UN’IDEA', '1', 'TEATRO TRAETTA', '22:00');

select * from Programmazione;

INSERT INTO  Attori VALUES
("CHH19KJF5Z0EUL9F", "Laila", "Faraoni", '1991-08-02', "Via Margutta Roma", "Si", 395378477, 800,  "comparsa", "SERVO DI SCENA"),
("B837VOGT5PDSWBYR", "Fabrizio", "Faoni", '1990-08-02', "Via Roma", "Si", 399378977, 800,  "comparsa", "LA CLASSE"),
("HZ860WCI98MDUAM", "Lucrezia", "Severini", '1961-04-05', "Via dell'Oriuolo", "Po", 916518531, 800,  "comparsa", "SERVO DI SCENA"),
("VMPY4JZRI75D9HQ", "Valter", "Marconi", '1964-10-27', "Via degli Arazzieri", "Fi",  991619755, 2000, "protagonista", "Le Danaidi"),
("ZUDQPLMR2M75PFW", "Gaio", "Giromondi", '1973-12-03', "Via delle Belle Donne",  "Fi",  560173750, 850, "comparsa", "IL REGNO DELLE OMBRE"),
("VY1HFHC2M7GPUQM", "Francesca", "Conti", '1985-09-25', "Viale Belfiore",  "Fi",  085734547, 900, "comparsa", "Peter and Alice"),
("YJXEEJONF5JYXPA", "Paolo", "Bersani", '2001-08-24', "Via del Campanile",  "Lu", 582305103, 1500, "coprotagonista", "IL DELITTO DI VIA DELL’ORSINA"),
("RX5TKKDC41UT52Z", "Ginevra", "Lunghi", '1981-12-04', "Via Vittorio Emanuele II", "Fi",   842815984, 1900, "protagonista","The Baltimore Waltz"),
("PNK1NH3DONHOTR1", "Pietro", "Dimola", '1973-09-27', "Via Ghibellina",  "Al", 024221832, 1200, "coprotagonista", "IL REGNO DELLE OMBRE"),
("O34OIQE4OWYVHSB", "Giacomo", "Travazzi", '2003-11-25', "Via Nazionale", "Al",  341338195, 800, "comparsa", "IL MALATO IMMAGINARIO"),
("EW3OBPO6XXDI87M", "Sofia", "Fiordi", '2000-08-30', "Via Pistoiese", "Fi",  163020381, 1250, "coprotagonista", "LA CLASSE"),
("0GEH139KV0QR0JO", "Maddalena", "Ria", '1979-11-22', "Viale Redi", "Pt",  252500964, 1300, "coprotagonista", "UNA VITA PER UN’IDEA"),
("88KT1GPKI2W3S2Z", "Geronimo", "Raimondi", '1985-03-22', "Via Sant'Antonino", "Pt", 936768936, 950, "comparsa", "DA ROMA A BUENOS AIRES"),
("E7EC7YTU2WZKWTZ", "Kevin", "Kley", '1996-06-20', "Via della Vigna Nuova",  "Lu",  748792805, 2100, "protagonista", "SE QUESTO E’ UN UOMO"),
("6A9Z8V5RI9WNM5C", "William", "Hargreevs", '2001-02-19', "Via delle Torri",  "Or",  624264527, 1975, "protagonista", "LA GAIA SCIENZA"),
("NY9JQNU5SSG7QV8", "Xavier", "Frizzi", '1981-04-09', "Via dei Servi",  "Pi",  087821735, 1400, "coprotagonista", "QUANDO SARÒ CAPACE DI AMARE"),
("IVOM5V2ED8EZVIV", "Ugo", "Foschia", '1966-09-05', "Via San Carlo", "Pi",  543074081, 800, "comparsa", "IL MALATO IMMAGINARIO"),
("T9FEYARS21ZJCJG", "Elena", "Troisi", '1994-11-22', "Via Pratese",  "Pi",  062448712, 1800, "protagonista", "DA ROMA A BUENOS AIRES"),
("FZA674SLW9ISMZX", "Sara", "Amandola", '1993-02-12', "Via Por Santa Maria",  "Po", 784532746, 1000, "comparsa", "SE QUESTO E’ UN UOMO");

select * from Attori;


############################################################################
########################      Interrogazioni       #########################
############################################################################


#1 Trovare il nome e il cognome degli attori protagonisti che vivono a Firenze o a Prato


select Nome, Cognome
from Attori
where provincia='Fi' or provincia='Po'
order by cognome;


#2 Trovare il nome e il cognome degli attori che hanno recitato in una tragedia


select A.Nome, A.Cognome 
from attori A, spettacoli S, genere G
where A.titolo=S.titolo and G.cod= S.genere and G.cod=015;
	
                    
#3 Trovare i produttori di tragedie


select distinct nome, cognome 
from produttore P join spettacoli S on P.cod=S.produttore
where genere =015;


#4 Trovare i produttori che hanno prodotto più di uno spettacolo


select nome, cognome, count(*)
from produttore P join spettacoli S on P.cod=S.produttore
group by cod
having count(*)>1
order by cod;


#5 Trovare nome, cognome e ruolo degli attori che hanno recitato negli spettacoli in sala dopo le 21:00


select Nome, Cognome, Ruolo, S.Titolo
from attori A
 join spettacoli S  on S.titolo=A.titolo
 join programmazione P on P.titolo=A.titolo
where orarioDiInizio between '21:00' and '24:00' ;


#6 Trovare i dipendenti(nome e cognome) il cui nome inizia con E che hanno lavorato in più di un teatro


select Nome, Cognome
from dipendenti natural join impiegopassato
where nome like 'E%';

#7 Estrarre gli spettacoli in programmazione dal teatro gestito da amministratori il cui cognome finisce per la lettera i


select S.Titolo
from spettacoli S
 join programmazione P on S.titolo= P.titolo
 join teatro T on P.teatro=T.nome
 join amministratore A on T.amministratore=A.id
 where A.cognome like '%i';


#8 Estrarre l'attore più pagato negli spettacoli in programmazione nel teatro con più sale e relativo stipendio


select A.nome, A.cognome, MAX(A.stipendio)
from attori A 
join spettacoli S on A.titolo=S.titolo
join programmazione P on S.titolo= P.titolo
join teatro T on P.teatro=T.nome
 where T.nome = (select nome_teatro
from SALA 
group by nome_teatro
order by count(*) desc
limit 1);


#9 Estrarre nome, cognome degli attori che guadagnano più della media dello stipendio


select nome, cognome
from attori 
where stipendio > (select avg(stipendio)
					from attori);
  
  
#10 Estrarre nome, cognome dell'attore più pagato e il nome del teatro in cui si esibisce


select A.nome, A.cognome, P.teatro
from attori A join Programmazione P on A.titolo= P.titolo
where A.stipendio = (select Max(stipendio)
					from attori) ;

                    
############################################################################
#############################      Viste      ##############################
############################################################################


#Vista sui dipendenti che lavorano al teatro Ariston


DROP VIEW IF EXISTS DipendentiAriston;
CREATE VIEW DipendentiAriston AS
	SELECT *
		FROM Dipendenti D
		WHERE D.nominativo_teatro="Ariston"
	WITH LOCAL CHECK OPTION;
SELECT * FROM DipendentiAriston;

INSERT INTO DipendentiAriston VALUES ('Luca', 'Padovani','cassiere', "H3IB6IK17EGJ0CK0", "ARISTON", '2021-10-20');
#INSERT INTO DipendentiAriston VALUES ('Luca', 'Padovani','cassiere', "H3IB6IK17EGJ0CK0", "ODEON", '2021-10-20'); 
#Errore per la check option, Odeon viola la clausola where della select definita nela vista DipendentiAriston

SELECT * FROM DipendentiAriston;
SELECT * FROM Dipendenti WHERE nominativo_teatro="Ariston";


#Vista sugli attori che recitano nel ruolo di protagonisti


DROP VIEW IF EXISTS Protagonisti;
CREATE VIEW Protagonisti AS
	SELECT *
		FROM Attori A
		WHERE A.ruolo="Protagonista"
	WITH LOCAL CHECK OPTION;
SELECT * FROM Protagonisti;


#Vista sugli attori che recitano nel ruolo di protagonisti nelle tragedie


DROP VIEW IF EXISTS ProtagonistiTragedie;
CREATE VIEW ProtagonistiTragedie AS
	SELECT P.nome, P.cognome
		FROM Protagonisti P JOIN  Spettacoli S ON P.titolo=S.titolo
			JOIN Genere G ON G.cod=S.genere AND G.cod=015;
SELECT * FROM ProtagonistiTragedie;


#Vista sugli attori nati nel XIX secolo.


DROP VIEW IF EXISTS XIXAttori;
CREATE VIEW XIXAttori AS
	SELECT concat(A.Nome,' ', A.Cognome) as Attore_Del_XIXsec
		FROM Attori A where data like '1%';
SELECT * FROM XIXAttori;


############################################################################
###########################      Procedure      ############################
############################################################################


DROP PROCEDURE IF EXISTS RicercaInformazioniSpettacolo;

DELIMITER $$
CREATE PROCEDURE RicercaInformazioniSpettacolo(Titolo VARCHAR(70))
BEGIN
SELECT DISTINCT Titolo, Sala, OrarioDiInizio as Orario, concat(durata,'h') as Durata, Teatro, concat(Pr.nome, ' ', Pr.cognome) as Autore , G.nome as Genere
		FROM Spettacoli S 
			JOIN Programmazione P ON S.titolo=P.titolo
			JOIN Produttore Pr ON S.produttore=Pr.cod
            JOIN Genere G ON G.cod=S.genere
		WHERE S.Titolo=Titolo;
END $$
DELIMITER ;

CALL RicercaInformazioniSpettacolo("SERVO DI SCENA");
CALL RicercaInformazioniSpettacolo("IL MALATO IMMAGINARIO");


DROP PROCEDURE IF EXISTS RicercaAttoriSpettacolo;

DELIMITER $$
CREATE PROCEDURE RicercaAttoriSpettacolo(Titolo VARCHAR(70))
BEGIN
SELECT DISTINCT Titolo, concat(A.nome, ' ', A.cognome)as Attori
		FROM Spettacoli S 
			JOIN Attori A ON S.titolo=A.titolo
		WHERE S.Titolo=Titolo;
END $$
DELIMITER ;

CALL RicercaAttoriSpettacolo("SERVO DI SCENA");
CALL RicercaAttoriSpettacolo("IL MALATO IMMAGINARIO");


DROP PROCEDURE IF EXISTS OrdinaSpettacoliPerGenereEOrario;

DELIMITER $$
CREATE PROCEDURE OrdinaSpettacoliPerGenereEOrario()
BEGIN
SELECT S.Titolo as Spettacolo, G.nome as Genere, P.orarioDiInizio as Orario
FROM Spettacoli S 
		join Genere G on S.genere=G.cod
		join Programmazione P on S.titolo=P.titolo
order by G.cod and P.orarioDiInizio; 
END $$
DELIMITER ;

CALL OrdinaSpettacoliPerGenereEOrario;


DROP PROCEDURE IF EXISTS RicercaMansioneDipendentiTeatro;

DELIMITER $$
CREATE PROCEDURE RicercaMansioneDipendentiTeatro(Ruolo VARCHAR(30),Teatro VARCHAR(20))
BEGIN
SELECT CONCAT(Nome,' ', cognome) AS Dipendente from Dipendenti where Mansione=Ruolo and nominativo_teatro=Teatro;
END $$
DELIMITER ;

CALL RicercaMansioneDipendentiTeatro("Cassiere","KURSAAL");
CALL RicercaMansioneDipendentiTeatro("Addetto alle pulizie","Ariston");


DROP PROCEDURE IF EXISTS RicercaImpiegati;

DELIMITER $$
CREATE PROCEDURE RicercaImpiegati(Teatro VARCHAR(20))
BEGIN
SELECT DISTINCT concat(D.nome,' ', D.cognome) as Dipendente
		FROM (select CF_dipendente from ImpiegoPassato I where I.teatro= Teatro) as result natural join Dipendenti D
        union select concat(D2.nome,' ', D2.cognome) as Dipendente from Dipendenti D2 where nominativo_teatro= Teatro;
END $$
DELIMITER ;

CALL RicercaImpiegati("KURSAAL");


############################################################################
############################      Trigger      #############################
############################################################################

DROP TRIGGER IF EXISTS CodiceGenere;

DELIMITER $$
CREATE TRIGGER CodiceGenere
BEFORE INSERT ON Genere
FOR EACH ROW
BEGIN
IF LEFT(NEW.cod,1)<>'0' THEN SET NEW.cod=concat('0',substring(new.cod,1,2));
END IF ;
END $$
DELIMITER ;

 
 INSERT INTO Genere VALUES
('222', 'Gioco dal vivo'),
('17', 'Gioco'),
('018', 'Vivo');

SELECT * FROM GENERE order by cod;
