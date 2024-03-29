DROP TABLE IF EXISTS Recensione;
DROP TABLE IF EXISTS Prenotazione;
DROP TABLE IF EXISTS Facilities;
DROP TABLE IF EXISTS Dipendenti;
DROP TABLE IF EXISTS Camera;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Albergo;
CREATE TABLE Albergo(
	albergoID INT PRIMARY KEY IDENTITY (1,1),
	nome VARCHAR(250) NOT NULL,
	indirizzo VARCHAR(250) NOT NULL,
	stelle_albergo INT NOT NULL CHECK (stelle_albergo BETWEEN 1 AND 5)
	UNIQUE(nome,indirizzo)
);

CREATE TABLE Cliente(
	clienteID INT PRIMARY KEY IDENTITY (1,1),
	nome VARCHAR(250) NOT NULL,
	cognome VARCHAR(250) NOT NULL,
	telefono VARCHAR(250) NOT NULL,
	email VARCHAR(250)
);

CREATE TABLE Camera(
	cameraID INT PRIMARY KEY IDENTITY (1,1),
	numero INT NOT NULL,
	tipo VARCHAR (250) NOT NULL CHECK (tipo IN ('singola','doppia','suite')),
	tariffa DECIMAL (5,2) NOT NULL,
	capacita_massima INT NOT NULL CHECK (capacita_massima >=0),
	albergoRIF INT NOT NULL,
	FOREIGN KEY (albergoRIF) REFERENCES Albergo (albergoID) ON DELETE CASCADE,
	UNIQUE (numero, albergoRIF)
);


CREATE TABLE Dipendenti (
	dipendentiID INT PRIMARY KEY IDENTITY (1,1),
	posizione VARCHAR(250) NOT NULL CHECK (posizione IN ('Receptionist','Manager','Pulizie')),
	nome VARCHAR(250) NOT NULL,
	cognome VARCHAR(250) NOT NULL,
	telefono VARCHAR(250) NOT NULL,
	email VARCHAR(250),
	albergoRIF INT NOT NULL,
	FOREIGN KEY(albergoRIF) REFERENCES Albergo (albergoID) ON DELETE CASCADE,
	UNIQUE(dipendentiID,albergoRIF)
);

CREATE TABLE Facilities (
	facilitiesID INT PRIMARY KEY IDENTITY (1,1),
	nome VARCHAR (250) NOT NULL, CHECK (nome IN ('Piscina','Spa','Palestra')),
	descrizione TEXT,
	orari_apertura VARCHAR(250),
	albergoRIF INT NOT NULL,
	FOREIGN KEY (albergoRIF) REFERENCES Albergo(albergoID) ON DELETE CASCADE,
	UNIQUE (facilitiesID,albergoRIF)
);



CREATE TABLE Prenotazione(
	prenotazioneID INT PRIMARY KEY IDENTITY (1,1),
	data_check_in DATE NOT NULL,
	data_check_out DATE NOT NULL, 
	clienteRIF INT,
	cameraRIF INT NOT NULL,
	FOREIGN KEY (clienteRIF) REFERENCES Cliente (clienteID) ON DELETE SET NULL,
	FOREIGN KEY (cameraRIF) REFERENCES Camera (cameraID) ON DELETE CASCADE,
	-- DA FINIRE
	-- RISOLVIAMO CON UN PROCESSO

);

CREATE TABLE Recensione(
	recensioneID INT PRIMARY KEY IDENTITY(1,1),
	valutazione INT CHECK (valutazione BETWEEN 1 AND 5),
	descrizione TEXT,
	prenotazioneRIF INT NOT NULL,
	FOREIGN KEY (prenotazioneRIF) REFERENCES Prenotazione(prenotazioneID) ON DELETE CASCADE
	 -- Verificare se la recensione pu� essere inserita a fine del soggiorno (checkout riempito)
);

INSERT INTO Albergo (nome, Indirizzo, stelle_albergo)
VALUES ('Sogni D''oro 1', 'Via Roma, 123, Roma, Italia', 4),
       ('Sogni D''oro 2', 'Piazza Garibaldi, 5, Milano, Italia', 5),
       ('Sogni D''oro 3', '100 Ocean Boulevard, Miami Beach, FL 33139, USA', 4);


INSERT INTO Cliente (nome, cognome, telefono, email)
VALUES ('Mario', 'Rossi', '+39 333 1234567', 'mario.rossi@example.com'),
       ('Laura', 'Bianchi', '+39 345 2345678', 'laura.bianchi@example.com'),
       ('Roberto', 'Verdi', '+39 333 3456789', 'roberto.verdi@example.com'),
       ('Anna', 'Esposito', '+39 345 4567890', 'anna.esposito@example.com'),
       ('Giuseppe', 'Russo', '+39 333 5678901', 'giuseppe.russo@example.com'),
       ('Sara', 'Romano', '+39 345 6789012', 'sara.romano@example.com'),
       ('Alessia', 'Colombo', '+39 333 7890123', 'alessia.colombo@example.com'),
       ('Luigi', 'Ferrari', '+39 345 8901234', 'luigi.ferrari@example.com'),
       ('Elena', 'Martini', '+39 333 9012345', 'elena.martini@example.com'),
       ('Marco', 'Moretti', '+39 345 0123456', 'marco.moretti@example.com');



INSERT INTO Camera (numero, tipo, tariffa, capacita_massima,albergoRIF)
VALUES ('101', 'Singola', 100, 1,3),
       ('102', 'Singola', 100, 1,2),
       ('103', 'Singola', 100, 1,1),
       ('201', 'Doppia', 150, 2,1),
       ('202', 'Doppia', 150, 2,1),
       ('203', 'Doppia', 150, 2,2),
       ('301', 'Suite', 250, 3,3),
       ('302', 'Suite', 250, 3,2),
       ('303', 'Suite', 250, 3,3),
       ('401', 'Singola', 100, 1,1),
       ('402', 'Singola', 100, 1,1),
       ('403', 'Singola', 100, 1,2),
       ('501', 'Doppia', 150, 2,2),
       ('502', 'Doppia', 150, 2,3),
       ('503', 'Doppia', 150, 2,3);

INSERT INTO Dipendenti (Posizione, Nome, Cognome, Telefono, Email,albergoRIF)
VALUES ('Receptionist', 'Giulia', 'Rossi', '+39 333 1234567', 'giulia.rossi@example.com',1),
       ('Manager', 'Marco', 'Bianchi', '+39 345 2345678', 'marco.bianchi@example.com',2),
       ('Receptionist', 'Alessia', 'Verdi', '+39 333 3456789', 'alessia.verdi@example.com',1),
       ('Manager', 'Roberto', 'Esposito', '+39 345 4567890', 'roberto.esposito@example.com',2),
       ('Pulizie', 'Luca', 'Russo', '+39 333 5678901', 'luca.russo@example.com',2),
       ('Receptionist', 'Francesca', 'Romano', '+39 345 6789012', 'francesca.romano@example.com',3),
       ('Manager', 'Paolo', 'Colombo', '+39 333 7890123', 'paolo.colombo@example.com',3),
       ('Pulizie', 'Elena', 'Ferrari', '+39 345 8901234', 'elena.ferrari@example.com',3),
       ('Receptionist', 'Simone', 'Martini', '+39 333 9012345', 'simone.martini@example.com',2),
       ('Pulizie', 'Chiara', 'Moretti', '+39 345 0123456', 'chiara.moretti@example.com',1);




INSERT INTO Facilities (nome, descrizione, orari_apertura,albergoRIF)
VALUES ('Piscina', 'Una piscina olimpionica con corsie separate per il nuoto e aree separate per il relax.', 'Lun-Ven 9:00-21:00, Sab-Dom 10:00-20:00',3),
       ('Spa', 'Una spa di lusso con sauna, bagno turco, vasca idromassaggio e varie opzioni di trattamento.', 'Lun-Dom 10:00-22:00',2),
       ('Palestra', 'Una palestra completamente attrezzata con attrezzature per il sollevamento pesi, macchine cardio e sale per lezioni di gruppo.', 'Lun-Ven 6:00-23:00, Sab-Dom 8:00-20:00',1)

INSERT INTO Prenotazione (data_check_in, data_check_out,cameraRIF,clienteRIF)
VALUES ('2024-03-15', '2024-03-20',3,1),
       ('2024-03-18', '2024-03-23',7,2),
       ('2024-03-21', '2024-03-24',9,3),
       ('2024-03-25', '2024-03-28',8,4),
       ('2024-03-28', '2024-04-02',6,5),
       ('2024-04-01', '2024-04-06',1,6),
       ('2024-04-05', '2024-04-09',2,7),
       ('2024-04-10', '2024-04-15',10,8),
       ('2024-04-15', '2024-04-20',11,9),
       ('2024-04-20', '2024-04-25',15,10);

INSERT INTO Recensione	(valutazione,descrizione,prenotazioneRIF)
	VALUES(1,'Camera brutta', 1),
	(5 ,'albergo ottimo',2),
	(3,'nella media',4)


--	   SELECT * FROM Prenotazione
--	   SELECT * FROM Albergo

--CREATE VIEW AlbergoConRelativiClienti AS 
--	SELECT al.nome AS 'Albergo', cl.nome + '' + cl.cognome AS 'Nominativo'
--		From Albergo al
--		JOIN Camera ca ON al.albergoID = ca.albergoRIF
--		JOIN Prenotazione pr ON ca.cameraID = pr.cameraRIF
--		JOIN Cliente cl ON pr.clienteRIF = cl.clienteID;
	
--CREATE VIEW AlbergoGeneraleClienti AS 
--SELECT albergoID,al.nome AS nome_albergo,indirizzo,cl.nome + ' '+cl.cognome AS 'Nominativo' 
--		From Albergo al
--		JOIN Camera ca ON al.albergoID = ca.albergoRIF
--		JOIN Prenotazione pr ON ca.cameraID = pr.cameraRIF
--		JOIN Cliente cl ON pr.clienteRIF = cl.clienteID;



--SELECT * 
--	FROM AlbergoGeneraleClienti
--	JOIN Facilities f ON AlbergoGeneraleClienti.albergoID = f.albergoRIF
--	ORDER BY nome_albergo;

----Conta tutti i clienti per un albergo
--SELECT COUNT(*) AS 'Numero Clienti' FROM AlbergoGeneraleClienti WHERE nome_albergo = 'Sogni D''oro 1';


--Voglio una view che mi visualizzi il nome dell'albergo e la media delle valutazioni
--CREATE VIEW MediaRecensioniPerAlbergo AS
--SELECT Albergo.nome, AVG (Recensione.valutazione) AS 'Media recensioni'
--	FROM Recensione
--	JOIN Prenotazione ON Recensione.prenotazioneRIF = Prenotazione.prenotazioneID
--	JOIN Camera ON Prenotazione.cameraRIF = Camera.cameraID
--	JOIN Albergo ON Camera.albergoRIF = Albergo.albergoID
--	GROUP BY Albergo.nome
CREATE VIEW alberghiRecensioniPrenotazioni AS 
SELECT 
Albergo.nome AS nome_albergo,
data_check_in,
data_check_out,
valutazione,
	descrizione,
	Cliente.nome AS nome_cliente,
	Cliente.cognome AS cognome_cliente
	FROM Albergo 
	JOIN Camera ON Albergo.albergoID= Camera.albergoRIF
	JOIN Prenotazione ON Camera.cameraID = Prenotazione.cameraRIF
	JOIN Recensione ON Prenotazione.prenotazioneID = Recensione.prenotazioneRIF
	JOIN Cliente ON Prenotazione.clienteRif = Cliente.clienteID

SELECT nome_albergo, AVG(valutazione)
	FROM alberghiRecensioniPrenotazioni
	GROUP BY nome_albergo;
DROP PROCEDURE IF EXISTS CheckDatePrenotation
CREATE PROCEDURE CheckDatePrenotation
    @check_in_value DATE,
    @check_out_value DATE,
    @cameraRIF INT,
    @clienteRIF INTAS VARCHAR
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        
        IF @check_out_value < @check_in_value
            THROW 50001, 'La data di check-in non pu� essere successiva alla data di check-out', 1;

        
         SELECT *
		 FROM Prenotazione
		 WHERE cameraRIF = @cameraRIF
         AND ((@check_in_value BETWEEN data_check_in AND data_check_out)
			OR (@check_out_value BETWEEN data_check_in AND data_check_out)
			OR (data_check_in BETWEEN @check_in_value AND @check_out_value)
			OR (data_check_out BETWEEN @check_in_value AND @check_out_value));

        IF @@ROWCOUNT > 0
            THROW 50002, 'La camera risulta gi� occupata durante il periodo selezionato', 1;
    


		INSERT INTO Prenotazione (data_check_in, data_check_out, cameraRIF, clienteRIF)
        VALUES (@check_in_value, @check_out_value, @cameraRIF, @clienteRIF);

        COMMIT TRANSACTION;

        PRINT 'Prenotazione effettuata con successo.';
    END TRY
    BEGIN CATCH
      
        ROLLBACK TRANSACTION;
        
        PRINT 'Ho riscontrato l''errore: ' + ERROR_MESSAGE();
    END CATCH
END;



EXEC CheckDatePrenotation @check_in_value = '2024-03-16' ,@check_out_value='2024-03-17', @cameraRIF=1,@clienteRIF=1
SELECT * FROM Prenotazione

SELECT *
	FROM Albergo
	JOIN Camera ON Albergo.albergoID = Camera.albergoRIF
	JOIN Prenotazione ON camera.cameraID = Prenotazione.cameraRIF

	DECLARE @dataIngresso DATE ='2024-03-16'
	DECLARE @dataUscita DATE ='2024-03-19'


SELECT  COUNT(*) 
	FROM Prenotazione 
	WHERE data_check_in <= @dataIngresso AND data_check_in >= @dataUscita

--Sull'esercizio degli alberghi, permettere la prenotazione solo tramite SP ed evitare che la prenotazione ne sovrasti una gi� attiva su una stanza.
