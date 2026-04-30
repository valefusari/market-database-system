CREATE DATABASE  IF NOT EXISTS `market` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `market`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: market
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acquisto`
--

DROP TABLE IF EXISTS `acquisto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acquisto` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `stato` varchar(10) DEFAULT 'in corso',
  `data_richiesta` datetime DEFAULT CURRENT_TIMESTAMP,
  `data_chiusura` datetime DEFAULT NULL,
  `report_consegna` varchar(50) DEFAULT NULL,
  `note` varchar(512) DEFAULT NULL,
  `codice_tecnico` varchar(6) DEFAULT NULL,
  `nome_categoria` varchar(20) NOT NULL,
  `codice_prodotto_candidato` varchar(10) DEFAULT NULL,
  `email_ordinante` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `codice_tecnico` (`codice_tecnico`),
  KEY `nome_categoria` (`nome_categoria`),
  KEY `codice_prodotto_candidato` (`codice_prodotto_candidato`),
  KEY `email_ordinante` (`email_ordinante`),
  CONSTRAINT `acquisto_ibfk_1` FOREIGN KEY (`codice_tecnico`) REFERENCES `tecnico_incaricato` (`codice`) ON DELETE SET NULL,
  CONSTRAINT `acquisto_ibfk_2` FOREIGN KEY (`nome_categoria`) REFERENCES `categoria` (`nome`) ON DELETE RESTRICT,
  CONSTRAINT `acquisto_ibfk_3` FOREIGN KEY (`codice_prodotto_candidato`) REFERENCES `prodotto_candidato` (`codice_prodotto`) ON DELETE SET NULL,
  CONSTRAINT `acquisto_ibfk_4` FOREIGN KEY (`email_ordinante`) REFERENCES `ordinante` (`email`) ON DELETE RESTRICT,
  CONSTRAINT `acquisto_chk_1` CHECK ((`report_consegna` in (_utf8mb4'accettato',_utf8mb4'respinto perchè non conforme',_utf8mb4'respinto perchè non funzionante',NULL))),
  CONSTRAINT `acquisto_chk_2` CHECK ((((`report_consegna` is not null) and (`stato` = _utf8mb4'terminato')) or ((`report_consegna` is null) and (`stato` = _utf8mb4'in corso')))),
  CONSTRAINT `acquisto_chk_3` CHECK ((`stato` in (_utf8mb4'in corso',_utf8mb4'terminato'))),
  CONSTRAINT `acquisto_chk_4` CHECK ((((`data_chiusura` is null) and (`report_consegna` is null) and (`stato` = _utf8mb4'in corso')) or ((`data_chiusura` is not null) and (`report_consegna` is not null) and (`stato` = _utf8mb4'terminato') and (`data_chiusura` >= `data_richiesta`))))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acquisto`
--

LOCK TABLES `acquisto` WRITE;
/*!40000 ALTER TABLE `acquisto` DISABLE KEYS */;
INSERT INTO `acquisto` VALUES (2,'in corso','2025-07-06 00:00:00',NULL,NULL,'Può essere anche leggermente più piccolo delle dimensioni indicate','334562','Monitor',NULL,'luca.bianchi@gmail.com'),(3,'in corso','2025-07-06 00:00:00',NULL,NULL,NULL,'123456','Stampante','PC00000004','marco@gmail.com');
/*!40000 ALTER TABLE `acquisto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amministratore`
--

DROP TABLE IF EXISTS `amministratore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amministratore` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `email_amministratore` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `email_amministratore` (`email_amministratore`),
  CONSTRAINT `amministratore_ibfk_1` FOREIGN KEY (`email_amministratore`) REFERENCES `personale` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amministratore`
--

LOCK TABLES `amministratore` WRITE;
/*!40000 ALTER TABLE `amministratore` DISABLE KEYS */;
INSERT INTO `amministratore` VALUES (1,'admin1@email.com');
/*!40000 ALTER TABLE `amministratore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caratteristiche`
--

DROP TABLE IF EXISTS `caratteristiche`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `caratteristiche` (
  `nome` varchar(20) NOT NULL,
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caratteristiche`
--

LOCK TABLES `caratteristiche` WRITE;
/*!40000 ALTER TABLE `caratteristiche` DISABLE KEYS */;
INSERT INTO `caratteristiche` VALUES ('Colore'),('CPU'),('Dimensione'),('Numero Porte USB'),('RAM'),('Sistema Operativo'),('Velocità di stampa');
/*!40000 ALTER TABLE `caratteristiche` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caratteristiche_acquisto`
--

DROP TABLE IF EXISTS `caratteristiche_acquisto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `caratteristiche_acquisto` (
  `ID_acquisto` int NOT NULL,
  `nome_caratteristica` varchar(20) NOT NULL,
  `specifica_caratteristica` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_acquisto`,`nome_caratteristica`),
  KEY `nome_caratteristica` (`nome_caratteristica`),
  CONSTRAINT `caratteristiche_acquisto_ibfk_1` FOREIGN KEY (`ID_acquisto`) REFERENCES `acquisto` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `caratteristiche_acquisto_ibfk_2` FOREIGN KEY (`nome_caratteristica`) REFERENCES `caratteristiche` (`nome`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caratteristiche_acquisto`
--

LOCK TABLES `caratteristiche_acquisto` WRITE;
/*!40000 ALTER TABLE `caratteristiche_acquisto` DISABLE KEYS */;
INSERT INTO `caratteristiche_acquisto` VALUES (2,'Colore','Nero'),(2,'Dimensione','40 pollici'),(3,'Colore','Rossa'),(3,'Velocità di stampa','3 pagine al secondo');
/*!40000 ALTER TABLE `caratteristiche_acquisto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caratteristiche_categoria`
--

DROP TABLE IF EXISTS `caratteristiche_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `caratteristiche_categoria` (
  `nome_categoria` varchar(20) NOT NULL,
  `nome_caratteristica` varchar(20) NOT NULL,
  PRIMARY KEY (`nome_categoria`,`nome_caratteristica`),
  KEY `nome_caratteristica` (`nome_caratteristica`),
  CONSTRAINT `caratteristiche_categoria_ibfk_1` FOREIGN KEY (`nome_categoria`) REFERENCES `categoria` (`nome`),
  CONSTRAINT `caratteristiche_categoria_ibfk_2` FOREIGN KEY (`nome_caratteristica`) REFERENCES `caratteristiche` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caratteristiche_categoria`
--

LOCK TABLES `caratteristiche_categoria` WRITE;
/*!40000 ALTER TABLE `caratteristiche_categoria` DISABLE KEYS */;
INSERT INTO `caratteristiche_categoria` VALUES ('Monitor','Colore'),('Scrivania','Colore'),('Smartphone','Colore'),('Stampante','Colore'),('Smartphone','CPU'),('Monitor','Dimensione'),('Scrivania','Dimensione'),('Notebook','Numero Porte USB'),('Smartphone','RAM'),('Smartphone','Sistema Operativo'),('Stampante','Velocità di stampa');
/*!40000 ALTER TABLE `caratteristiche_categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `nome` varchar(20) NOT NULL,
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES ('Monitor'),('Notebook'),('Scrivania'),('Smartphone'),('Stampante');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordinante`
--

DROP TABLE IF EXISTS `ordinante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordinante` (
  `email` varchar(50) NOT NULL,
  `password` varchar(512) NOT NULL,
  `citta` varchar(50) NOT NULL,
  `CAP` varchar(5) NOT NULL,
  `via` varchar(50) NOT NULL,
  `numero_civico` smallint NOT NULL,
  PRIMARY KEY (`email`),
  CONSTRAINT `lunghezza_CAP` CHECK (regexp_like(`CAP`,_utf8mb4'^[0-9]{5}$')),
  CONSTRAINT `o_email` CHECK (regexp_like(`email`,_utf8mb4'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordinante`
--

LOCK TABLES `ordinante` WRITE;
/*!40000 ALTER TABLE `ordinante` DISABLE KEYS */;
INSERT INTO `ordinante` VALUES ('luca.bianchi@gmail.com','eb91b4404ae0028f74aa78aad8ce00d206b987ddde20ea6a713d148842270b6f','Milano','20019','Torino',3),('marco@gmail.com','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','Torino','10121','Carlo ALberto',27),('mario@gmail.com','b5d776dcca1ed61311d5dda09342470ad9023ffea1d754fb8eb6e310c16ba2ce','Roma','00042','Giulia',23);
/*!40000 ALTER TABLE `ordinante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personale`
--

DROP TABLE IF EXISTS `personale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personale` (
  `email` varchar(50) NOT NULL,
  `password` varchar(512) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `data_nascita` date NOT NULL,
  `data_assunzione` date NOT NULL,
  `data_licenziamento` date DEFAULT NULL,
  PRIMARY KEY (`email`),
  CONSTRAINT `s_email` CHECK (regexp_like(`email`,_utf8mb4'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personale`
--

LOCK TABLES `personale` WRITE;
/*!40000 ALTER TABLE `personale` DISABLE KEYS */;
INSERT INTO `personale` VALUES ('admin1@email.com','ebcfc99aa881883fd9a06b78b50b140df65f2794470e444d57470345dacdb536','Laura','Rossi','1985-04-10','2020-01-15',NULL),('tecnico1@email.com','dc727112ba0546fe7bb0cc60698c2c0a12bae20113f47bcb115060063a2ecbee','Marco','Bianchi','1990-07-22','2021-05-20',NULL),('tecnico2@email.com','18196e5a14e9282dab992fd5a019a61ccc1484340b8e814f2a67db2e00bf7825','Giulia','Verdi','1995-02-12','2022-03-10',NULL);
/*!40000 ALTER TABLE `personale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodotto_candidato`
--

DROP TABLE IF EXISTS `prodotto_candidato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prodotto_candidato` (
  `codice_prodotto` varchar(10) NOT NULL,
  `nome_prodotto` varchar(50) NOT NULL,
  `prezzo` decimal(6,2) NOT NULL,
  `produttore` varchar(50) NOT NULL,
  `spedito` tinyint(1) DEFAULT '0',
  `motivazione_rifiuto` varchar(512) DEFAULT NULL,
  `approvato` tinyint(1) DEFAULT NULL,
  `URL` varchar(512) DEFAULT NULL,
  `data_spedizione` datetime DEFAULT NULL,
  PRIMARY KEY (`codice_prodotto`),
  CONSTRAINT `chk_3` CHECK ((((`spedito` = false) and (`approvato` = false)) or ((`spedito` = true) and (`approvato` = true)) or ((`spedito` = false) and (`approvato` = true)) or ((`spedito` = false) and (`approvato` is null)))),
  CONSTRAINT `chk_data` CHECK ((((`spedito` = true) and (`data_spedizione` is not null)) or ((`spedito` = false) and (`data_spedizione` is null)))),
  CONSTRAINT `prodotto_candidato_chk_1` CHECK (regexp_like(`codice_prodotto`,_utf8mb4'^[0-9A-Z]{10}$')),
  CONSTRAINT `prodotto_candidato_chk_2` CHECK ((`prezzo` > 0)),
  CONSTRAINT `sintassi_url` CHECK (((`URL` is null) or (`URL` like _utf8mb4'http://%') or (`URL` like _utf8mb4'https://%')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodotto_candidato`
--

LOCK TABLES `prodotto_candidato` WRITE;
/*!40000 ALTER TABLE `prodotto_candidato` DISABLE KEYS */;
INSERT INTO `prodotto_candidato` VALUES ('PC00000002','Stampante Laser HP 1200',149.50,'HP',0,'Prezzo troppo alto',0,'https://hp.com/stampante1200',NULL),('PC00000004','Stampante Logitech',49.99,'Logitech',0,NULL,1,'https://logitech.com/tastiera',NULL);
/*!40000 ALTER TABLE `prodotto_candidato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tecnico_incaricato`
--

DROP TABLE IF EXISTS `tecnico_incaricato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tecnico_incaricato` (
  `codice` varchar(6) NOT NULL,
  `reparto` varchar(50) NOT NULL,
  `richieste_gestite` int DEFAULT '0',
  `email_tecnico` varchar(50) NOT NULL,
  PRIMARY KEY (`codice`),
  KEY `email_tecnico` (`email_tecnico`),
  CONSTRAINT `tecnico_incaricato_ibfk_1` FOREIGN KEY (`email_tecnico`) REFERENCES `personale` (`email`) ON DELETE CASCADE,
  CONSTRAINT `sintassi_codice` CHECK (regexp_like(`codice`,_utf8mb4'^[0-9]{6}$'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tecnico_incaricato`
--

LOCK TABLES `tecnico_incaricato` WRITE;
/*!40000 ALTER TABLE `tecnico_incaricato` DISABLE KEYS */;
INSERT INTO `tecnico_incaricato` VALUES ('123456','informatica',1,'tecnico2@email.com'),('334562','informatica',0,'tecnico1@email.com');
/*!40000 ALTER TABLE `tecnico_incaricato` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-07 14:22:54
