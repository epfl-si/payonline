USE payonline;
CREATE TABLE `instances` (
  `id` varchar(50) NOT NULL DEFAULT '',
  `fonds` varchar(50) NOT NULL DEFAULT '',
  `etat` varchar(20) NOT NULL DEFAULT '',
  `cf` varchar(10) NOT NULL DEFAULT '',
  `descr` tinytext NOT NULL,
  `naturecomptable` varchar(100) NOT NULL DEFAULT '',
  `urlconf` varchar(100) NOT NULL DEFAULT '',
  `datedeb` date NOT NULL DEFAULT '0000-00-00',
  `datefin` date NOT NULL DEFAULT '0000-00-00',
  `sciper` varchar(10) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `monnaie` char(3) DEFAULT NULL,
  `mailinst` varchar(255) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `ois` varchar(50) DEFAULT NULL,
  `codetva` char(2) DEFAULT NULL,
  `bypass_cg` char(1) DEFAULT NULL,
  `bypass_return` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

CREATE TABLE `logs` (
  `ts` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ip` varchar(100) NOT NULL DEFAULT '',
  `sciper` varchar(10) NOT NULL DEFAULT '',
  `descr` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `transact` (
  `id` varchar(50) NOT NULL DEFAULT '0',
  `id_inst` varchar(50) NOT NULL DEFAULT '0',
  `paymode` varchar(100) NOT NULL DEFAULT '',
  `datecr` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `etat` varchar(20) NOT NULL DEFAULT '',
  `PaymentID` varchar(40) NOT NULL DEFAULT '',
  `lang` varchar(10) NOT NULL DEFAULT '',
  `query` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `transact1` (
  `id` varchar(50) NOT NULL DEFAULT '0',
  `id_inst` varchar(50) NOT NULL DEFAULT '0',
  `Total` decimal(16,2) NOT NULL DEFAULT '0.00',
  `Currency` varchar(10) NOT NULL DEFAULT '',
  `paymode` varchar(100) NOT NULL DEFAULT '',
  `datecr` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `etat` varchar(20) NOT NULL DEFAULT '',
  `LastName` varchar(100) NOT NULL DEFAULT '',
  `FirstName` varchar(100) NOT NULL DEFAULT '',
  `Addr` varchar(100) NOT NULL DEFAULT '',
  `ZipCode` varchar(20) NOT NULL DEFAULT '',
  `City` varchar(100) NOT NULL DEFAULT '',
  `Country` char(2) NOT NULL DEFAULT '',
  `Email` varchar(100) NOT NULL DEFAULT '',
  `Phone` varchar(100) NOT NULL DEFAULT '',
  `Fax` varchar(100) NOT NULL DEFAULT '',
  `ypID` varchar(40) NOT NULL DEFAULT '',
  `lang` varchar(10) NOT NULL DEFAULT '',
  `query` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;