USE dinfo;
-- MySQL dump 10.13  Distrib 5.1.73, for redhat-linux-gnu (x86_64)
--
-- Host: cadidb.epfl.ch    Database: dinfo
-- ------------------------------------------------------
-- Server version	5.1.73-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Corps`
--

DROP TABLE IF EXISTS `Corps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Corps` (
  `sciper` varchar(6) NOT NULL DEFAULT '',
  `corps` varchar(6) DEFAULT NULL,
  `faculte` varchar(6) DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Courses`
--

DROP TABLE IF EXISTS `Courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cle` varchar(128) DEFAULT NULL,
  `libellefr` varchar(128) DEFAULT NULL,
  `libelleen` varchar(128) DEFAULT NULL,
  `langueens` char(2) DEFAULT NULL,
  `anneeacad` char(9) DEFAULT NULL,
  `urlficheen` varchar(256) DEFAULT NULL,
  `urlfichefr` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `libellefr` (`libellefr`,`libelleen`)
) ENGINE=MyISAM AUTO_INCREMENT=2320 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Fonctions_SAP`
--

DROP TABLE IF EXISTS `Fonctions_SAP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Fonctions_SAP` (
  `id` varchar(6) NOT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Fonctions_SAP_old`
--

DROP TABLE IF EXISTS `Fonctions_SAP_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Fonctions_SAP_old` (
  `id` varchar(6) NOT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Personnel`
--

DROP TABLE IF EXISTS `Personnel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Personnel` (
  `sciper` char(6) NOT NULL,
  `debval` date DEFAULT NULL,
  `finval` date DEFAULT NULL,
  `numsap` int(11) DEFAULT NULL,
  `fonction` varchar(6) DEFAULT NULL,
  `sortie` date DEFAULT NULL,
  `categ` varchar(4) DEFAULT NULL,
  `corps` varchar(4) DEFAULT NULL,
  `unite1` varchar(4) DEFAULT NULL,
  `unite2` varchar(4) DEFAULT NULL,
  `unite3` varchar(4) DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PersonnelNow`
--

DROP TABLE IF EXISTS `PersonnelNow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PersonnelNow` (
  `sciper` varchar(6) NOT NULL DEFAULT '',
  `debval` date DEFAULT NULL,
  `finval` date DEFAULT NULL,
  `numsap` int(11) DEFAULT NULL,
  `fonction` varchar(6) DEFAULT NULL,
  `sortie` date DEFAULT NULL,
  `categ` varchar(4) DEFAULT NULL,
  `corps` varchar(4) DEFAULT NULL,
  `unite1` varchar(4) DEFAULT NULL,
  `unite2` varchar(4) DEFAULT NULL,
  `unite3` varchar(4) DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Personnel_old`
--

DROP TABLE IF EXISTS `Personnel_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Personnel_old` (
  `sciper` char(6) NOT NULL,
  `debval` date DEFAULT NULL,
  `finval` date DEFAULT NULL,
  `numsap` int(11) DEFAULT NULL,
  `fonction` varchar(6) DEFAULT NULL,
  `sortie` date DEFAULT NULL,
  `categ` varchar(4) DEFAULT NULL,
  `corps` varchar(4) DEFAULT NULL,
  `unite1` varchar(4) DEFAULT NULL,
  `unite2` varchar(4) DEFAULT NULL,
  `unite3` varchar(4) DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Students`
--

DROP TABLE IF EXISTS `Students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Students` (
  `idcours` int(11) DEFAULT NULL,
  `sciper` char(6) DEFAULT NULL,
  KEY `idcours` (`idcours`,`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SwitchAAIUsers`
--

DROP TABLE IF EXISTS `SwitchAAIUsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SwitchAAIUsers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sciper` varchar(6) DEFAULT NULL,
  `username` varchar(32) NOT NULL DEFAULT '',
  `name` varchar(64) DEFAULT NULL,
  `firstname` varchar(64) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `org` varchar(32) DEFAULT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `postaladdress` varchar(128) DEFAULT NULL,
  `identprov` varchar(32) DEFAULT NULL,
  `orgtype` varchar(16) DEFAULT NULL,
  `origsite` varchar(16) DEFAULT NULL,
  `studybranch1` int(11) DEFAULT NULL,
  `studybranch2` int(11) DEFAULT NULL,
  `studybranch3` int(11) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `renewal` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Teachers`
--

DROP TABLE IF EXISTS `Teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Teachers` (
  `idcours` int(11) DEFAULT NULL,
  `sciper` char(6) DEFAULT NULL,
  KEY `idcours` (`idcours`,`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_Fonctions_SAP_bak`
--

DROP TABLE IF EXISTS `_Fonctions_SAP_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_Fonctions_SAP_bak` (
  `id` varchar(6) NOT NULL,
  `libelle` varchar(128) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_autolistes1`
--

DROP TABLE IF EXISTS `_autolistes1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_autolistes1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(16) NOT NULL,
  `subtype` varchar(48) DEFAULT NULL,
  `unite` varchar(64) DEFAULT NULL,
  `id_unite` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `subtype` (`subtype`),
  KEY `unite` (`unite`)
) ENGINE=MyISAM AUTO_INCREMENT=54844 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `_autolistesmembres1`
--

DROP TABLE IF EXISTS `_autolistesmembres1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_autolistesmembres1` (
  `id` int(11) DEFAULT NULL,
  `sciper` varchar(6) NOT NULL,
  KEY `id` (`id`),
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accountprefs`
--

DROP TABLE IF EXISTS `accountprefs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accountprefs` (
  `sciper` varchar(6) DEFAULT NULL,
  `user` varchar(16) NOT NULL DEFAULT '',
  `home` varchar(64) DEFAULT NULL,
  `shell` varchar(32) DEFAULT NULL,
  `automap` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`user`),
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `user` varchar(32) NOT NULL,
  `sciper` varchar(6) NOT NULL,
  `uid` int(11) DEFAULT NULL,
  `gid` int(11) DEFAULT NULL,
  `gecos` varchar(64) DEFAULT NULL,
  `home` varchar(32) DEFAULT NULL,
  `shell` varchar(16) DEFAULT NULL,
  KEY `user` (`user`),
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accounts_old`
--

DROP TABLE IF EXISTS `accounts_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_old` (
  `user` varchar(32) NOT NULL,
  `sciper` varchar(6) NOT NULL,
  `uid` int(11) DEFAULT NULL,
  `gid` int(11) DEFAULT NULL,
  `gecos` varchar(64) DEFAULT NULL,
  `home` varchar(32) DEFAULT NULL,
  `shell` varchar(16) DEFAULT NULL,
  KEY `user` (`user`),
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accred`
--

DROP TABLE IF EXISTS `accred`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accred` (
  `sciper` varchar(8) NOT NULL DEFAULT '',
  `unite` varchar(8) DEFAULT NULL,
  `statut` smallint(6) DEFAULT NULL,
  `classe` smallint(6) DEFAULT NULL,
  `fonction` varchar(128) DEFAULT NULL,
  `datedeb` datetime DEFAULT NULL,
  `duree` varchar(8) DEFAULT NULL,
  `createur` varchar(8) DEFAULT NULL,
  `datecreat` datetime DEFAULT NULL,
  `origine` char(1) DEFAULT NULL,
  `datefin` datetime DEFAULT NULL,
  `datereval` datetime DEFAULT NULL,
  `ordre` tinyint(4) DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accredtest`
--

DROP TABLE IF EXISTS `accredtest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accredtest` (
  `sciper` varchar(8) NOT NULL DEFAULT '',
  `unite` varchar(8) DEFAULT NULL,
  `statut` smallint(6) DEFAULT NULL,
  `classe` smallint(6) DEFAULT NULL,
  `fonction` int(11) DEFAULT NULL,
  `datedeb` datetime DEFAULT NULL,
  `datefin` datetime DEFAULT NULL,
  `datereval` datetime DEFAULT NULL,
  `duree` char(2) DEFAULT NULL,
  `createur` varchar(8) DEFAULT NULL,
  `datecreat` datetime DEFAULT NULL,
  `origine` char(1) DEFAULT NULL,
  `comment` text,
  `auteur` varchar(6) DEFAULT NULL,
  `revalman` char(1) DEFAULT NULL,
  `ordre` tinyint(4) DEFAULT NULL,
  `debval` datetime DEFAULT NULL,
  `finval` datetime DEFAULT NULL,
  KEY `sciper` (`sciper`),
  KEY `unite` (`unite`),
  KEY `debval` (`debval`),
  KEY `finval` (`finval`),
  KEY `datedeb` (`datedeb`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `adrspost`
--

DROP TABLE IF EXISTS `adrspost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adrspost` (
  `sciper` char(6) NOT NULL,
  `unite` varchar(6) DEFAULT NULL,
  `ordre` mediumint(9) DEFAULT NULL,
  `adresse` text,
  `pays` varchar(64) DEFAULT NULL,
  `country` varchar(64) DEFAULT NULL,
  KEY `sciper` (`sciper`),
  KEY `unite` (`unite`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `adrspost_old`
--

DROP TABLE IF EXISTS `adrspost_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adrspost_old` (
  `sciper` char(6) NOT NULL,
  `unite` varchar(6) DEFAULT NULL,
  `ordre` mediumint(9) DEFAULT NULL,
  `adresse` text,
  `pays` varchar(64) DEFAULT NULL,
  `country` varchar(64) DEFAULT NULL,
  KEY `sciper` (`sciper`),
  KEY `unite` (`unite`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `agepoly`
--

DROP TABLE IF EXISTS `agepoly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agepoly` (
  `sciper` varchar(6) DEFAULT NULL,
  `unite` varchar(6) DEFAULT NULL,
  `fonction` int(11) DEFAULT NULL,
  `annuaire` char(1) DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `agepoly_old`
--

DROP TABLE IF EXISTS `agepoly_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agepoly_old` (
  `sciper` varchar(6) DEFAULT NULL,
  `unite` varchar(6) DEFAULT NULL,
  `fonction` int(11) DEFAULT NULL,
  `annuaire` char(1) DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `allunits`
--

DROP TABLE IF EXISTS `allunits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allunits` (
  `id_unite` int(11) NOT NULL AUTO_INCREMENT,
  `sigle` varchar(24) DEFAULT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `libelle_en` varchar(128) DEFAULT NULL,
  `date_debut` datetime DEFAULT NULL,
  `date_fin` datetime DEFAULT NULL,
  `hierarchie` varchar(64) DEFAULT NULL,
  `niveau` smallint(6) DEFAULT NULL,
  `id_parent` int(11) DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  `resp_unite` varchar(6) DEFAULT NULL,
  `cmpl_type` char(1) DEFAULT NULL,
  `unittype` int(11) DEFAULT NULL,
  `adresse_1` varchar(64) DEFAULT NULL,
  `adresse_2` varchar(64) DEFAULT NULL,
  `adresse_3` varchar(64) DEFAULT NULL,
  `adresse_4` varchar(64) DEFAULT NULL,
  `ville` varchar(64) DEFAULT NULL,
  `pays` varchar(6) DEFAULT NULL,
  `cf` varchar(6) DEFAULT NULL,
  `level1` int(11) DEFAULT NULL,
  `level2` int(11) DEFAULT NULL,
  `level3` int(11) DEFAULT NULL,
  `level4` int(11) DEFAULT NULL,
  `url` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_unite`),
  KEY `sigle` (`sigle`),
  KEY `libelle` (`libelle`),
  KEY `level1` (`level1`),
  KEY `level2` (`level2`),
  KEY `level3` (`level3`),
  KEY `level4` (`level4`)
) ENGINE=MyISAM AUTO_INCREMENT=71114 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `allunits_old`
--

DROP TABLE IF EXISTS `allunits_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allunits_old` (
  `id_unite` int(11) NOT NULL AUTO_INCREMENT,
  `sigle` varchar(24) DEFAULT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `libelle_en` varchar(128) DEFAULT NULL,
  `date_debut` datetime DEFAULT NULL,
  `date_fin` datetime DEFAULT NULL,
  `hierarchie` varchar(64) DEFAULT NULL,
  `niveau` smallint(6) DEFAULT NULL,
  `id_parent` int(11) DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  `resp_unite` varchar(6) DEFAULT NULL,
  `cmpl_type` char(1) DEFAULT NULL,
  `unittype` int(11) DEFAULT NULL,
  `adresse_1` varchar(64) DEFAULT NULL,
  `adresse_2` varchar(64) DEFAULT NULL,
  `adresse_3` varchar(64) DEFAULT NULL,
  `adresse_4` varchar(64) DEFAULT NULL,
  `ville` varchar(64) DEFAULT NULL,
  `pays` varchar(6) DEFAULT NULL,
  `cf` varchar(6) DEFAULT NULL,
  `level1` int(11) DEFAULT NULL,
  `level2` int(11) DEFAULT NULL,
  `level3` int(11) DEFAULT NULL,
  `level4` int(11) DEFAULT NULL,
  `url` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_unite`),
  KEY `sigle` (`sigle`),
  KEY `libelle` (`libelle`),
  KEY `level1` (`level1`),
  KEY `level2` (`level2`),
  KEY `level3` (`level3`),
  KEY `level4` (`level4`)
) ENGINE=MyISAM AUTO_INCREMENT=71114 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alumni`
--

DROP TABLE IF EXISTS `alumni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alumni` (
  `sciper` varchar(6) NOT NULL DEFAULT '',
  `username` varchar(16) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `lastvisit` datetime DEFAULT NULL,
  `firstname` varchar(64) DEFAULT NULL,
  `lastname` varchar(64) DEFAULT NULL,
  `companyname` varchar(128) DEFAULT NULL,
  `companyposition` varchar(128) DEFAULT NULL,
  `companyaddress` varchar(128) DEFAULT NULL,
  `companycity` varchar(64) DEFAULT NULL,
  `companyzipcode` varchar(8) DEFAULT NULL,
  `companycountry` varchar(32) DEFAULT NULL,
  `companyemail` varchar(64) DEFAULT NULL,
  `companyphone` varchar(16) DEFAULT NULL,
  `companyfax` varchar(16) DEFAULT NULL,
  `companywww` varchar(64) DEFAULT NULL,
  `privateaddress` varchar(128) DEFAULT NULL,
  `privatecity` varchar(32) DEFAULT NULL,
  `privatezipcode` varchar(8) DEFAULT NULL,
  `privatecountry` varchar(32) DEFAULT NULL,
  `privateemail` varchar(64) DEFAULT NULL,
  `privatephone` varchar(16) DEFAULT NULL,
  `privatefax` varchar(16) DEFAULT NULL,
  `privatewww` varchar(64) DEFAULT NULL,
  `schoolsection` varchar(6) DEFAULT NULL,
  `schoolposition` varchar(16) DEFAULT NULL,
  `schoolpromotion` int(11) DEFAULT NULL,
  `ipaddress` varchar(16) DEFAULT NULL,
  `hostname` varchar(32) DEFAULT NULL,
  `sessionid` varchar(32) DEFAULT NULL,
  `maillist` char(1) DEFAULT NULL,
  `uniteaccred` int(11) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alumni_new`
--

DROP TABLE IF EXISTS `alumni_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alumni_new` (
  `sciper` varchar(6) NOT NULL DEFAULT '',
  `username` varchar(16) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `lastvisit` datetime DEFAULT NULL,
  `firstname` varchar(64) DEFAULT NULL,
  `lastname` varchar(64) DEFAULT NULL,
  `companyname` varchar(128) DEFAULT NULL,
  `companyposition` varchar(128) DEFAULT NULL,
  `companyaddress` varchar(128) DEFAULT NULL,
  `companycity` varchar(64) DEFAULT NULL,
  `companyzipcode` varchar(8) DEFAULT NULL,
  `companycountry` varchar(32) DEFAULT NULL,
  `companyemail` varchar(64) DEFAULT NULL,
  `companyphone` varchar(16) DEFAULT NULL,
  `companyfax` varchar(16) DEFAULT NULL,
  `companywww` varchar(64) DEFAULT NULL,
  `privateaddress` varchar(128) DEFAULT NULL,
  `privatecity` varchar(32) DEFAULT NULL,
  `privatezipcode` varchar(8) DEFAULT NULL,
  `privatecountry` varchar(32) DEFAULT NULL,
  `privateemail` varchar(64) DEFAULT NULL,
  `privatephone` varchar(16) DEFAULT NULL,
  `privatefax` varchar(16) DEFAULT NULL,
  `privatewww` varchar(64) DEFAULT NULL,
  `schoolsection` varchar(6) DEFAULT NULL,
  `schoolposition` varchar(16) DEFAULT NULL,
  `schoolpromotion` int(11) DEFAULT NULL,
  `ipaddress` varchar(16) DEFAULT NULL,
  `hostname` varchar(32) DEFAULT NULL,
  `sessionid` varchar(32) DEFAULT NULL,
  `maillist` char(1) DEFAULT NULL,
  `uniteaccred` int(11) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alumni_old`
--

DROP TABLE IF EXISTS `alumni_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alumni_old` (
  `sciper` varchar(6) NOT NULL DEFAULT '',
  `username` varchar(16) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `lastvisit` datetime DEFAULT NULL,
  `firstname` varchar(64) DEFAULT NULL,
  `lastname` varchar(64) DEFAULT NULL,
  `companyname` varchar(128) DEFAULT NULL,
  `companyposition` varchar(128) DEFAULT NULL,
  `companyaddress` varchar(128) DEFAULT NULL,
  `companycity` varchar(64) DEFAULT NULL,
  `companyzipcode` varchar(8) DEFAULT NULL,
  `companycountry` varchar(32) DEFAULT NULL,
  `companyemail` varchar(64) DEFAULT NULL,
  `companyphone` varchar(16) DEFAULT NULL,
  `companyfax` varchar(16) DEFAULT NULL,
  `companywww` varchar(64) DEFAULT NULL,
  `privateaddress` varchar(128) DEFAULT NULL,
  `privatecity` varchar(32) DEFAULT NULL,
  `privatezipcode` varchar(8) DEFAULT NULL,
  `privatecountry` varchar(32) DEFAULT NULL,
  `privateemail` varchar(64) DEFAULT NULL,
  `privatephone` varchar(16) DEFAULT NULL,
  `privatefax` varchar(16) DEFAULT NULL,
  `privatewww` varchar(64) DEFAULT NULL,
  `schoolsection` varchar(6) DEFAULT NULL,
  `schoolposition` varchar(16) DEFAULT NULL,
  `schoolpromotion` int(11) DEFAULT NULL,
  `ipaddress` varchar(16) DEFAULT NULL,
  `hostname` varchar(32) DEFAULT NULL,
  `sessionid` varchar(32) DEFAULT NULL,
  `maillist` char(1) DEFAULT NULL,
  `uniteaccred` int(11) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alumnis_old`
--

DROP TABLE IF EXISTS `alumnis_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alumnis_old` (
  `sciper` varchar(6) NOT NULL DEFAULT '',
  `username` varchar(16) DEFAULT NULL,
  `password` varchar(16) DEFAULT NULL,
  `lastvisit` datetime DEFAULT NULL,
  `firstname` varchar(64) DEFAULT NULL,
  `lastname` varchar(64) DEFAULT NULL,
  `companyname` varchar(128) DEFAULT NULL,
  `companyposition` varchar(128) DEFAULT NULL,
  `companyaddress` varchar(128) DEFAULT NULL,
  `companycity` varchar(64) DEFAULT NULL,
  `companyzipcode` varchar(8) DEFAULT NULL,
  `companycountry` varchar(32) DEFAULT NULL,
  `companyemail` varchar(64) DEFAULT NULL,
  `companyphone` varchar(16) DEFAULT NULL,
  `companyfax` varchar(16) DEFAULT NULL,
  `companywww` varchar(64) DEFAULT NULL,
  `privateaddress` varchar(128) DEFAULT NULL,
  `privatecity` varchar(32) DEFAULT NULL,
  `privatezipcode` varchar(8) DEFAULT NULL,
  `privatecountry` varchar(32) DEFAULT NULL,
  `privateemail` varchar(64) DEFAULT NULL,
  `privatephone` varchar(16) DEFAULT NULL,
  `privatefax` varchar(16) DEFAULT NULL,
  `privatewww` varchar(64) DEFAULT NULL,
  `schoolsection` varchar(6) DEFAULT NULL,
  `schoolposition` varchar(16) DEFAULT NULL,
  `schoolpromotion` int(11) DEFAULT NULL,
  `ipaddress` varchar(16) DEFAULT NULL,
  `hostname` varchar(32) DEFAULT NULL,
  `sessionid` varchar(32) DEFAULT NULL,
  `maillist` char(1) DEFAULT NULL,
  `uniteaccred` int(11) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `annu`
--

DROP TABLE IF EXISTS `annu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `annu` (
  `sciper` char(6) NOT NULL,
  `unite` varchar(6) DEFAULT NULL,
  `localid` int(11) DEFAULT NULL,
  `local` varchar(25) DEFAULT NULL,
  `telephone1` varchar(16) DEFAULT NULL,
  `telephone2` varchar(25) DEFAULT NULL,
  `type` varchar(16) DEFAULT NULL,
  KEY `sciper` (`sciper`),
  KEY `unite` (`unite`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `annu_impers`
--

DROP TABLE IF EXISTS `annu_impers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `annu_impers` (
  `unite` char(6) NOT NULL,
  `telephone` varchar(16) DEFAULT NULL,
  `localid` int(11) DEFAULT NULL,
  `local` varchar(16) DEFAULT NULL,
  `type` varchar(16) DEFAULT NULL,
  `attrib` varchar(128) DEFAULT NULL,
  `teltype` varchar(16) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `annu_impers_old`
--

DROP TABLE IF EXISTS `annu_impers_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `annu_impers_old` (
  `unite` char(6) NOT NULL,
  `telephone` varchar(16) DEFAULT NULL,
  `localid` int(11) DEFAULT NULL,
  `local` varchar(16) DEFAULT NULL,
  `type` varchar(16) DEFAULT NULL,
  `attrib` varchar(128) DEFAULT NULL,
  `teltype` varchar(16) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `annu_old`
--

DROP TABLE IF EXISTS `annu_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `annu_old` (
  `sciper` char(6) NOT NULL,
  `unite` varchar(6) DEFAULT NULL,
  `localid` int(11) DEFAULT NULL,
  `local` varchar(25) DEFAULT NULL,
  `telephone1` varchar(16) DEFAULT NULL,
  `telephone2` varchar(25) DEFAULT NULL,
  `type` varchar(16) DEFAULT NULL,
  KEY `sciper` (`sciper`),
  KEY `unite` (`unite`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `annuaire_adrspost`
--

DROP TABLE IF EXISTS `annuaire_adrspost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `annuaire_adrspost` (
  `pers_id` varchar(6) NOT NULL,
  `unit_id` varchar(12) NOT NULL,
  `type` varchar(10) NOT NULL,
  `type_related_id` int(11) DEFAULT NULL,
  `adr` varchar(255) DEFAULT NULL,
  `pays` varchar(24) DEFAULT NULL,
  `cmd_id` int(11) NOT NULL,
  PRIMARY KEY (`pers_id`,`unit_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `annuaire_commandes`
--

DROP TABLE IF EXISTS `annuaire_commandes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `annuaire_commandes` (
  `cmd_id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `creator` varchar(6) NOT NULL,
  `pers_id` varchar(6) DEFAULT NULL,
  `unit_id` varchar(12) DEFAULT NULL,
  `commande` varchar(45) NOT NULL,
  `params` text,
  `date_valid` datetime DEFAULT NULL,
  `validator` varchar(6) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `comment` text,
  PRIMARY KEY (`cmd_id`)
) ENGINE=MyISAM AUTO_INCREMENT=35644 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `annuaire_impers`
--

DROP TABLE IF EXISTS `annuaire_impers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `annuaire_impers` (
  `phone_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `cmd_id` int(11) NOT NULL,
  PRIMARY KEY (`phone_id`,`room_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `annuaire_persphones`
--

DROP TABLE IF EXISTS `annuaire_persphones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `annuaire_persphones` (
  `pers_id` varchar(6) NOT NULL,
  `unit_id` varchar(12) NOT NULL,
  `phone_id` int(11) NOT NULL,
  `phone_hidden` tinyint(1) NOT NULL DEFAULT '0',
  `phone_order` int(11) NOT NULL DEFAULT '1',
  `cmd_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`pers_id`,`unit_id`,`phone_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `annuaire_persrooms`
--

DROP TABLE IF EXISTS `annuaire_persrooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `annuaire_persrooms` (
  `pers_id` varchar(6) NOT NULL,
  `unit_id` varchar(12) NOT NULL,
  `room_id` int(11) NOT NULL,
  `room_hidden` tinyint(1) NOT NULL DEFAULT '0',
  `room_order` int(11) NOT NULL DEFAULT '1',
  `cmd_id` int(11) NOT NULL,
  PRIMARY KEY (`pers_id`,`unit_id`,`room_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `annuaire_phones`
--

DROP TABLE IF EXISTS `annuaire_phones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `annuaire_phones` (
  `phone_id` int(11) NOT NULL AUTO_INCREMENT,
  `phone_nb` varchar(45) DEFAULT NULL,
  `phone_type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`phone_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `autolistes`
--

DROP TABLE IF EXISTS `autolistes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autolistes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(16) NOT NULL,
  `subtype` varchar(48) DEFAULT NULL,
  `unite` varchar(64) DEFAULT NULL,
  `id_unite` varchar(8) DEFAULT NULL,
  `members` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `subtype` (`subtype`),
  KEY `unite` (`unite`)
) ENGINE=MyISAM AUTO_INCREMENT=73022 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `autolistes_old`
--

DROP TABLE IF EXISTS `autolistes_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autolistes_old` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(16) NOT NULL,
  `subtype` varchar(48) DEFAULT NULL,
  `unite` varchar(64) DEFAULT NULL,
  `id_unite` varchar(8) DEFAULT NULL,
  `members` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `subtype` (`subtype`),
  KEY `unite` (`unite`)
) ENGINE=MyISAM AUTO_INCREMENT=72996 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `autolistesmembres`
--

DROP TABLE IF EXISTS `autolistesmembres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autolistesmembres` (
  `id` int(11) DEFAULT NULL,
  `sciper` varchar(6) NOT NULL,
  KEY `id` (`id`),
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `autolistesmembres_old`
--

DROP TABLE IF EXISTS `autolistesmembres_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autolistesmembres_old` (
  `id` int(11) DEFAULT NULL,
  `sciper` varchar(6) NOT NULL,
  KEY `id` (`id`),
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `automaps`
--

DROP TABLE IF EXISTS `automaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `automaps` (
  `sciper` char(6) NOT NULL DEFAULT '',
  `protocol` char(6) DEFAULT NULL,
  `server` char(32) DEFAULT NULL,
  `path` char(128) DEFAULT NULL,
  `security` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `batiments`
--

DROP TABLE IF EXISTS `batiments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batiments` (
  `bat_id` int(11) NOT NULL,
  `bat_abr` varchar(6) DEFAULT NULL,
  `bat_name` varchar(64) DEFAULT NULL,
  `regle` varchar(6) DEFAULT NULL,
  `site_id` int(11) NOT NULL,
  PRIMARY KEY (`bat_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `batiments_old`
--

DROP TABLE IF EXISTS `batiments_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batiments_old` (
  `bat_id` int(11) NOT NULL,
  `bat_abr` varchar(6) DEFAULT NULL,
  `bat_name` varchar(64) DEFAULT NULL,
  `regle` varchar(6) DEFAULT NULL,
  `site_id` int(11) NOT NULL,
  PRIMARY KEY (`bat_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bottin`
--

DROP TABLE IF EXISTS `bottin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bottin` (
  `sciper` char(6) NOT NULL,
  `nom` varchar(32) DEFAULT NULL,
  `prenom` varchar(32) DEFAULT NULL,
  `nom_acc` varchar(32) DEFAULT NULL,
  `prenom_acc` varchar(32) DEFAULT NULL,
  `unite` varchar(6) DEFAULT NULL,
  `telephone1` varchar(16) DEFAULT NULL,
  `telephone2` varchar(16) DEFAULT NULL,
  `local` varchar(16) DEFAULT NULL,
  `fonction` varchar(32) DEFAULT NULL,
  `ordre` char(1) DEFAULT NULL,
  `email` char(64) DEFAULT NULL,
  `camipro` char(1) DEFAULT NULL,
  `nomlocal` varchar(25) DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bottin_impers`
--

DROP TABLE IF EXISTS `bottin_impers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bottin_impers` (
  `unite` char(6) NOT NULL,
  `telephone` varchar(16) DEFAULT NULL,
  `local` varchar(16) DEFAULT NULL,
  `ordre` tinyint(4) DEFAULT NULL,
  `type` varchar(16) DEFAULT NULL,
  `attrib` varchar(128) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bottin_impers_old`
--

DROP TABLE IF EXISTS `bottin_impers_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bottin_impers_old` (
  `unite` char(6) NOT NULL,
  `telephone` varchar(16) DEFAULT NULL,
  `local` varchar(16) DEFAULT NULL,
  `ordre` tinyint(4) DEFAULT NULL,
  `type` varchar(16) DEFAULT NULL,
  `attrib` varchar(128) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bottin_old`
--

DROP TABLE IF EXISTS `bottin_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bottin_old` (
  `sciper` char(6) NOT NULL,
  `nom` varchar(32) DEFAULT NULL,
  `prenom` varchar(32) DEFAULT NULL,
  `nom_acc` varchar(32) DEFAULT NULL,
  `prenom_acc` varchar(32) DEFAULT NULL,
  `unite` varchar(6) DEFAULT NULL,
  `telephone1` varchar(16) DEFAULT NULL,
  `telephone2` varchar(16) DEFAULT NULL,
  `local` varchar(16) DEFAULT NULL,
  `fonction` varchar(32) DEFAULT NULL,
  `ordre` char(1) DEFAULT NULL,
  `email` char(64) DEFAULT NULL,
  `camipro` char(1) DEFAULT NULL,
  `nomlocal` varchar(25) DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bottinadminlog`
--

DROP TABLE IF EXISTS `bottinadminlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bottinadminlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `opcode` tinyint(4) DEFAULT NULL,
  `author` varchar(6) DEFAULT NULL,
  `sciper` varchar(6) DEFAULT NULL,
  `param` varchar(128) DEFAULT NULL,
  KEY `id` (`id`,`author`,`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bottinorder`
--

DROP TABLE IF EXISTS `bottinorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bottinorder` (
  `sciper` varchar(6) DEFAULT NULL,
  `unit` varchar(6) DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `camipro`
--

DROP TABLE IF EXISTS `camipro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `camipro` (
  `sciper` varchar(6) DEFAULT NULL,
  `cardid` varchar(16) DEFAULT NULL,
  `cardstatus` char(1) DEFAULT NULL,
  `persstatus` varchar(32) DEFAULT NULL,
  `validitydate` datetime DEFAULT NULL,
  `emissiondate` datetime DEFAULT NULL,
  `statedate` datetime DEFAULT NULL,
  `pin` varchar(8) DEFAULT NULL,
  `lefttries` tinyint(4) DEFAULT NULL,
  KEY `sciper` (`sciper`),
  KEY `cardid` (`cardid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `camipro_old`
--

DROP TABLE IF EXISTS `camipro_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `camipro_old` (
  `sciper` varchar(6) DEFAULT NULL,
  `cardid` varchar(16) DEFAULT NULL,
  `cardstatus` char(1) DEFAULT NULL,
  `persstatus` varchar(32) DEFAULT NULL,
  `validitydate` datetime DEFAULT NULL,
  `emissiondate` datetime DEFAULT NULL,
  `statedate` datetime DEFAULT NULL,
  `pin` varchar(8) DEFAULT NULL,
  `lefttries` tinyint(4) DEFAULT NULL,
  KEY `sciper` (`sciper`),
  KEY `cardid` (`cardid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `canon`
--

DROP TABLE IF EXISTS `canon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `canon` (
  `sciper` varchar(6) NOT NULL DEFAULT '',
  `canon` varchar(32) DEFAULT NULL,
  `visible` char(1) DEFAULT 'n',
  PRIMARY KEY (`sciper`),
  KEY `canon` (`canon`),
  KEY `visible` (`visible`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cdelangues`
--

DROP TABLE IF EXISTS `cdelangues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cdelangues` (
  `sciper` char(6) NOT NULL,
  `ext_mail` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cdelangues_old`
--

DROP TABLE IF EXISTS `cdelangues_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cdelangues_old` (
  `sciper` char(6) NOT NULL,
  `ext_mail` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `certificates`
--

DROP TABLE IF EXISTS `certificates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificates` (
  `sciper` char(6) NOT NULL,
  `cert` text,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `certificates_old`
--

DROP TABLE IF EXISTS `certificates_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificates_old` (
  `sciper` char(6) NOT NULL,
  `cert` text,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `classes`
--

DROP TABLE IF EXISTS `classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classes` (
  `id` mediumint(9) NOT NULL DEFAULT '0',
  `libelle` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comptesAD`
--

DROP TABLE IF EXISTS `comptesAD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comptesAD` (
  `sciper` varchar(6) NOT NULL DEFAULT '',
  `sam` varchar(6) NOT NULL DEFAULT '',
  `srv` varchar(64) NOT NULL DEFAULT '',
  `ADsPath` varchar(128) DEFAULT NULL,
  `IsAccountLocked` char(1) DEFAULT NULL,
  `AccountDisabled` char(1) DEFAULT NULL,
  PRIMARY KEY (`sciper`,`sam`,`srv`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `copercust`
--

DROP TABLE IF EXISTS `copercust`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `copercust` (
  `id` char(10) NOT NULL,
  `accountgroup` varchar(6) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  `name1` varchar(32) DEFAULT NULL,
  `name2` varchar(32) DEFAULT NULL,
  `searchcriteria` varchar(16) DEFAULT NULL,
  `street` varchar(64) DEFAULT NULL,
  `streetnum` varchar(8) DEFAULT NULL,
  `street2` varchar(64) DEFAULT NULL,
  `country` varchar(2) DEFAULT NULL,
  `zip` varchar(6) DEFAULT NULL,
  `city` varchar(32) DEFAULT NULL,
  `currency` varchar(6) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `cf` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `name1` (`name1`),
  KEY `name2` (`name2`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `copercust_old`
--

DROP TABLE IF EXISTS `copercust_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `copercust_old` (
  `id` char(10) NOT NULL,
  `accountgroup` varchar(6) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  `name1` varchar(32) DEFAULT NULL,
  `name2` varchar(32) DEFAULT NULL,
  `searchcriteria` varchar(16) DEFAULT NULL,
  `street` varchar(64) DEFAULT NULL,
  `streetnum` varchar(8) DEFAULT NULL,
  `street2` varchar(64) DEFAULT NULL,
  `country` varchar(2) DEFAULT NULL,
  `zip` varchar(6) DEFAULT NULL,
  `city` varchar(32) DEFAULT NULL,
  `currency` varchar(6) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `cf` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `name1` (`name1`),
  KEY `name2` (`name2`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `coperprest`
--

DROP TABLE IF EXISTS `coperprest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coperprest` (
  `id` char(18) NOT NULL,
  `type` varchar(6) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `unitbase` varchar(8) DEFAULT NULL,
  `measureunit` varchar(16) DEFAULT NULL,
  `merchantgroup` varchar(16) DEFAULT NULL,
  `merchantname` varchar(32) DEFAULT NULL,
  `productshierarchy` varchar(16) DEFAULT NULL,
  `articlegroup` varchar(16) DEFAULT NULL,
  `chargegroup` varchar(16) DEFAULT NULL,
  `tvaclass` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `coperprest_old`
--

DROP TABLE IF EXISTS `coperprest_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coperprest_old` (
  `id` char(18) NOT NULL,
  `type` varchar(6) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `unitbase` varchar(8) DEFAULT NULL,
  `measureunit` varchar(16) DEFAULT NULL,
  `merchantgroup` varchar(16) DEFAULT NULL,
  `merchantname` varchar(32) DEFAULT NULL,
  `productshierarchy` varchar(16) DEFAULT NULL,
  `articlegroup` varchar(16) DEFAULT NULL,
  `chargegroup` varchar(16) DEFAULT NULL,
  `tvaclass` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `delegues`
--

DROP TABLE IF EXISTS `delegues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delegues` (
  `section` varchar(8) DEFAULT NULL,
  `periode` varchar(8) DEFAULT NULL,
  `sciper` varchar(6) DEFAULT NULL,
  `annee` varchar(12) DEFAULT NULL,
  `semestre` varchar(8) DEFAULT NULL,
  KEY `section` (`section`),
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `delegues_old`
--

DROP TABLE IF EXISTS `delegues_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delegues_old` (
  `section` varchar(8) DEFAULT NULL,
  `periode` varchar(8) DEFAULT NULL,
  `sciper` varchar(6) DEFAULT NULL,
  `annee` varchar(12) DEFAULT NULL,
  `semestre` varchar(8) DEFAULT NULL,
  KEY `section` (`section`),
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `departs`
--

DROP TABLE IF EXISTS `departs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departs` (
  `sciper` varchar(8) NOT NULL,
  `date_depart` datetime DEFAULT NULL,
  `lastunits` varchar(64) DEFAULT NULL,
  `username` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `departs_old`
--

DROP TABLE IF EXISTS `departs_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departs_old` (
  `sciper` varchar(8) NOT NULL,
  `date_depart` datetime DEFAULT NULL,
  `lastunits` varchar(64) DEFAULT NULL,
  `username` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `departssave`
--

DROP TABLE IF EXISTS `departssave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departssave` (
  `sciper` varchar(8) NOT NULL,
  `date_depart` datetime DEFAULT NULL,
  `lastunits` varchar(64) DEFAULT NULL,
  `username` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `diode`
--

DROP TABLE IF EXISTS `diode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `diode` (
  `ip` varchar(16) NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `port` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `diode_old`
--

DROP TABLE IF EXISTS `diode_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `diode_old` (
  `ip` varchar(16) NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `port` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `droits`
--

DROP TABLE IF EXISTS `droits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `droits` (
  `id` mediumint(9) NOT NULL,
  `libelle` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `emails`
--

DROP TABLE IF EXISTS `emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emails` (
  `sciper` char(6) NOT NULL,
  `addrlog` varchar(64) DEFAULT NULL,
  `addrphy` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `emails_old`
--

DROP TABLE IF EXISTS `emails_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emails_old` (
  `sciper` char(6) NOT NULL,
  `addrlog` varchar(64) DEFAULT NULL,
  `addrphy` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `emailsext`
--

DROP TABLE IF EXISTS `emailsext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emailsext` (
  `sciper` char(6) NOT NULL,
  `email` varchar(64) DEFAULT NULL,
  `unite` varchar(6) DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `emailsext_old`
--

DROP TABLE IF EXISTS `emailsext_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emailsext_old` (
  `sciper` char(6) NOT NULL,
  `email` varchar(64) DEFAULT NULL,
  `unite` varchar(6) DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entreeprincipalebottin`
--

DROP TABLE IF EXISTS `entreeprincipalebottin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entreeprincipalebottin` (
  `sciper` varchar(6) NOT NULL DEFAULT '',
  `unite` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `epflold`
--

DROP TABLE IF EXISTS `epflold`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epflold` (
  `sciper` char(6) NOT NULL,
  `lastunits` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exceptpers`
--

DROP TABLE IF EXISTS `exceptpers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exceptpers` (
  `sciper` varchar(6) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exceptpers_old`
--

DROP TABLE IF EXISTS `exceptpers_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exceptpers_old` (
  `sciper` varchar(6) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exceptprofs`
--

DROP TABLE IF EXISTS `exceptprofs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exceptprofs` (
  `sciper` varchar(6) DEFAULT NULL,
  `fonction` mediumint(9) DEFAULT NULL,
  `classe` mediumint(9) DEFAULT NULL,
  `unite` mediumint(9) DEFAULT NULL,
  `FACCOL` varchar(32) DEFAULT NULL,
  `datefin` datetime DEFAULT NULL,
  `comment` varchar(128) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exceptprofs_new`
--

DROP TABLE IF EXISTS `exceptprofs_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exceptprofs_new` (
  `sciper` varchar(6) DEFAULT NULL,
  `fonction` mediumint(9) DEFAULT NULL,
  `classe` mediumint(9) DEFAULT NULL,
  `unite` mediumint(9) DEFAULT NULL,
  `FACCOL` varchar(32) DEFAULT NULL,
  `datefin` datetime DEFAULT NULL,
  `comment` varchar(128) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exceptprofs_old`
--

DROP TABLE IF EXISTS `exceptprofs_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exceptprofs_old` (
  `sciper` varchar(6) DEFAULT NULL,
  `fonction` mediumint(9) DEFAULT NULL,
  `classe` mediumint(9) DEFAULT NULL,
  `unite` mediumint(9) DEFAULT NULL,
  `FACCOL` varchar(32) DEFAULT NULL,
  `datefin` datetime DEFAULT NULL,
  `comment` varchar(128) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `externalids`
--

DROP TABLE IF EXISTS `externalids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `externalids` (
  `type` varchar(20) NOT NULL,
  `sciper` varchar(6) NOT NULL,
  `value` varchar(200) NOT NULL,
  KEY `type` (`type`),
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `externalids_old`
--

DROP TABLE IF EXISTS `externalids_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `externalids_old` (
  `type` varchar(20) NOT NULL,
  `sciper` varchar(6) NOT NULL,
  `value` varchar(200) NOT NULL,
  KEY `type` (`type`),
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fonctionstest`
--

DROP TABLE IF EXISTS `fonctionstest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fonctionstest` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `unit` varchar(4) DEFAULT NULL,
  `oldid` mediumint(9) DEFAULT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `libelle_xx` varchar(128) DEFAULT NULL,
  `libelle_en` varchar(128) DEFAULT NULL,
  `policy` char(1) DEFAULT NULL,
  `debval` datetime DEFAULT NULL,
  `finval` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `libelle` (`libelle`),
  KEY `unit` (`unit`,`oldid`)
) ENGINE=MyISAM AUTO_INCREMENT=794 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fonds`
--

DROP TABLE IF EXISTS `fonds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fonds` (
  `no_fond` varchar(20) NOT NULL,
  `libelle` varchar(100) DEFAULT NULL,
  `cf` varchar(10) DEFAULT NULL,
  `resp_nom` varchar(100) DEFAULT NULL,
  `resp_sciper` varchar(8) DEFAULT NULL,
  `etat` char(1) DEFAULT NULL,
  `clients` varchar(20) DEFAULT NULL,
  `motif` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`no_fond`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fonds_last`
--

DROP TABLE IF EXISTS `fonds_last`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fonds_last` (
  `no_fond` varchar(20) NOT NULL,
  `libelle` varchar(100) DEFAULT NULL,
  `cf` varchar(10) DEFAULT NULL,
  `resp_nom` varchar(100) DEFAULT NULL,
  `resp_sciper` varchar(8) DEFAULT NULL,
  `etat` char(1) DEFAULT NULL,
  PRIMARY KEY (`no_fond`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fonds_old`
--

DROP TABLE IF EXISTS `fonds_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fonds_old` (
  `no_fond` varchar(20) NOT NULL,
  `libelle` varchar(100) DEFAULT NULL,
  `cf` varchar(10) DEFAULT NULL,
  `resp_nom` varchar(100) DEFAULT NULL,
  `resp_sciper` varchar(8) DEFAULT NULL,
  `etat` char(1) DEFAULT NULL,
  `clients` varchar(20) DEFAULT NULL,
  `motif` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`no_fond`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `futurs_emails`
--

DROP TABLE IF EXISTS `futurs_emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `futurs_emails` (
  `sciper` char(6) NOT NULL,
  `addrlog` varchar(64) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groupes`
--

DROP TABLE IF EXISTS `groupes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groupes` (
  `id` mediumint(9) NOT NULL DEFAULT '0',
  `nom` varchar(64) NOT NULL DEFAULT '',
  `owner` varchar(6) DEFAULT NULL,
  `description` text,
  `url` varchar(128) DEFAULT NULL,
  `access` enum('o','r','f') DEFAULT NULL,
  `registration` enum('o','w','f') DEFAULT NULL,
  `visible` char(1) DEFAULT NULL,
  `maillist` char(1) DEFAULT NULL,
  `ldap` char(1) DEFAULT NULL,
  `afsgroup` char(1) DEFAULT NULL,
  `ad` char(1) DEFAULT NULL,
  `flushed` char(1) DEFAULT NULL,
  `gid` int(11) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  PRIMARY KEY (`nom`),
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groupes_after`
--

DROP TABLE IF EXISTS `groupes_after`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groupes_after` (
  `id` mediumint(9) NOT NULL DEFAULT '0',
  `nom` varchar(64) NOT NULL DEFAULT '',
  `owner` varchar(6) DEFAULT NULL,
  `description` text,
  `url` varchar(128) DEFAULT NULL,
  `access` enum('o','r','f') DEFAULT NULL,
  `registration` enum('o','w','f') DEFAULT NULL,
  `visible` char(1) DEFAULT NULL,
  `maillist` char(1) DEFAULT NULL,
  `ldap` char(1) DEFAULT NULL,
  `afsgroup` char(1) DEFAULT NULL,
  `ad` char(1) DEFAULT NULL,
  `flushed` char(1) DEFAULT NULL,
  `gid` int(11) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  KEY `nom` (`nom`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groupes_before`
--

DROP TABLE IF EXISTS `groupes_before`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groupes_before` (
  `id` mediumint(9) NOT NULL DEFAULT '0',
  `nom` varchar(64) NOT NULL DEFAULT '',
  `owner` varchar(6) DEFAULT NULL,
  `description` text,
  `url` varchar(128) DEFAULT NULL,
  `access` enum('o','r','f') DEFAULT NULL,
  `registration` enum('o','w','f') DEFAULT NULL,
  `visible` char(1) DEFAULT NULL,
  `maillist` char(1) DEFAULT NULL,
  `ldap` char(1) DEFAULT NULL,
  `afsgroup` char(1) DEFAULT NULL,
  `ad` char(1) DEFAULT NULL,
  `flushed` char(1) DEFAULT NULL,
  `gid` int(11) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  KEY `nom` (`nom`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `id` mediumint(9) NOT NULL,
  `acro` varchar(24) NOT NULL DEFAULT '',
  `libelle` varchar(64) DEFAULT NULL,
  `gid` int(11) DEFAULT NULL,
  PRIMARY KEY (`acro`),
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groups_old`
--

DROP TABLE IF EXISTS `groups_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups_old` (
  `id` mediumint(9) NOT NULL,
  `acro` varchar(24) NOT NULL DEFAULT '',
  `libelle` varchar(64) DEFAULT NULL,
  `gid` int(11) DEFAULT NULL,
  PRIMARY KEY (`acro`),
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guests`
--

DROP TABLE IF EXISTS `guests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guests` (
  `sciper` varchar(6) NOT NULL DEFAULT '',
  `name` varchar(32) DEFAULT NULL,
  `firstname` varchar(32) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `organization` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hosts`
--

DROP TABLE IF EXISTS `hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts` (
  `nom` varchar(32) NOT NULL,
  `domaine` varchar(32) NOT NULL,
  `adresse` varchar(16) DEFAULT NULL,
  `reseau` varchar(10) DEFAULT NULL,
  `modele` varchar(32) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `os` varchar(32) DEFAULT NULL,
  `macaddr` varchar(12) DEFAULT NULL,
  `faculte` varchar(20) DEFAULT NULL,
  `unite` varchar(20) DEFAULT NULL,
  `local` varchar(16) DEFAULT NULL,
  `resp_email` varchar(48) DEFAULT NULL,
  KEY `nom` (`nom`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hosts_old`
--

DROP TABLE IF EXISTS `hosts_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts_old` (
  `nom` varchar(32) NOT NULL,
  `domaine` varchar(32) NOT NULL,
  `adresse` varchar(16) DEFAULT NULL,
  `reseau` varchar(10) DEFAULT NULL,
  `modele` varchar(32) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `os` varchar(32) DEFAULT NULL,
  `macaddr` varchar(12) DEFAULT NULL,
  `faculte` varchar(20) DEFAULT NULL,
  `unite` varchar(20) DEFAULT NULL,
  `local` varchar(16) DEFAULT NULL,
  `resp_email` varchar(48) DEFAULT NULL,
  KEY `nom` (`nom`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `imap`
--

DROP TABLE IF EXISTS `imap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imap` (
  `sciper` char(6) NOT NULL,
  `server` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `imap_new`
--

DROP TABLE IF EXISTS `imap_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imap_new` (
  `sciper` char(6) NOT NULL,
  `server` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `imap_old`
--

DROP TABLE IF EXISTS `imap_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imap_old` (
  `sciper` char(6) NOT NULL,
  `server` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `isa_codes`
--

DROP TABLE IF EXISTS `isa_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `isa_codes` (
  `type` varchar(100) NOT NULL,
  `code` varchar(100) DEFAULT NULL,
  `libelle` varchar(150) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `isa_codes_old`
--

DROP TABLE IF EXISTS `isa_codes_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `isa_codes_old` (
  `type` varchar(100) NOT NULL,
  `code` varchar(100) DEFAULT NULL,
  `libelle` varchar(150) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `isa_ens`
--

DROP TABLE IF EXISTS `isa_ens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `isa_ens` (
  `sciper` varchar(6) NOT NULL,
  `nom` varchar(64) DEFAULT NULL,
  `prenom` varchar(32) DEFAULT NULL,
  `section` varchar(16) DEFAULT NULL,
  `unitacro` varchar(16) DEFAULT NULL,
  `unite` varchar(6) DEFAULT NULL,
  `emailint` varchar(64) DEFAULT NULL,
  `emailext` varchar(64) DEFAULT NULL,
  `telsac` varchar(16) DEFAULT NULL,
  `telbottin` varchar(16) DEFAULT NULL,
  `typeaddr` tinyint(4) DEFAULT NULL,
  `addr1` varchar(32) DEFAULT NULL,
  `addr2` varchar(32) DEFAULT NULL,
  `addr3` varchar(32) DEFAULT NULL,
  `addr4` varchar(32) DEFAULT NULL,
  `addr5` varchar(32) DEFAULT NULL,
  `fonctionsac` varchar(64) DEFAULT NULL,
  `titre` varchar(64) DEFAULT NULL,
  `cfsecens` varchar(6) DEFAULT NULL,
  `saisienotes` tinyint(4) DEFAULT NULL,
  KEY `sciper` (`sciper`),
  KEY `nom` (`nom`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `isa_ens_old`
--

DROP TABLE IF EXISTS `isa_ens_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `isa_ens_old` (
  `sciper` varchar(6) NOT NULL,
  `nom` varchar(64) DEFAULT NULL,
  `prenom` varchar(32) DEFAULT NULL,
  `section` varchar(16) DEFAULT NULL,
  `unitacro` varchar(16) DEFAULT NULL,
  `unite` varchar(6) DEFAULT NULL,
  `emailint` varchar(64) DEFAULT NULL,
  `emailext` varchar(64) DEFAULT NULL,
  `telsac` varchar(16) DEFAULT NULL,
  `telbottin` varchar(16) DEFAULT NULL,
  `typeaddr` tinyint(4) DEFAULT NULL,
  `addr1` varchar(32) DEFAULT NULL,
  `addr2` varchar(32) DEFAULT NULL,
  `addr3` varchar(32) DEFAULT NULL,
  `addr4` varchar(32) DEFAULT NULL,
  `addr5` varchar(32) DEFAULT NULL,
  `fonctionsac` varchar(64) DEFAULT NULL,
  `titre` varchar(64) DEFAULT NULL,
  `cfsecens` varchar(6) DEFAULT NULL,
  `saisienotes` tinyint(4) DEFAULT NULL,
  KEY `sciper` (`sciper`),
  KEY `nom` (`nom`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `isa_etu`
--

DROP TABLE IF EXISTS `isa_etu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `isa_etu` (
  `sciper` varchar(6) NOT NULL,
  `section` varchar(6) DEFAULT NULL,
  `orientation` varchar(32) DEFAULT NULL,
  `semestre` varchar(6) DEFAULT NULL,
  `matricule` varchar(8) DEFAULT NULL,
  `civilite` char(1) DEFAULT NULL,
  `statut` char(1) DEFAULT NULL,
  `categorie` varchar(16) DEFAULT NULL,
  `adresse1` varchar(36) DEFAULT NULL,
  `adresse2` varchar(36) DEFAULT NULL,
  `adresse3` varchar(36) DEFAULT NULL,
  `echange` varchar(36) DEFAULT NULL,
  `telephone` varchar(36) DEFAULT NULL,
  `idunite` varchar(6) DEFAULT NULL,
  `idpgmdoct` varchar(8) DEFAULT NULL,
  `libpgmdoct` varchar(64) DEFAULT NULL,
  `dateexmat` varchar(16) DEFAULT NULL,
  `periode` varchar(9) DEFAULT NULL,
  `hiverete` varchar(5) DEFAULT NULL,
  `uniteaccred` int(11) DEFAULT NULL,
  `debinscr` date DEFAULT NULL,
  `branche1` varchar(10) DEFAULT NULL,
  `branche3` varchar(10) DEFAULT NULL,
  `nivetude` varchar(10) DEFAULT NULL,
  `mineur` varchar(64) DEFAULT NULL,
  `autlieuetud` varchar(64) DEFAULT NULL,
  `masqannu` varchar(64) DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `isa_etu_old`
--

DROP TABLE IF EXISTS `isa_etu_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `isa_etu_old` (
  `sciper` varchar(6) NOT NULL,
  `section` varchar(6) DEFAULT NULL,
  `orientation` varchar(32) DEFAULT NULL,
  `semestre` varchar(6) DEFAULT NULL,
  `matricule` varchar(8) DEFAULT NULL,
  `civilite` char(1) DEFAULT NULL,
  `statut` char(1) DEFAULT NULL,
  `categorie` varchar(16) DEFAULT NULL,
  `adresse1` varchar(36) DEFAULT NULL,
  `adresse2` varchar(36) DEFAULT NULL,
  `adresse3` varchar(36) DEFAULT NULL,
  `echange` varchar(36) DEFAULT NULL,
  `telephone` varchar(36) DEFAULT NULL,
  `idunite` varchar(6) DEFAULT NULL,
  `idpgmdoct` varchar(8) DEFAULT NULL,
  `libpgmdoct` varchar(64) DEFAULT NULL,
  `dateexmat` varchar(16) DEFAULT NULL,
  `periode` varchar(9) DEFAULT NULL,
  `hiverete` varchar(5) DEFAULT NULL,
  `uniteaccred` int(11) DEFAULT NULL,
  `debinscr` date DEFAULT NULL,
  `branche1` varchar(10) DEFAULT NULL,
  `branche3` varchar(10) DEFAULT NULL,
  `nivetude` varchar(10) DEFAULT NULL,
  `mineur` varchar(64) DEFAULT NULL,
  `autlieuetud` varchar(64) DEFAULT NULL,
  `masqannu` varchar(64) DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `isa_etu_save`
--

DROP TABLE IF EXISTS `isa_etu_save`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `isa_etu_save` (
  `sciper` varchar(6) NOT NULL,
  `section` varchar(6) DEFAULT NULL,
  `orientation` varchar(32) DEFAULT NULL,
  `semestre` varchar(6) DEFAULT NULL,
  `matricule` varchar(8) DEFAULT NULL,
  `civilite` char(1) DEFAULT NULL,
  `statut` char(1) DEFAULT NULL,
  `categorie` varchar(6) DEFAULT NULL,
  `adresse1` varchar(36) DEFAULT NULL,
  `adresse2` varchar(36) DEFAULT NULL,
  `adresse3` varchar(36) DEFAULT NULL,
  `echange` varchar(36) DEFAULT NULL,
  `telephone` varchar(36) DEFAULT NULL,
  `idunite` varchar(6) DEFAULT NULL,
  `idpgmdoct` varchar(8) DEFAULT NULL,
  `libpgmdoct` varchar(64) DEFAULT NULL,
  `dateexmat` varchar(16) DEFAULT NULL,
  `periode` varchar(9) DEFAULT NULL,
  `hiverete` varchar(5) DEFAULT NULL,
  `uniteaccred` int(11) DEFAULT NULL,
  `debinscr` date DEFAULT NULL,
  `branche1` varchar(10) DEFAULT NULL,
  `branche3` varchar(10) DEFAULT NULL,
  `nivetude` varchar(10) DEFAULT NULL,
  `mineur` varchar(64) DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `isa_futurdoc`
--

DROP TABLE IF EXISTS `isa_futurdoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `isa_futurdoc` (
  `sciper` varchar(6) NOT NULL,
  `ecole` varchar(6) DEFAULT NULL,
  `debcand` date DEFAULT NULL,
  `fincand` date DEFAULT NULL,
  `annee` int(11) DEFAULT NULL,
  `periode` varchar(16) DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `isa_futurdoc_old`
--

DROP TABLE IF EXISTS `isa_futurdoc_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `isa_futurdoc_old` (
  `sciper` varchar(6) NOT NULL,
  `ecole` varchar(6) DEFAULT NULL,
  `debcand` date DEFAULT NULL,
  `fincand` date DEFAULT NULL,
  `annee` int(11) DEFAULT NULL,
  `periode` varchar(16) DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `isa_profs`
--

DROP TABLE IF EXISTS `isa_profs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `isa_profs` (
  `sciper` varchar(6) NOT NULL,
  `statut` varchar(32) DEFAULT NULL,
  `datedeb` date DEFAULT NULL,
  `datefin` date DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `isa_profs_old`
--

DROP TABLE IF EXISTS `isa_profs_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `isa_profs_old` (
  `sciper` varchar(6) NOT NULL,
  `statut` varchar(32) DEFAULT NULL,
  `datedeb` date DEFAULT NULL,
  `datefin` date DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `isaexcan`
--

DROP TABLE IF EXISTS `isaexcan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `isaexcan` (
  `sciper` char(6) NOT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `isaexcan_new`
--

DROP TABLE IF EXISTS `isaexcan_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `isaexcan_new` (
  `sciper` char(6) NOT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `isaexcan_old`
--

DROP TABLE IF EXISTS `isaexcan_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `isaexcan_old` (
  `sciper` char(6) NOT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivaluaaddrs`
--

DROP TABLE IF EXISTS `ivaluaaddrs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivaluaaddrs` (
  `hashkey` varchar(64) NOT NULL DEFAULT '',
  `Contact` varchar(6) DEFAULT NULL,
  `ORGA_ADR_CITY` varchar(64) DEFAULT NULL,
  `ORGA_ADR_COMP` varchar(64) DEFAULT NULL,
  `ORGA_ADR_COUNTRY` varchar(4) DEFAULT NULL,
  `ORGA_ADR_LABEL` varchar(64) DEFAULT NULL,
  `ORGA_ADR_STREET` varchar(64) DEFAULT NULL,
  `ORGA_ADR_ZIP` varchar(6) DEFAULT NULL,
  `ORGA_IS_MAIN` varchar(1) DEFAULT NULL,
  `ORGA_TYPE_CODE` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`hashkey`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivaluaaddrs_bak`
--

DROP TABLE IF EXISTS `ivaluaaddrs_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivaluaaddrs_bak` (
  `hashkey` varchar(64) NOT NULL DEFAULT '',
  `Contact` varchar(6) DEFAULT NULL,
  `ORGA_ADR_CITY` varchar(64) DEFAULT NULL,
  `ORGA_ADR_COMP` varchar(64) DEFAULT NULL,
  `ORGA_ADR_COUNTRY` varchar(4) DEFAULT NULL,
  `ORGA_ADR_LABEL` varchar(64) DEFAULT NULL,
  `ORGA_ADR_STREET` varchar(64) DEFAULT NULL,
  `ORGA_ADR_ZIP` varchar(6) DEFAULT NULL,
  `ORGA_IS_MAIN` varchar(1) DEFAULT NULL,
  `ORGA_TYPE_CODE` varchar(16) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivaluaaddrs_formation`
--

DROP TABLE IF EXISTS `ivaluaaddrs_formation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivaluaaddrs_formation` (
  `hashkey` varchar(64) NOT NULL DEFAULT '',
  `Contact` varchar(6) DEFAULT NULL,
  `ORGA_ADR_CITY` varchar(64) DEFAULT NULL,
  `ORGA_ADR_COMP` varchar(64) DEFAULT NULL,
  `ORGA_ADR_COUNTRY` varchar(4) DEFAULT NULL,
  `ORGA_ADR_LABEL` varchar(64) DEFAULT NULL,
  `ORGA_ADR_STREET` varchar(64) DEFAULT NULL,
  `ORGA_ADR_ZIP` varchar(6) DEFAULT NULL,
  `ORGA_IS_MAIN` varchar(1) DEFAULT NULL,
  `ORGA_TYPE_CODE` varchar(16) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivalualevel2`
--

DROP TABLE IF EXISTS `ivalualevel2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivalualevel2` (
  `POL_CODE` varchar(16) NOT NULL DEFAULT '',
  `POL_LABEL_FR` varchar(128) DEFAULT NULL,
  `POL_LABEL_EN` varchar(128) DEFAULT NULL,
  `GRP_CODE` varchar(16) DEFAULT NULL,
  `_POL_CENTRE_FINANCIER` varchar(8) DEFAULT NULL,
  `LCOMP_ID` varchar(1) DEFAULT NULL,
  `SHORT_LABEL` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`POL_CODE`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivalualevel2_bak`
--

DROP TABLE IF EXISTS `ivalualevel2_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivalualevel2_bak` (
  `POL_CODE` varchar(16) NOT NULL DEFAULT '',
  `POL_LABEL_FR` varchar(128) DEFAULT NULL,
  `POL_LABEL_EN` varchar(128) DEFAULT NULL,
  `GRP_CODE` varchar(16) DEFAULT NULL,
  `_POL_CENTRE_FINANCIER` varchar(8) DEFAULT NULL,
  `LCOMP_ID` varchar(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivalualevel2_formation`
--

DROP TABLE IF EXISTS `ivalualevel2_formation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivalualevel2_formation` (
  `POL_CODE` varchar(16) NOT NULL DEFAULT '',
  `POL_LABEL_FR` varchar(128) DEFAULT NULL,
  `POL_LABEL_EN` varchar(128) DEFAULT NULL,
  `GRP_CODE` varchar(16) DEFAULT NULL,
  `_POL_CENTRE_FINANCIER` varchar(8) DEFAULT NULL,
  `LCOMP_ID` varchar(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivalualevel3`
--

DROP TABLE IF EXISTS `ivalualevel3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivalualevel3` (
  `ENT_CODE` varchar(16) NOT NULL DEFAULT '',
  `ENT_LABEL_FR` varchar(128) DEFAULT NULL,
  `ENT_LABEL_EN` varchar(128) DEFAULT NULL,
  `POL_CODE` varchar(16) DEFAULT NULL,
  `_ENT_CENTRE_FINANCIER` varchar(8) DEFAULT NULL,
  `SHORT_LABEL` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ENT_CODE`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivalualevel3_bak`
--

DROP TABLE IF EXISTS `ivalualevel3_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivalualevel3_bak` (
  `ENT_CODE` varchar(16) NOT NULL DEFAULT '',
  `ENT_LABEL_FR` varchar(128) DEFAULT NULL,
  `ENT_LABEL_EN` varchar(128) DEFAULT NULL,
  `POL_CODE` varchar(16) DEFAULT NULL,
  `_ENT_CENTRE_FINANCIER` varchar(8) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivalualevel3_formation`
--

DROP TABLE IF EXISTS `ivalualevel3_formation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivalualevel3_formation` (
  `ENT_CODE` varchar(16) NOT NULL DEFAULT '',
  `ENT_LABEL_FR` varchar(128) DEFAULT NULL,
  `ENT_LABEL_EN` varchar(128) DEFAULT NULL,
  `POL_CODE` varchar(16) DEFAULT NULL,
  `_ENT_CENTRE_FINANCIER` varchar(8) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivalualevel4`
--

DROP TABLE IF EXISTS `ivalualevel4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivalualevel4` (
  `SITE_CODE` varchar(16) NOT NULL DEFAULT '',
  `SITE_LABEL_FR` varchar(128) DEFAULT NULL,
  `SITE_LABEL_EN` varchar(128) DEFAULT NULL,
  `COM_CODE` varchar(16) DEFAULT NULL,
  `ENT_CODE` varchar(16) DEFAULT NULL,
  `_SIT_CENTRE_FINANCIER` varchar(8) DEFAULT NULL,
  `SHORT_LABEL` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`SITE_CODE`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivalualevel4_bak`
--

DROP TABLE IF EXISTS `ivalualevel4_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivalualevel4_bak` (
  `SITE_CODE` varchar(16) NOT NULL DEFAULT '',
  `SITE_LABEL_FR` varchar(128) DEFAULT NULL,
  `SITE_LABEL_EN` varchar(128) DEFAULT NULL,
  `COM_CODE` varchar(16) DEFAULT NULL,
  `ENT_CODE` varchar(16) DEFAULT NULL,
  `_SIT_CENTRE_FINANCIER` varchar(8) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivalualevel4_formation`
--

DROP TABLE IF EXISTS `ivalualevel4_formation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivalualevel4_formation` (
  `SITE_CODE` varchar(16) NOT NULL DEFAULT '',
  `SITE_LABEL_FR` varchar(128) DEFAULT NULL,
  `SITE_LABEL_EN` varchar(128) DEFAULT NULL,
  `COM_CODE` varchar(16) DEFAULT NULL,
  `ENT_CODE` varchar(16) DEFAULT NULL,
  `_SIT_CENTRE_FINANCIER` varchar(8) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivaluaorgadd`
--

DROP TABLE IF EXISTS `ivaluaorgadd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivaluaorgadd` (
  `ORGA_LEVEL` varchar(8) DEFAULT NULL,
  `ORGA_NODE` varchar(16) NOT NULL DEFAULT '',
  `ORGA_TYPE_CODE` varchar(16) DEFAULT NULL,
  `ORGA_ADR_LABEL` varchar(64) DEFAULT NULL,
  `ORGA_ADR_NUM` varchar(16) DEFAULT NULL,
  `ORGA_ADR_STREET` varchar(64) DEFAULT NULL,
  `ORGA_ADR_COMP` varchar(64) DEFAULT NULL,
  `ORGA_ADR_ZIP` varchar(8) DEFAULT NULL,
  `ORGA_ADR_CITY` varchar(32) DEFAULT NULL,
  `ORGA_ADR_COUNTRY` varchar(16) DEFAULT NULL,
  `ORGA_IS_MAIN` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`ORGA_NODE`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivaluaorgadd_bak`
--

DROP TABLE IF EXISTS `ivaluaorgadd_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivaluaorgadd_bak` (
  `ORGA_LEVEL` varchar(8) DEFAULT NULL,
  `ORGA_NODE` varchar(16) NOT NULL DEFAULT '',
  `ORGA_TYPE_CODE` varchar(16) DEFAULT NULL,
  `ORGA_ADR_LABEL` varchar(64) DEFAULT NULL,
  `ORGA_ADR_NUM` varchar(16) DEFAULT NULL,
  `ORGA_ADR_STREET` varchar(64) DEFAULT NULL,
  `ORGA_ADR_COMP` varchar(64) DEFAULT NULL,
  `ORGA_ADR_ZIP` varchar(8) DEFAULT NULL,
  `ORGA_ADR_CITY` varchar(32) DEFAULT NULL,
  `ORGA_ADR_COUNTRY` varchar(16) DEFAULT NULL,
  `ORGA_IS_MAIN` varchar(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivaluaorgadd_formation`
--

DROP TABLE IF EXISTS `ivaluaorgadd_formation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivaluaorgadd_formation` (
  `ORGA_LEVEL` varchar(8) DEFAULT NULL,
  `ORGA_NODE` varchar(16) NOT NULL DEFAULT '',
  `ORGA_TYPE_CODE` varchar(16) DEFAULT NULL,
  `ORGA_ADR_LABEL` varchar(64) DEFAULT NULL,
  `ORGA_ADR_NUM` varchar(16) DEFAULT NULL,
  `ORGA_ADR_STREET` varchar(64) DEFAULT NULL,
  `ORGA_ADR_COMP` varchar(64) DEFAULT NULL,
  `ORGA_ADR_ZIP` varchar(8) DEFAULT NULL,
  `ORGA_ADR_CITY` varchar(32) DEFAULT NULL,
  `ORGA_ADR_COUNTRY` varchar(16) DEFAULT NULL,
  `ORGA_IS_MAIN` varchar(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivaluauserorgas`
--

DROP TABLE IF EXISTS `ivaluauserorgas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivaluauserorgas` (
  `LOGIN_NAME` varchar(6) NOT NULL,
  `CENTRE_FINANCIER` varchar(8) NOT NULL,
  `ORGA_LEVEL` varchar(8) NOT NULL,
  `hashkey` varchar(64) NOT NULL,
  PRIMARY KEY (`hashkey`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivaluauserorgas_bak`
--

DROP TABLE IF EXISTS `ivaluauserorgas_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivaluauserorgas_bak` (
  `LOGIN_NAME` varchar(6) NOT NULL,
  `CENTRE_FINANCIER` varchar(8) NOT NULL,
  `ORGA_LEVEL` varchar(8) NOT NULL,
  `hashkey` varchar(64) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivaluauserorgas_formation`
--

DROP TABLE IF EXISTS `ivaluauserorgas_formation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivaluauserorgas_formation` (
  `LOGIN_NAME` varchar(6) NOT NULL,
  `CENTRE_FINANCIER` varchar(8) NOT NULL,
  `ORGA_LEVEL` varchar(8) NOT NULL,
  `hashkey` varchar(64) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivaluausers`
--

DROP TABLE IF EXISTS `ivaluausers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivaluausers` (
  `LOGIN_NAME` varchar(6) NOT NULL DEFAULT '',
  `CONTACT_LASTNAME` varchar(64) DEFAULT NULL,
  `CONTACT_FIRSTNAME` varchar(64) DEFAULT NULL,
  `CONTACT_PHONE` varchar(64) DEFAULT NULL,
  `ADR_NOM_COMPLT` varchar(64) DEFAULT NULL,
  `ADR_NUM` varchar(16) DEFAULT NULL,
  `ADR_VOIE` varchar(64) DEFAULT NULL,
  `ADR_VOIE_COMPLT` varchar(64) DEFAULT NULL,
  `COUNTRY_CODE` varchar(4) DEFAULT NULL,
  `CONTACT_EMAIL` varchar(64) DEFAULT NULL,
  `LANG_CODE` varchar(4) DEFAULT NULL,
  `PTITLE_CODE` varchar(2) DEFAULT NULL,
  `ZIP_CODE` varchar(6) DEFAULT NULL,
  `ZIP_LABEL_FR` varchar(32) DEFAULT NULL,
  `PROFIL_CODE_1` varchar(32) DEFAULT NULL,
  `PROFIL_CODE_2` varchar(32) DEFAULT NULL,
  `PROFIL_CODE_3` varchar(32) DEFAULT NULL,
  `PROFIL_CODE_4` varchar(32) DEFAULT NULL,
  `PROFIL_CODE_5` varchar(32) DEFAULT NULL,
  `CENTRE_FINANCIER_1` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_1` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_2` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_2` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_3` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_3` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_4` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_4` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_5` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_5` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_6` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_6` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_7` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_7` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_8` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_8` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_9` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_9` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_10` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_10` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_11` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_11` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_12` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_12` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_13` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_13` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_14` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_14` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_15` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_15` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_16` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_16` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_17` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_17` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_18` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_18` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_19` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_19` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_20` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_20` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_21` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_21` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_22` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_22` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_23` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_23` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_24` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_24` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_25` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_25` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_26` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_26` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_27` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_27` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_28` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_28` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_29` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_29` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_30` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_30` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_31` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_31` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_32` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_32` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_33` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_33` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_34` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_34` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_35` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_35` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_36` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_36` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_37` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_37` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_38` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_38` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_39` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_39` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_40` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_40` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`LOGIN_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivaluausers_bak`
--

DROP TABLE IF EXISTS `ivaluausers_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivaluausers_bak` (
  `LOGIN_NAME` varchar(6) NOT NULL DEFAULT '',
  `CONTACT_LASTNAME` varchar(64) DEFAULT NULL,
  `CONTACT_FIRSTNAME` varchar(64) DEFAULT NULL,
  `CONTACT_PHONE` varchar(64) DEFAULT NULL,
  `ADR_NOM_COMPLT` varchar(64) DEFAULT NULL,
  `ADR_NUM` varchar(16) DEFAULT NULL,
  `ADR_VOIE` varchar(64) DEFAULT NULL,
  `ADR_VOIE_COMPLT` varchar(64) DEFAULT NULL,
  `COUNTRY_CODE` varchar(4) DEFAULT NULL,
  `CONTACT_EMAIL` varchar(64) DEFAULT NULL,
  `LANG_CODE` varchar(4) DEFAULT NULL,
  `PTITLE_CODE` varchar(2) DEFAULT NULL,
  `ZIP_CODE` varchar(6) DEFAULT NULL,
  `ZIP_LABEL_FR` varchar(32) DEFAULT NULL,
  `PROFIL_CODE_1` varchar(32) DEFAULT NULL,
  `PROFIL_CODE_2` varchar(32) DEFAULT NULL,
  `PROFIL_CODE_3` varchar(32) DEFAULT NULL,
  `PROFIL_CODE_4` varchar(32) DEFAULT NULL,
  `PROFIL_CODE_5` varchar(32) DEFAULT NULL,
  `CENTRE_FINANCIER_1` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_1` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_2` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_2` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_3` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_3` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_4` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_4` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_5` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_5` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_6` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_6` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_7` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_7` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_8` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_8` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_9` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_9` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_10` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_10` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_11` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_11` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_12` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_12` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_13` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_13` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_14` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_14` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_15` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_15` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_16` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_16` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_17` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_17` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_18` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_18` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_19` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_19` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_20` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_20` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_21` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_21` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_22` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_22` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_23` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_23` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_24` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_24` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_25` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_25` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_26` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_26` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_27` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_27` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_28` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_28` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_29` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_29` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_30` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_30` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_31` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_31` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_32` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_32` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_33` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_33` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_34` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_34` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_35` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_35` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_36` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_36` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_37` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_37` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_38` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_38` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_39` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_39` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_40` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_40` varchar(8) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ivaluausers_formation`
--

DROP TABLE IF EXISTS `ivaluausers_formation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ivaluausers_formation` (
  `LOGIN_NAME` varchar(6) NOT NULL DEFAULT '',
  `CONTACT_LASTNAME` varchar(64) DEFAULT NULL,
  `CONTACT_FIRSTNAME` varchar(64) DEFAULT NULL,
  `CONTACT_PHONE` varchar(64) DEFAULT NULL,
  `ADR_NOM_COMPLT` varchar(64) DEFAULT NULL,
  `ADR_NUM` varchar(16) DEFAULT NULL,
  `ADR_VOIE` varchar(64) DEFAULT NULL,
  `ADR_VOIE_COMPLT` varchar(64) DEFAULT NULL,
  `COUNTRY_CODE` varchar(4) DEFAULT NULL,
  `CONTACT_EMAIL` varchar(64) DEFAULT NULL,
  `LANG_CODE` varchar(4) DEFAULT NULL,
  `PTITLE_CODE` varchar(2) DEFAULT NULL,
  `ZIP_CODE` varchar(6) DEFAULT NULL,
  `ZIP_LABEL_FR` varchar(32) DEFAULT NULL,
  `PROFIL_CODE_1` varchar(32) DEFAULT NULL,
  `PROFIL_CODE_2` varchar(32) DEFAULT NULL,
  `PROFIL_CODE_3` varchar(32) DEFAULT NULL,
  `PROFIL_CODE_4` varchar(32) DEFAULT NULL,
  `PROFIL_CODE_5` varchar(32) DEFAULT NULL,
  `CENTRE_FINANCIER_1` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_1` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_2` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_2` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_3` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_3` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_4` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_4` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_5` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_5` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_6` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_6` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_7` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_7` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_8` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_8` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_9` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_9` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_10` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_10` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_11` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_11` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_12` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_12` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_13` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_13` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_14` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_14` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_15` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_15` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_16` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_16` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_17` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_17` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_18` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_18` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_19` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_19` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_20` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_20` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_21` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_21` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_22` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_22` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_23` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_23` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_24` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_24` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_25` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_25` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_26` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_26` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_27` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_27` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_28` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_28` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_29` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_29` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_30` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_30` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_31` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_31` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_32` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_32` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_33` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_33` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_34` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_34` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_35` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_35` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_36` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_36` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_37` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_37` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_38` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_38` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_39` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_39` varchar(8) DEFAULT NULL,
  `CENTRE_FINANCIER_40` varchar(8) DEFAULT NULL,
  `ORGA_LEVEL_40` varchar(8) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `langues`
--

DROP TABLE IF EXISTS `langues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `langues` (
  `code` smallint(6) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lastupdates`
--

DROP TABLE IF EXISTS `lastupdates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lastupdates` (
  `name` varchar(32) DEFAULT NULL,
  `lastupdate` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ldapstamps`
--

DROP TABLE IF EXISTS `ldapstamps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ldapstamps` (
  `dn` varchar(256) NOT NULL,
  `hash` char(40) DEFAULT NULL,
  `stamp` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`dn`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ldapstamps_old`
--

DROP TABLE IF EXISTS `ldapstamps_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ldapstamps_old` (
  `dn` varchar(256) DEFAULT NULL,
  `hash` char(40) DEFAULT NULL,
  `stamp` varchar(16) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locaux`
--

DROP TABLE IF EXISTS `locaux`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locaux` (
  `site_id` int(11) NOT NULL,
  `bat_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `room_abr` varchar(25) DEFAULT NULL,
  `room_zone` varchar(10) DEFAULT NULL,
  `room_etage` varchar(10) DEFAULT NULL,
  `room_din` varchar(10) DEFAULT NULL,
  `room_alias` varchar(40) DEFAULT NULL,
  `room_uti_admin` varchar(40) DEFAULT NULL,
  `room_uti_faculte` varchar(40) DEFAULT NULL,
  `room_cf_2` varchar(16) DEFAULT NULL,
  `room_cf_3` varchar(16) DEFAULT NULL,
  `room_cf_4` varchar(16) DEFAULT NULL,
  `canon` varchar(16) DEFAULT NULL,
  `x_ehandle` varchar(8) DEFAULT NULL,
  `n_places` int(11) DEFAULT NULL,
  `n_surf_esp` float DEFAULT NULL,
  `stationpost` int(11) DEFAULT NULL,
  `height` float DEFAULT NULL,
  PRIMARY KEY (`room_id`),
  KEY `room_abr` (`room_abr`),
  KEY `room_alias` (`room_alias`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locaux_old`
--

DROP TABLE IF EXISTS `locaux_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locaux_old` (
  `site_id` int(11) NOT NULL,
  `bat_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `room_abr` varchar(25) DEFAULT NULL,
  `room_zone` varchar(10) DEFAULT NULL,
  `room_etage` varchar(10) DEFAULT NULL,
  `room_din` varchar(10) DEFAULT NULL,
  `room_alias` varchar(40) DEFAULT NULL,
  `room_uti_admin` varchar(40) DEFAULT NULL,
  `room_uti_faculte` varchar(40) DEFAULT NULL,
  `room_cf_2` varchar(16) DEFAULT NULL,
  `room_cf_3` varchar(16) DEFAULT NULL,
  `room_cf_4` varchar(16) DEFAULT NULL,
  `canon` varchar(16) DEFAULT NULL,
  `x_ehandle` varchar(8) DEFAULT NULL,
  `n_places` int(11) DEFAULT NULL,
  `n_surf_esp` float DEFAULT NULL,
  `stationpost` int(11) DEFAULT NULL,
  `height` float DEFAULT NULL,
  PRIMARY KEY (`room_id`),
  KEY `room_abr` (`room_abr`),
  KEY `room_alias` (`room_alias`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `membres`
--

DROP TABLE IF EXISTS `membres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `membres` (
  `sciper` varchar(6) NOT NULL DEFAULT '',
  `groupe` varchar(64) DEFAULT NULL,
  `admin` char(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `membres_after`
--

DROP TABLE IF EXISTS `membres_after`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `membres_after` (
  `sciper` varchar(6) NOT NULL DEFAULT '',
  `groupe` varchar(64) DEFAULT NULL,
  `admin` char(1) DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `membres_before`
--

DROP TABLE IF EXISTS `membres_before`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `membres_before` (
  `sciper` varchar(6) NOT NULL DEFAULT '',
  `groupe` varchar(64) DEFAULT NULL,
  `admin` char(1) DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `newgroups`
--

DROP TABLE IF EXISTS `newgroups`;
/*!50001 DROP VIEW IF EXISTS `newgroups`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `newgroups` (
 `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `owner` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `url` tinyint NOT NULL,
  `access` tinyint NOT NULL,
  `registration` tinyint NOT NULL,
  `visible` tinyint NOT NULL,
  `maillist` tinyint NOT NULL,
  `ldap` tinyint NOT NULL,
  `gid` tinyint NOT NULL,
  `creation` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `nicknames`
--

DROP TABLE IF EXISTS `nicknames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nicknames` (
  `sciper` varchar(6) NOT NULL DEFAULT '',
  `nickname` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orient`
--

DROP TABLE IF EXISTS `orient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orient` (
  `code` smallint(6) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=72 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orient_old`
--

DROP TABLE IF EXISTS `orient_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orient_old` (
  `code` smallint(6) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `otpusers`
--

DROP TABLE IF EXISTS `otpusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `otpusers` (
  `sciper` char(6) NOT NULL DEFAULT '',
  `username` varchar(16) DEFAULT NULL,
  `totpsecret` char(26) DEFAULT NULL,
  `hotpsecret` char(26) DEFAULT NULL,
  `counter` int(11) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`sciper`),
  KEY `username` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pays`
--

DROP TABLE IF EXISTS `pays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pays` (
  `code` smallint(6) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `persdata`
--

DROP TABLE IF EXISTS `persdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persdata` (
  `sciper` varchar(10) NOT NULL,
  `fax` varchar(64) DEFAULT NULL,
  `web` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `persdata_old`
--

DROP TABLE IF EXISTS `persdata_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persdata_old` (
  `sciper` varchar(10) NOT NULL,
  `fax` varchar(64) DEFAULT NULL,
  `web` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `personnel`
--

DROP TABLE IF EXISTS `personnel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personnel` (
  `sciper` char(6) NOT NULL DEFAULT '',
  `codpolit` char(1) DEFAULT NULL,
  `fctfed` char(4) DEFAULT NULL,
  `fctint` char(4) DEFAULT NULL,
  `finepfl` char(8) DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phonex`
--

DROP TABLE IF EXISTS `phonex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phonex` (
  `sciper` char(6) DEFAULT NULL,
  `phonex` double DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` mediumint(9) NOT NULL,
  `libelle` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sac`
--

DROP TABLE IF EXISTS `sac`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sac` (
  `sciper` varchar(6) NOT NULL DEFAULT '',
  `section` varchar(6) DEFAULT NULL,
  `orientation` smallint(6) DEFAULT NULL,
  `semestre` smallint(6) DEFAULT NULL,
  `civilite` char(1) DEFAULT NULL,
  `statut` char(1) DEFAULT NULL,
  `categorie` char(1) DEFAULT NULL,
  `addresse1` varchar(36) DEFAULT NULL,
  `addresse2` varchar(36) DEFAULT NULL,
  `addresse3` varchar(36) DEFAULT NULL,
  `echange` varchar(36) DEFAULT NULL,
  `telephone` varchar(36) DEFAULT NULL,
  `id_unite` varchar(6) DEFAULT NULL,
  `idpgmdoct` varchar(8) DEFAULT NULL,
  `libpgmdoct` varchar(64) DEFAULT NULL,
  `dateexmat` varchar(16) DEFAULT NULL,
  `uniteaccred` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sac1`
--

DROP TABLE IF EXISTS `sac1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sac1` (
  `sciper` varchar(6) NOT NULL DEFAULT '',
  `section` varchar(6) DEFAULT NULL,
  `orientation` smallint(6) DEFAULT NULL,
  `semestre` smallint(6) DEFAULT NULL,
  `civilite` char(1) DEFAULT NULL,
  `statut` char(1) DEFAULT NULL,
  `categorie` char(1) DEFAULT NULL,
  `addresse1` varchar(36) DEFAULT NULL,
  `addresse2` varchar(36) DEFAULT NULL,
  `addresse3` varchar(36) DEFAULT NULL,
  `echange` varchar(36) DEFAULT NULL,
  `telephone` varchar(36) DEFAULT NULL,
  `idunite` varchar(6) DEFAULT NULL,
  `idpgmdoct` varchar(8) DEFAULT NULL,
  `libpgmdoct` varchar(64) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sacens`
--

DROP TABLE IF EXISTS `sacens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sacens` (
  `sciper` varchar(6) NOT NULL DEFAULT '',
  `nom` varchar(64) DEFAULT NULL,
  `prenom` varchar(32) DEFAULT NULL,
  `section` varchar(16) DEFAULT NULL,
  `unitacro` varchar(16) DEFAULT NULL,
  `unite` varchar(6) DEFAULT NULL,
  `emailint` varchar(64) DEFAULT NULL,
  `emailext` varchar(64) DEFAULT NULL,
  `telsac` varchar(16) DEFAULT NULL,
  `telbottin` varchar(16) DEFAULT NULL,
  `typeaddr` tinyint(4) DEFAULT NULL,
  `addr1` varchar(32) DEFAULT NULL,
  `addr2` varchar(32) DEFAULT NULL,
  `addr3` varchar(32) DEFAULT NULL,
  `addr4` varchar(32) DEFAULT NULL,
  `addr5` varchar(32) DEFAULT NULL,
  `fonctionsac` varchar(64) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sappers`
--

DROP TABLE IF EXISTS `sappers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sappers` (
  `sciper` varchar(6) NOT NULL DEFAULT '',
  `unite` varchar(6) DEFAULT NULL,
  `tauxact` mediumint(9) DEFAULT NULL,
  `debcont` varchar(8) DEFAULT NULL,
  `fincont` varchar(8) DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sciper`
--

DROP TABLE IF EXISTS `sciper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sciper` (
  `sciper` varchar(6) NOT NULL,
  `nom` varchar(64) DEFAULT NULL,
  `prenom` varchar(64) DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  `nom_acc` varchar(64) DEFAULT NULL,
  `prenom_acc` varchar(64) DEFAULT NULL,
  `date_naiss` varchar(12) DEFAULT NULL,
  `sexe` char(1) DEFAULT NULL,
  `canon` varchar(32) DEFAULT NULL,
  `nom_usuel` varchar(64) DEFAULT NULL,
  `prenom_usuel` varchar(64) DEFAULT NULL,
  `nom_usuel_maj` varchar(64) DEFAULT NULL,
  `prenom_usuel_maj` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`sciper`),
  KEY `nom` (`nom`),
  KEY `prenom` (`prenom`),
  KEY `nom_acc` (`nom_acc`),
  KEY `prenom_acc` (`prenom_acc`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sciper_old`
--

DROP TABLE IF EXISTS `sciper_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sciper_old` (
  `sciper` varchar(6) NOT NULL,
  `nom` varchar(64) DEFAULT NULL,
  `prenom` varchar(64) DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  `nom_acc` varchar(64) DEFAULT NULL,
  `prenom_acc` varchar(64) DEFAULT NULL,
  `date_naiss` varchar(12) DEFAULT NULL,
  `sexe` char(1) DEFAULT NULL,
  `canon` varchar(32) DEFAULT NULL,
  `nom_usuel` varchar(64) DEFAULT NULL,
  `prenom_usuel` varchar(64) DEFAULT NULL,
  `nom_usuel_maj` varchar(64) DEFAULT NULL,
  `prenom_usuel_maj` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`sciper`),
  KEY `nom` (`nom`),
  KEY `prenom` (`prenom`),
  KEY `nom_acc` (`nom_acc`),
  KEY `prenom_acc` (`prenom_acc`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `label` varchar(64) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `owner` varchar(6) DEFAULT NULL,
  `unit` varchar(6) DEFAULT NULL,
  `description` varchar(256) DEFAULT NULL,
  `tequila` char(1) DEFAULT NULL,
  `ldap` char(1) DEFAULT NULL,
  `ad` char(1) DEFAULT NULL,
  `radius` char(1) DEFAULT NULL,
  `sco` char(1) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `gid` int(11) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `camiproid` char(5) DEFAULT NULL,
  `camiprorfid` varchar(32) DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `removal` datetime DEFAULT NULL,
  `renewed` datetime DEFAULT NULL,
  `reminded` datetime DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3647 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serviceslog`
--

DROP TABLE IF EXISTS `serviceslog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serviceslog` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `author` char(6) DEFAULT NULL,
  `action` tinyint(4) DEFAULT NULL,
  `srvid` mediumint(9) DEFAULT NULL,
  `text` text,
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=57443 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sid`
--

DROP TABLE IF EXISTS `sid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sid` (
  `sciper` varchar(6) NOT NULL DEFAULT '',
  `nom` varchar(32) DEFAULT NULL,
  `prenom` varchar(32) DEFAULT NULL,
  `sexe` char(1) DEFAULT NULL,
  `type` char(3) DEFAULT NULL,
  `cf` varchar(5) DEFAULT NULL,
  KEY `sciper` (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sid2`
--

DROP TABLE IF EXISTS `sid2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sid2` (
  `sciper` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `cf_sac` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `camipro_category` varchar(45) DEFAULT NULL,
  `camipro_enddate` datetime DEFAULT NULL,
  `agepoly` tinyint(1) DEFAULT '0',
  `extension` tinyint(1) DEFAULT '0',
  `valid_from` datetime NOT NULL,
  `valid_to` datetime DEFAULT NULL,
  PRIMARY KEY (`sciper`,`unit_id`,`valid_from`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sid2_person`
--

DROP TABLE IF EXISTS `sid2_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sid2_person` (
  `sciper` int(11) NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `firstname_long` varchar(255) DEFAULT NULL,
  `lastname_long` varchar(255) DEFAULT NULL,
  `camipro_category` varchar(45) DEFAULT NULL,
  `camipro_enddate` datetime DEFAULT NULL,
  `camipro_unconditional_enddate` datetime DEFAULT NULL,
  `agepoly` tinyint(1) DEFAULT '0',
  `extension` tinyint(1) DEFAULT '0',
  `valid_from` datetime NOT NULL,
  `valid_to` datetime DEFAULT NULL,
  PRIMARY KEY (`sciper`,`valid_from`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sid2_person_bkp`
--

DROP TABLE IF EXISTS `sid2_person_bkp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sid2_person_bkp` (
  `sciper` int(11) NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `camipro_category` varchar(45) DEFAULT NULL,
  `camipro_enddate` datetime DEFAULT NULL,
  `camipro_unconditional_enddate` datetime DEFAULT NULL,
  `agepoly` tinyint(1) DEFAULT '0',
  `extension` tinyint(1) DEFAULT '0',
  `valid_from` datetime NOT NULL,
  `valid_to` datetime DEFAULT NULL,
  PRIMARY KEY (`sciper`,`valid_from`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sid2_person_new`
--

DROP TABLE IF EXISTS `sid2_person_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sid2_person_new` (
  `sciper` int(11) NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `firstname_long` varchar(255) DEFAULT NULL,
  `lastname_long` varchar(255) DEFAULT NULL,
  `camipro_category` varchar(45) DEFAULT NULL,
  `camipro_enddate` datetime DEFAULT NULL,
  `camipro_unconditional_enddate` datetime DEFAULT NULL,
  `agepoly` tinyint(1) DEFAULT '0',
  `extension` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sid2_person_profile`
--

DROP TABLE IF EXISTS `sid2_person_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sid2_person_profile` (
  `sciper` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `cf_sac` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `valid_from` datetime NOT NULL,
  `valid_to` datetime DEFAULT NULL,
  PRIMARY KEY (`sciper`,`unit_id`,`valid_from`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sid2_person_profile_bkp`
--

DROP TABLE IF EXISTS `sid2_person_profile_bkp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sid2_person_profile_bkp` (
  `sciper` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `cf_sac` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `camipro` tinyint(1) DEFAULT '0',
  `valid_from` datetime NOT NULL,
  `valid_to` datetime DEFAULT NULL,
  PRIMARY KEY (`sciper`,`unit_id`,`valid_from`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sid2_person_profile_new`
--

DROP TABLE IF EXISTS `sid2_person_profile_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sid2_person_profile_new` (
  `sciper` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `cf_sac` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `camipro` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`sciper`,`unit_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sid2_profile`
--

DROP TABLE IF EXISTS `sid2_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sid2_profile` (
  `unit_id` int(11) NOT NULL,
  `cf` varchar(5) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(100) NOT NULL,
  `hierarchy` varchar(100) NOT NULL,
  `valid_from` datetime NOT NULL,
  `valid_to` datetime DEFAULT NULL,
  PRIMARY KEY (`unit_id`,`valid_from`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sid2_profile_bkp`
--

DROP TABLE IF EXISTS `sid2_profile_bkp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sid2_profile_bkp` (
  `unit_id` int(11) NOT NULL,
  `cf` varchar(5) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(100) NOT NULL,
  `hierarchy` varchar(100) NOT NULL,
  `valid_from` datetime NOT NULL,
  `valid_to` datetime DEFAULT NULL,
  PRIMARY KEY (`unit_id`,`valid_from`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sid2_profile_new`
--

DROP TABLE IF EXISTS `sid2_profile_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sid2_profile_new` (
  `unit_id` int(11) NOT NULL,
  `cf` varchar(5) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(100) NOT NULL,
  `hierarchy` varchar(100) NOT NULL,
  PRIMARY KEY (`unit_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `site_id` int(11) NOT NULL,
  `site_abr` varchar(4) DEFAULT NULL,
  `site_lib` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sites_old`
--

DROP TABLE IF EXISTS `sites_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites_old` (
  `site_id` int(11) NOT NULL,
  `site_abr` varchar(4) DEFAULT NULL,
  `site_lib` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `skeyslips`
--

DROP TABLE IF EXISTS `skeyslips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skeyslips` (
  `username` varchar(32) DEFAULT NULL,
  `salt` char(4) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `lastkey` char(14) NOT NULL DEFAULT '',
  `created` datetime DEFAULT NULL,
  `initialized` datetime DEFAULT NULL,
  PRIMARY KEY (`lastkey`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `skeyusers`
--

DROP TABLE IF EXISTS `skeyusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skeyusers` (
  `username` varchar(32) NOT NULL,
  `type` varchar(8) DEFAULT NULL,
  `salt` char(4) NOT NULL,
  `lastnum` int(11) NOT NULL,
  `lastkey` varchar(14) DEFAULT NULL,
  `origkey` varchar(14) DEFAULT NULL,
  `initkey` varchar(6) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `statuts`
--

DROP TABLE IF EXISTS `statuts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statuts` (
  `id` mediumint(9) NOT NULL DEFAULT '0',
  `libelle` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stinas_accreds`
--

DROP TABLE IF EXISTS `stinas_accreds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stinas_accreds` (
  `sciper` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `gid` int(11) NOT NULL,
  `sigle` varchar(50) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `hierarchy` varchar(255) DEFAULT NULL,
  `accred_order` int(11) NOT NULL,
  PRIMARY KEY (`sciper`,`unit_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stinas_accreds_old`
--

DROP TABLE IF EXISTS `stinas_accreds_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stinas_accreds_old` (
  `sciper` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `gid` int(11) NOT NULL,
  `sigle` varchar(50) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `hierarchy` varchar(255) DEFAULT NULL,
  `accred_order` int(11) NOT NULL,
  PRIMARY KEY (`sciper`,`unit_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stinas_units`
--

DROP TABLE IF EXISTS `stinas_units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stinas_units` (
  `id` int(11) NOT NULL,
  `sigle` varchar(50) DEFAULT NULL,
  `label` varchar(255) NOT NULL,
  `gid` int(11) NOT NULL,
  `hierarchy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stinas_units_old`
--

DROP TABLE IF EXISTS `stinas_units_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stinas_units_old` (
  `id` int(11) NOT NULL,
  `sigle` varchar(50) DEFAULT NULL,
  `label` varchar(255) NOT NULL,
  `gid` int(11) NOT NULL,
  `hierarchy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `testutf8`
--

DROP TABLE IF EXISTS `testutf8`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testutf8` (
  `libelle` varchar(64) COLLATE utf8_bin DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `types_unites`
--

DROP TABLE IF EXISTS `types_unites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `types_unites` (
  `code` smallint(6) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unitdata`
--

DROP TABLE IF EXISTS `unitdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unitdata` (
  `id` varchar(6) NOT NULL,
  `address` varchar(128) DEFAULT NULL,
  `url` varchar(128) DEFAULT NULL,
  `faxes` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unitdata_old`
--

DROP TABLE IF EXISTS `unitdata_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unitdata_old` (
  `id` varchar(6) NOT NULL,
  `address` varchar(128) DEFAULT NULL,
  `url` varchar(128) DEFAULT NULL,
  `faxes` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unites`
--

DROP TABLE IF EXISTS `unites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unites` (
  `sigle` varchar(24) DEFAULT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `abrege` varchar(64) DEFAULT NULL,
  `date_debut` varchar(16) DEFAULT NULL,
  `date_fin` varchar(16) DEFAULT NULL,
  `type` varchar(24) DEFAULT NULL,
  `resp_unite` varchar(6) DEFAULT NULL,
  `cf` varchar(6) DEFAULT NULL,
  `hierarchie` varchar(64) DEFAULT NULL,
  `id_unite` varchar(6) NOT NULL,
  `id_parent` varchar(6) DEFAULT NULL,
  `sigle_en` varchar(24) DEFAULT NULL,
  `libelle_en` varchar(128) DEFAULT NULL,
  `abrege_en` varchar(64) DEFAULT NULL,
  `ordre` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id_unite`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unites1`
--

DROP TABLE IF EXISTS `unites1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unites1` (
  `id_unite` varchar(6) NOT NULL,
  `id_parent` varchar(6) DEFAULT NULL,
  `sigle` varchar(24) DEFAULT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `abrege` varchar(64) DEFAULT NULL,
  `date_debut` datetime DEFAULT NULL,
  `date_fin` datetime DEFAULT NULL,
  `type` smallint(6) DEFAULT NULL,
  `responsable` varchar(6) DEFAULT NULL,
  `langueprinc` smallint(6) DEFAULT NULL,
  `no_unite` varchar(6) DEFAULT NULL,
  `cf` varchar(6) DEFAULT NULL,
  `hierarchie` varchar(64) DEFAULT NULL,
  `niveau` smallint(6) DEFAULT NULL,
  `date_creat` datetime DEFAULT NULL,
  `date_modif` datetime DEFAULT NULL,
  `sigle_en` varchar(24) DEFAULT NULL,
  `libelle_en` varchar(128) DEFAULT NULL,
  `abrege_en` varchar(64) DEFAULT NULL,
  `sigle_de` varchar(24) DEFAULT NULL,
  `libelle_de` varchar(128) DEFAULT NULL,
  `abrege_de` varchar(64) DEFAULT NULL,
  `sigle_it` varchar(24) DEFAULT NULL,
  `libelle_it` varchar(128) DEFAULT NULL,
  `abrege_it` varchar(64) DEFAULT NULL,
  `adresse_1` varchar(64) DEFAULT NULL,
  `adresse_2` varchar(64) DEFAULT NULL,
  `adresse_3` varchar(64) DEFAULT NULL,
  `adresse_4` varchar(64) DEFAULT NULL,
  `ville` varchar(64) DEFAULT NULL,
  `pays` smallint(6) DEFAULT NULL,
  `cmpl_type` varchar(4) DEFAULT NULL,
  `visible` char(1) DEFAULT NULL,
  `affichage` char(3) DEFAULT NULL,
  `fnresp` varchar(64) DEFAULT NULL,
  `visildap` char(1) DEFAULT NULL,
  `sigleorga` varchar(8) DEFAULT NULL,
  `ordre` smallint(6) DEFAULT NULL,
  KEY `id_unite` (`id_unite`),
  KEY `cf` (`cf`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unites1_old`
--

DROP TABLE IF EXISTS `unites1_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unites1_old` (
  `id_unite` varchar(6) NOT NULL,
  `id_parent` varchar(6) DEFAULT NULL,
  `sigle` varchar(24) DEFAULT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `abrege` varchar(64) DEFAULT NULL,
  `date_debut` datetime DEFAULT NULL,
  `date_fin` datetime DEFAULT NULL,
  `type` smallint(6) DEFAULT NULL,
  `responsable` varchar(6) DEFAULT NULL,
  `langueprinc` smallint(6) DEFAULT NULL,
  `no_unite` varchar(6) DEFAULT NULL,
  `cf` varchar(6) DEFAULT NULL,
  `hierarchie` varchar(64) DEFAULT NULL,
  `niveau` smallint(6) DEFAULT NULL,
  `date_creat` datetime DEFAULT NULL,
  `date_modif` datetime DEFAULT NULL,
  `sigle_en` varchar(24) DEFAULT NULL,
  `libelle_en` varchar(128) DEFAULT NULL,
  `abrege_en` varchar(64) DEFAULT NULL,
  `sigle_de` varchar(24) DEFAULT NULL,
  `libelle_de` varchar(128) DEFAULT NULL,
  `abrege_de` varchar(64) DEFAULT NULL,
  `sigle_it` varchar(24) DEFAULT NULL,
  `libelle_it` varchar(128) DEFAULT NULL,
  `abrege_it` varchar(64) DEFAULT NULL,
  `adresse_1` varchar(64) DEFAULT NULL,
  `adresse_2` varchar(64) DEFAULT NULL,
  `adresse_3` varchar(64) DEFAULT NULL,
  `adresse_4` varchar(64) DEFAULT NULL,
  `ville` varchar(64) DEFAULT NULL,
  `pays` smallint(6) DEFAULT NULL,
  `cmpl_type` varchar(4) DEFAULT NULL,
  `visible` char(1) DEFAULT NULL,
  `affichage` char(3) DEFAULT NULL,
  `fnresp` varchar(64) DEFAULT NULL,
  `visildap` char(1) DEFAULT NULL,
  `sigleorga` varchar(8) DEFAULT NULL,
  `ordre` smallint(6) DEFAULT NULL,
  KEY `id_unite` (`id_unite`),
  KEY `cf` (`cf`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unites2`
--

DROP TABLE IF EXISTS `unites2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unites2` (
  `sigle` varchar(24) DEFAULT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `abrege` varchar(64) DEFAULT NULL,
  `date_debut` varchar(16) DEFAULT NULL,
  `date_fin` varchar(16) DEFAULT NULL,
  `type` varchar(24) DEFAULT NULL,
  `resp_unite` varchar(6) DEFAULT NULL,
  `cf` varchar(6) DEFAULT NULL,
  `hierarchie` varchar(64) DEFAULT NULL,
  `id_unite` int(11) NOT NULL DEFAULT '0',
  `id_parent` int(11) DEFAULT NULL,
  `sigle_en` varchar(24) DEFAULT NULL,
  `libelle_en` varchar(128) DEFAULT NULL,
  `abrege_en` varchar(64) DEFAULT NULL,
  `ordre` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id_unite`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unites_alumni`
--

DROP TABLE IF EXISTS `unites_alumni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unites_alumni` (
  `id_unite` int(11) NOT NULL AUTO_INCREMENT,
  `sigle` varchar(16) DEFAULT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `libelle_en` varchar(128) DEFAULT NULL,
  `hierarchie` varchar(64) DEFAULT NULL,
  `niveau` smallint(6) DEFAULT NULL,
  `date_debut` datetime DEFAULT NULL,
  `date_fin` datetime DEFAULT NULL,
  `id_parent` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_unite`)
) ENGINE=MyISAM AUTO_INCREMENT=60029 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unites_alumni_new`
--

DROP TABLE IF EXISTS `unites_alumni_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unites_alumni_new` (
  `id_unite` int(11) NOT NULL AUTO_INCREMENT,
  `sigle` varchar(16) DEFAULT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `libelle_en` varchar(128) DEFAULT NULL,
  `hierarchie` varchar(64) DEFAULT NULL,
  `niveau` smallint(6) DEFAULT NULL,
  `date_debut` datetime DEFAULT NULL,
  `date_fin` datetime DEFAULT NULL,
  `id_parent` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_unite`)
) ENGINE=MyISAM AUTO_INCREMENT=60029 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unites_alumni_old`
--

DROP TABLE IF EXISTS `unites_alumni_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unites_alumni_old` (
  `id_unite` int(11) NOT NULL AUTO_INCREMENT,
  `sigle` varchar(16) DEFAULT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `libelle_en` varchar(128) DEFAULT NULL,
  `hierarchie` varchar(64) DEFAULT NULL,
  `niveau` smallint(6) DEFAULT NULL,
  `date_debut` datetime DEFAULT NULL,
  `date_fin` datetime DEFAULT NULL,
  `id_parent` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_unite`)
) ENGINE=MyISAM AUTO_INCREMENT=60029 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unites_etud`
--

DROP TABLE IF EXISTS `unites_etud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unites_etud` (
  `id_unite` int(11) NOT NULL AUTO_INCREMENT,
  `sigle` varchar(16) DEFAULT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `libelle_en` varchar(128) DEFAULT NULL,
  `hierarchie` varchar(64) DEFAULT NULL,
  `niveau` smallint(6) DEFAULT NULL,
  `date_debut` datetime DEFAULT NULL,
  `date_fin` datetime DEFAULT NULL,
  `id_parent` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_unite`)
) ENGINE=MyISAM AUTO_INCREMENT=50391 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unites_etud_old`
--

DROP TABLE IF EXISTS `unites_etud_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unites_etud_old` (
  `id_unite` int(11) NOT NULL AUTO_INCREMENT,
  `sigle` varchar(16) DEFAULT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `libelle_en` varchar(128) DEFAULT NULL,
  `hierarchie` varchar(64) DEFAULT NULL,
  `niveau` smallint(6) DEFAULT NULL,
  `date_debut` datetime DEFAULT NULL,
  `date_fin` datetime DEFAULT NULL,
  `id_parent` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_unite`)
) ENGINE=MyISAM AUTO_INCREMENT=50391 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unites_hbp`
--

DROP TABLE IF EXISTS `unites_hbp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unites_hbp` (
  `id_unite` int(11) NOT NULL AUTO_INCREMENT,
  `sigle` varchar(16) DEFAULT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `libelle_en` varchar(128) DEFAULT NULL,
  `hierarchie` varchar(64) DEFAULT NULL,
  `niveau` smallint(6) DEFAULT NULL,
  `date_debut` datetime DEFAULT NULL,
  `date_fin` datetime DEFAULT NULL,
  `id_parent` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_unite`)
) ENGINE=MyISAM AUTO_INCREMENT=71114 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unites_hbp_new`
--

DROP TABLE IF EXISTS `unites_hbp_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unites_hbp_new` (
  `id_unite` int(11) NOT NULL AUTO_INCREMENT,
  `sigle` varchar(16) DEFAULT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `libelle_en` varchar(128) DEFAULT NULL,
  `hierarchie` varchar(64) DEFAULT NULL,
  `niveau` smallint(6) DEFAULT NULL,
  `date_debut` datetime DEFAULT NULL,
  `date_fin` datetime DEFAULT NULL,
  `id_parent` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_unite`)
) ENGINE=MyISAM AUTO_INCREMENT=71114 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unites_hbp_old`
--

DROP TABLE IF EXISTS `unites_hbp_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unites_hbp_old` (
  `id_unite` int(11) NOT NULL AUTO_INCREMENT,
  `sigle` varchar(16) DEFAULT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `libelle_en` varchar(128) DEFAULT NULL,
  `hierarchie` varchar(64) DEFAULT NULL,
  `niveau` smallint(6) DEFAULT NULL,
  `date_debut` datetime DEFAULT NULL,
  `date_fin` datetime DEFAULT NULL,
  `id_parent` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_unite`)
) ENGINE=MyISAM AUTO_INCREMENT=71114 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unites_old`
--

DROP TABLE IF EXISTS `unites_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unites_old` (
  `sigle` varchar(24) DEFAULT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `abrege` varchar(64) DEFAULT NULL,
  `date_debut` varchar(16) DEFAULT NULL,
  `date_fin` varchar(16) DEFAULT NULL,
  `type` varchar(24) DEFAULT NULL,
  `resp_unite` varchar(6) DEFAULT NULL,
  `cf` varchar(6) DEFAULT NULL,
  `hierarchie` varchar(64) DEFAULT NULL,
  `id_unite` varchar(6) NOT NULL,
  `id_parent` varchar(6) DEFAULT NULL,
  `sigle_en` varchar(24) DEFAULT NULL,
  `libelle_en` varchar(128) DEFAULT NULL,
  `abrege_en` varchar(64) DEFAULT NULL,
  `ordre` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id_unite`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unitesutf8`
--

DROP TABLE IF EXISTS `unitesutf8`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unitesutf8` (
  `sigle` varchar(24) DEFAULT NULL,
  `libelle` varchar(128) DEFAULT NULL,
  `abrege` varchar(64) DEFAULT NULL,
  `date_debut` varchar(16) DEFAULT NULL,
  `date_fin` varchar(16) DEFAULT NULL,
  `type` varchar(24) DEFAULT NULL,
  `resp_unite` varchar(6) DEFAULT NULL,
  `cf` varchar(6) DEFAULT NULL,
  `hierarchie` varchar(64) DEFAULT NULL,
  `id_unite` varchar(6) NOT NULL,
  `id_parent` varchar(6) DEFAULT NULL,
  `sigle_en` varchar(24) DEFAULT NULL,
  `libelle_en` varchar(128) DEFAULT NULL,
  `abrege_en` varchar(64) DEFAULT NULL,
  `ordre` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id_unite`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `url_pers`
--

DROP TABLE IF EXISTS `url_pers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `url_pers` (
  `sciper` varchar(10) NOT NULL DEFAULT '',
  `url` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usedids`
--

DROP TABLE IF EXISTS `usedids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usedids` (
  `sciper` varchar(8) NOT NULL,
  `units` varchar(64) DEFAULT NULL,
  `username` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usedids_new`
--

DROP TABLE IF EXISTS `usedids_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usedids_new` (
  `sciper` varchar(8) NOT NULL,
  `units` varchar(64) DEFAULT NULL,
  `username` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usedids_old`
--

DROP TABLE IF EXISTS `usedids_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usedids_old` (
  `sciper` varchar(8) NOT NULL,
  `units` varchar(64) DEFAULT NULL,
  `username` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `validscipers`
--

DROP TABLE IF EXISTS `validscipers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `validscipers` (
  `sciper` char(6) NOT NULL DEFAULT '',
  `nom` varchar(64) DEFAULT NULL,
  `prenom` varchar(64) DEFAULT NULL,
  `nom_acc` varchar(64) DEFAULT NULL,
  `prenom_acc` varchar(64) DEFAULT NULL,
  `nom_usuel` varchar(64) DEFAULT NULL,
  `prenom_usuel` varchar(64) DEFAULT NULL,
  `nom_usuel_maj` varchar(64) DEFAULT NULL,
  `prenom_usuel_maj` varchar(64) DEFAULT NULL,
  `canon` varchar(32) DEFAULT NULL,
  `visible` char(1) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `validscipers1`
--

DROP TABLE IF EXISTS `validscipers1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `validscipers1` (
  `sciper` char(6) NOT NULL DEFAULT '',
  `nom` varchar(64) DEFAULT NULL,
  `prenom` varchar(64) DEFAULT NULL,
  `nom_acc` varchar(64) DEFAULT NULL,
  `prenom_acc` varchar(64) DEFAULT NULL,
  `nom_usuel` varchar(64) DEFAULT NULL,
  `prenom_usuel` varchar(64) DEFAULT NULL,
  `nom_usuel_maj` varchar(64) DEFAULT NULL,
  `prenom_usuel_maj` varchar(64) DEFAULT NULL,
  `canon` varchar(32) DEFAULT NULL,
  `visible` char(1) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `validscipers_old`
--

DROP TABLE IF EXISTS `validscipers_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `validscipers_old` (
  `sciper` char(6) NOT NULL DEFAULT '',
  `nom` varchar(64) DEFAULT NULL,
  `prenom` varchar(64) DEFAULT NULL,
  `nom_acc` varchar(64) DEFAULT NULL,
  `prenom_acc` varchar(64) DEFAULT NULL,
  `nom_usuel` varchar(64) DEFAULT NULL,
  `prenom_usuel` varchar(64) DEFAULT NULL,
  `nom_usuel_maj` varchar(64) DEFAULT NULL,
  `prenom_usuel_maj` varchar(64) DEFAULT NULL,
  `canon` varchar(32) DEFAULT NULL,
  `visible` char(1) DEFAULT NULL,
  PRIMARY KEY (`sciper`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yubiaccess`
--

DROP TABLE IF EXISTS `yubiaccess`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yubiaccess` (
  `publicid` varchar(8) DEFAULT NULL,
  `uid` char(6) DEFAULT NULL,
  `counter` int(11) DEFAULT NULL,
  `session` int(11) DEFAULT NULL,
  `stamp` int(11) DEFAULT NULL,
  `random` int(11) DEFAULT NULL,
  `crc` int(11) DEFAULT NULL,
  `accesstime` datetime DEFAULT NULL,
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yubikeys`
--

DROP TABLE IF EXISTS `yubikeys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yubikeys` (
  `publicid` varchar(8) DEFAULT NULL,
  `uid` char(6) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-20  9:58:29
