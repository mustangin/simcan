-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 22, 2018 at 02:45 AM
-- Server version: 5.7.20-log
-- PHP Version: 5.6.31

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbsimcan_master`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `setAutoIncrement`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `setAutoIncrement` ()  BEGIN
DECLARE done int default false;
    DECLARE table_name CHAR(255);
DECLARE cur1 cursor for SELECT t.table_name FROM INFORMATION_SCHEMA.TABLES t 
        WHERE t.table_schema = "dbsimcan_master";

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    open cur1;

    myloop: loop
        fetch cur1 into table_name;
        if done then
            leave myloop;
        end if;
        set @sql = CONCAT('ALTER TABLE ',table_name, ' AUTO_INCREMENT = 1');
        prepare stmt from @sql;
        execute stmt;
        drop prepare stmt;
    end loop;

    close cur1;
END$$

--
-- Functions
--
DROP FUNCTION IF EXISTS `GantiEnter`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `GantiEnter` (`uraian` VARCHAR(1000)) RETURNS VARCHAR(1000) CHARSET latin1 BEGIN 
  DECLARE xUraian VARCHAR(1000); 
  SET xUraian = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(uraian, CHAR(9), ''), CHAR(10), ''),CHAR(11),''),CHAR(12),''),CHAR(13),'')); 
	WHILE INSTR(xUraian,'  ')>0 DO
		SET xUraian = REPLACE(xUraian,'  ',' ');
	END WHILE;
  RETURN (xUraian); 
END$$

DROP FUNCTION IF EXISTS `HTML_UnEncode`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `HTML_UnEncode` (`X` VARCHAR(1000)) RETURNS VARCHAR(1000) CHARSET latin1 BEGIN 

    DECLARE TextString VARCHAR(1000) ; 
    SET TextString = X ; 

    #quotation mark 
    IF INSTR( X , '&quot;' ) 
    THEN SET TextString = REPLACE(TextString, '&quot;','"') ; 
    END IF ; 

    #apostrophe  
    IF INSTR( X , '&apos;' ) 
    THEN SET TextString = REPLACE(TextString, '&apos;','"') ; 
    END IF ; 

    #ampersand 
    IF INSTR( X , '&amp;' ) 
    THEN SET TextString = REPLACE(TextString, '&amp;','&') ; 
    END IF ; 

    #less-than 
    IF INSTR( X , '&lt;' ) 
    THEN SET TextString = REPLACE(TextString, '&lt;','<') ; 
    END IF ; 

    #greater-than 
    IF INSTR( X , '&gt;' ) 
    THEN SET TextString = REPLACE(TextString, '&gt;','>') ; 
    END IF ; 

    #non-breaking space 
    IF INSTR( X , '&nbsp;' ) 
    THEN SET TextString = REPLACE(TextString, '&nbsp;',' ') ; 
    END IF ; 

    #inverted exclamation mark 
    IF INSTR( X , '&iexcl;' ) 
    THEN SET TextString = REPLACE(TextString, '&iexcl;','¡') ; 
    END IF ; 

    #cent 
    IF INSTR( X , '&cent;' ) 
    THEN SET TextString = REPLACE(TextString, '&cent;','¢') ; 
    END IF ; 

    #pound 
    IF INSTR( X , '&pound;' ) 
    THEN SET TextString = REPLACE(TextString, '&pound;','£') ; 
    END IF ; 

    #currency 
    IF INSTR( X , '&curren;' ) 
    THEN SET TextString = REPLACE(TextString, '&curren;','¤') ; 
    END IF ; 

    #yen 
    IF INSTR( X , '&yen;' ) 
    THEN SET TextString = REPLACE(TextString, '&yen;','¥') ; 
    END IF ; 

    #broken vertical bar 
    IF INSTR( X , '&brvbar;' ) 
    THEN SET TextString = REPLACE(TextString, '&brvbar;','¦') ; 
    END IF ; 

    #section 
    IF INSTR( X , '&sect;' ) 
    THEN SET TextString = REPLACE(TextString, '&sect;','§') ; 
    END IF ; 

    #spacing diaeresis 
    IF INSTR( X , '&uml;' ) 
    THEN SET TextString = REPLACE(TextString, '&uml;','¨') ; 
    END IF ; 

    #copyright 
    IF INSTR( X , '&copy;' ) 
    THEN SET TextString = REPLACE(TextString, '&copy;','©') ; 
    END IF ; 

    #feminine ordinal indicator 
    IF INSTR( X , '&ordf;' ) 
    THEN SET TextString = REPLACE(TextString, '&ordf;','ª') ; 
    END IF ; 

    #angle quotation mark (left) 
    IF INSTR( X , '&laquo;' ) 
    THEN SET TextString = REPLACE(TextString, '&laquo;','«') ; 
    END IF ; 

    #negation 
    IF INSTR( X , '&not;' ) 
    THEN SET TextString = REPLACE(TextString, '&not;','¬') ; 
    END IF ; 

    #soft hyphen 
    IF INSTR( X , '&shy;' ) 
    THEN SET TextString = REPLACE(TextString, '&shy;','­') ; 
    END IF ; 

    #registered trademark 
    IF INSTR( X , '&reg;' ) 
    THEN SET TextString = REPLACE(TextString, '&reg;','®') ; 
    END IF ; 

    #spacing macron 
    IF INSTR( X , '&macr;' ) 
    THEN SET TextString = REPLACE(TextString, '&macr;','¯') ; 
    END IF ; 

    #degree 
    IF INSTR( X , '&deg;' ) 
    THEN SET TextString = REPLACE(TextString, '&deg;','°') ; 
    END IF ; 

    #plus-or-minus  
    IF INSTR( X , '&plusmn;' ) 
    THEN SET TextString = REPLACE(TextString, '&plusmn;','±') ; 
    END IF ; 

    #superscript 2 
    IF INSTR( X , '&sup2;' ) 
    THEN SET TextString = REPLACE(TextString, '&sup2;','²') ; 
    END IF ; 

    #superscript 3 
    IF INSTR( X , '&sup3;' ) 
    THEN SET TextString = REPLACE(TextString, '&sup3;','³') ; 
    END IF ; 

    #spacing acute 
    IF INSTR( X , '&acute;' ) 
    THEN SET TextString = REPLACE(TextString, '&acute;','´') ; 
    END IF ; 

    #micro 
    IF INSTR( X , '&micro;' ) 
    THEN SET TextString = REPLACE(TextString, '&micro;','µ') ; 
    END IF ; 

    #paragraph 
    IF INSTR( X , '&para;' ) 
    THEN SET TextString = REPLACE(TextString, '&para;','¶') ; 
    END IF ; 

    #middle dot 
    IF INSTR( X , '&middot;' ) 
    THEN SET TextString = REPLACE(TextString, '&middot;','·') ; 
    END IF ; 

    #spacing cedilla 
    IF INSTR( X , '&cedil;' ) 
    THEN SET TextString = REPLACE(TextString, '&cedil;','¸') ; 
    END IF ; 

    #superscript 1 
    IF INSTR( X , '&sup1;' ) 
    THEN SET TextString = REPLACE(TextString, '&sup1;','¹') ; 
    END IF ; 

    #masculine ordinal indicator 
    IF INSTR( X , '&ordm;' ) 
    THEN SET TextString = REPLACE(TextString, '&ordm;','º') ; 
    END IF ; 

    #angle quotation mark (right) 
    IF INSTR( X , '&raquo;' ) 
    THEN SET TextString = REPLACE(TextString, '&raquo;','»') ; 
    END IF ; 

    #fraction 1/4 
    IF INSTR( X , '&frac14;' ) 
    THEN SET TextString = REPLACE(TextString, '&frac14;','¼') ; 
    END IF ; 

    #fraction 1/2 
    IF INSTR( X , '&frac12;' ) 
    THEN SET TextString = REPLACE(TextString, '&frac12;','½') ; 
    END IF ; 

    #fraction 3/4 
    IF INSTR( X , '&frac34;' ) 
    THEN SET TextString = REPLACE(TextString, '&frac34;','¾') ; 
    END IF ; 

    #inverted question mark 
    IF INSTR( X , '&iquest;' ) 
    THEN SET TextString = REPLACE(TextString, '&iquest;','¿') ; 
    END IF ; 

    #multiplication 
    IF INSTR( X , '&times;' ) 
    THEN SET TextString = REPLACE(TextString, '&times;','×') ; 
    END IF ; 

    #division 
    IF INSTR( X , '&divide;' ) 
    THEN SET TextString = REPLACE(TextString, '&divide;','÷') ; 
    END IF ; 

    #capital a, grave accent 
    IF INSTR( X , '&Agrave;' ) 
    THEN SET TextString = REPLACE(TextString, '&Agrave;','À') ; 
    END IF ; 

    #capital a, acute accent 
    IF INSTR( X , '&Aacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&Aacute;','Á') ; 
    END IF ; 

    #capital a, circumflex accent 
    IF INSTR( X , '&Acirc;' ) 
    THEN SET TextString = REPLACE(TextString, '&Acirc;','Â') ; 
    END IF ; 

    #capital a, tilde 
    IF INSTR( X , '&Atilde;' ) 
    THEN SET TextString = REPLACE(TextString, '&Atilde;','Ã') ; 
    END IF ; 

    #capital a, umlaut mark 
    IF INSTR( X , '&Auml;' ) 
    THEN SET TextString = REPLACE(TextString, '&Auml;','Ä') ; 
    END IF ; 

    #capital a, ring 
    IF INSTR( X , '&Aring;' ) 
    THEN SET TextString = REPLACE(TextString, '&Aring;','Å') ; 
    END IF ; 

    #capital ae 
    IF INSTR( X , '&AElig;' ) 
    THEN SET TextString = REPLACE(TextString, '&AElig;','Æ') ; 
    END IF ; 

    #capital c, cedilla 
    IF INSTR( X , '&Ccedil;' ) 
    THEN SET TextString = REPLACE(TextString, '&Ccedil;','Ç') ; 
    END IF ; 

    #capital e, grave accent 
    IF INSTR( X , '&Egrave;' ) 
    THEN SET TextString = REPLACE(TextString, '&Egrave;','È') ; 
    END IF ; 

    #capital e, acute accent 
    IF INSTR( X , '&Eacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&Eacute;','É') ; 
    END IF ; 

    #capital e, circumflex accent 
    IF INSTR( X , '&Ecirc;' ) 
    THEN SET TextString = REPLACE(TextString, '&Ecirc;','Ê') ; 
    END IF ; 

    #capital e, umlaut mark 
    IF INSTR( X , '&Euml;' ) 
    THEN SET TextString = REPLACE(TextString, '&Euml;','Ë') ; 
    END IF ; 

    #capital i, grave accent 
    IF INSTR( X , '&Igrave;' ) 
    THEN SET TextString = REPLACE(TextString, '&Igrave;','Ì') ; 
    END IF ; 

    #capital i, acute accent 
    IF INSTR( X , '&Iacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&Iacute;','Í') ; 
    END IF ; 

    #capital i, circumflex accent 
    IF INSTR( X , '&Icirc;' ) 
    THEN SET TextString = REPLACE(TextString, '&Icirc;','Î') ; 
    END IF ; 

    #capital i, umlaut mark 
    IF INSTR( X , '&Iuml;' ) 
    THEN SET TextString = REPLACE(TextString, '&Iuml;','Ï') ; 
    END IF ; 

    #capital eth, Icelandic 
    IF INSTR( X , '&ETH;' ) 
    THEN SET TextString = REPLACE(TextString, '&ETH;','Ð') ; 
    END IF ; 

    #capital n, tilde 
    IF INSTR( X , '&Ntilde;' ) 
    THEN SET TextString = REPLACE(TextString, '&Ntilde;','Ñ') ; 
    END IF ; 

    #capital o, grave accent 
    IF INSTR( X , '&Ograve;' ) 
    THEN SET TextString = REPLACE(TextString, '&Ograve;','Ò') ; 
    END IF ; 

    #capital o, acute accent 
    IF INSTR( X , '&Oacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&Oacute;','Ó') ; 
    END IF ; 

    #capital o, circumflex accent 
    IF INSTR( X , '&Ocirc;' ) 
    THEN SET TextString = REPLACE(TextString, '&Ocirc;','Ô') ; 
    END IF ; 

    #capital o, tilde 
    IF INSTR( X , '&Otilde;' ) 
    THEN SET TextString = REPLACE(TextString, '&Otilde;','Õ') ; 
    END IF ; 

    #capital o, umlaut mark 
    IF INSTR( X , '&Ouml;' ) 
    THEN SET TextString = REPLACE(TextString, '&Ouml;','Ö') ; 
    END IF ; 

    #capital o, slash 
    IF INSTR( X , '&Oslash;' ) 
    THEN SET TextString = REPLACE(TextString, '&Oslash;','Ø') ; 
    END IF ; 

    #capital u, grave accent 
    IF INSTR( X , '&Ugrave;' ) 
    THEN SET TextString = REPLACE(TextString, '&Ugrave;','Ù') ; 
    END IF ; 

    #capital u, acute accent 
    IF INSTR( X , '&Uacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&Uacute;','Ú') ; 
    END IF ; 

    #capital u, circumflex accent 
    IF INSTR( X , '&Ucirc;' ) 
    THEN SET TextString = REPLACE(TextString, '&Ucirc;','Û') ; 
    END IF ; 

    #capital u, umlaut mark 
    IF INSTR( X , '&Uuml;' ) 
    THEN SET TextString = REPLACE(TextString, '&Uuml;','Ü') ; 
    END IF ; 

    #capital y, acute accent 
    IF INSTR( X , '&Yacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&Yacute;','Ý') ; 
    END IF ; 

    #capital THORN, Icelandic 
    IF INSTR( X , '&THORN;' ) 
    THEN SET TextString = REPLACE(TextString, '&THORN;','Þ') ; 
    END IF ; 

    #small sharp s, German 
    IF INSTR( X , '&szlig;' ) 
    THEN SET TextString = REPLACE(TextString, '&szlig;','ß') ; 
    END IF ; 

    #small a, grave accent 
    IF INSTR( X , '&agrave;' ) 
    THEN SET TextString = REPLACE(TextString, '&agrave;','à') ; 
    END IF ; 

    #small a, acute accent 
    IF INSTR( X , '&aacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&aacute;','á') ; 
    END IF ; 

    #small a, circumflex accent 
    IF INSTR( X , '&acirc;' ) 
    THEN SET TextString = REPLACE(TextString, '&acirc;','â') ; 
    END IF ; 

    #small a, tilde 
    IF INSTR( X , '&atilde;' ) 
    THEN SET TextString = REPLACE(TextString, '&atilde;','ã') ; 
    END IF ; 

    #small a, umlaut mark 
    IF INSTR( X , '&auml;' ) 
    THEN SET TextString = REPLACE(TextString, '&auml;','ä') ; 
    END IF ; 

    #small a, ring 
    IF INSTR( X , '&aring;' ) 
    THEN SET TextString = REPLACE(TextString, '&aring;','å') ; 
    END IF ; 

    #small ae 
    IF INSTR( X , '&aelig;' ) 
    THEN SET TextString = REPLACE(TextString, '&aelig;','æ') ; 
    END IF ; 

    #small c, cedilla 
    IF INSTR( X , '&ccedil;' ) 
    THEN SET TextString = REPLACE(TextString, '&ccedil;','ç') ; 
    END IF ; 

    #small e, grave accent 
    IF INSTR( X , '&egrave;' ) 
    THEN SET TextString = REPLACE(TextString, '&egrave;','è') ; 
    END IF ; 

    #small e, acute accent 
    IF INSTR( X , '&eacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&eacute;','é') ; 
    END IF ; 

    #small e, circumflex accent 
    IF INSTR( X , '&ecirc;' ) 
    THEN SET TextString = REPLACE(TextString, '&ecirc;','ê') ; 
    END IF ; 

    #small e, umlaut mark 
    IF INSTR( X , '&euml;' ) 
    THEN SET TextString = REPLACE(TextString, '&euml;','ë') ; 
    END IF ; 

    #small i, grave accent 
    IF INSTR( X , '&igrave;' ) 
    THEN SET TextString = REPLACE(TextString, '&igrave;','ì') ; 
    END IF ; 

    #small i, acute accent 
    IF INSTR( X , '&iacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&iacute;','í') ; 
    END IF ; 

    #small i, circumflex accent 
    IF INSTR( X , '&icirc;' ) 
    THEN SET TextString = REPLACE(TextString, '&icirc;','î') ; 
    END IF ; 

    #small i, umlaut mark 
    IF INSTR( X , '&iuml;' ) 
    THEN SET TextString = REPLACE(TextString, '&iuml;','ï') ; 
    END IF ; 

    #small eth, Icelandic 
    IF INSTR( X , '&eth;' ) 
    THEN SET TextString = REPLACE(TextString, '&eth;','ð') ; 
    END IF ; 

    #small n, tilde 
    IF INSTR( X , '&ntilde;' ) 
    THEN SET TextString = REPLACE(TextString, '&ntilde;','ñ') ; 
    END IF ; 

    #small o, grave accent 
    IF INSTR( X , '&ograve;' ) 
    THEN SET TextString = REPLACE(TextString, '&ograve;','ò') ; 
    END IF ; 

    #small o, acute accent 
    IF INSTR( X , '&oacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&oacute;','ó') ; 
    END IF ; 

    #small o, circumflex accent 
    IF INSTR( X , '&ocirc;' ) 
    THEN SET TextString = REPLACE(TextString, '&ocirc;','ô') ; 
    END IF ; 

    #small o, tilde 
    IF INSTR( X , '&otilde;' ) 
    THEN SET TextString = REPLACE(TextString, '&otilde;','õ') ; 
    END IF ; 

    #small o, umlaut mark 
    IF INSTR( X , '&ouml;' ) 
    THEN SET TextString = REPLACE(TextString, '&ouml;','ö') ; 
    END IF ; 

    #small o, slash 
    IF INSTR( X , '&oslash;' ) 
    THEN SET TextString = REPLACE(TextString, '&oslash;','ø') ; 
    END IF ; 

    #small u, grave accent 
    IF INSTR( X , '&ugrave;' ) 
    THEN SET TextString = REPLACE(TextString, '&ugrave;','ù') ; 
    END IF ; 

    #small u, acute accent 
    IF INSTR( X , '&uacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&uacute;','ú') ; 
    END IF ; 

    #small u, circumflex accent 
    IF INSTR( X , '&ucirc;' ) 
    THEN SET TextString = REPLACE(TextString, '&ucirc;','û') ; 
    END IF ; 

    #small u, umlaut mark 
    IF INSTR( X , '&uuml;' ) 
    THEN SET TextString = REPLACE(TextString, '&uuml;','ü') ; 
    END IF ; 

    #small y, acute accent 
    IF INSTR( X , '&yacute;' ) 
    THEN SET TextString = REPLACE(TextString, '&yacute;','ý') ; 
    END IF ; 

    #small thorn, Icelandic 
    IF INSTR( X , '&thorn;' ) 
    THEN SET TextString = REPLACE(TextString, '&thorn;','þ') ; 
    END IF ; 

    #small y, umlaut mark 
    IF INSTR( X , '&yuml;' ) 
    THEN SET TextString = REPLACE(TextString, '&yuml;','ÿ') ; 
    END IF ; 

    RETURN TextString ; 

    END$$

DROP FUNCTION IF EXISTS `PaguASB`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `PaguASB` (`jns_biaya` INT, `hub_driver` INT, `vol1` DECIMAL(15,4), `vol2` DECIMAL(15,4), `r1` DECIMAL(15,4), `r2` DECIMAL(15,4), `m1` DECIMAL(15,4), `m2` DECIMAL(15,4), `k1` DECIMAL(15,4), `k2` DECIMAL(15,4), `k3` DECIMAL(15,4), `harga` DECIMAL(15,4)) RETURNS DECIMAL(15,4) BEGIN
		DECLARE hargax DECIMAL(15,4);
		DECLARE kmax DECIMAL(15,4);
		DECLARE rx1 DECIMAL(15,4);
		DECLARE rx2 DECIMAL(15,4);
		DECLARE koef DECIMAL(15,4);
		
		SET koef = (k1*k2*k3);
		
		IF m1 = 1 THEN
			IF m2 = 1 THEN
				SET kmax = 1;
			ELSE
				IF m1 <= m2 THEN
							SET kmax = CEILING(vol1/m1);
						ELSE
							SET kmax = CEILING(vol2/m2);
						END IF;
			END IF;
		ELSE
			IF m1 <= m2 THEN
				SET kmax = CEILING(vol2/m2);
			ELSE
				SET kmax = CEILING(vol1/m1);
			END IF;
		END IF;

    IF r1 <= 1 THEN 
			SET rx1= CEILING(vol1/vol1); 
		ELSE 
			SET rx1= CEILING(vol1/r1); 
		END IF;
		
		IF r2 <= 1 THEN 
			SET rx2= CEILING(vol2/vol2); 
		ELSE 
			SET rx2= CEILING(vol2/r2); 
		END IF;

		IF jns_biaya =1 THEN 
			SET hargax = (koef*kmax*harga);
		ELSE 			
			IF hub_driver=1 THEN 
				SET hargax = (vol1*koef*harga); 
			END IF;
			
			IF hub_driver=2 THEN 
				SET hargax = (vol2*koef*harga); 
			END IF;
			
			IF hub_driver=3 THEN 
				SET hargax = (vol1*vol2*koef*harga); 
			END IF;
			
			IF hub_driver=4 THEN 
				SET hargax = (koef*rx1*harga); 
			END IF;
			
			IF hub_driver=5 THEN 
				SET hargax = (koef*rx2*harga); 
			END IF;
			
			IF hub_driver=6 THEN 
				SET hargax = (koef*rx1*rx2*harga); 
			END IF;
			
			IF hub_driver=7 THEN 
				SET hargax = (vol2*koef*rx1*harga); 
			END IF;
			
			IF hub_driver=8 THEN 
				SET hargax = (vol1*koef*rx2*harga); 
			END IF;
			
		END IF;
 
 RETURN (hargax);
END$$

DROP FUNCTION IF EXISTS `PaguASBDistribusi`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `PaguASBDistribusi` (`jns_biaya` INT, `hub_driver` INT, `vol1` DECIMAL(15,4), `vol2` DECIMAL(15,4), `r1` DECIMAL(15,4), `r2` DECIMAL(15,4), `m1` DECIMAL(15,4), `m2` DECIMAL(15,4), `k1` DECIMAL(15,4), `k2` DECIMAL(15,4), `k3` DECIMAL(15,4), `harga` DECIMAL(15,4), `persen` DECIMAL(15,4)) RETURNS DECIMAL(15,4) BEGIN
		DECLARE hargax DECIMAL(15,4);
		DECLARE kmax DECIMAL(15,4);
		DECLARE rx1 DECIMAL(15,4);
		DECLARE rx2 DECIMAL(15,4);
		DECLARE koef DECIMAL(15,4);
		DECLARE koef_dis DECIMAL(15,4);
		
		SET koef = (k1*k2*k3);
		
		IF persen <= 0 OR persen > 100 THEN 
			SET koef_dis = 1;
		ELSE
			SET koef_dis = persen/100;
		END IF;
		
		IF m1 = 1 THEN
			IF m2 = 1 THEN
				SET kmax = 1;
			ELSE
				IF m1 <= m2 THEN
							SET kmax = CEILING(vol1/m1);
						ELSE
							SET kmax = CEILING(vol2/m2);
						END IF;
			END IF;
		ELSE
			IF m1 <= m2 THEN
				SET kmax = CEILING(vol1/m1);
			ELSE
				SET kmax = CEILING(vol2/m2);
			END IF;
		END IF;

    IF r1 <= 1 THEN 
			SET rx1= CEILING(vol1/vol1); 
		ELSE 
			SET rx1= CEILING(vol1/r1); 
		END IF;
		
		IF r2 <= 1 THEN 
			SET rx2= CEILING(vol2/vol2); 
		ELSE 
			SET rx2= CEILING(vol2/r2); 
		END IF;

		IF jns_biaya =1 THEN 
			SET hargax = (koef*kmax*harga*koef_dis); 
		END IF;
		
		IF jns_biaya =2 AND hub_driver=1 THEN 
			SET hargax = (vol1*koef*rx1*harga); 
		END IF;
		
		IF jns_biaya =2 AND hub_driver=2 THEN 
			SET hargax = (vol2*koef*rx2*harga); 
		END IF;
		
		IF jns_biaya =3 AND hub_driver=1 THEN 
			SET hargax = (vol1*koef*harga); 
		END IF;
		
		IF jns_biaya =3 AND hub_driver=2 THEN 
			SET hargax = (vol2*koef*harga); 
		END IF;
		
		IF jns_biaya =3 AND hub_driver=3 THEN 
			SET hargax = (vol1*vol2*koef*harga); 
		END IF;
 
 RETURN (hargax);
END$$

DROP FUNCTION IF EXISTS `XML_Encode`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `XML_Encode` (`X` VARCHAR(1000)) RETURNS VARCHAR(1000) CHARSET latin1 BEGIN 

    DECLARE TextString VARCHAR(1000) ; 
    SET TextString = X ; 

    #quotation mark 
    IF INSTR( X , '"' ) 
    THEN SET TextString = REPLACE(TextString,'"' , '&quot;') ; 
    END IF ; 

    #apostrophe  
    IF INSTR( X , "'" ) 
    THEN SET TextString = REPLACE(TextString,"'" , '&apos;') ; 
    END IF ; 

    #ampersand 
    IF INSTR( X , '&' ) 
    THEN SET TextString = REPLACE(TextString, '&', '&amp;') ; 
    END IF ; 

    #less-than 
    IF INSTR( X , '<' ) 
    THEN SET TextString = REPLACE(TextString, '<', '&lt;') ; 
    END IF ; 

    #greater-than 
    IF INSTR( X , '>' ) 
    THEN SET TextString = REPLACE(TextString, '>', '&gt;') ; 
    END IF ; 
		
		#remove-horizontal-tab
    IF INSTR( X , CHAR(9)) 
    THEN SET TextString = REPLACE(TextString, CHAR(9), '') ;
    END IF ; 
		
		#remove-new-line
    IF INSTR( X , CHAR(10) ) 
    THEN SET TextString = REPLACE(TextString,CHAR(10) , '') ; 
    END IF ; 
		
		#remove-vertical-tab
		IF INSTR( X , CHAR(11)) 
    THEN SET TextString = REPLACE(TextString, CHAR(11), '') ; 
    END IF ; 
		
		#remove-new-page
    IF INSTR( X , CHAR(12)) 
    THEN SET TextString = REPLACE(TextString, CHAR(12), '') ;
    END IF ;  
		
		#remove-carriage-return
		IF INSTR( X , CHAR(13) ) 
    THEN SET TextString = REPLACE(TextString,CHAR(13) , '') ; 
    END IF ;
		
		RETURN TextString ; 

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_cascading_indikator_kegiatan_pd`
--

DROP TABLE IF EXISTS `kin_trx_cascading_indikator_kegiatan_pd`;
CREATE TABLE `kin_trx_cascading_indikator_kegiatan_pd` (
  `id_indikator_kegiatan_pd` int(11) NOT NULL,
  `id_hasil_kegiatan` int(11) NOT NULL DEFAULT '0',
  `id_renstra_kegiatan_indikator` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_cascading_indikator_program_pd`
--

DROP TABLE IF EXISTS `kin_trx_cascading_indikator_program_pd`;
CREATE TABLE `kin_trx_cascading_indikator_program_pd` (
  `id_indikator_program_pd` int(11) NOT NULL,
  `id_hasil_program` int(11) NOT NULL DEFAULT '0',
  `id_renstra_program_indikator` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_cascading_kegiatan_opd`
--

DROP TABLE IF EXISTS `kin_trx_cascading_kegiatan_opd`;
CREATE TABLE `kin_trx_cascading_kegiatan_opd` (
  `id_hasil_kegiatan` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL DEFAULT '0',
  `id_hasil_program` int(11) NOT NULL DEFAULT '0',
  `id_renstra_kegiatan` int(11) NOT NULL DEFAULT '0',
  `uraian_hasil_kegiatan` varchar(500) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_cascading_program_opd`
--

DROP TABLE IF EXISTS `kin_trx_cascading_program_opd`;
CREATE TABLE `kin_trx_cascading_program_opd` (
  `id_hasil_program` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL DEFAULT '0',
  `id_renstra_sasaran` int(11) NOT NULL DEFAULT '0',
  `id_renstra_program` int(11) NOT NULL DEFAULT '0',
  `uraian_hasil_program` varchar(500) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_iku_opd_dok`
--

DROP TABLE IF EXISTS `kin_trx_iku_opd_dok`;
CREATE TABLE `kin_trx_iku_opd_dok` (
  `id_dokumen` int(11) NOT NULL,
  `no_dokumen` varchar(255) DEFAULT NULL,
  `tgl_dokumen` date NOT NULL,
  `uraian_dokumen` varchar(255) DEFAULT NULL,
  `id_renstra` int(11) NOT NULL DEFAULT '1',
  `id_unit` int(11) NOT NULL DEFAULT '0',
  `id_perubahan` int(11) DEFAULT NULL,
  `status_dokumen` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_iku_opd_kegiatan`
--

DROP TABLE IF EXISTS `kin_trx_iku_opd_kegiatan`;
CREATE TABLE `kin_trx_iku_opd_kegiatan` (
  `id_iku_opd_kegiatan` int(11) NOT NULL,
  `id_iku_opd_program` int(11) NOT NULL,
  `id_indikator_kegiatan_renstra` int(11) NOT NULL,
  `id_kegiatan_renstra` int(11) NOT NULL,
  `id_indikator` int(11) NOT NULL,
  `flag_iku` int(11) NOT NULL DEFAULT '0',
  `id_esl4` int(11) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_iku_opd_program`
--

DROP TABLE IF EXISTS `kin_trx_iku_opd_program`;
CREATE TABLE `kin_trx_iku_opd_program` (
  `id_iku_opd_program` int(11) NOT NULL,
  `id_iku_opd_sasaran` int(11) NOT NULL,
  `id_indikator_program_renstra` int(11) NOT NULL,
  `id_program_renstra` int(11) NOT NULL,
  `id_indikator` int(11) NOT NULL,
  `flag_iku` int(11) NOT NULL DEFAULT '0',
  `id_esl3` int(11) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_iku_opd_sasaran`
--

DROP TABLE IF EXISTS `kin_trx_iku_opd_sasaran`;
CREATE TABLE `kin_trx_iku_opd_sasaran` (
  `id_iku_opd_sasaran` int(11) NOT NULL,
  `id_dokumen` int(11) NOT NULL,
  `id_indikator_sasaran_renstra` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_indikator` int(11) NOT NULL,
  `flag_iku` int(11) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_iku_pemda_dok`
--

DROP TABLE IF EXISTS `kin_trx_iku_pemda_dok`;
CREATE TABLE `kin_trx_iku_pemda_dok` (
  `id_dokumen` int(11) NOT NULL,
  `no_dokumen` varchar(255) DEFAULT NULL,
  `tgl_dokumen` date NOT NULL,
  `uraian_dokumen` varchar(255) DEFAULT NULL,
  `id_rpjmd` int(11) NOT NULL DEFAULT '1',
  `id_perubahan` int(11) DEFAULT NULL,
  `status_dokumen` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_iku_pemda_rinci`
--

DROP TABLE IF EXISTS `kin_trx_iku_pemda_rinci`;
CREATE TABLE `kin_trx_iku_pemda_rinci` (
  `id_iku_pemda` int(11) NOT NULL,
  `id_dokumen` int(11) NOT NULL,
  `id_indikator_sasaran_rpjmd` int(11) NOT NULL,
  `id_indikator` int(11) NOT NULL,
  `flag_iku` int(11) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `unit_penanggung_jawab` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_es3_dok`
--

DROP TABLE IF EXISTS `kin_trx_perkin_es3_dok`;
CREATE TABLE `kin_trx_perkin_es3_dok` (
  `id_dokumen_perkin` int(11) NOT NULL,
  `id_sotk_es3` int(11) NOT NULL,
  `tahun` int(11) DEFAULT NULL,
  `no_dokumen` varchar(100) DEFAULT NULL,
  `tgl_dokumen` date DEFAULT NULL,
  `tanggal_mulai` date NOT NULL DEFAULT '2018-01-01',
  `id_pegawai` int(11) NOT NULL DEFAULT '0',
  `nama_penandatangan` varchar(255) DEFAULT NULL,
  `jabatan_penandatangan` varchar(255) DEFAULT NULL,
  `pangkat_penandatangan` int(11) NOT NULL DEFAULT '0',
  `uraian_pangkat_penandatangan` varchar(255) NOT NULL DEFAULT '0',
  `nip_penandatangan` varchar(30) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_es3_kegiatan`
--

DROP TABLE IF EXISTS `kin_trx_perkin_es3_kegiatan`;
CREATE TABLE `kin_trx_perkin_es3_kegiatan` (
  `id_perkin_kegiatan` int(11) NOT NULL,
  `id_perkin_program` int(11) DEFAULT NULL,
  `id_kegiatan_renstra` int(11) DEFAULT NULL,
  `pagu_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_sotk_es4` int(11) NOT NULL DEFAULT '0',
  `status_data` int(2) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_es3_program`
--

DROP TABLE IF EXISTS `kin_trx_perkin_es3_program`;
CREATE TABLE `kin_trx_perkin_es3_program` (
  `id_perkin_program` int(11) NOT NULL,
  `id_dokumen_perkin` int(11) NOT NULL DEFAULT '0',
  `id_perkin_program_opd` int(11) NOT NULL,
  `id_program_renstra` int(11) NOT NULL,
  `pagu_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(2) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_es3_program_indikator`
--

DROP TABLE IF EXISTS `kin_trx_perkin_es3_program_indikator`;
CREATE TABLE `kin_trx_perkin_es3_program_indikator` (
  `id_perkin_indikator` int(11) NOT NULL,
  `id_perkin_program` int(11) DEFAULT NULL,
  `id_indikator_program_renstra` int(11) DEFAULT NULL,
  `target_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t2` decimal(20,2) NOT NULL,
  `target_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_es4_dok`
--

DROP TABLE IF EXISTS `kin_trx_perkin_es4_dok`;
CREATE TABLE `kin_trx_perkin_es4_dok` (
  `id_dokumen_perkin` int(11) NOT NULL,
  `id_sotk_es4` int(11) NOT NULL,
  `tahun` int(11) DEFAULT NULL,
  `no_dokumen` varchar(100) DEFAULT NULL,
  `tgl_dokumen` date DEFAULT NULL,
  `tanggal_mulai` date NOT NULL DEFAULT '2018-01-01',
  `id_pegawai` int(11) DEFAULT NULL,
  `nama_penandatangan` varchar(255) DEFAULT NULL,
  `jabatan_penandatangan` varchar(255) DEFAULT NULL,
  `pangkat_penandatangan` int(11) NOT NULL DEFAULT '0',
  `uraian_pangkat_penandatangan` varchar(255) NOT NULL DEFAULT '0',
  `nip_penandatangan` varchar(30) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_es4_kegiatan`
--

DROP TABLE IF EXISTS `kin_trx_perkin_es4_kegiatan`;
CREATE TABLE `kin_trx_perkin_es4_kegiatan` (
  `id_perkin_kegiatan` int(11) NOT NULL,
  `id_dokumen_perkin` int(11) NOT NULL DEFAULT '0',
  `id_perkin_kegiatan_es3` int(11) DEFAULT NULL,
  `id_kegiatan_renstra` int(11) DEFAULT NULL,
  `pagu_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t2` decimal(20,2) NOT NULL,
  `pagu_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_es4_kegiatan_indikator`
--

DROP TABLE IF EXISTS `kin_trx_perkin_es4_kegiatan_indikator`;
CREATE TABLE `kin_trx_perkin_es4_kegiatan_indikator` (
  `id_perkin_indikator` int(11) NOT NULL,
  `id_perkin_kegiatan` int(11) DEFAULT NULL,
  `id_indikator_kegiatan_renstra` int(11) DEFAULT NULL,
  `target_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t2` decimal(20,2) NOT NULL,
  `target_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_opd_dok`
--

DROP TABLE IF EXISTS `kin_trx_perkin_opd_dok`;
CREATE TABLE `kin_trx_perkin_opd_dok` (
  `id_dokumen_perkin` int(11) NOT NULL,
  `id_sotk_es2` int(11) NOT NULL,
  `tahun` int(11) DEFAULT NULL,
  `no_dokumen` varchar(100) DEFAULT NULL,
  `tgl_dokumen` date DEFAULT NULL,
  `tanggal_mulai` date NOT NULL DEFAULT '2018-01-01',
  `id_pegawai` int(11) NOT NULL DEFAULT '0',
  `nama_penandatangan` varchar(255) DEFAULT NULL,
  `jabatan_penandatangan` varchar(255) DEFAULT NULL,
  `pangkat_penandatangan` int(11) NOT NULL DEFAULT '0',
  `uraian_pangkat_penandatangan` varchar(255) DEFAULT '0',
  `nip_penandatangan` varchar(30) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_opd_program`
--

DROP TABLE IF EXISTS `kin_trx_perkin_opd_program`;
CREATE TABLE `kin_trx_perkin_opd_program` (
  `id_perkin_program` int(11) NOT NULL,
  `id_perkin_sasaran` int(11) NOT NULL,
  `id_program_renstra` int(11) NOT NULL,
  `id_sotk_es3` int(11) NOT NULL DEFAULT '0',
  `pagu_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(2) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_opd_sasaran`
--

DROP TABLE IF EXISTS `kin_trx_perkin_opd_sasaran`;
CREATE TABLE `kin_trx_perkin_opd_sasaran` (
  `id_perkin_sasaran` int(11) NOT NULL,
  `id_dokumen_perkin` int(11) DEFAULT NULL,
  `id_sasaran_renstra` int(11) DEFAULT NULL,
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_perkin_opd_sasaran_indikator`
--

DROP TABLE IF EXISTS `kin_trx_perkin_opd_sasaran_indikator`;
CREATE TABLE `kin_trx_perkin_opd_sasaran_indikator` (
  `id_perkin_indikator` int(11) NOT NULL,
  `id_perkin_sasaran` int(11) DEFAULT NULL,
  `id_indikator_sasaran_renstra` int(11) DEFAULT NULL,
  `target_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t2` decimal(20,2) NOT NULL,
  `target_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_real_es2_dok`
--

DROP TABLE IF EXISTS `kin_trx_real_es2_dok`;
CREATE TABLE `kin_trx_real_es2_dok` (
  `id_dokumen_real` int(11) NOT NULL,
  `id_dokumen_perkin` int(11) DEFAULT NULL,
  `id_sotk_es2` int(11) NOT NULL,
  `tahun` int(11) DEFAULT NULL,
  `triwulan` int(11) NOT NULL DEFAULT '1',
  `no_dokumen` varchar(100) DEFAULT NULL,
  `tgl_dokumen` date DEFAULT NULL,
  `id_pegawai` int(11) DEFAULT NULL,
  `nama_penandatangan` varchar(255) DEFAULT NULL,
  `jabatan_penandatangan` varchar(255) DEFAULT NULL,
  `pangkat_penandatangan` int(11) NOT NULL DEFAULT '0',
  `uraian_pangkat_penandatangan` varchar(255) NOT NULL DEFAULT '0',
  `nip_penandatangan` varchar(30) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_real_es2_program`
--

DROP TABLE IF EXISTS `kin_trx_real_es2_program`;
CREATE TABLE `kin_trx_real_es2_program` (
  `id_real_program` int(11) NOT NULL,
  `id_real_sasaran` int(11) NOT NULL DEFAULT '0',
  `id_real_program_es3` int(11) DEFAULT NULL,
  `id_perkin_program` int(11) DEFAULT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `pagu_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t2` decimal(20,2) NOT NULL,
  `pagu_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t2` decimal(20,2) NOT NULL,
  `real_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_real_es2_sasaran`
--

DROP TABLE IF EXISTS `kin_trx_real_es2_sasaran`;
CREATE TABLE `kin_trx_real_es2_sasaran` (
  `id_real_sasaran` int(11) NOT NULL,
  `id_dokumen_real` int(11) DEFAULT NULL,
  `id_perkin_sasaran` int(11) DEFAULT NULL,
  `id_sasaran_renstra` int(11) DEFAULT NULL,
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_real_es2_sasaran_indikator`
--

DROP TABLE IF EXISTS `kin_trx_real_es2_sasaran_indikator`;
CREATE TABLE `kin_trx_real_es2_sasaran_indikator` (
  `id_real_indikator` int(11) NOT NULL,
  `id_real_sasaran` int(11) DEFAULT NULL,
  `id_perkin_indikator` int(11) DEFAULT NULL,
  `id_indikator_sasaran_renstra` int(11) DEFAULT NULL,
  `target_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t2` decimal(20,2) NOT NULL,
  `target_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t2` decimal(20,2) NOT NULL,
  `real_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `uraian_deviasi` varchar(500) DEFAULT NULL,
  `uraian_renaksi` varchar(500) DEFAULT NULL,
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_real_es3_dok`
--

DROP TABLE IF EXISTS `kin_trx_real_es3_dok`;
CREATE TABLE `kin_trx_real_es3_dok` (
  `id_dokumen_real` int(11) NOT NULL,
  `id_dokumen_perkin` int(11) DEFAULT NULL,
  `id_sotk_es3` int(11) NOT NULL,
  `tahun` int(11) DEFAULT NULL,
  `triwulan` int(11) NOT NULL DEFAULT '1',
  `no_dokumen` varchar(100) DEFAULT NULL,
  `tgl_dokumen` date DEFAULT NULL,
  `id_pegawai` int(11) DEFAULT NULL,
  `nama_penandatangan` varchar(255) DEFAULT NULL,
  `jabatan_penandatangan` varchar(255) DEFAULT NULL,
  `pangkat_penandatangan` int(11) NOT NULL DEFAULT '0',
  `uraian_pangkat_penandatangan` varchar(255) NOT NULL DEFAULT '0',
  `nip_penandatangan` varchar(30) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_real_es3_kegiatan`
--

DROP TABLE IF EXISTS `kin_trx_real_es3_kegiatan`;
CREATE TABLE `kin_trx_real_es3_kegiatan` (
  `id_real_kegiatan` int(11) NOT NULL,
  `id_real_program` int(11) NOT NULL DEFAULT '0',
  `id_perkin_kegiatan` int(11) DEFAULT NULL,
  `id_real_kegiatan_es4` int(11) DEFAULT NULL,
  `id_kegiatan_renstra` int(11) DEFAULT NULL,
  `pagu_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t2` decimal(20,2) NOT NULL,
  `pagu_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t2` decimal(20,2) NOT NULL,
  `real_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_real_kegiatan_4` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_real_es3_program`
--

DROP TABLE IF EXISTS `kin_trx_real_es3_program`;
CREATE TABLE `kin_trx_real_es3_program` (
  `id_real_program` int(11) NOT NULL,
  `id_dokumen_real` int(11) NOT NULL DEFAULT '0',
  `id_perkin_program` int(11) DEFAULT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `pagu_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t2` decimal(20,2) NOT NULL,
  `pagu_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t2` decimal(20,2) NOT NULL,
  `real_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `uraian_deviasi` varchar(500) DEFAULT NULL,
  `uraian_renaksi` varchar(500) DEFAULT NULL,
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_real_es3_program_indikator`
--

DROP TABLE IF EXISTS `kin_trx_real_es3_program_indikator`;
CREATE TABLE `kin_trx_real_es3_program_indikator` (
  `id_real_indikator` int(11) NOT NULL,
  `id_real_program` int(11) NOT NULL,
  `id_perkin_indikator` int(11) DEFAULT NULL,
  `id_indikator_program_renstra` int(11) DEFAULT NULL,
  `target_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t2` decimal(20,2) NOT NULL,
  `target_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t2` decimal(20,2) NOT NULL,
  `real_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `uraian_deviasi` varchar(500) DEFAULT NULL,
  `uraian_renaksi` varchar(500) DEFAULT NULL,
  `reviu_real` decimal(20,2) NOT NULL DEFAULT '0.00',
  `reviu_deviasi` varchar(500) DEFAULT NULL,
  `reviu_renaksi` varchar(500) DEFAULT NULL,
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_real_es4_dok`
--

DROP TABLE IF EXISTS `kin_trx_real_es4_dok`;
CREATE TABLE `kin_trx_real_es4_dok` (
  `id_dokumen_real` int(11) NOT NULL,
  `id_dokumen_perkin` int(11) DEFAULT NULL,
  `id_sotk_es4` int(11) NOT NULL,
  `tahun` int(11) DEFAULT NULL,
  `triwulan` int(11) NOT NULL DEFAULT '1',
  `no_dokumen` varchar(100) DEFAULT NULL,
  `tgl_dokumen` date DEFAULT NULL,
  `id_pegawai` int(11) DEFAULT NULL,
  `nama_penandatangan` varchar(255) DEFAULT NULL,
  `jabatan_penandatangan` varchar(255) DEFAULT NULL,
  `pangkat_penandatangan` int(11) NOT NULL DEFAULT '0',
  `uraian_pangkat_penandatangan` varchar(255) NOT NULL DEFAULT '0',
  `nip_penandatangan` varchar(30) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_real_es4_kegiatan`
--

DROP TABLE IF EXISTS `kin_trx_real_es4_kegiatan`;
CREATE TABLE `kin_trx_real_es4_kegiatan` (
  `id_real_kegiatan` int(11) NOT NULL,
  `id_dokumen_real` int(11) NOT NULL DEFAULT '0',
  `id_perkin_kegiatan` int(11) DEFAULT NULL,
  `id_kegiatan_renstra` int(11) DEFAULT NULL,
  `pagu_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t2` decimal(20,2) NOT NULL,
  `pagu_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t2` decimal(20,2) NOT NULL,
  `real_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(2) DEFAULT NULL,
  `uraian_deviasi` varchar(500) DEFAULT NULL,
  `uraian_renaksi` varchar(500) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `kin_trx_real_es4_kegiatan_indikator`
--

DROP TABLE IF EXISTS `kin_trx_real_es4_kegiatan_indikator`;
CREATE TABLE `kin_trx_real_es4_kegiatan_indikator` (
  `id_real_indikator` int(11) NOT NULL,
  `id_real_kegiatan` int(11) DEFAULT NULL,
  `id_perkin_indikator` int(11) DEFAULT NULL,
  `id_indikator_kegiatan_renstra` int(11) DEFAULT NULL,
  `target_tahun` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t2` decimal(20,2) NOT NULL,
  `target_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t2` decimal(20,2) NOT NULL,
  `real_t3` decimal(20,2) NOT NULL DEFAULT '0.00',
  `real_t4` decimal(20,2) NOT NULL DEFAULT '0.00',
  `uraian_deviasi` varchar(500) DEFAULT NULL,
  `uraian_renaksi` varchar(500) DEFAULT NULL,
  `reviu_real` decimal(20,2) NOT NULL DEFAULT '0.00',
  `reviu_deviasi` varchar(500) DEFAULT NULL,
  `reviu_renaksi` varchar(500) DEFAULT NULL,
  `status_data` int(2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_bidang`
--

DROP TABLE IF EXISTS `ref_bidang`;
CREATE TABLE `ref_bidang` (
  `id_bidang` int(11) NOT NULL,
  `kd_urusan` int(255) NOT NULL,
  `kd_bidang` int(255) NOT NULL,
  `nm_bidang` varchar(255) NOT NULL,
  `kd_fungsi` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_data_sub_unit`
--

DROP TABLE IF EXISTS `ref_data_sub_unit`;
CREATE TABLE `ref_data_sub_unit` (
  `tahun` int(11) NOT NULL,
  `id_rincian_unit` int(11) NOT NULL,
  `id_sub_unit` int(11) NOT NULL,
  `alamat_sub_unit` varchar(200) NOT NULL,
  `kota_sub_unit` varchar(100) NOT NULL,
  `nama_jabatan_pimpinan_skpd` varchar(100) NOT NULL,
  `nama_pimpinan_skpd` varchar(150) NOT NULL,
  `nip_pimpinan_skpd` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_desa`
--

DROP TABLE IF EXISTS `ref_desa`;
CREATE TABLE `ref_desa` (
  `id_kecamatan` int(11) NOT NULL,
  `kd_desa` int(11) NOT NULL COMMENT 'kode desa / kelurahan',
  `id_desa` int(11) NOT NULL,
  `status_desa` int(11) NOT NULL COMMENT '2 = Desa 1 = Kelurahan',
  `nama_desa` varchar(50) NOT NULL,
  `id_zona` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_dokumen`
--

DROP TABLE IF EXISTS `ref_dokumen`;
CREATE TABLE `ref_dokumen` (
  `id_dokumen` int(255) NOT NULL,
  `nm_dokumen` varchar(255) DEFAULT NULL,
  `jenis_proses` int(11) NOT NULL DEFAULT '0' COMMENT '0 = rkpd 1 = renja 2 = rpjmd 3 = renstra'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_fungsi`
--

DROP TABLE IF EXISTS `ref_fungsi`;
CREATE TABLE `ref_fungsi` (
  `kd_fungsi` int(11) NOT NULL,
  `nm_fungsi` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_group`
--

DROP TABLE IF EXISTS `ref_group`;
CREATE TABLE `ref_group` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_roles` int(11) NOT NULL,
  `keterangan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci ROW_FORMAT=DYNAMIC;

--
-- Triggers `ref_group`
--
DROP TRIGGER IF EXISTS `trg_egroup`;
DELIMITER $$
CREATE TRIGGER `trg_egroup` BEFORE UPDATE ON `ref_group` FOR EACH ROW IF old.id = 1 OR old.name ='super_admin' THEN 
    SIGNAL SQLSTATE '45000' 
    SET MESSAGE_TEXT = 'This record is sacred! You are not allowed to update it!!';
END IF
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_group`;
DELIMITER $$
CREATE TRIGGER `trg_group` BEFORE DELETE ON `ref_group` FOR EACH ROW IF old.id = 1 OR old.name ='super_admin' THEN 
    SIGNAL SQLSTATE '45000' 
    SET MESSAGE_TEXT = 'This record is sacred! You are not allowed to remove it!!';
END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ref_indikator`
--

DROP TABLE IF EXISTS `ref_indikator`;
CREATE TABLE `ref_indikator` (
  `id_indikator` int(11) NOT NULL,
  `type_indikator` int(11) NOT NULL DEFAULT '0' COMMENT '0 keluaran 1 hasil 2 dampak 3 masukan',
  `jenis_indikator` int(11) NOT NULL DEFAULT '0' COMMENT '1 positif 0 negatif',
  `sifat_indikator` int(11) NOT NULL DEFAULT '0' COMMENT '1 Incremental 2 Absolut  3 Komulatif',
  `nm_indikator` varchar(255) DEFAULT NULL,
  `flag_iku` int(11) NOT NULL DEFAULT '0' COMMENT '0 non iku 1 iku pemda 2 iku skpd',
  `asal_indikator` int(11) DEFAULT '0' COMMENT '0 rpjmd 1 renstra 2 rkpd 3 renja',
  `metode_penghitungan` blob COMMENT 'file image ',
  `sumber_data_indikator` varchar(255) DEFAULT NULL,
  `id_satuan_output` int(255) DEFAULT NULL,
  `kualitas_indikator` int(255) NOT NULL DEFAULT '0' COMMENT '0 kualitas 1 kuantitas 2 persentase 3 rata-rata 4 rasio'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_jadwal`
--

DROP TABLE IF EXISTS `ref_jadwal`;
CREATE TABLE `ref_jadwal` (
  `tahun` int(11) NOT NULL,
  `id_proses` int(11) NOT NULL,
  `id_langkah` int(11) NOT NULL,
  `jenis_proses` int(11) NOT NULL DEFAULT '0' COMMENT '0 = rkpd 1 = renja 2 = rpjmd 3 = renstra',
  `uraian_proses` varchar(255) DEFAULT NULL,
  `tgl_mulai` date DEFAULT NULL,
  `tgl_akhir` date DEFAULT NULL,
  `status_proses` int(255) DEFAULT '0' COMMENT '0 = belum 1 = proses 2 = selesai 3 = kedaluwarsa 4 = batal',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `ref_jenis_lokasi`
--

DROP TABLE IF EXISTS `ref_jenis_lokasi`;
CREATE TABLE `ref_jenis_lokasi` (
  `id_jenis` int(11) NOT NULL,
  `nm_jenis` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_kabupaten`
--

DROP TABLE IF EXISTS `ref_kabupaten`;
CREATE TABLE `ref_kabupaten` (
  `id_pemda` int(11) NOT NULL,
  `id_prov` int(11) NOT NULL,
  `id_kab` int(11) NOT NULL,
  `kd_kab` int(11) NOT NULL,
  `nama_kab_kota` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `ref_kecamatan`
--

DROP TABLE IF EXISTS `ref_kecamatan`;
CREATE TABLE `ref_kecamatan` (
  `id_pemda` int(11) NOT NULL,
  `kd_kecamatan` int(11) NOT NULL,
  `id_kecamatan` int(11) NOT NULL,
  `nama_kecamatan` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_kegiatan`
--

DROP TABLE IF EXISTS `ref_kegiatan`;
CREATE TABLE `ref_kegiatan` (
  `id_kegiatan` int(11) NOT NULL,
  `id_program` int(11) NOT NULL,
  `kd_kegiatan` int(11) NOT NULL,
  `nm_kegiatan` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_kolom_tabel_dasar`
--

DROP TABLE IF EXISTS `ref_kolom_tabel_dasar`;
CREATE TABLE `ref_kolom_tabel_dasar` (
  `id_kolom_tabel_dasar` int(11) NOT NULL,
  `id_tabel_dasar` int(11) DEFAULT NULL,
  `nama_kolom` varchar(255) DEFAULT NULL,
  `level` int(2) DEFAULT NULL,
  `parent_id` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `ref_langkah`
--

DROP TABLE IF EXISTS `ref_langkah`;
CREATE TABLE `ref_langkah` (
  `id_langkah` int(255) NOT NULL,
  `jenis_dokumen` int(255) NOT NULL,
  `nm_langkah` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_log_akses`
--

DROP TABLE IF EXISTS `ref_log_akses`;
CREATE TABLE `ref_log_akses` (
  `id_log` varchar(255) NOT NULL,
  `fl1` varchar(255) DEFAULT NULL,
  `fd1` varchar(255) DEFAULT NULL,
  `fp2` varchar(255) DEFAULT NULL,
  `fu3` varchar(255) DEFAULT NULL,
  `fr4` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `ref_lokasi`
--

DROP TABLE IF EXISTS `ref_lokasi`;
CREATE TABLE `ref_lokasi` (
  `id_lokasi` int(11) NOT NULL,
  `jenis_lokasi` int(11) NOT NULL COMMENT '0 = Kewilayahan\r\n1 = Ruas Jalan \r\n2 = Saluran Irigasi\r\n3 = Kawasan\r\n99 = Lokasi di Luar Daerah',
  `nama_lokasi` varchar(255) NOT NULL,
  `id_desa` int(11) DEFAULT NULL,
  `id_desa_awal` int(11) DEFAULT NULL,
  `id_desa_akhir` int(11) DEFAULT NULL,
  `koordinat_1` varchar(100) DEFAULT NULL,
  `koordinat_2` varchar(100) DEFAULT NULL,
  `koordinat_3` varchar(100) DEFAULT NULL,
  `koordinat_4` varchar(100) DEFAULT NULL,
  `luasan_kawasan` decimal(20,2) DEFAULT '0.00',
  `satuan_luas` int(50) DEFAULT NULL,
  `panjang` decimal(20,2) DEFAULT '0.00',
  `satuan_panjang` int(50) DEFAULT NULL,
  `lebar` decimal(20,2) DEFAULT '0.00',
  `satuan_lebar` int(11) DEFAULT NULL,
  `keterangan_lokasi` longtext
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_mapping_asb_renstra`
--

DROP TABLE IF EXISTS `ref_mapping_asb_renstra`;
CREATE TABLE `ref_mapping_asb_renstra` (
  `id_aktivitas_asb` bigint(20) NOT NULL,
  `id_kegiatan_renstra` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_menu`
--

DROP TABLE IF EXISTS `ref_menu`;
CREATE TABLE `ref_menu` (
  `id_menu` bigint(255) NOT NULL,
  `group_id` int(11) NOT NULL,
  `menu` int(11) NOT NULL,
  `akses` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '11100' COMMENT '0 denied, 1 granted, CRUD-Posting'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Triggers `ref_menu`
--
DROP TRIGGER IF EXISTS `trg_ref_menu_c`;
DELIMITER $$
CREATE TRIGGER `trg_ref_menu_c` BEFORE INSERT ON `ref_menu` FOR EACH ROW IF new.group_id = 0 THEN 
    SIGNAL SQLSTATE '45000' 
     SET MESSAGE_TEXT = 'You are not allowed to insert it!!';
END IF
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_ref_menu_d`;
DELIMITER $$
CREATE TRIGGER `trg_ref_menu_d` BEFORE DELETE ON `ref_menu` FOR EACH ROW IF old.group_id = 1 THEN 
    SIGNAL SQLSTATE '45000' 
     SET MESSAGE_TEXT = 'This record is sacred! You are not allowed to remove it!!';
END IF
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_ref_menu_u`;
DELIMITER $$
CREATE TRIGGER `trg_ref_menu_u` BEFORE UPDATE ON `ref_menu` FOR EACH ROW IF old.group_id = 0 THEN 
    SIGNAL SQLSTATE '45000' 
     SET MESSAGE_TEXT = 'This record is sacred! You are not allowed to update it!!';
END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ref_pegawai`
--

DROP TABLE IF EXISTS `ref_pegawai`;
CREATE TABLE `ref_pegawai` (
  `id_pegawai` int(11) NOT NULL,
  `nama_pegawai` varchar(255) NOT NULL,
  `nip_pegawai` varchar(18) NOT NULL DEFAULT '199909091999091009',
  `status_pegawai` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ref_pegawai_pangkat`
--

DROP TABLE IF EXISTS `ref_pegawai_pangkat`;
CREATE TABLE `ref_pegawai_pangkat` (
  `id_pangkat` int(11) NOT NULL,
  `id_pegawai` int(255) NOT NULL DEFAULT '0',
  `pangkat_pegawai` int(11) DEFAULT NULL,
  `tmt_pangkat` date DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ref_pegawai_unit`
--

DROP TABLE IF EXISTS `ref_pegawai_unit`;
CREATE TABLE `ref_pegawai_unit` (
  `id_unit_pegawai` int(11) NOT NULL,
  `id_pegawai` int(255) NOT NULL DEFAULT '0',
  `id_unit` int(11) NOT NULL,
  `tingkat_eselon` int(11) NOT NULL,
  `id_sotk` int(11) NOT NULL,
  `nama_jabatan` varchar(500) NOT NULL,
  `tmt_unit` date NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `ref_pembatalan`
--

DROP TABLE IF EXISTS `ref_pembatalan`;
CREATE TABLE `ref_pembatalan` (
  `id_batal` int(255) NOT NULL,
  `uraian_batal` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ref_pemda`
--

DROP TABLE IF EXISTS `ref_pemda`;
CREATE TABLE `ref_pemda` (
  `kd_prov` int(11) NOT NULL,
  `kd_kab` int(11) NOT NULL,
  `id_pemda` int(11) NOT NULL,
  `prefix_pemda` varchar(255) NOT NULL,
  `nm_prov` varchar(50) DEFAULT NULL,
  `nm_kabkota` varchar(50) DEFAULT NULL,
  `ibu_kota` varchar(50) DEFAULT NULL,
  `nama_jabatan_kepala_daerah` varchar(50) DEFAULT NULL COMMENT 'BUPATI/WALIKOTA/GUBERNUR',
  `nama_kepala_daerah` varchar(150) DEFAULT NULL,
  `nama_jabatan_sekretariat_daerah` varchar(100) DEFAULT NULL,
  `nama_sekretariat_daerah` varchar(150) DEFAULT NULL,
  `nip_sekretariat_daerah` varchar(20) DEFAULT NULL,
  `unit_perencanaan` int(11) DEFAULT NULL COMMENT 'id_sub_unit koordinator perencanaan',
  `nama_kepala_bappeda` varchar(150) DEFAULT NULL,
  `nip_kepala_bappeda` varchar(20) DEFAULT NULL,
  `unit_keuangan` int(11) DEFAULT NULL COMMENT 'id_sub_unit pengelola keuangan',
  `nama_kepala_bpkad` varchar(150) DEFAULT NULL,
  `nip_kepala_bpkad` varchar(20) DEFAULT NULL,
  `logo_pemda` mediumblob,
  `alamat` varchar(500) DEFAULT NULL COMMENT 'alamat sekretariat daerah',
  `no_telepon` varchar(255) NOT NULL DEFAULT '000-0000 0000' COMMENT 'nomor telepon',
  `no_faksimili` varchar(255) NOT NULL DEFAULT '000-0000 0000' COMMENT 'nomor faksimili',
  `email` varchar(255) NOT NULL DEFAULT 'email@pemdasimulasi.go.id'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_pengusul`
--

DROP TABLE IF EXISTS `ref_pengusul`;
CREATE TABLE `ref_pengusul` (
  `id_pengusul` int(255) NOT NULL,
  `nm_pengusul` varchar(255) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_prioritas_nasional`
--

DROP TABLE IF EXISTS `ref_prioritas_nasional`;
CREATE TABLE `ref_prioritas_nasional` (
  `tahun` int(11) NOT NULL,
  `id_prioritas` int(11) NOT NULL,
  `nama_prioritas` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_prioritas_provinsi`
--

DROP TABLE IF EXISTS `ref_prioritas_provinsi`;
CREATE TABLE `ref_prioritas_provinsi` (
  `tahun` int(11) NOT NULL,
  `id_prioritas` int(11) NOT NULL,
  `nama_prioritas` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_program`
--

DROP TABLE IF EXISTS `ref_program`;
CREATE TABLE `ref_program` (
  `id_bidang` int(11) NOT NULL,
  `id_program` int(11) NOT NULL,
  `kd_program` int(11) NOT NULL,
  `uraian_program` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_program_nasional`
--

DROP TABLE IF EXISTS `ref_program_nasional`;
CREATE TABLE `ref_program_nasional` (
  `id_prioritas` int(11) NOT NULL,
  `id_program_nasional` int(11) NOT NULL,
  `uraian_program_nasional` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_program_provinsi`
--

DROP TABLE IF EXISTS `ref_program_provinsi`;
CREATE TABLE `ref_program_provinsi` (
  `id_prioritas` int(11) NOT NULL,
  `id_program_provinsi` int(11) NOT NULL,
  `uraian_program_provinsi` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_rek_1`
--

DROP TABLE IF EXISTS `ref_rek_1`;
CREATE TABLE `ref_rek_1` (
  `kd_rek_1` int(11) NOT NULL,
  `nama_kd_rek_1` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_rek_2`
--

DROP TABLE IF EXISTS `ref_rek_2`;
CREATE TABLE `ref_rek_2` (
  `kd_rek_1` int(11) NOT NULL,
  `kd_rek_2` int(11) NOT NULL,
  `nama_kd_rek_2` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_rek_3`
--

DROP TABLE IF EXISTS `ref_rek_3`;
CREATE TABLE `ref_rek_3` (
  `kd_rek_1` int(11) NOT NULL,
  `kd_rek_2` int(11) NOT NULL,
  `kd_rek_3` int(11) NOT NULL,
  `nama_kd_rek_3` varchar(150) DEFAULT NULL,
  `saldo_normal` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_rek_4`
--

DROP TABLE IF EXISTS `ref_rek_4`;
CREATE TABLE `ref_rek_4` (
  `kd_rek_1` int(11) NOT NULL,
  `kd_rek_2` int(11) NOT NULL,
  `kd_rek_3` int(11) NOT NULL,
  `kd_rek_4` int(11) NOT NULL,
  `nama_kd_rek_4` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_rek_5`
--

DROP TABLE IF EXISTS `ref_rek_5`;
CREATE TABLE `ref_rek_5` (
  `kd_rek_1` int(11) NOT NULL,
  `kd_rek_2` int(11) NOT NULL,
  `kd_rek_3` int(11) NOT NULL,
  `kd_rek_4` int(11) NOT NULL,
  `kd_rek_5` int(11) NOT NULL,
  `nama_kd_rek_5` varchar(150) DEFAULT NULL,
  `peraturan` varchar(200) DEFAULT NULL,
  `id_rekening` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_revisi`
--

DROP TABLE IF EXISTS `ref_revisi`;
CREATE TABLE `ref_revisi` (
  `id_revisi` int(255) NOT NULL,
  `uraian_revisi` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_satuan`
--

DROP TABLE IF EXISTS `ref_satuan`;
CREATE TABLE `ref_satuan` (
  `id_satuan` int(11) NOT NULL,
  `uraian_satuan` varchar(50) NOT NULL,
  `singkatan_satuan` varchar(30) NOT NULL,
  `scope_pemakaian` varchar(20) DEFAULT NULL COMMENT ' 0 rpjmd\r\n              1 renstra\r\n             2 rkpd\r\n              3 renja\r\n              4 ssh\r\n              5 Pemicu Biaya ASB\r\n              6 Turunan Pemicu Biaya ASB\r\n              7 Rincian ASB\r\n              8 program\r\n              9 kegiatan'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_setting`
--

DROP TABLE IF EXISTS `ref_setting`;
CREATE TABLE `ref_setting` (
  `tahun_rencana` int(11) NOT NULL COMMENT 'tahun_perencanaan',
  `jenis_rw` int(11) NOT NULL DEFAULT '0' COMMENT 'jenis_pembatasan_rw, 0 tidak dibatasi, 1 jml_usulan, 2 jml_pagu',
  `jml_rw` int(11) NOT NULL DEFAULT '0' COMMENT 'batas usulan rw, 0 tidak dibatasi',
  `pagu_rw` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jenis_desa` int(11) NOT NULL DEFAULT '0' COMMENT 'jenis_pembatasan_rw, 0 tidak dibatasi, 1 jml_usulan, 2 jml_pagu',
  `jml_desa` int(11) NOT NULL DEFAULT '0' COMMENT 'batas usulan rw, 0 tidak dibatasi',
  `pagu_desa` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jenis_kecamatan` int(11) NOT NULL DEFAULT '0' COMMENT 'jenis_pembatasan_rw, 0 tidak dibatasi, 1 jml_usulan, 2 jml_pagu',
  `jml_kecamatan` int(11) NOT NULL DEFAULT '0' COMMENT 'batas usulan rw, 0 tidak dibatasi',
  `pagu_kecamatan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `deviasi_pagu` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_setting` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_sotk_level_1`
--

DROP TABLE IF EXISTS `ref_sotk_level_1`;
CREATE TABLE `ref_sotk_level_1` (
  `id_sotk_es2` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `nama_eselon` varchar(255) DEFAULT NULL COMMENT 'nama_jabatan_eselon',
  `tingkat_eselon` int(11) NOT NULL COMMENT '1/2/3',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ref_sotk_level_2`
--

DROP TABLE IF EXISTS `ref_sotk_level_2`;
CREATE TABLE `ref_sotk_level_2` (
  `id_sotk_es3` int(11) NOT NULL,
  `id_sotk_es2` int(11) NOT NULL,
  `nama_eselon` varchar(255) DEFAULT NULL,
  `tingkat_eselon` int(11) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ref_sotk_level_3`
--

DROP TABLE IF EXISTS `ref_sotk_level_3`;
CREATE TABLE `ref_sotk_level_3` (
  `id_sotk_es4` int(11) NOT NULL,
  `id_sotk_es3` int(11) NOT NULL,
  `nama_eselon` varchar(255) DEFAULT NULL,
  `tingkat_eselon` int(11) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ref_ssh_golongan`
--

DROP TABLE IF EXISTS `ref_ssh_golongan`;
CREATE TABLE `ref_ssh_golongan` (
  `id_golongan_ssh` int(11) NOT NULL,
  `jenis_ssh` int(11) NOT NULL DEFAULT '0' COMMENT '0 = BL 1=BTL 2=Pendapatan 3=Pembiayaan ',
  `no_urut` int(11) NOT NULL,
  `uraian_golongan_ssh` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_ssh_kelompok`
--

DROP TABLE IF EXISTS `ref_ssh_kelompok`;
CREATE TABLE `ref_ssh_kelompok` (
  `id_kelompok_ssh` int(11) NOT NULL,
  `id_golongan_ssh` int(11) NOT NULL,
  `no_urut` int(11) DEFAULT NULL,
  `uraian_kelompok_ssh` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_ssh_perkada`
--

DROP TABLE IF EXISTS `ref_ssh_perkada`;
CREATE TABLE `ref_ssh_perkada` (
  `id_perkada` int(11) NOT NULL,
  `nomor_perkada` varchar(255) NOT NULL,
  `tanggal_perkada` date NOT NULL,
  `tahun_berlaku` int(11) NOT NULL COMMENT 'tahun berlakuknya perkada',
  `id_perkada_induk` int(11) NOT NULL DEFAULT '0',
  `id_perubahan` int(11) NOT NULL DEFAULT '0',
  `uraian_perkada` varchar(500) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif',
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_ssh_perkada_tarif`
--

DROP TABLE IF EXISTS `ref_ssh_perkada_tarif`;
CREATE TABLE `ref_ssh_perkada_tarif` (
  `id_tarif_perkada` bigint(11) NOT NULL,
  `id_tarif_old` bigint(11) NOT NULL DEFAULT '0',
  `no_urut` bigint(11) NOT NULL,
  `id_tarif_ssh` bigint(11) NOT NULL,
  `id_rekening` int(11) DEFAULT NULL,
  `id_zona_perkada` int(11) NOT NULL,
  `jml_rupiah` decimal(20,2) NOT NULL DEFAULT '0.00',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_ssh_perkada_zona`
--

DROP TABLE IF EXISTS `ref_ssh_perkada_zona`;
CREATE TABLE `ref_ssh_perkada_zona` (
  `id_zona_perkada` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_perkada` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL DEFAULT '0',
  `id_zona` int(11) NOT NULL,
  `nama_zona` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_ssh_rekening`
--

DROP TABLE IF EXISTS `ref_ssh_rekening`;
CREATE TABLE `ref_ssh_rekening` (
  `id_rekening_ssh` bigint(11) NOT NULL,
  `id_tarif_ssh` bigint(20) NOT NULL,
  `id_rekening` int(11) NOT NULL,
  `uraian_tarif_ssh` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_ssh_sub_kelompok`
--

DROP TABLE IF EXISTS `ref_ssh_sub_kelompok`;
CREATE TABLE `ref_ssh_sub_kelompok` (
  `id_sub_kelompok_ssh` int(11) NOT NULL,
  `id_kelompok_ssh` int(11) NOT NULL,
  `no_urut` int(11) DEFAULT NULL,
  `uraian_sub_kelompok_ssh` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_ssh_tarif`
--

DROP TABLE IF EXISTS `ref_ssh_tarif`;
CREATE TABLE `ref_ssh_tarif` (
  `id_tarif_ssh` bigint(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_sub_kelompok_ssh` int(11) NOT NULL,
  `uraian_tarif_ssh` varchar(255) NOT NULL,
  `keterangan_tarif_ssh` varchar(500) DEFAULT NULL,
  `id_satuan` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_ssh_zona`
--

DROP TABLE IF EXISTS `ref_ssh_zona`;
CREATE TABLE `ref_ssh_zona` (
  `id_zona` int(11) NOT NULL,
  `keterangan_zona` varchar(255) NOT NULL DEFAULT '',
  `diskripsi_zona` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_ssh_zona_lokasi`
--

DROP TABLE IF EXISTS `ref_ssh_zona_lokasi`;
CREATE TABLE `ref_ssh_zona_lokasi` (
  `id_zona_lokasi` int(11) NOT NULL,
  `id_zona` int(11) NOT NULL,
  `id_lokasi` int(11) NOT NULL,
  `id_desa` int(11) DEFAULT NULL,
  `diskripsi_lokasi` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_status_usul`
--

DROP TABLE IF EXISTS `ref_status_usul`;
CREATE TABLE `ref_status_usul` (
  `id_status_usul` int(11) NOT NULL,
  `uraian_status_usul` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_sub_unit`
--

DROP TABLE IF EXISTS `ref_sub_unit`;
CREATE TABLE `ref_sub_unit` (
  `id_sub_unit` int(255) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `kd_sub` int(255) NOT NULL,
  `nm_sub` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_sumber_dana`
--

DROP TABLE IF EXISTS `ref_sumber_dana`;
CREATE TABLE `ref_sumber_dana` (
  `id_sumber_dana` int(11) NOT NULL,
  `uraian_sumber_dana` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_tabel_dasar`
--

DROP TABLE IF EXISTS `ref_tabel_dasar`;
CREATE TABLE `ref_tabel_dasar` (
  `id_tabel_dasar` int(11) NOT NULL,
  `nama_tabel` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `ref_tahun`
--

DROP TABLE IF EXISTS `ref_tahun`;
CREATE TABLE `ref_tahun` (
  `id_tahun` int(11) NOT NULL,
  `id_pemda` int(11) NOT NULL,
  `id_rpjmd` int(11) NOT NULL,
  `tahun_0` int(255) NOT NULL,
  `tahun_1` int(255) NOT NULL,
  `tahun_2` int(255) NOT NULL,
  `tahun_3` int(255) NOT NULL,
  `tahun_4` int(255) NOT NULL,
  `tahun_5` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_unit`
--

DROP TABLE IF EXISTS `ref_unit`;
CREATE TABLE `ref_unit` (
  `id_unit` int(11) NOT NULL,
  `id_bidang` int(11) NOT NULL,
  `kd_unit` int(255) NOT NULL,
  `nm_unit` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_urusan`
--

DROP TABLE IF EXISTS `ref_urusan`;
CREATE TABLE `ref_urusan` (
  `kd_urusan` int(255) NOT NULL,
  `nm_urusan` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `ref_user_role`
--

DROP TABLE IF EXISTS `ref_user_role`;
CREATE TABLE `ref_user_role` (
  `id` int(11) NOT NULL,
  `uraian_peran` varchar(255) NOT NULL,
  `tambah` int(11) NOT NULL DEFAULT '0',
  `edit` int(11) NOT NULL DEFAULT '0',
  `hapus` int(11) NOT NULL DEFAULT '0',
  `lihat` int(11) NOT NULL DEFAULT '0',
  `reviu` int(11) NOT NULL DEFAULT '0',
  `posting` int(11) NOT NULL DEFAULT '0',
  `status_role` int(11) NOT NULL DEFAULT '0' COMMENT '0 aktif 1 non aktif',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `trx_asb_aktivitas`
--

DROP TABLE IF EXISTS `trx_asb_aktivitas`;
CREATE TABLE `trx_asb_aktivitas` (
  `id_aktivitas_asb` bigint(20) NOT NULL,
  `id_asb_sub_sub_kelompok` int(11) NOT NULL,
  `nm_aktivitas_asb` varchar(255) NOT NULL,
  `satuan_aktivitas` varchar(255) DEFAULT NULL COMMENT 'tidak ditampilkan',
  `diskripsi_aktivitas` varchar(500) DEFAULT NULL,
  `volume_1` decimal(20,2) DEFAULT '0.00',
  `id_satuan_1` int(11) DEFAULT NULL COMMENT 'cost driver',
  `sat_derivatif_1` int(11) DEFAULT NULL,
  `volume_2` decimal(20,2) DEFAULT '0.00',
  `id_satuan_2` int(11) DEFAULT NULL COMMENT 'cost driver',
  `sat_derivatif_2` int(11) DEFAULT NULL,
  `range_max` decimal(20,2) NOT NULL DEFAULT '0.00',
  `kapasitas_max` decimal(20,2) NOT NULL DEFAULT '0.00',
  `range_max1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `kapasitas_max1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `temp_id` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_asb_kelompok`
--

DROP TABLE IF EXISTS `trx_asb_kelompok`;
CREATE TABLE `trx_asb_kelompok` (
  `id_asb_kelompok` int(11) NOT NULL,
  `id_asb_perkada` int(11) NOT NULL,
  `uraian_kelompok_asb` varchar(255) NOT NULL,
  `temp_id` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_asb_komponen`
--

DROP TABLE IF EXISTS `trx_asb_komponen`;
CREATE TABLE `trx_asb_komponen` (
  `id_aktivitas_asb` bigint(20) NOT NULL,
  `id_komponen_asb` bigint(20) NOT NULL,
  `nm_komponen_asb` varchar(255) NOT NULL,
  `id_rekening` int(11) NOT NULL,
  `temp_id` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_asb_komponen_rinci`
--

DROP TABLE IF EXISTS `trx_asb_komponen_rinci`;
CREATE TABLE `trx_asb_komponen_rinci` (
  `id_komponen_asb_rinci` bigint(20) NOT NULL,
  `id_komponen_asb` bigint(20) NOT NULL,
  `jenis_biaya` int(11) NOT NULL DEFAULT '1' COMMENT '1 fix 2 dependent variabel 3 independen variable',
  `id_tarif_ssh` bigint(11) NOT NULL,
  `koefisien1` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `id_satuan1` int(11) DEFAULT NULL,
  `sat_derivatif1` int(11) DEFAULT NULL,
  `koefisien2` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `id_satuan2` int(11) DEFAULT NULL,
  `sat_derivatif2` int(11) DEFAULT NULL,
  `koefisien3` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `id_satuan3` int(11) DEFAULT NULL,
  `satuan` varchar(255) DEFAULT NULL,
  `ket_group` varchar(255) DEFAULT NULL COMMENT 'untuk menyimpan data grouping di rincian yang sifatnya opsional',
  `hub_driver` int(11) DEFAULT '0' COMMENT '1 driver1 2 driver2 3 driver12 0 N/A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_asb_perhitungan`
--

DROP TABLE IF EXISTS `trx_asb_perhitungan`;
CREATE TABLE `trx_asb_perhitungan` (
  `tahun_perhitungan` int(11) NOT NULL,
  `id_perhitungan` bigint(20) NOT NULL,
  `id_perkada` int(11) NOT NULL,
  `flag_aktif` int(11) NOT NULL DEFAULT '0' COMMENT '0 aktif 1 non aktif'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_asb_perhitungan_rinci`
--

DROP TABLE IF EXISTS `trx_asb_perhitungan_rinci`;
CREATE TABLE `trx_asb_perhitungan_rinci` (
  `id_perhitungan_rinci` bigint(20) NOT NULL,
  `id_perhitungan` bigint(20) NOT NULL,
  `id_asb_kelompok` bigint(20) NOT NULL,
  `id_asb_sub_kelompok` bigint(20) NOT NULL,
  `id_asb_sub_sub_kelompok` bigint(20) NOT NULL,
  `id_aktivitas_asb` bigint(20) NOT NULL,
  `id_komponen_asb` bigint(20) NOT NULL,
  `id_komponen_asb_rinci` bigint(20) NOT NULL,
  `id_tarif_ssh` bigint(20) NOT NULL,
  `id_zona` int(11) NOT NULL,
  `harga_satuan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_pagu` decimal(20,2) DEFAULT '0.00',
  `kfix` decimal(20,4) DEFAULT '0.0000',
  `kmax` decimal(20,4) DEFAULT '0.0000',
  `kdv1` decimal(20,4) DEFAULT '0.0000',
  `kr1` decimal(20,4) DEFAULT '0.0000',
  `kdv2` decimal(20,4) DEFAULT '0.0000',
  `kr2` decimal(20,4) DEFAULT '0.0000',
  `kiv1` decimal(20,4) DEFAULT '0.0000',
  `kiv2` decimal(20,4) DEFAULT '0.0000',
  `kiv3` decimal(20,4) DEFAULT '0.0000'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_asb_perkada`
--

DROP TABLE IF EXISTS `trx_asb_perkada`;
CREATE TABLE `trx_asb_perkada` (
  `id_asb_perkada` int(11) NOT NULL,
  `nomor_perkada` varchar(255) NOT NULL,
  `tanggal_perkada` date NOT NULL,
  `tahun_berlaku` int(11) NOT NULL COMMENT 'tahun berlakuknya perkada',
  `uraian_perkada` varchar(500) DEFAULT NULL,
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_asb_sub_kelompok`
--

DROP TABLE IF EXISTS `trx_asb_sub_kelompok`;
CREATE TABLE `trx_asb_sub_kelompok` (
  `id_asb_sub_kelompok` int(11) NOT NULL,
  `id_asb_kelompok` int(11) NOT NULL,
  `uraian_sub_kelompok_asb` varchar(255) NOT NULL,
  `temp_id` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_asb_sub_sub_kelompok`
--

DROP TABLE IF EXISTS `trx_asb_sub_sub_kelompok`;
CREATE TABLE `trx_asb_sub_sub_kelompok` (
  `id_asb_sub_sub_kelompok` int(11) NOT NULL,
  `id_asb_sub_kelompok` int(11) NOT NULL,
  `uraian_sub_sub_kelompok_asb` varchar(255) NOT NULL,
  `temp_id` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd`
--

DROP TABLE IF EXISTS `trx_forum_skpd`;
CREATE TABLE `trx_forum_skpd` (
  `id_forum_skpd` bigint(20) NOT NULL,
  `id_forum_program` bigint(20) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja` int(11) DEFAULT '0',
  `id_rkpd_renstra` int(11) DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT '0',
  `id_kegiatan_renstra` int(11) DEFAULT '0',
  `id_kegiatan_ref` int(11) NOT NULL,
  `uraian_kegiatan_forum` varchar(500) DEFAULT NULL,
  `pagu_tahun_kegiatan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_kegiatan_renstra` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_plus1_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_plus1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_status` varchar(500) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 =  musrenbang',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal dilaksanakan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari renja 1 baru tambahan',
  `kelompok_sasaran` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd_aktivitas`
--

DROP TABLE IF EXISTS `trx_forum_skpd_aktivitas`;
CREATE TABLE `trx_forum_skpd_aktivitas` (
  `id_aktivitas_forum` bigint(11) NOT NULL,
  `id_forum_skpd` bigint(20) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `sumber_aktivitas` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari ASB 1 Bukan ASB',
  `id_aktivitas_asb` int(11) DEFAULT '0',
  `id_aktivitas_renja` int(11) DEFAULT '0',
  `uraian_aktivitas_kegiatan` varchar(500) DEFAULT NULL,
  `volume_aktivitas_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_forum_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `volume_aktivitas_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_forum_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `id_program_nasional` int(11) DEFAULT NULL,
  `id_program_provinsi` int(11) DEFAULT NULL,
  `jenis_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru 1 lanjutan',
  `sumber_dana` int(11) NOT NULL DEFAULT '0',
  `pagu_aktivitas_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_aktivitas_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_musren` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal',
  `keterangan_aktivitas` varchar(500) DEFAULT '0',
  `status_musren` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 = musrenbang',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renja 1 tambahan baru',
  `id_satuan_publik` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd_belanja`
--

DROP TABLE IF EXISTS `trx_forum_skpd_belanja`;
CREATE TABLE `trx_forum_skpd_belanja` (
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_belanja_forum` bigint(20) NOT NULL,
  `id_lokasi_forum` bigint(20) NOT NULL,
  `id_zona_ssh` int(11) NOT NULL,
  `id_belanja_renja` int(11) NOT NULL DEFAULT '0',
  `sumber_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 asb 1 ssh',
  `id_aktivitas_asb` int(11) NOT NULL,
  `id_item_ssh` bigint(20) NOT NULL,
  `id_rekening_ssh` int(11) NOT NULL,
  `uraian_belanja` varchar(500) DEFAULT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL,
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '1',
  `harga_satuan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1_forum` int(11) NOT NULL,
  `volume_2_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2_forum` int(11) NOT NULL DEFAULT '1',
  `harga_satuan_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd_dokumen`
--

DROP TABLE IF EXISTS `trx_forum_skpd_dokumen`;
CREATE TABLE `trx_forum_skpd_dokumen` (
  `id_dokumen_ranwal` int(11) NOT NULL,
  `id_unit_renja` int(255) NOT NULL,
  `nomor_ranwal` varchar(255) NOT NULL,
  `tanggal_ranwal` date NOT NULL,
  `tahun_ranwal` int(11) NOT NULL COMMENT 'tahun berlakuknya perkada',
  `uraian_perkada` varchar(500) DEFAULT NULL,
  `jabatan_tandatangan` varchar(255) DEFAULT NULL,
  `nama_tandatangan` varchar(255) DEFAULT NULL,
  `nip_tandatangan` varchar(255) DEFAULT NULL,
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd_kebijakan`
--

DROP TABLE IF EXISTS `trx_forum_skpd_kebijakan`;
CREATE TABLE `trx_forum_skpd_kebijakan` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_kebijakan_renja` int(11) NOT NULL,
  `uraian_kebijakan` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd_kegiatan_indikator`
--

DROP TABLE IF EXISTS `trx_forum_skpd_kegiatan_indikator`;
CREATE TABLE `trx_forum_skpd_kegiatan_indikator` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_forum_skpd` bigint(11) NOT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_kegiatan` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_kegiatan` text,
  `tolok_ukur_indikator` text,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `indikator_input` text,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd_lokasi`
--

DROP TABLE IF EXISTS `trx_forum_skpd_lokasi`;
CREATE TABLE `trx_forum_skpd_lokasi` (
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_pelaksana_forum` bigint(20) NOT NULL,
  `id_lokasi_forum` bigint(20) NOT NULL,
  `id_lokasi` int(11) NOT NULL,
  `id_lokasi_renja` int(11) DEFAULT '0',
  `id_lokasi_teknis` int(11) DEFAULT NULL,
  `jenis_lokasi` int(11) NOT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_usulan_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_usulan_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `id_desa` int(11) DEFAULT '0',
  `id_kecamatan` int(11) DEFAULT '0',
  `rt` int(11) DEFAULT '0',
  `rw` int(11) DEFAULT '0',
  `uraian_lokasi` varchar(500) DEFAULT NULL,
  `lat` varchar(500) DEFAULT NULL,
  `lang` varchar(500) DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_lokasi` varchar(500) DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 renja 1 tambahan 2 musrenbang 3 pokir'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd_pelaksana`
--

DROP TABLE IF EXISTS `trx_forum_skpd_pelaksana`;
CREATE TABLE `trx_forum_skpd_pelaksana` (
  `id_pelaksana_forum` bigint(20) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_aktivitas_forum` bigint(11) NOT NULL,
  `id_sub_unit` int(11) NOT NULL,
  `id_pelaksana_renja` int(11) DEFAULT '0',
  `id_lokasi` int(11) DEFAULT '0' COMMENT 'lokasi penyelenggaraan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 renja 1 tambahan',
  `ket_pelaksana` varchar(500) DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal 2 baru',
  `status_data` int(11) NOT NULL COMMENT '0 draft 1 final'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd_program`
--

DROP TABLE IF EXISTS `trx_forum_skpd_program`;
CREATE TABLE `trx_forum_skpd_program` (
  `id_forum_program` bigint(11) NOT NULL,
  `id_forum_rkpdprog` int(11) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pdt 2 BTL',
  `no_urut` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_renja_program` int(11) DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT '0',
  `uraian_program_renstra` varchar(500) DEFAULT NULL,
  `id_program_ref` int(11) NOT NULL,
  `pagu_tahun_renstra` decimal(20,2) DEFAULT '0.00',
  `pagu_forum` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renstra 1 = baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_usulan` varchar(250) DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `id_dokumen` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd_program_indikator`
--

DROP TABLE IF EXISTS `trx_forum_skpd_program_indikator`;
CREATE TABLE `trx_forum_skpd_program_indikator` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_forum_program` bigint(11) NOT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_program` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program` text,
  `tolok_ukur_indikator` text,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `indikator_input` text,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd_program_ranwal`
--

DROP TABLE IF EXISTS `trx_forum_skpd_program_ranwal`;
CREATE TABLE `trx_forum_skpd_program_ranwal` (
  `id_forum_rkpdprog` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pdt 2 BTL',
  `id_program_rpjmd` int(11) DEFAULT NULL,
  `id_bidang` int(11) NOT NULL DEFAULT '0',
  `id_unit` int(11) NOT NULL DEFAULT '0',
  `uraian_program_rpjmd` varchar(500) DEFAULT NULL,
  `pagu_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_ranwal` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_program` varchar(500) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Draft 1 = Posting Renja 2 = Posting Musren',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = RPJMD 1 = Baru 2 = Luncuran tahun sebelumnya'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_forum_skpd_usulan`
--

DROP TABLE IF EXISTS `trx_forum_skpd_usulan`;
CREATE TABLE `trx_forum_skpd_usulan` (
  `id_sumber_usulan` bigint(20) NOT NULL,
  `sumber_usulan` int(11) DEFAULT '0' COMMENT '0 renja 1 musrendes 2 musrencam 3 pokir 4 forum_skpd',
  `id_lokasi_forum` bigint(20) NOT NULL,
  `id_ref_usulan` int(11) DEFAULT NULL,
  `volume_1_usulan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2_usulan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 tanpa 1 dengan 2 digabung 3 ditolak',
  `uraian_usulan` varchar(500) DEFAULT NULL,
  `ket_usulan` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_group_menu`
--

DROP TABLE IF EXISTS `trx_group_menu`;
CREATE TABLE `trx_group_menu` (
  `menu` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Triggers `trx_group_menu`
--
DROP TRIGGER IF EXISTS `trg_agroup_menu`;
DELIMITER $$
CREATE TRIGGER `trg_agroup_menu` BEFORE INSERT ON `trx_group_menu` FOR EACH ROW IF new.group_id = 1 THEN 
    SIGNAL SQLSTATE '45000' 
     SET MESSAGE_TEXT = 'You are not allowed to insert it!!';
END IF
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_egroup_menu`;
DELIMITER $$
CREATE TRIGGER `trg_egroup_menu` BEFORE UPDATE ON `trx_group_menu` FOR EACH ROW IF old.group_id = 1 THEN 
    SIGNAL SQLSTATE '45000' 
     SET MESSAGE_TEXT = 'This record is sacred! You are not allowed to update it!!';
END IF
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `trg_group_menu`;
DELIMITER $$
CREATE TRIGGER `trg_group_menu` BEFORE DELETE ON `trx_group_menu` FOR EACH ROW IF old.group_id = 1 THEN 
    SIGNAL SQLSTATE '45000' 
     SET MESSAGE_TEXT = 'This record is sacred! You are not allowed to remove it!!';
END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `trx_isian_data_dasar`
--

DROP TABLE IF EXISTS `trx_isian_data_dasar`;
CREATE TABLE `trx_isian_data_dasar` (
  `id_isian_tabel_dasar` int(11) NOT NULL,
  `id_kolom_tabel_dasar` int(11) DEFAULT NULL,
  `id_kecamatan` int(11) DEFAULT NULL,
  `nmin1` decimal(20,2) DEFAULT '0.00',
  `nmin2` decimal(20,2) DEFAULT '0.00',
  `nmin3` decimal(20,2) DEFAULT '0.00',
  `nmin4` decimal(20,2) DEFAULT '0.00',
  `nmin5` decimal(20,2) DEFAULT '0.00',
  `tahun` int(4) DEFAULT NULL,
  `nmin1_persen` decimal(20,2) DEFAULT '0.00',
  `nmin2_persen` decimal(20,2) DEFAULT '0.00',
  `nmin3_persen` decimal(20,2) DEFAULT '0.00',
  `nmin4_persen` decimal(20,2) DEFAULT '0.00',
  `nmin5_persen` decimal(20,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `trx_log_events`
--

DROP TABLE IF EXISTS `trx_log_events`;
CREATE TABLE `trx_log_events` (
  `id` int(11) NOT NULL,
  `code_events` int(11) NOT NULL DEFAULT '0',
  `discription` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `operate` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrencam`
--

DROP TABLE IF EXISTS `trx_musrencam`;
CREATE TABLE `trx_musrencam` (
  `tahun_musren` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_musrencam` int(11) NOT NULL,
  `id_renja` int(11) NOT NULL,
  `id_kecamatan` int(11) NOT NULL,
  `id_kegiatan` int(11) NOT NULL,
  `id_asb_aktivitas` int(11) NOT NULL,
  `uraian_aktivitas_kegiatan` varchar(500) DEFAULT NULL,
  `uraian_kondisi` varchar(500) DEFAULT NULL,
  `tolak_ukur_aktivitas` varchar(500) DEFAULT NULL,
  `target_output_aktivitas` decimal(20,2) DEFAULT '0.00',
  `id_satuan` int(11) DEFAULT NULL,
  `id_satuan_desa` int(11) DEFAULT NULL,
  `volume` decimal(20,2) DEFAULT '0.00',
  `volume_desa` decimal(20,2) DEFAULT '0.00',
  `harga_satuan` decimal(20,2) DEFAULT '0.00',
  `harga_satuan_desa` decimal(20,2) DEFAULT '0.00',
  `jml_pagu` decimal(20,2) DEFAULT '0.00',
  `jml_pagu_desa` decimal(20,2) DEFAULT '0.00',
  `id_usulan_desa` bigint(255) DEFAULT NULL,
  `pagu_aktivitas` decimal(20,2) DEFAULT '0.00',
  `sumber_usulan` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Ranwal/Renja 1 = Desa 2 = Musrencam',
  `status_usulan` int(11) NOT NULL COMMENT '0 = Proses Usulan 1 = Kirim_Forum',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0= Diterima\r\n1= Diterima dengan perubahan\r\n2= Digabungkan dengan usulan lain\r\n3= Ditolak'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrencam_lokasi`
--

DROP TABLE IF EXISTS `trx_musrencam_lokasi`;
CREATE TABLE `trx_musrencam_lokasi` (
  `tahun_musren` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_musrencam` int(11) NOT NULL,
  `id_lokasi_musrencam` int(11) NOT NULL,
  `id_lokasi` int(11) NOT NULL COMMENT 'difilter hanya id lokasi yang jenis lokasinya kewilayahan',
  `id_desa` int(11) DEFAULT NULL,
  `rt` int(11) DEFAULT NULL,
  `rw` int(11) DEFAULT NULL,
  `uraian_kondisi` varchar(500) DEFAULT NULL,
  `file_foto` varchar(500) DEFAULT NULL,
  `lat` varchar(500) DEFAULT NULL,
  `lang` varchar(500) DEFAULT NULL,
  `id_musrendes` int(11) DEFAULT NULL,
  `id_lokasi_musrendes` int(255) DEFAULT NULL,
  `sumber_data` int(11) DEFAULT NULL COMMENT '0 = desa 1 = kecamatan',
  `volume_desa` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume` decimal(20,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrendes`
--

DROP TABLE IF EXISTS `trx_musrendes`;
CREATE TABLE `trx_musrendes` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_musrendes` int(11) NOT NULL,
  `id_renja` int(11) NOT NULL,
  `id_desa` int(11) NOT NULL,
  `id_kegiatan` int(11) NOT NULL,
  `id_asb_aktivitas` int(11) NOT NULL,
  `uraian_aktivitas_kegiatan` varchar(500) DEFAULT NULL,
  `uraian_kondisi` varchar(500) DEFAULT NULL,
  `tolak_ukur_aktivitas` varchar(500) DEFAULT NULL,
  `target_output_aktivitas` decimal(20,2) DEFAULT '0.00',
  `id_satuan` int(11) DEFAULT NULL,
  `id_satuan_rw` int(11) DEFAULT NULL,
  `volume` decimal(20,2) DEFAULT '0.00',
  `volume_rw` decimal(20,2) DEFAULT '0.00',
  `harga_satuan` decimal(20,2) DEFAULT '0.00',
  `harga_satuan_rw` decimal(20,2) DEFAULT '0.00',
  `jml_pagu` decimal(20,2) DEFAULT '0.00',
  `jml_pagu_rw` decimal(20,2) DEFAULT '0.00',
  `id_usulan_rw` bigint(255) DEFAULT NULL,
  `pagu_aktivitas` decimal(20,2) DEFAULT '0.00',
  `sumber_usulan` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Ranwal/Renja 1 = RW 2 = Musrendes',
  `status_usulan` int(11) NOT NULL COMMENT '0 = Proses Usulan 1 = Kirim_Musrencam',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0= Diterima\r\n1= Diterima dengan perubahan\r\n2= Digabungkan dengan usulan lain\r\n3= Ditolak'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrendes_lokasi`
--

DROP TABLE IF EXISTS `trx_musrendes_lokasi`;
CREATE TABLE `trx_musrendes_lokasi` (
  `tahun_musren` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_musrendes` int(11) NOT NULL,
  `id_lokasi_musrendes` int(11) NOT NULL,
  `id_lokasi` int(11) NOT NULL COMMENT 'difilter hanya id lokasi yang jenis lokasinya kewilayahan',
  `id_desa` int(11) DEFAULT NULL,
  `rt` int(11) DEFAULT NULL,
  `rw` int(11) DEFAULT NULL,
  `uraian_kondisi` varchar(500) DEFAULT NULL,
  `file_foto` varchar(500) DEFAULT NULL,
  `lat` varchar(500) DEFAULT NULL,
  `lang` varchar(500) DEFAULT NULL,
  `sumber_data` int(11) DEFAULT NULL COMMENT '0 = RW 1 = Desa',
  `volume_rw` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_desa` decimal(20,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrendes_rw`
--

DROP TABLE IF EXISTS `trx_musrendes_rw`;
CREATE TABLE `trx_musrendes_rw` (
  `tahun_musren` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_musrendes_rw` int(11) NOT NULL,
  `id_renja` int(11) NOT NULL,
  `id_desa` int(11) NOT NULL,
  `id_kegiatan` int(11) NOT NULL,
  `id_asb_aktivitas` int(11) NOT NULL,
  `uraian_aktivitas_kegiatan` varchar(500) DEFAULT NULL,
  `uraian_kondisi` varchar(1000) DEFAULT NULL,
  `id_satuan` int(11) NOT NULL DEFAULT '0',
  `volume` decimal(20,2) NOT NULL DEFAULT '0.00',
  `harga_satuan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_pagu` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_usulan` int(11) NOT NULL COMMENT '0 = Proses Usulan 1 = Kirim_Musrencam',
  `rt` int(11) DEFAULT NULL,
  `rw` int(11) DEFAULT NULL,
  `lat` varchar(500) DEFAULT NULL,
  `lang` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrendes_rw_lokasi`
--

DROP TABLE IF EXISTS `trx_musrendes_rw_lokasi`;
CREATE TABLE `trx_musrendes_rw_lokasi` (
  `no_urut` int(11) NOT NULL,
  `id_musrendes_rw` int(11) NOT NULL,
  `id_musrendes_lokasi` int(11) NOT NULL,
  `file_foto` varchar(500) DEFAULT NULL,
  `uraian_kondisi` varchar(1000) DEFAULT NULL,
  `lat` varchar(100) NOT NULL DEFAULT '0',
  `lang` varchar(100) NOT NULL DEFAULT '0.00',
  `status_usulan` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Proses Usulan 1 = Kirim_Musrencam'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab`
--

DROP TABLE IF EXISTS `trx_musrenkab`;
CREATE TABLE `trx_musrenkab` (
  `id_musrenkab` int(11) NOT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL COMMENT '0 baru',
  `id_rkpd_rancangan` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru',
  `no_urut` int(11) NOT NULL,
  `tahun_rkpd` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pendapatan 2 BTL',
  `id_rkpd_rpjmd` int(11) DEFAULT NULL,
  `thn_id_rpjmd` int(11) DEFAULT NULL,
  `id_visi_rpjmd` int(11) DEFAULT NULL,
  `id_misi_rpjmd` int(11) DEFAULT NULL,
  `id_tujuan_rpjmd` int(11) DEFAULT NULL,
  `id_sasaran_rpjmd` int(11) DEFAULT NULL,
  `id_program_rpjmd` int(11) DEFAULT NULL,
  `uraian_program_rpjmd` varchar(500) DEFAULT NULL,
  `pagu_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_ranwal` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_program` varchar(500) DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL COMMENT '0 = data tepat waktu sesuai renstra/rpjmd\\r\\n1 = data pergeseran waktu renstra/rpjmd\\r\\n2 = data baru yang belum ada di renstra/rpjmd\\r\\n9 = dibatalkan pelaksanaanya\\r\\n8 = ditunda dilaksanakan\\r\\n',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Draft 1 = Posting Renja 2 = Posting Musren',
  `ket_usulan` varchar(500) DEFAULT NULL COMMENT 'Keterangan / alasan status usulan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = RPJMD 1 = Baru 2 = Luncuran tahun sebelumnya',
  `id_dokumen` int(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_aktivitas_pd`
--

DROP TABLE IF EXISTS `trx_musrenkab_aktivitas_pd`;
CREATE TABLE `trx_musrenkab_aktivitas_pd` (
  `id_aktivitas_pd` bigint(11) NOT NULL,
  `id_pelaksana_pd` bigint(20) NOT NULL,
  `id_aktivitas_forum` int(11) NOT NULL DEFAULT '0',
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `sumber_aktivitas` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari ASB 1 Bukan ASB',
  `id_aktivitas_asb` int(11) DEFAULT '0',
  `id_aktivitas_renja` int(11) DEFAULT '0',
  `uraian_aktivitas_kegiatan` varchar(500) DEFAULT NULL,
  `volume_aktivitas_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_forum_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `volume_aktivitas_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_forum_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `id_program_nasional` int(11) DEFAULT NULL,
  `id_program_provinsi` int(11) DEFAULT NULL,
  `jenis_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru 1 lanjutan',
  `sumber_dana` int(11) NOT NULL DEFAULT '0',
  `pagu_aktivitas_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_aktivitas_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_musren` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal',
  `keterangan_aktivitas` varchar(500) DEFAULT '0',
  `status_musren` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 = musrenbang',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renja 1 tambahan baru',
  `id_satuan_publik` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_belanja_pd`
--

DROP TABLE IF EXISTS `trx_musrenkab_belanja_pd`;
CREATE TABLE `trx_musrenkab_belanja_pd` (
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_belanja_pd` bigint(20) NOT NULL,
  `id_aktivitas_pd` bigint(20) NOT NULL,
  `id_belanja_forum` int(11) NOT NULL DEFAULT '0',
  `id_zona_ssh` int(11) NOT NULL,
  `id_belanja_renja` int(11) NOT NULL DEFAULT '0',
  `sumber_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 asb 1 ssh',
  `id_aktivitas_asb` int(11) NOT NULL,
  `id_item_ssh` bigint(20) NOT NULL,
  `id_rekening_ssh` int(11) NOT NULL,
  `uraian_belanja` varchar(500) DEFAULT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL,
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '1',
  `harga_satuan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1_forum` int(11) NOT NULL,
  `volume_2_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2_forum` int(11) NOT NULL DEFAULT '1',
  `harga_satuan_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_dokumen`
--

DROP TABLE IF EXISTS `trx_musrenkab_dokumen`;
CREATE TABLE `trx_musrenkab_dokumen` (
  `id_dokumen_rkpd` int(11) NOT NULL,
  `nomor_rkpd` varchar(255) NOT NULL,
  `tanggal_rkpd` date NOT NULL,
  `tahun_rkpd` int(11) NOT NULL COMMENT 'tahun perencanaan',
  `uraian_perkada` varchar(500) DEFAULT NULL,
  `id_unit_perencana` int(11) DEFAULT NULL,
  `jabatan_tandatangan` varchar(255) DEFAULT NULL,
  `nama_tandatangan` varchar(255) DEFAULT NULL,
  `nip_tandatangan` varchar(255) DEFAULT NULL,
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_indikator`
--

DROP TABLE IF EXISTS `trx_musrenkab_indikator`;
CREATE TABLE `trx_musrenkab_indikator` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_musrenkab` int(11) NOT NULL,
  `id_indikator_program_rkpd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_indikator_rkpd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program_rkpd` text,
  `tolok_ukur_indikator` text,
  `target_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `indikator_input` text,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `indikator_output` text,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum direviu 1 sudah direviu',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 data rpjmd 1 data baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_kebijakan`
--

DROP TABLE IF EXISTS `trx_musrenkab_kebijakan`;
CREATE TABLE `trx_musrenkab_kebijakan` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_musrenkab` int(11) NOT NULL,
  `id_kebijakan_rancangan` int(11) NOT NULL,
  `id_kebijakan_rkpd` int(11) NOT NULL,
  `uraian_kebijakan` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_kebijakan_pd`
--

DROP TABLE IF EXISTS `trx_musrenkab_kebijakan_pd`;
CREATE TABLE `trx_musrenkab_kebijakan_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_kebijakan_pd` int(11) NOT NULL,
  `uraian_kebijakan` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_kegiatan_pd`
--

DROP TABLE IF EXISTS `trx_musrenkab_kegiatan_pd`;
CREATE TABLE `trx_musrenkab_kegiatan_pd` (
  `id_kegiatan_pd` bigint(20) NOT NULL,
  `id_program_pd` bigint(20) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_forum_skpd` int(11) DEFAULT NULL,
  `id_renja` int(11) DEFAULT '0',
  `id_rkpd_renstra` int(11) DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT '0',
  `id_kegiatan_renstra` int(11) DEFAULT '0',
  `id_kegiatan_ref` int(11) NOT NULL,
  `uraian_kegiatan_forum` varchar(500) DEFAULT NULL,
  `pagu_tahun_kegiatan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_kegiatan_renstra` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_plus1_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_plus1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_status` varchar(500) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 =  musrenbang',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal dilaksanakan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari renja 1 baru tambahan',
  `kelompok_sasaran` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_keg_indikator_pd`
--

DROP TABLE IF EXISTS `trx_musrenkab_keg_indikator_pd`;
CREATE TABLE `trx_musrenkab_keg_indikator_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_kegiatan_pd` bigint(11) NOT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_kegiatan` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_kegiatan` text,
  `tolok_ukur_indikator` text,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `indikator_input` text,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_lokasi_pd`
--

DROP TABLE IF EXISTS `trx_musrenkab_lokasi_pd`;
CREATE TABLE `trx_musrenkab_lokasi_pd` (
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_aktivitas_pd` bigint(20) NOT NULL,
  `id_lokasi_forum` int(11) NOT NULL DEFAULT '0' COMMENT '0',
  `id_lokasi_pd` bigint(20) NOT NULL,
  `id_lokasi` int(11) NOT NULL,
  `id_lokasi_renja` int(11) DEFAULT '0',
  `id_lokasi_teknis` int(11) DEFAULT NULL,
  `jenis_lokasi` int(11) NOT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_usulan_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_usulan_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `id_desa` int(11) DEFAULT '0',
  `id_kecamatan` int(11) DEFAULT '0',
  `rt` int(11) DEFAULT '0',
  `rw` int(11) DEFAULT '0',
  `uraian_lokasi` varchar(500) DEFAULT NULL,
  `lat` varchar(500) DEFAULT NULL,
  `lang` varchar(500) DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_lokasi` varchar(500) DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 renja 1 tambahan 2 musrenbang 3 pokir'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_pelaksana`
--

DROP TABLE IF EXISTS `trx_musrenkab_pelaksana`;
CREATE TABLE `trx_musrenkab_pelaksana` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_pelaksana_rkpd` int(11) NOT NULL,
  `id_musrenkab` int(11) NOT NULL,
  `id_urusan_rkpd` int(11) NOT NULL,
  `id_pelaksana_rpjmd` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `pagu_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `hak_akses` int(11) NOT NULL DEFAULT '0' COMMENT '0 tidak dapat menambah data 1 dapat menambah data',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rpjmd 1 baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 dibatalkan',
  `ket_pelaksanaan` varchar(500) DEFAULT NULL COMMENT 'menjelaskan status pelaksanaan',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum direviu 1 sudah direviu'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_pelaksana_pd`
--

DROP TABLE IF EXISTS `trx_musrenkab_pelaksana_pd`;
CREATE TABLE `trx_musrenkab_pelaksana_pd` (
  `id_pelaksana_pd` bigint(20) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_kegiatan_pd` bigint(11) NOT NULL,
  `id_pelaksana_forum` int(11) DEFAULT NULL,
  `id_sub_unit` int(11) NOT NULL,
  `id_pelaksana_renja` int(11) DEFAULT '0',
  `id_lokasi` int(11) DEFAULT '0' COMMENT 'lokasi penyelenggaraan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 renja 1 tambahan',
  `ket_pelaksana` varchar(500) DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal 2 baru',
  `status_data` int(11) NOT NULL COMMENT '0 draft 1 final'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_program_pd`
--

DROP TABLE IF EXISTS `trx_musrenkab_program_pd`;
CREATE TABLE `trx_musrenkab_program_pd` (
  `id_program_pd` bigint(11) NOT NULL,
  `id_pelaksana_rkpd` int(11) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pdt 2 BTL',
  `no_urut` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_rkpd_rancangan` int(11) DEFAULT NULL,
  `id_renja_program` int(11) DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT '0',
  `uraian_program_renstra` varchar(500) DEFAULT NULL,
  `id_program_ref` int(11) NOT NULL,
  `pagu_tahun_renstra` decimal(20,2) DEFAULT '0.00',
  `pagu_forum` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renstra 1 = baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_usulan` varchar(250) DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `id_dokumen` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_prog_indikator_pd`
--

DROP TABLE IF EXISTS `trx_musrenkab_prog_indikator_pd`;
CREATE TABLE `trx_musrenkab_prog_indikator_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_program_pd` bigint(11) NOT NULL,
  `id_program_forum` int(11) NOT NULL DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_program` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program` text,
  `tolok_ukur_indikator` text,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `indikator_input` text,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_musrenkab_urusan`
--

DROP TABLE IF EXISTS `trx_musrenkab_urusan`;
CREATE TABLE `trx_musrenkab_urusan` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) DEFAULT NULL,
  `id_musrenkab` int(11) NOT NULL,
  `id_urusan_rkpd` int(11) NOT NULL,
  `id_bidang` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rpjmd 1 baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_pokir`
--

DROP TABLE IF EXISTS `trx_pokir`;
CREATE TABLE `trx_pokir` (
  `id_tahun` int(11) NOT NULL,
  `id_pokir` int(11) NOT NULL,
  `tanggal_pengusul` date NOT NULL,
  `asal_pengusul` int(11) NOT NULL DEFAULT '0' COMMENT '0 Fraksi\r\n1 Pempinan\r\n2 Badan Musyawarah\r\n3 Komisi\r\n4 Badan Legislasi Daerah\r\n5 Badan Anggaran\r\n6 Badan Kehormatan\r\n9 Badan Lainnya',
  `jabatan_pengusul` int(11) NOT NULL DEFAULT '4' COMMENT '0 ketua 1 wakil ketua 2 sekretaris 3 bendahara 4 anggota',
  `nama_pengusul` varchar(255) DEFAULT NULL,
  `nomor_anggota` varchar(20) DEFAULT NULL,
  `daerah_pemilihan` varchar(255) DEFAULT NULL,
  `media_pokir` int(11) DEFAULT '0' COMMENT '1 surat 2 email 3 telepon 4 lisan 9 lainnya',
  `bukti_dokumen` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `entried_at` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_pokir_lokasi`
--

DROP TABLE IF EXISTS `trx_pokir_lokasi`;
CREATE TABLE `trx_pokir_lokasi` (
  `id_pokir_usulan` int(11) NOT NULL,
  `id_pokir_lokasi` int(11) NOT NULL,
  `id_kecamatan` int(11) NOT NULL,
  `id_desa` int(11) DEFAULT NULL,
  `rw` int(11) DEFAULT NULL,
  `rt` int(11) DEFAULT NULL,
  `diskripsi_lokasi` blob
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_pokir_tl`
--

DROP TABLE IF EXISTS `trx_pokir_tl`;
CREATE TABLE `trx_pokir_tl` (
  `id_pokir_tl` int(11) NOT NULL,
  `id_pokir` int(11) NOT NULL,
  `id_pokir_usulan` int(11) NOT NULL,
  `id_pokir_lokasi` int(11) NOT NULL,
  `unit_tl` int(11) DEFAULT NULL,
  `status_tl` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Belum TL, 1 = Disposisi Ke Unit, 2 = Dipending, 3 = Perlu Dibahas kembali  4 = tidak diakomodir',
  `keterangan_status` varchar(500) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_pokir_tl_unit`
--

DROP TABLE IF EXISTS `trx_pokir_tl_unit`;
CREATE TABLE `trx_pokir_tl_unit` (
  `id_pokir_unit` int(11) NOT NULL,
  `unit_tl` int(11) DEFAULT NULL,
  `id_pokir_tl` int(11) NOT NULL,
  `id_pokir` int(11) NOT NULL,
  `id_pokir_usulan` int(11) NOT NULL,
  `id_pokir_lokasi` int(11) NOT NULL,
  `id_aktivitas_renja` int(11) NOT NULL DEFAULT '0',
  `id_lokasi_renja` int(11) NOT NULL DEFAULT '0',
  `id_aktivitas_forum` int(11) NOT NULL DEFAULT '0',
  `id_lokasi_forum` int(11) NOT NULL DEFAULT '0',
  `volume_tl` decimal(20,2) DEFAULT '0.00',
  `pagu_tl` decimal(20,2) DEFAULT '0.00',
  `status_tl` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Belum TL, 1 = Diakomodir Renja, 2 = Diakomodir Forum, 3 = Tidak diakomodir',
  `keterangan_status` varchar(500) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_pokir_usulan`
--

DROP TABLE IF EXISTS `trx_pokir_usulan`;
CREATE TABLE `trx_pokir_usulan` (
  `id_pokir` int(11) NOT NULL,
  `id_pokir_usulan` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL DEFAULT '1',
  `id_judul_usulan` varchar(150) NOT NULL,
  `diskripsi_usulan` blob,
  `id_unit` int(11) DEFAULT NULL,
  `volume` decimal(20,2) DEFAULT '0.00',
  `id_satuan` int(11) DEFAULT NULL,
  `jml_anggaran` decimal(20,2) NOT NULL DEFAULT '0.00',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `entried_at` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_aktivitas`
--

DROP TABLE IF EXISTS `trx_renja_aktivitas`;
CREATE TABLE `trx_renja_aktivitas` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_aktivitas_renja` int(11) NOT NULL,
  `id_renja` int(11) NOT NULL,
  `sumber_aktivitas` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari ASB 1 Bukan ASB',
  `id_aktivitas_asb` int(11) DEFAULT NULL,
  `id_satuan_publik` int(11) DEFAULT NULL,
  `uraian_aktivitas_kegiatan` varchar(500) DEFAULT NULL,
  `tolak_ukur_aktivitas` varchar(500) DEFAULT NULL,
  `target_output_aktivitas` decimal(20,2) DEFAULT '0.00',
  `id_program_nasional` int(11) DEFAULT NULL,
  `id_program_provinsi` int(11) DEFAULT NULL,
  `jenis_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru 1 lanjutan',
  `sumber_dana` int(11) NOT NULL DEFAULT '0',
  `pagu_aktivitas` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_musren` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_rata2` decimal(20,2) DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_musren` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 = musrenbang',
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(255) DEFAULT NULL,
  `id_satuan_2` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_belanja`
--

DROP TABLE IF EXISTS `trx_renja_belanja`;
CREATE TABLE `trx_renja_belanja` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_belanja_renja` int(11) NOT NULL,
  `id_lokasi_renja` int(11) NOT NULL,
  `id_zona_ssh` int(11) NOT NULL DEFAULT '0',
  `sumber_aktivitas` int(11) NOT NULL DEFAULT '0' COMMENT '1 ssh 0 asb',
  `id_aktivitas_asb` bigint(20) DEFAULT NULL,
  `id_tarif_ssh` bigint(20) NOT NULL,
  `id_rekening_ssh` int(11) NOT NULL,
  `uraian_belanja` varchar(500) DEFAULT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `harga_satuan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_dokumen`
--

DROP TABLE IF EXISTS `trx_renja_dokumen`;
CREATE TABLE `trx_renja_dokumen` (
  `id_dokumen_ranwal` int(11) NOT NULL,
  `id_unit_renja` int(255) NOT NULL,
  `nomor_ranwal` varchar(255) NOT NULL,
  `tanggal_ranwal` date NOT NULL,
  `tahun_ranwal` int(11) NOT NULL COMMENT 'tahun berlakuknya perkada',
  `uraian_perkada` varchar(500) DEFAULT NULL,
  `jabatan_tandatangan` varchar(255) DEFAULT NULL,
  `nama_tandatangan` varchar(255) DEFAULT NULL,
  `nip_tandatangan` varchar(255) DEFAULT NULL,
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_kebijakan`
--

DROP TABLE IF EXISTS `trx_renja_kebijakan`;
CREATE TABLE `trx_renja_kebijakan` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_kebijakan_renja` int(11) NOT NULL,
  `uraian_kebijakan` varchar(500) NOT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_kegiatan`
--

DROP TABLE IF EXISTS `trx_renja_kegiatan`;
CREATE TABLE `trx_renja_kegiatan` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL COMMENT 'juga menunjukkan prioritas',
  `id_renja` int(11) NOT NULL,
  `id_renja_program` bigint(11) NOT NULL,
  `id_rkpd_renstra` int(11) DEFAULT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_visi_renstra` int(11) DEFAULT NULL,
  `id_misi_renstra` int(11) DEFAULT NULL,
  `id_tujuan_renstra` int(11) DEFAULT NULL,
  `id_sasaran_renstra` int(11) DEFAULT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `uraian_program_renstra` varchar(500) DEFAULT NULL,
  `id_kegiatan_renstra` int(11) DEFAULT NULL,
  `id_kegiatan_ref` int(11) NOT NULL,
  `uraian_kegiatan_renstra` varchar(500) DEFAULT '0',
  `pagu_tahun_renstra` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun_kegiatan` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun_selanjutnya` decimal(20,2) DEFAULT '0.00',
  `status_pelaksanaan_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 = tepat 1 = dimajukan 2 = ditunda 3 dibatalkan 4 baru',
  `pagu_musrenbang` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renja skpd 1 =  tambahan baru',
  `ket_usulan` varchar(500) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 Final',
  `status_rancangan` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum selesai 1 siap kirim ke forum',
  `kelompok_sasaran` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_kegiatan_indikator`
--

DROP TABLE IF EXISTS `trx_renja_kegiatan_indikator`;
CREATE TABLE `trx_renja_kegiatan_indikator` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja` int(11) NOT NULL,
  `id_indikator_kegiatan_renja` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_kegiatan_renja` text,
  `tolok_ukur_indikator` text,
  `angka_tahun` decimal(20,2) DEFAULT '0.00',
  `angka_renstra` decimal(20,2) DEFAULT '0.00',
  `id_satuan_output` int(255) DEFAULT NULL,
  `status_data` int(11) DEFAULT '0' COMMENT '0 draft 1 final',
  `sumber_data` int(11) DEFAULT '0' COMMENT '0 renstra 1 tambahan'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_lokasi`
--

DROP TABLE IF EXISTS `trx_renja_lokasi`;
CREATE TABLE `trx_renja_lokasi` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_pelaksana_renja` int(11) NOT NULL,
  `id_lokasi_renja` int(11) NOT NULL,
  `jenis_lokasi` int(11) NOT NULL COMMENT '0 kewilayah 1 teknis',
  `id_lokasi` int(11) NOT NULL,
  `id_kecamatan` int(11) DEFAULT NULL,
  `id_desa` int(11) DEFAULT NULL,
  `rt` int(11) DEFAULT NULL,
  `rw` int(11) DEFAULT NULL,
  `uraian_lokasi` varchar(500) DEFAULT NULL,
  `lat` varchar(500) DEFAULT NULL,
  `lang` varchar(500) DEFAULT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_pelaksana`
--

DROP TABLE IF EXISTS `trx_renja_pelaksana`;
CREATE TABLE `trx_renja_pelaksana` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_pelaksana_renja` int(11) NOT NULL,
  `id_renja` int(11) NOT NULL,
  `id_aktivitas_renja` int(11) NOT NULL,
  `id_sub_unit` int(11) NOT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_pelaksanaan` int(11) DEFAULT '0',
  `ket_usul` int(11) DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `id_lokasi` int(11) NOT NULL DEFAULT '0' COMMENT 'Lokasi Penyelenggaraan Kegiatan'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_program`
--

DROP TABLE IF EXISTS `trx_renja_program`;
CREATE TABLE `trx_renja_program` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja_program` bigint(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pendapatan 2 BTL',
  `id_renja_ranwal` int(11) NOT NULL DEFAULT '0',
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_program_rpjmd` int(11) DEFAULT NULL,
  `id_bidang` int(11) NOT NULL DEFAULT '0',
  `id_unit` int(11) NOT NULL,
  `id_visi_renstra` int(11) DEFAULT NULL,
  `id_misi_renstra` int(11) DEFAULT NULL,
  `id_tujuan_renstra` int(11) DEFAULT NULL,
  `id_sasaran_renstra` int(11) DEFAULT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `uraian_program_renstra` varchar(500) DEFAULT NULL,
  `id_program_ref` int(11) NOT NULL,
  `pagu_tahun_ranwal` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun_renstra` decimal(20,2) DEFAULT '0.00',
  `status_program_rkpd` int(11) DEFAULT NULL COMMENT 'status pelaksanaan unit di rkpd',
  `sumber_data_rkpd` int(11) DEFAULT NULL COMMENT 'sumber usulan pelaksana unit di rkpd',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renstra 1 = baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_usulan` varchar(250) DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `id_dokumen` int(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_program_indikator`
--

DROP TABLE IF EXISTS `trx_renja_program_indikator`;
CREATE TABLE `trx_renja_program_indikator` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja_program` bigint(11) NOT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_program_renja` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program_renja` text,
  `tolok_ukur_indikator` text,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `indikator_input` text,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_program_rkpd`
--

DROP TABLE IF EXISTS `trx_renja_program_rkpd`;
CREATE TABLE `trx_renja_program_rkpd` (
  `tahun_renja` int(11) NOT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_renja_ranwal` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0',
  `id_unit` int(11) NOT NULL,
  `uraian_program_rpjmd` varchar(500) DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `jml_data` int(11) NOT NULL DEFAULT '0',
  `jml_baru` int(11) NOT NULL DEFAULT '0',
  `jml_lama` int(11) NOT NULL DEFAULT '0',
  `jml_tepat` int(11) NOT NULL DEFAULT '0',
  `jml_maju` int(11) NOT NULL DEFAULT '0',
  `jml_tunda` int(11) NOT NULL DEFAULT '0',
  `jml_batal` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan`
--

DROP TABLE IF EXISTS `trx_renja_rancangan`;
CREATE TABLE `trx_renja_rancangan` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL COMMENT 'juga menunjukkan prioritas',
  `id_renja` int(11) NOT NULL,
  `id_renja_program` bigint(11) NOT NULL,
  `id_rkpd_renstra` int(11) DEFAULT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_visi_renstra` int(11) DEFAULT NULL,
  `id_misi_renstra` int(11) DEFAULT NULL,
  `id_tujuan_renstra` int(11) DEFAULT NULL,
  `id_sasaran_renstra` int(11) DEFAULT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `uraian_program_renstra` varchar(500) DEFAULT NULL,
  `id_kegiatan_renstra` int(11) DEFAULT NULL,
  `id_kegiatan_ref` int(11) NOT NULL,
  `uraian_kegiatan_renstra` varchar(500) DEFAULT '0',
  `pagu_tahun_renstra` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun_kegiatan` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun_selanjutnya` decimal(20,2) DEFAULT '0.00',
  `status_pelaksanaan_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 = tepat 1 = dimajukan 2 = ditunda 3 dibatalkan 4 baru',
  `pagu_musrenbang` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renja skpd 1 =  tambahan baru',
  `ket_usulan` varchar(500) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 Final',
  `status_rancangan` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum selesai 1 siap kirim ke forum',
  `kelompok_sasaran` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan_aktivitas`
--

DROP TABLE IF EXISTS `trx_renja_rancangan_aktivitas`;
CREATE TABLE `trx_renja_rancangan_aktivitas` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_aktivitas_renja` int(11) NOT NULL,
  `id_renja` int(11) NOT NULL,
  `sumber_aktivitas` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari ASB 1 Bukan ASB',
  `id_aktivitas_asb` int(11) DEFAULT NULL,
  `id_satuan_publik` int(11) DEFAULT NULL,
  `uraian_aktivitas_kegiatan` varchar(500) DEFAULT NULL,
  `tolak_ukur_aktivitas` varchar(500) DEFAULT NULL,
  `target_output_aktivitas` decimal(20,2) DEFAULT '0.00',
  `id_program_nasional` int(11) DEFAULT NULL,
  `id_program_provinsi` int(11) DEFAULT NULL,
  `jenis_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru 1 lanjutan',
  `sumber_dana` int(11) NOT NULL DEFAULT '0',
  `pagu_aktivitas` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_musren` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_rata2` decimal(20,2) DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_musren` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 = musrenbang',
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(255) DEFAULT NULL,
  `id_satuan_2` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan_belanja`
--

DROP TABLE IF EXISTS `trx_renja_rancangan_belanja`;
CREATE TABLE `trx_renja_rancangan_belanja` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_belanja_renja` int(11) NOT NULL,
  `id_lokasi_renja` int(11) NOT NULL,
  `id_zona_ssh` int(11) NOT NULL DEFAULT '0',
  `sumber_aktivitas` int(11) NOT NULL DEFAULT '0' COMMENT '1 ssh 0 asb',
  `id_aktivitas_asb` bigint(20) DEFAULT NULL,
  `id_tarif_ssh` bigint(20) NOT NULL,
  `id_rekening_ssh` int(11) NOT NULL,
  `uraian_belanja` varchar(500) DEFAULT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `harga_satuan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan_dokumen`
--

DROP TABLE IF EXISTS `trx_renja_rancangan_dokumen`;
CREATE TABLE `trx_renja_rancangan_dokumen` (
  `id_dokumen_ranwal` int(11) NOT NULL,
  `id_unit_renja` int(255) NOT NULL,
  `nomor_ranwal` varchar(255) NOT NULL,
  `tanggal_ranwal` date NOT NULL,
  `tahun_ranwal` int(11) NOT NULL COMMENT 'tahun berlakuknya perkada',
  `uraian_perkada` varchar(500) DEFAULT NULL,
  `jabatan_tandatangan` varchar(255) DEFAULT NULL,
  `nama_tandatangan` varchar(255) DEFAULT NULL,
  `nip_tandatangan` varchar(255) DEFAULT NULL,
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan_indikator`
--

DROP TABLE IF EXISTS `trx_renja_rancangan_indikator`;
CREATE TABLE `trx_renja_rancangan_indikator` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja` int(11) NOT NULL,
  `id_indikator_kegiatan_renja` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_kegiatan_renja` text,
  `tolok_ukur_indikator` text,
  `angka_tahun` decimal(20,2) DEFAULT '0.00',
  `angka_renstra` decimal(20,2) DEFAULT '0.00',
  `id_satuan_output` int(255) DEFAULT NULL,
  `status_data` int(11) DEFAULT '0' COMMENT '0 draft 1 final',
  `sumber_data` int(11) DEFAULT '0' COMMENT '0 renstra 1 tambahan'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan_kebijakan`
--

DROP TABLE IF EXISTS `trx_renja_rancangan_kebijakan`;
CREATE TABLE `trx_renja_rancangan_kebijakan` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_kebijakan_renja` int(11) NOT NULL,
  `uraian_kebijakan` varchar(500) NOT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan_lokasi`
--

DROP TABLE IF EXISTS `trx_renja_rancangan_lokasi`;
CREATE TABLE `trx_renja_rancangan_lokasi` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_pelaksana_renja` int(11) NOT NULL,
  `id_lokasi_renja` int(11) NOT NULL,
  `jenis_lokasi` int(11) NOT NULL COMMENT '0 kewilayah 1 teknis',
  `id_lokasi` int(11) NOT NULL,
  `id_kecamatan` int(11) DEFAULT NULL,
  `id_desa` int(11) DEFAULT NULL,
  `rt` int(11) DEFAULT NULL,
  `rw` int(11) DEFAULT NULL,
  `uraian_lokasi` varchar(500) DEFAULT NULL,
  `lat` varchar(500) DEFAULT NULL,
  `lang` varchar(500) DEFAULT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan_pelaksana`
--

DROP TABLE IF EXISTS `trx_renja_rancangan_pelaksana`;
CREATE TABLE `trx_renja_rancangan_pelaksana` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_pelaksana_renja` int(11) NOT NULL,
  `id_renja` int(11) NOT NULL,
  `id_aktivitas_renja` int(11) NOT NULL,
  `id_sub_unit` int(11) NOT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_pelaksanaan` int(11) DEFAULT '0',
  `ket_usul` int(11) DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `id_lokasi` int(11) NOT NULL DEFAULT '0' COMMENT 'Lokasi Penyelenggaraan Kegiatan'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan_program`
--

DROP TABLE IF EXISTS `trx_renja_rancangan_program`;
CREATE TABLE `trx_renja_rancangan_program` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja_program` bigint(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pendapatan 2 BTL',
  `id_renja_ranwal` int(11) NOT NULL DEFAULT '0',
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_program_rpjmd` int(11) DEFAULT NULL,
  `id_bidang` int(11) NOT NULL DEFAULT '0',
  `id_unit` int(11) NOT NULL,
  `id_visi_renstra` int(11) DEFAULT NULL,
  `id_misi_renstra` int(11) DEFAULT NULL,
  `id_tujuan_renstra` int(11) DEFAULT NULL,
  `id_sasaran_renstra` int(11) DEFAULT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `uraian_program_renstra` varchar(500) DEFAULT NULL,
  `id_program_ref` int(11) NOT NULL,
  `pagu_tahun_ranwal` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun_renstra` decimal(20,2) DEFAULT '0.00',
  `status_program_rkpd` int(11) DEFAULT NULL COMMENT 'status pelaksanaan unit di rkpd',
  `sumber_data_rkpd` int(11) DEFAULT NULL COMMENT 'sumber usulan pelaksana unit di rkpd',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renstra 1 = baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_usulan` varchar(250) DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `id_dokumen` int(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan_program_indikator`
--

DROP TABLE IF EXISTS `trx_renja_rancangan_program_indikator`;
CREATE TABLE `trx_renja_rancangan_program_indikator` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja_program` bigint(11) NOT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_program_renja` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program_renja` text,
  `tolok_ukur_indikator` text,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text,
  `id_satuan_output` int(255) DEFAULT NULL,
  `indikator_input` text,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan_program_ranwal`
--

DROP TABLE IF EXISTS `trx_renja_rancangan_program_ranwal`;
CREATE TABLE `trx_renja_rancangan_program_ranwal` (
  `tahun_renja` int(11) NOT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_renja_ranwal` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0',
  `id_unit` int(11) NOT NULL,
  `uraian_program_rpjmd` varchar(500) DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `jml_data` int(11) NOT NULL DEFAULT '0',
  `jml_baru` int(11) NOT NULL DEFAULT '0',
  `jml_lama` int(11) NOT NULL DEFAULT '0',
  `jml_tepat` int(11) NOT NULL DEFAULT '0',
  `jml_maju` int(11) NOT NULL DEFAULT '0',
  `jml_tunda` int(11) NOT NULL DEFAULT '0',
  `jml_batal` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_rancangan_ref_pokir`
--

DROP TABLE IF EXISTS `trx_renja_rancangan_ref_pokir`;
CREATE TABLE `trx_renja_rancangan_ref_pokir` (
  `id_aktivitas_renja` int(11) NOT NULL,
  `id_pokir_usulan` int(11) NOT NULL,
  `id_ref_pokir_renja` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_ranwal_aktivitas`
--

DROP TABLE IF EXISTS `trx_renja_ranwal_aktivitas`;
CREATE TABLE `trx_renja_ranwal_aktivitas` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_aktivitas_renja` int(11) NOT NULL,
  `id_renja` int(11) NOT NULL,
  `sumber_aktivitas` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari ASB 1 Bukan ASB',
  `id_aktivitas_asb` int(11) DEFAULT NULL,
  `id_satuan_publik` int(11) DEFAULT NULL,
  `uraian_aktivitas_kegiatan` varchar(500) DEFAULT NULL,
  `tolak_ukur_aktivitas` varchar(500) DEFAULT NULL,
  `target_output_aktivitas` decimal(20,2) DEFAULT '0.00',
  `id_program_nasional` int(11) DEFAULT NULL,
  `id_program_provinsi` int(11) DEFAULT NULL,
  `jenis_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru 1 lanjutan',
  `sumber_dana` int(11) NOT NULL DEFAULT '0',
  `pagu_aktivitas` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_musren` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_rata2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_musren` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 = musrenbang',
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(255) DEFAULT NULL,
  `id_satuan_2` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_ranwal_dokumen`
--

DROP TABLE IF EXISTS `trx_renja_ranwal_dokumen`;
CREATE TABLE `trx_renja_ranwal_dokumen` (
  `id_dokumen_ranwal` int(11) NOT NULL,
  `id_unit_renja` int(255) NOT NULL,
  `nomor_ranwal` varchar(255) NOT NULL,
  `tanggal_ranwal` date NOT NULL,
  `tahun_ranwal` int(11) NOT NULL COMMENT 'tahun berlakuknya perkada',
  `uraian_perkada` varchar(500) DEFAULT NULL,
  `jabatan_tandatangan` varchar(255) DEFAULT NULL,
  `nama_tandatangan` varchar(255) DEFAULT NULL,
  `nip_tandatangan` varchar(255) DEFAULT NULL,
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_ranwal_kegiatan`
--

DROP TABLE IF EXISTS `trx_renja_ranwal_kegiatan`;
CREATE TABLE `trx_renja_ranwal_kegiatan` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL COMMENT 'juga menunjukkan prioritas',
  `id_renja` int(11) NOT NULL,
  `id_renja_program` bigint(11) NOT NULL,
  `id_rkpd_renstra` int(11) DEFAULT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_visi_renstra` int(11) DEFAULT NULL,
  `id_misi_renstra` int(11) DEFAULT NULL,
  `id_tujuan_renstra` int(11) DEFAULT NULL,
  `id_sasaran_renstra` int(11) DEFAULT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `uraian_program_renstra` varchar(500) DEFAULT NULL,
  `id_kegiatan_renstra` int(11) DEFAULT NULL,
  `id_kegiatan_ref` int(11) NOT NULL,
  `uraian_kegiatan_renstra` varchar(500) DEFAULT '0',
  `pagu_tahun_renstra` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun_kegiatan` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun_selanjutnya` decimal(20,2) DEFAULT '0.00',
  `status_pelaksanaan_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 = tepat 1 = dimajukan 2 = ditunda 3 dibatalkan 4 baru',
  `pagu_musrenbang` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renja skpd 1 =  tambahan baru',
  `ket_usulan` varchar(500) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 Final',
  `status_rancangan` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum selesai 1 siap kirim ke forum',
  `kelompok_sasaran` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_ranwal_kegiatan_indikator`
--

DROP TABLE IF EXISTS `trx_renja_ranwal_kegiatan_indikator`;
CREATE TABLE `trx_renja_ranwal_kegiatan_indikator` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja` int(11) NOT NULL,
  `id_indikator_kegiatan_renja` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_kegiatan_renja` text,
  `tolok_ukur_indikator` text,
  `angka_tahun` decimal(20,2) DEFAULT '0.00',
  `angka_renstra` decimal(20,2) DEFAULT '0.00',
  `id_satuan_output` int(255) DEFAULT NULL,
  `status_data` int(11) DEFAULT '0' COMMENT '0 draft 1 final',
  `sumber_data` int(11) DEFAULT '0' COMMENT '0 renstra 1 tambahan'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_ranwal_pelaksana`
--

DROP TABLE IF EXISTS `trx_renja_ranwal_pelaksana`;
CREATE TABLE `trx_renja_ranwal_pelaksana` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_pelaksana_renja` int(11) NOT NULL,
  `id_renja` int(11) NOT NULL,
  `id_aktivitas_renja` int(11) NOT NULL DEFAULT '0',
  `id_sub_unit` int(11) NOT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_pelaksanaan` int(11) DEFAULT '0',
  `ket_usul` int(11) DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `id_lokasi` int(11) NOT NULL DEFAULT '0' COMMENT 'Lokasi Penyelenggaraan Kegiatan'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_ranwal_program`
--

DROP TABLE IF EXISTS `trx_renja_ranwal_program`;
CREATE TABLE `trx_renja_ranwal_program` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja_program` bigint(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pendapatan 2 BTL',
  `id_renja_ranwal` int(11) NOT NULL DEFAULT '0',
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_program_rpjmd` int(11) DEFAULT NULL,
  `id_bidang` int(11) NOT NULL DEFAULT '0',
  `id_unit` int(11) NOT NULL,
  `id_visi_renstra` int(11) DEFAULT NULL,
  `id_misi_renstra` int(11) DEFAULT NULL,
  `id_tujuan_renstra` int(11) DEFAULT NULL,
  `id_sasaran_renstra` int(11) DEFAULT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `uraian_program_renstra` varchar(500) DEFAULT NULL,
  `id_program_ref` int(11) NOT NULL,
  `pagu_tahun_ranwal` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun_renstra` decimal(20,2) DEFAULT '0.00',
  `status_program_rkpd` int(11) DEFAULT NULL COMMENT 'status pelaksanaan unit di rkpd',
  `sumber_data_rkpd` int(11) DEFAULT NULL COMMENT 'sumber usulan pelaksana unit di rkpd',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renstra 1 = baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_usulan` varchar(250) DEFAULT '0',
  `id_dokumen` int(255) NOT NULL DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_ranwal_program_indikator`
--

DROP TABLE IF EXISTS `trx_renja_ranwal_program_indikator`;
CREATE TABLE `trx_renja_ranwal_program_indikator` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renja_program` bigint(11) NOT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_program_renja` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program_renja` text,
  `tolok_ukur_indikator` text,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `indikator_output` text,
  `id_satuan_output` int(255) DEFAULT NULL,
  `indikator_input` text,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renja_ranwal_program_rkpd`
--

DROP TABLE IF EXISTS `trx_renja_ranwal_program_rkpd`;
CREATE TABLE `trx_renja_ranwal_program_rkpd` (
  `tahun_renja` int(11) NOT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_renja_ranwal` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0',
  `id_unit` int(11) NOT NULL,
  `uraian_program_rpjmd` varchar(500) DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `jml_data` int(11) NOT NULL DEFAULT '0',
  `jml_baru` int(11) NOT NULL DEFAULT '0',
  `jml_lama` int(11) NOT NULL DEFAULT '0',
  `jml_tepat` int(11) NOT NULL DEFAULT '0',
  `jml_maju` int(11) NOT NULL DEFAULT '0',
  `jml_tunda` int(11) NOT NULL DEFAULT '0',
  `jml_batal` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_dokumen`
--

DROP TABLE IF EXISTS `trx_renstra_dokumen`;
CREATE TABLE `trx_renstra_dokumen` (
  `id_rpjmd` int(11) NOT NULL,
  `id_renstra` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `nomor_renstra` varchar(255) DEFAULT NULL,
  `tanggal_renstra` date DEFAULT NULL,
  `uraian_renstra` varchar(500) DEFAULT NULL,
  `nm_pimpinan` varchar(255) DEFAULT NULL,
  `nip_pimpinan` varchar(255) DEFAULT NULL,
  `jabatan_pimpinan` varchar(255) DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_kebijakan`
--

DROP TABLE IF EXISTS `trx_renstra_kebijakan`;
CREATE TABLE `trx_renstra_kebijakan` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_kebijakan_renstra` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `uraian_kebijakan_renstra` varchar(500) DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_kegiatan`
--

DROP TABLE IF EXISTS `trx_renstra_kegiatan`;
CREATE TABLE `trx_renstra_kegiatan` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_program_renstra` int(11) NOT NULL,
  `id_kegiatan_renstra` int(11) NOT NULL,
  `id_kegiatan_ref` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL,
  `uraian_kegiatan_renstra` varchar(255) DEFAULT NULL,
  `uraian_sasaran_kegiatan` varchar(500) DEFAULT NULL,
  `pagu_tahun1` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun2` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun3` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun4` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun5` decimal(20,2) DEFAULT '0.00',
  `total_pagu` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_kegiatan_indikator`
--

DROP TABLE IF EXISTS `trx_renstra_kegiatan_indikator`;
CREATE TABLE `trx_renstra_kegiatan_indikator` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_kegiatan_renstra` int(11) NOT NULL,
  `id_indikator_kegiatan_renstra` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_kegiatan_renstra` varchar(255) DEFAULT NULL,
  `tolok_ukur_indikator` varchar(255) DEFAULT NULL,
  `angka_awal_periode` decimal(20,2) DEFAULT '0.00',
  `angka_tahun1` decimal(20,2) DEFAULT '0.00',
  `angka_tahun2` decimal(20,2) DEFAULT '0.00',
  `angka_tahun3` decimal(20,2) DEFAULT '0.00',
  `angka_tahun4` decimal(20,2) DEFAULT '0.00',
  `angka_tahun5` decimal(20,2) DEFAULT '0.00',
  `angka_akhir_periode` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_kegiatan_pelaksana`
--

DROP TABLE IF EXISTS `trx_renstra_kegiatan_pelaksana`;
CREATE TABLE `trx_renstra_kegiatan_pelaksana` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_kegiatan_renstra_pelaksana` int(11) NOT NULL,
  `id_kegiatan_renstra` int(255) NOT NULL,
  `id_perubahan` int(11) NOT NULL,
  `id_sub_unit` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_misi`
--

DROP TABLE IF EXISTS `trx_renstra_misi`;
CREATE TABLE `trx_renstra_misi` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_visi_renstra` int(11) NOT NULL,
  `id_misi_renstra` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL,
  `uraian_misi_renstra` varchar(255) NOT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_program`
--

DROP TABLE IF EXISTS `trx_renstra_program`;
CREATE TABLE `trx_renstra_program` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_program_renstra` int(11) NOT NULL,
  `id_program_rpjmd` int(11) NOT NULL,
  `id_program_ref` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL,
  `uraian_program_renstra` varchar(255) DEFAULT NULL,
  `uraian_sasaran_program` varchar(500) DEFAULT NULL,
  `pagu_tahun1` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun2` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun3` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun4` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun5` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_program_indikator`
--

DROP TABLE IF EXISTS `trx_renstra_program_indikator`;
CREATE TABLE `trx_renstra_program_indikator` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_program_renstra` int(11) NOT NULL,
  `id_indikator_sasaran_renstra` int(11) NOT NULL DEFAULT '0',
  `id_indikator_program_renstra` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program_renstra` varchar(255) DEFAULT NULL,
  `tolok_ukur_indikator` varchar(255) DEFAULT NULL,
  `angka_awal_periode` decimal(20,2) DEFAULT '0.00',
  `angka_tahun1` decimal(20,2) DEFAULT '0.00',
  `angka_tahun2` decimal(20,2) DEFAULT '0.00',
  `angka_tahun3` decimal(20,2) DEFAULT '0.00',
  `angka_tahun4` decimal(20,2) DEFAULT '0.00',
  `angka_tahun5` decimal(20,2) DEFAULT '0.00',
  `angka_akhir_periode` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_sasaran`
--

DROP TABLE IF EXISTS `trx_renstra_sasaran`;
CREATE TABLE `trx_renstra_sasaran` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_tujuan_renstra` int(11) NOT NULL,
  `id_sasaran_rpjmd` int(11) NOT NULL DEFAULT '0',
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL,
  `uraian_sasaran_renstra` varchar(255) DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_sasaran_indikator`
--

DROP TABLE IF EXISTS `trx_renstra_sasaran_indikator`;
CREATE TABLE `trx_renstra_sasaran_indikator` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_indikator_sasaran_rpjmd` int(11) NOT NULL DEFAULT '0',
  `id_indikator_sasaran_renstra` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_sasaran_renstra` varchar(500) DEFAULT NULL,
  `tolok_ukur_indikator` varchar(500) DEFAULT NULL,
  `angka_awal_periode` decimal(20,2) DEFAULT '0.00',
  `angka_tahun1` decimal(20,2) DEFAULT '0.00',
  `angka_tahun2` decimal(20,2) DEFAULT '0.00',
  `angka_tahun3` decimal(20,2) DEFAULT '0.00',
  `angka_tahun4` decimal(20,2) DEFAULT '0.00',
  `angka_tahun5` decimal(20,2) DEFAULT '0.00',
  `angka_akhir_periode` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_strategi`
--

DROP TABLE IF EXISTS `trx_renstra_strategi`;
CREATE TABLE `trx_renstra_strategi` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_strategi_renstra` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `uraian_strategi_renstra` varchar(500) DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_tujuan`
--

DROP TABLE IF EXISTS `trx_renstra_tujuan`;
CREATE TABLE `trx_renstra_tujuan` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_misi_renstra` int(11) NOT NULL,
  `id_tujuan_renstra` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL,
  `uraian_tujuan_renstra` varchar(255) NOT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_tujuan_indikator`
--

DROP TABLE IF EXISTS `trx_renstra_tujuan_indikator`;
CREATE TABLE `trx_renstra_tujuan_indikator` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_tujuan_renstra` int(11) NOT NULL,
  `id_indikator_tujuan_renstra` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_sasaran_renstra` varchar(500) DEFAULT NULL,
  `tolok_ukur_indikator` varchar(500) DEFAULT NULL,
  `angka_awal_periode` decimal(20,2) DEFAULT '0.00',
  `angka_tahun1` decimal(20,2) DEFAULT '0.00',
  `angka_tahun2` decimal(20,2) DEFAULT '0.00',
  `angka_tahun3` decimal(20,2) DEFAULT '0.00',
  `angka_tahun4` decimal(20,2) DEFAULT '0.00',
  `angka_tahun5` decimal(20,2) DEFAULT '0.00',
  `angka_akhir_periode` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_renstra_visi`
--

DROP TABLE IF EXISTS `trx_renstra_visi`;
CREATE TABLE `trx_renstra_visi` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_renstra` int(11) NOT NULL DEFAULT '1',
  `id_visi_renstra` int(11) NOT NULL COMMENT 'berisi id khusus untuk setiap visi pada periode yang sama',
  `id_unit` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL DEFAULT '0',
  `thn_awal_renstra` int(11) NOT NULL,
  `thn_akhir_renstra` int(11) NOT NULL,
  `uraian_visi_renstra` varchar(255) NOT NULL,
  `id_status_dokumen` int(11) NOT NULL DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final`
--

DROP TABLE IF EXISTS `trx_rkpd_final`;
CREATE TABLE `trx_rkpd_final` (
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL COMMENT '0 baru',
  `id_forum_rkpdprog` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru',
  `no_urut` int(11) NOT NULL,
  `tahun_rkpd` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pendapatan 2 BTL',
  `id_rkpd_rpjmd` int(11) DEFAULT NULL,
  `thn_id_rpjmd` int(11) DEFAULT NULL,
  `id_visi_rpjmd` int(11) DEFAULT NULL,
  `id_misi_rpjmd` int(11) DEFAULT NULL,
  `id_tujuan_rpjmd` int(11) DEFAULT NULL,
  `id_sasaran_rpjmd` int(11) DEFAULT NULL,
  `id_program_rpjmd` int(11) DEFAULT NULL,
  `uraian_program_rpjmd` varchar(500) DEFAULT NULL,
  `pagu_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_ranwal` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_program` varchar(500) DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL COMMENT '0 = data tepat waktu sesuai renstra/rpjmd\\r\\n1 = data pergeseran waktu renstra/rpjmd\\r\\n2 = data baru yang belum ada di renstra/rpjmd\\r\\n9 = dibatalkan pelaksanaanya\\r\\n8 = ditunda dilaksanakan\\r\\n',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Draft 1 = Posting Renja 2 = Posting Musren',
  `ket_usulan` varchar(500) DEFAULT NULL COMMENT 'Keterangan / alasan status usulan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = RPJMD 1 = Baru 2 = Luncuran tahun sebelumnya',
  `id_dokumen` int(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_aktivitas_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_final_aktivitas_pd`;
CREATE TABLE `trx_rkpd_final_aktivitas_pd` (
  `id_aktivitas_pd` bigint(11) NOT NULL,
  `id_pelaksana_pd` bigint(20) NOT NULL,
  `id_aktivitas_forum` int(11) NOT NULL DEFAULT '0',
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `sumber_aktivitas` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari ASB 1 Bukan ASB',
  `id_aktivitas_asb` int(11) DEFAULT '0',
  `id_aktivitas_renja` int(11) DEFAULT '0',
  `uraian_aktivitas_kegiatan` varchar(500) DEFAULT NULL,
  `volume_aktivitas_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_forum_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `volume_aktivitas_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_forum_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `id_program_nasional` int(11) DEFAULT NULL,
  `id_program_provinsi` int(11) DEFAULT NULL,
  `jenis_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru 1 lanjutan',
  `sumber_dana` int(11) NOT NULL DEFAULT '0',
  `pagu_aktivitas_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_aktivitas_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_musren` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal',
  `keterangan_aktivitas` varchar(500) DEFAULT '0',
  `status_musren` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 = musrenbang',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renja 1 tambahan baru',
  `id_satuan_publik` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_belanja_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_final_belanja_pd`;
CREATE TABLE `trx_rkpd_final_belanja_pd` (
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_belanja_pd` bigint(20) NOT NULL,
  `id_aktivitas_pd` bigint(20) NOT NULL,
  `id_belanja_forum` int(11) NOT NULL DEFAULT '0',
  `id_zona_ssh` int(11) NOT NULL,
  `id_belanja_renja` int(11) NOT NULL DEFAULT '0',
  `sumber_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 asb 1 ssh',
  `id_aktivitas_asb` int(11) NOT NULL,
  `id_item_ssh` bigint(20) NOT NULL,
  `id_rekening_ssh` int(11) NOT NULL,
  `uraian_belanja` varchar(500) DEFAULT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL,
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '1',
  `harga_satuan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1_forum` int(11) NOT NULL,
  `volume_2_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2_forum` int(11) NOT NULL DEFAULT '1',
  `harga_satuan_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_dokumen`
--

DROP TABLE IF EXISTS `trx_rkpd_final_dokumen`;
CREATE TABLE `trx_rkpd_final_dokumen` (
  `id_dokumen_rkpd` int(11) NOT NULL,
  `nomor_rkpd` varchar(255) NOT NULL,
  `tanggal_rkpd` date NOT NULL,
  `tahun_rkpd` int(11) NOT NULL COMMENT 'tahun perencanaan',
  `uraian_perkada` varchar(500) DEFAULT NULL,
  `id_unit_perencana` int(11) DEFAULT NULL,
  `jabatan_tandatangan` varchar(255) DEFAULT NULL,
  `nama_tandatangan` varchar(255) DEFAULT NULL,
  `nip_tandatangan` varchar(255) DEFAULT NULL,
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif',
  `id_log` int(11) NOT NULL,
  `uraian_log` varchar(6) NOT NULL,
  `log_perubahan` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_indikator`
--

DROP TABLE IF EXISTS `trx_rkpd_final_indikator`;
CREATE TABLE `trx_rkpd_final_indikator` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_indikator_program_rkpd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_indikator_rkpd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program_rkpd` text,
  `tolok_ukur_indikator` text,
  `target_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `indikator_input` text,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `indikator_output` text,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum direviu 1 sudah direviu',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 data rpjmd 1 data baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_kebijakan`
--

DROP TABLE IF EXISTS `trx_rkpd_final_kebijakan`;
CREATE TABLE `trx_rkpd_final_kebijakan` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_kebijakan_rancangan` int(11) NOT NULL,
  `id_kebijakan_rkpd` int(11) NOT NULL,
  `uraian_kebijakan` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_kebijakan_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_final_kebijakan_pd`;
CREATE TABLE `trx_rkpd_final_kebijakan_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_kebijakan_pd` int(11) NOT NULL,
  `uraian_kebijakan` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_kegiatan_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_final_kegiatan_pd`;
CREATE TABLE `trx_rkpd_final_kegiatan_pd` (
  `id_kegiatan_pd` bigint(20) NOT NULL,
  `id_program_pd` bigint(20) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_forum_skpd` int(11) DEFAULT NULL,
  `id_renja` int(11) DEFAULT '0',
  `id_rkpd_renstra` int(11) DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT '0',
  `id_kegiatan_renstra` int(11) DEFAULT '0',
  `id_kegiatan_ref` int(11) NOT NULL,
  `uraian_kegiatan_forum` varchar(500) DEFAULT NULL,
  `pagu_tahun_kegiatan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_kegiatan_renstra` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_plus1_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_plus1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_status` varchar(500) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 =  musrenbang',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal dilaksanakan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari renja 1 baru tambahan',
  `kelompok_sasaran` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_keg_indikator_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_final_keg_indikator_pd`;
CREATE TABLE `trx_rkpd_final_keg_indikator_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_kegiatan_pd` bigint(11) NOT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_kegiatan` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_kegiatan` text,
  `tolok_ukur_indikator` text,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `indikator_input` text,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_lokasi_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_final_lokasi_pd`;
CREATE TABLE `trx_rkpd_final_lokasi_pd` (
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_aktivitas_pd` bigint(20) NOT NULL,
  `id_lokasi_forum` int(11) NOT NULL DEFAULT '0' COMMENT '0',
  `id_lokasi_pd` bigint(20) NOT NULL,
  `id_lokasi` int(11) NOT NULL,
  `id_lokasi_renja` int(11) DEFAULT '0',
  `id_lokasi_teknis` int(11) DEFAULT NULL,
  `jenis_lokasi` int(11) NOT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_usulan_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_usulan_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `id_desa` int(11) DEFAULT '0',
  `id_kecamatan` int(11) DEFAULT '0',
  `rt` int(11) DEFAULT '0',
  `rw` int(11) DEFAULT '0',
  `uraian_lokasi` varchar(500) DEFAULT NULL,
  `lat` varchar(500) DEFAULT NULL,
  `lang` varchar(500) DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_lokasi` varchar(500) DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 renja 1 tambahan 2 musrenbang 3 pokir'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_pelaksana`
--

DROP TABLE IF EXISTS `trx_rkpd_final_pelaksana`;
CREATE TABLE `trx_rkpd_final_pelaksana` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_pelaksana_rkpd` int(11) NOT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_urusan_rkpd` int(11) NOT NULL,
  `id_pelaksana_rpjmd` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `pagu_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `hak_akses` int(11) NOT NULL DEFAULT '0' COMMENT '0 tidak dapat menambah data 1 dapat menambah data',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rpjmd 1 baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 dibatalkan',
  `ket_pelaksanaan` varchar(500) DEFAULT NULL COMMENT 'menjelaskan status pelaksanaan',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum direviu 1 sudah direviu'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_pelaksana_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_final_pelaksana_pd`;
CREATE TABLE `trx_rkpd_final_pelaksana_pd` (
  `id_pelaksana_pd` bigint(20) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_kegiatan_pd` bigint(11) NOT NULL,
  `id_pelaksana_forum` int(11) DEFAULT NULL,
  `id_sub_unit` int(11) NOT NULL,
  `id_pelaksana_renja` int(11) DEFAULT '0',
  `id_lokasi` int(11) DEFAULT '0' COMMENT 'lokasi penyelenggaraan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 renja 1 tambahan',
  `ket_pelaksana` varchar(500) DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal 2 baru',
  `status_data` int(11) NOT NULL COMMENT '0 draft 1 final'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_program_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_final_program_pd`;
CREATE TABLE `trx_rkpd_final_program_pd` (
  `id_program_pd` bigint(11) NOT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pdt 2 BTL',
  `no_urut` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_forum_program` int(11) DEFAULT NULL,
  `id_renja_program` int(11) DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT '0',
  `uraian_program_renstra` varchar(500) DEFAULT NULL,
  `id_program_ref` int(11) NOT NULL,
  `pagu_tahun_renstra` decimal(20,2) DEFAULT '0.00',
  `pagu_forum` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renstra 1 = baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_usulan` varchar(250) DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `id_dokumen` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_prog_indikator_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_final_prog_indikator_pd`;
CREATE TABLE `trx_rkpd_final_prog_indikator_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_program_pd` bigint(11) NOT NULL,
  `id_program_forum` int(11) NOT NULL DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_program` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program` text,
  `tolok_ukur_indikator` text,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `indikator_input` text,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_final_urusan`
--

DROP TABLE IF EXISTS `trx_rkpd_final_urusan`;
CREATE TABLE `trx_rkpd_final_urusan` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) DEFAULT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_urusan_rkpd` int(11) NOT NULL,
  `id_bidang` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rpjmd 1 baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan`;
CREATE TABLE `trx_rkpd_rancangan` (
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL COMMENT '0 baru',
  `id_forum_rkpdprog` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru',
  `no_urut` int(11) NOT NULL,
  `tahun_rkpd` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pendapatan 2 BTL',
  `id_rkpd_rpjmd` int(11) DEFAULT NULL,
  `thn_id_rpjmd` int(11) DEFAULT NULL,
  `id_visi_rpjmd` int(11) DEFAULT NULL,
  `id_misi_rpjmd` int(11) DEFAULT NULL,
  `id_tujuan_rpjmd` int(11) DEFAULT NULL,
  `id_sasaran_rpjmd` int(11) DEFAULT NULL,
  `id_program_rpjmd` int(11) DEFAULT NULL,
  `uraian_program_rpjmd` varchar(500) DEFAULT NULL,
  `pagu_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_ranwal` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_program` varchar(500) DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL COMMENT '0 = data tepat waktu sesuai renstra/rpjmd\\r\\n1 = data pergeseran waktu renstra/rpjmd\\r\\n2 = data baru yang belum ada di renstra/rpjmd\\r\\n9 = dibatalkan pelaksanaanya\\r\\n8 = ditunda dilaksanakan\\r\\n',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Draft 1 = Posting Renja 2 = Posting Musren',
  `ket_usulan` varchar(500) DEFAULT NULL COMMENT 'Keterangan / alasan status usulan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = RPJMD 1 = Baru 2 = Luncuran tahun sebelumnya',
  `id_dokumen` int(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_aktivitas_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_aktivitas_pd`;
CREATE TABLE `trx_rkpd_rancangan_aktivitas_pd` (
  `id_aktivitas_pd` bigint(11) NOT NULL,
  `id_pelaksana_pd` bigint(20) NOT NULL,
  `id_aktivitas_forum` int(11) NOT NULL DEFAULT '0',
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `sumber_aktivitas` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari ASB 1 Bukan ASB',
  `id_aktivitas_asb` int(11) DEFAULT '0',
  `id_aktivitas_renja` int(11) DEFAULT '0',
  `uraian_aktivitas_kegiatan` varchar(500) DEFAULT NULL,
  `volume_aktivitas_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_forum_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `volume_aktivitas_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_forum_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `id_program_nasional` int(11) DEFAULT NULL,
  `id_program_provinsi` int(11) DEFAULT NULL,
  `jenis_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru 1 lanjutan',
  `sumber_dana` int(11) NOT NULL DEFAULT '0',
  `pagu_aktivitas_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_aktivitas_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_musren` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal',
  `keterangan_aktivitas` varchar(500) DEFAULT '0',
  `status_musren` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 = musrenbang',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renja 1 tambahan baru',
  `id_satuan_publik` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_belanja_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_belanja_pd`;
CREATE TABLE `trx_rkpd_rancangan_belanja_pd` (
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_belanja_pd` bigint(20) NOT NULL,
  `id_aktivitas_pd` bigint(20) NOT NULL,
  `id_belanja_forum` int(11) NOT NULL DEFAULT '0',
  `id_zona_ssh` int(11) NOT NULL,
  `id_belanja_renja` int(11) NOT NULL DEFAULT '0',
  `sumber_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 asb 1 ssh',
  `id_aktivitas_asb` int(11) NOT NULL,
  `id_item_ssh` bigint(20) NOT NULL,
  `id_rekening_ssh` int(11) NOT NULL,
  `uraian_belanja` varchar(500) DEFAULT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL,
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '1',
  `harga_satuan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1_forum` int(11) NOT NULL,
  `volume_2_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2_forum` int(11) NOT NULL DEFAULT '1',
  `harga_satuan_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_dokumen`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_dokumen`;
CREATE TABLE `trx_rkpd_rancangan_dokumen` (
  `id_dokumen_rkpd` int(11) NOT NULL,
  `nomor_rkpd` varchar(255) NOT NULL,
  `tanggal_rkpd` date NOT NULL,
  `tahun_rkpd` int(11) NOT NULL COMMENT 'tahun perencanaan',
  `uraian_perkada` varchar(500) DEFAULT NULL,
  `id_unit_perencana` int(11) DEFAULT NULL,
  `jabatan_tandatangan` varchar(255) DEFAULT NULL,
  `nama_tandatangan` varchar(255) DEFAULT NULL,
  `nip_tandatangan` varchar(255) DEFAULT NULL,
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_indikator`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_indikator`;
CREATE TABLE `trx_rkpd_rancangan_indikator` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_indikator_program_rkpd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_indikator_rkpd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program_rkpd` text,
  `tolok_ukur_indikator` text,
  `target_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `indikator_input` text,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `indikator_output` text,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum direviu 1 sudah direviu',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 data rpjmd 1 data baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_kebijakan`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_kebijakan`;
CREATE TABLE `trx_rkpd_rancangan_kebijakan` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_kebijakan_rancangan` int(11) NOT NULL,
  `id_kebijakan_rkpd` int(11) NOT NULL,
  `uraian_kebijakan` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_kebijakan_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_kebijakan_pd`;
CREATE TABLE `trx_rkpd_rancangan_kebijakan_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_kebijakan_pd` int(11) NOT NULL,
  `uraian_kebijakan` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_kegiatan_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_kegiatan_pd`;
CREATE TABLE `trx_rkpd_rancangan_kegiatan_pd` (
  `id_kegiatan_pd` bigint(20) NOT NULL,
  `id_program_pd` bigint(20) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_forum_skpd` int(11) DEFAULT NULL,
  `id_renja` int(11) DEFAULT '0',
  `id_rkpd_renstra` int(11) DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT '0',
  `id_kegiatan_renstra` int(11) DEFAULT '0',
  `id_kegiatan_ref` int(11) NOT NULL,
  `uraian_kegiatan_forum` varchar(500) DEFAULT NULL,
  `pagu_tahun_kegiatan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_kegiatan_renstra` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_plus1_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_plus1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_status` varchar(500) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 =  musrenbang',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal dilaksanakan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari renja 1 baru tambahan',
  `kelompok_sasaran` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_keg_indikator_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_keg_indikator_pd`;
CREATE TABLE `trx_rkpd_rancangan_keg_indikator_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_kegiatan_pd` bigint(11) NOT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_kegiatan` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_kegiatan` text,
  `tolok_ukur_indikator` text,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `indikator_input` text,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_lokasi_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_lokasi_pd`;
CREATE TABLE `trx_rkpd_rancangan_lokasi_pd` (
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_aktivitas_pd` bigint(20) NOT NULL,
  `id_lokasi_forum` int(11) NOT NULL DEFAULT '0' COMMENT '0',
  `id_lokasi_pd` bigint(20) NOT NULL,
  `id_lokasi` int(11) NOT NULL,
  `id_lokasi_renja` int(11) DEFAULT '0',
  `id_lokasi_teknis` int(11) DEFAULT NULL,
  `jenis_lokasi` int(11) NOT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_usulan_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_usulan_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `id_desa` int(11) DEFAULT '0',
  `id_kecamatan` int(11) DEFAULT '0',
  `rt` int(11) DEFAULT '0',
  `rw` int(11) DEFAULT '0',
  `uraian_lokasi` varchar(500) DEFAULT NULL,
  `lat` varchar(500) DEFAULT NULL,
  `lang` varchar(500) DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_lokasi` varchar(500) DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 renja 1 tambahan 2 musrenbang 3 pokir'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_pelaksana`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_pelaksana`;
CREATE TABLE `trx_rkpd_rancangan_pelaksana` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_pelaksana_rkpd` int(11) NOT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_urusan_rkpd` int(11) NOT NULL,
  `id_pelaksana_rpjmd` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `pagu_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `hak_akses` int(11) NOT NULL DEFAULT '0' COMMENT '0 tidak dapat menambah data 1 dapat menambah data',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rpjmd 1 baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 dibatalkan',
  `ket_pelaksanaan` varchar(500) DEFAULT NULL COMMENT 'menjelaskan status pelaksanaan',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum direviu 1 sudah direviu'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_pelaksana_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_pelaksana_pd`;
CREATE TABLE `trx_rkpd_rancangan_pelaksana_pd` (
  `id_pelaksana_pd` bigint(20) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_kegiatan_pd` bigint(11) NOT NULL,
  `id_pelaksana_forum` int(11) DEFAULT NULL,
  `id_sub_unit` int(11) NOT NULL,
  `id_pelaksana_renja` int(11) DEFAULT '0',
  `id_lokasi` int(11) DEFAULT '0' COMMENT 'lokasi penyelenggaraan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 renja 1 tambahan',
  `ket_pelaksana` varchar(500) DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal 2 baru',
  `status_data` int(11) NOT NULL COMMENT '0 draft 1 final'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_program_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_program_pd`;
CREATE TABLE `trx_rkpd_rancangan_program_pd` (
  `id_program_pd` bigint(11) NOT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pdt 2 BTL',
  `no_urut` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_forum_program` int(11) DEFAULT NULL,
  `id_renja_program` int(11) DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT '0',
  `uraian_program_renstra` varchar(500) DEFAULT NULL,
  `id_program_ref` int(11) NOT NULL,
  `pagu_tahun_renstra` decimal(20,2) DEFAULT '0.00',
  `pagu_forum` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renstra 1 = baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_usulan` varchar(250) DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `id_dokumen` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_prog_indikator_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_prog_indikator_pd`;
CREATE TABLE `trx_rkpd_rancangan_prog_indikator_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_program_pd` bigint(11) NOT NULL,
  `id_program_forum` int(11) NOT NULL DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_program` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program` text,
  `tolok_ukur_indikator` text,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `indikator_input` text,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rancangan_urusan`
--

DROP TABLE IF EXISTS `trx_rkpd_rancangan_urusan`;
CREATE TABLE `trx_rkpd_rancangan_urusan` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) DEFAULT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_urusan_rkpd` int(11) NOT NULL,
  `id_bidang` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rpjmd 1 baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir`;
CREATE TABLE `trx_rkpd_ranhir` (
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL COMMENT '0 baru',
  `id_forum_rkpdprog` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru',
  `no_urut` int(11) NOT NULL,
  `tahun_rkpd` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pendapatan 2 BTL',
  `id_rkpd_rpjmd` int(11) DEFAULT NULL,
  `thn_id_rpjmd` int(11) DEFAULT NULL,
  `id_visi_rpjmd` int(11) DEFAULT NULL,
  `id_misi_rpjmd` int(11) DEFAULT NULL,
  `id_tujuan_rpjmd` int(11) DEFAULT NULL,
  `id_sasaran_rpjmd` int(11) DEFAULT NULL,
  `id_program_rpjmd` int(11) DEFAULT NULL,
  `uraian_program_rpjmd` varchar(500) DEFAULT NULL,
  `pagu_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_ranwal` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_program` varchar(500) DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL COMMENT '0 = data tepat waktu sesuai renstra/rpjmd\\r\\n1 = data pergeseran waktu renstra/rpjmd\\r\\n2 = data baru yang belum ada di renstra/rpjmd\\r\\n9 = dibatalkan pelaksanaanya\\r\\n8 = ditunda dilaksanakan\\r\\n',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Draft 1 = Posting Renja 2 = Posting Musren',
  `ket_usulan` varchar(500) DEFAULT NULL COMMENT 'Keterangan / alasan status usulan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = RPJMD 1 = Baru 2 = Luncuran tahun sebelumnya',
  `id_dokumen` int(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_aktivitas_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_aktivitas_pd`;
CREATE TABLE `trx_rkpd_ranhir_aktivitas_pd` (
  `id_aktivitas_pd` bigint(11) NOT NULL,
  `id_pelaksana_pd` bigint(20) NOT NULL,
  `id_aktivitas_forum` int(11) NOT NULL DEFAULT '0',
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `sumber_aktivitas` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari ASB 1 Bukan ASB',
  `id_aktivitas_asb` int(11) DEFAULT '0',
  `id_aktivitas_renja` int(11) DEFAULT '0',
  `uraian_aktivitas_kegiatan` varchar(500) DEFAULT NULL,
  `volume_aktivitas_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_forum_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `volume_aktivitas_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_forum_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `id_program_nasional` int(11) DEFAULT NULL,
  `id_program_provinsi` int(11) DEFAULT NULL,
  `jenis_kegiatan` int(11) NOT NULL DEFAULT '0' COMMENT '0 baru 1 lanjutan',
  `sumber_dana` int(11) NOT NULL DEFAULT '0',
  `pagu_aktivitas_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_aktivitas_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_musren` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 final',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal',
  `keterangan_aktivitas` varchar(500) DEFAULT '0',
  `status_musren` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 = musrenbang',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renja 1 tambahan baru',
  `id_satuan_publik` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_belanja_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_belanja_pd`;
CREATE TABLE `trx_rkpd_ranhir_belanja_pd` (
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_belanja_pd` bigint(20) NOT NULL,
  `id_aktivitas_pd` bigint(20) NOT NULL,
  `id_belanja_forum` int(11) NOT NULL DEFAULT '0',
  `id_zona_ssh` int(11) NOT NULL,
  `id_belanja_renja` int(11) NOT NULL DEFAULT '0',
  `sumber_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 asb 1 ssh',
  `id_aktivitas_asb` int(11) NOT NULL,
  `id_item_ssh` bigint(20) NOT NULL,
  `id_rekening_ssh` int(11) NOT NULL,
  `uraian_belanja` varchar(500) DEFAULT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL,
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2` int(11) NOT NULL DEFAULT '1',
  `harga_satuan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1_forum` int(11) NOT NULL,
  `volume_2_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_2_forum` int(11) NOT NULL DEFAULT '1',
  `harga_satuan_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `jml_belanja_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `status_data` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_dokumen`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_dokumen`;
CREATE TABLE `trx_rkpd_ranhir_dokumen` (
  `id_dokumen_rkpd` int(11) NOT NULL,
  `nomor_rkpd` varchar(255) NOT NULL,
  `tanggal_rkpd` date NOT NULL,
  `tahun_rkpd` int(11) NOT NULL COMMENT 'tahun perencanaan',
  `uraian_perkada` varchar(500) DEFAULT NULL,
  `id_unit_perencana` int(11) DEFAULT NULL,
  `jabatan_tandatangan` varchar(255) DEFAULT NULL,
  `nama_tandatangan` varchar(255) DEFAULT NULL,
  `nip_tandatangan` varchar(255) DEFAULT NULL,
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_indikator`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_indikator`;
CREATE TABLE `trx_rkpd_ranhir_indikator` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_indikator_program_rkpd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_indikator_rkpd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program_rkpd` text,
  `tolok_ukur_indikator` text,
  `target_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `indikator_input` text,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `indikator_output` text,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum direviu 1 sudah direviu',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 data rpjmd 1 data baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_kebijakan`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_kebijakan`;
CREATE TABLE `trx_rkpd_ranhir_kebijakan` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_kebijakan_rancangan` int(11) NOT NULL,
  `id_kebijakan_rkpd` int(11) NOT NULL,
  `uraian_kebijakan` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_kebijakan_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_kebijakan_pd`;
CREATE TABLE `trx_rkpd_ranhir_kebijakan_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `id_kebijakan_pd` int(11) NOT NULL,
  `uraian_kebijakan` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_kegiatan_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_kegiatan_pd`;
CREATE TABLE `trx_rkpd_ranhir_kegiatan_pd` (
  `id_kegiatan_pd` bigint(20) NOT NULL,
  `id_program_pd` bigint(20) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_forum_skpd` int(11) DEFAULT NULL,
  `id_renja` int(11) DEFAULT '0',
  `id_rkpd_renstra` int(11) DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT '0',
  `id_kegiatan_renstra` int(11) DEFAULT '0',
  `id_kegiatan_ref` int(11) NOT NULL,
  `uraian_kegiatan_forum` varchar(500) DEFAULT NULL,
  `pagu_tahun_kegiatan` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_kegiatan_renstra` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_plus1_renja` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_plus1_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_forum` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_status` varchar(500) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = non musrenbang 1 =  musrenbang',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal dilaksanakan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 dari renja 1 baru tambahan',
  `kelompok_sasaran` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_keg_indikator_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_keg_indikator_pd`;
CREATE TABLE `trx_rkpd_ranhir_keg_indikator_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_kegiatan_pd` bigint(11) NOT NULL,
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_kegiatan` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_kegiatan` text,
  `tolok_ukur_indikator` text,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `indikator_input` text,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_lokasi_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_lokasi_pd`;
CREATE TABLE `trx_rkpd_ranhir_lokasi_pd` (
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_aktivitas_pd` bigint(20) NOT NULL,
  `id_lokasi_forum` int(11) NOT NULL DEFAULT '0' COMMENT '0',
  `id_lokasi_pd` bigint(20) NOT NULL,
  `id_lokasi` int(11) NOT NULL,
  `id_lokasi_renja` int(11) DEFAULT '0',
  `id_lokasi_teknis` int(11) DEFAULT NULL,
  `jenis_lokasi` int(11) NOT NULL,
  `volume_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_usulan_1` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `volume_usulan_2` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_1` int(11) NOT NULL DEFAULT '0',
  `id_satuan_2` int(11) NOT NULL DEFAULT '0',
  `id_desa` int(11) DEFAULT '0',
  `id_kecamatan` int(11) DEFAULT '0',
  `rt` int(11) DEFAULT '0',
  `rw` int(11) DEFAULT '0',
  `uraian_lokasi` varchar(500) DEFAULT NULL,
  `lat` varchar(500) DEFAULT NULL,
  `lang` varchar(500) DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_lokasi` varchar(500) DEFAULT '0',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 renja 1 tambahan 2 musrenbang 3 pokir'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_pelaksana`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_pelaksana`;
CREATE TABLE `trx_rkpd_ranhir_pelaksana` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_pelaksana_rkpd` int(11) NOT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_urusan_rkpd` int(11) NOT NULL,
  `id_pelaksana_rpjmd` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `pagu_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `hak_akses` int(11) NOT NULL DEFAULT '0' COMMENT '0 tidak dapat menambah data 1 dapat menambah data',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rpjmd 1 baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 dibatalkan',
  `ket_pelaksanaan` varchar(500) DEFAULT NULL COMMENT 'menjelaskan status pelaksanaan',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum direviu 1 sudah direviu'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_pelaksana_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_pelaksana_pd`;
CREATE TABLE `trx_rkpd_ranhir_pelaksana_pd` (
  `id_pelaksana_pd` bigint(20) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_kegiatan_pd` bigint(11) NOT NULL,
  `id_pelaksana_forum` int(11) DEFAULT NULL,
  `id_sub_unit` int(11) NOT NULL,
  `id_pelaksana_renja` int(11) DEFAULT '0',
  `id_lokasi` int(11) DEFAULT '0' COMMENT 'lokasi penyelenggaraan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 renja 1 tambahan',
  `ket_pelaksana` varchar(500) DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 batal 2 baru',
  `status_data` int(11) NOT NULL COMMENT '0 draft 1 final'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_program_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_program_pd`;
CREATE TABLE `trx_rkpd_ranhir_program_pd` (
  `id_program_pd` bigint(11) NOT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `tahun_forum` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pdt 2 BTL',
  `no_urut` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_forum_program` int(11) DEFAULT NULL,
  `id_renja_program` int(11) DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT '0',
  `uraian_program_renstra` varchar(500) DEFAULT NULL,
  `id_program_ref` int(11) NOT NULL,
  `pagu_tahun_renstra` decimal(20,2) DEFAULT '0.00',
  `pagu_forum` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renstra 1 = baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0',
  `ket_usulan` varchar(250) DEFAULT '0',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `id_dokumen` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_prog_indikator_pd`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_prog_indikator_pd`;
CREATE TABLE `trx_rkpd_ranhir_prog_indikator_pd` (
  `tahun_renja` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_program_pd` bigint(11) NOT NULL,
  `id_program_forum` int(11) NOT NULL DEFAULT '0',
  `id_program_renstra` int(11) DEFAULT NULL,
  `id_indikator_program` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) DEFAULT '0',
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program` text,
  `tolok_ukur_indikator` text,
  `target_renstra` decimal(20,2) DEFAULT '0.00',
  `target_renja` decimal(20,2) DEFAULT '0.00',
  `indikator_output` text,
  `id_satuan_ouput` int(255) DEFAULT NULL,
  `indikator_input` text,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 posting',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 Renstra 1 baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranhir_urusan`
--

DROP TABLE IF EXISTS `trx_rkpd_ranhir_urusan`;
CREATE TABLE `trx_rkpd_ranhir_urusan` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) DEFAULT NULL,
  `id_rkpd_rancangan` int(11) NOT NULL,
  `id_urusan_rkpd` int(11) NOT NULL,
  `id_bidang` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rpjmd 1 baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranwal`
--

DROP TABLE IF EXISTS `trx_rkpd_ranwal`;
CREATE TABLE `trx_rkpd_ranwal` (
  `id_rkpd_ranwal` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `tahun_rkpd` int(11) NOT NULL,
  `jenis_belanja` int(11) NOT NULL DEFAULT '0' COMMENT '0 BL 1 Pendapatan 2 BTL',
  `id_rkpd_rpjmd` int(11) DEFAULT NULL,
  `thn_id_rpjmd` int(11) DEFAULT NULL,
  `id_visi_rpjmd` int(11) DEFAULT NULL,
  `id_misi_rpjmd` int(11) DEFAULT NULL,
  `id_tujuan_rpjmd` int(11) DEFAULT NULL,
  `id_sasaran_rpjmd` int(11) DEFAULT NULL,
  `id_program_rpjmd` int(11) DEFAULT NULL,
  `uraian_program_rpjmd` varchar(500) DEFAULT NULL,
  `pagu_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_ranwal` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_program` varchar(500) DEFAULT NULL,
  `status_pelaksanaan` int(11) NOT NULL COMMENT '0 = data tepat waktu sesuai renstra/rpjmd\\r\\n1 = data pergeseran waktu renstra/rpjmd\\r\\n2 = data baru yang belum ada di renstra/rpjmd\\r\\n9 = dibatalkan pelaksanaanya\\r\\n8 = ditunda dilaksanakan\\r\\n',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = Draft 1 = Posting Renja 2 = Posting Musren',
  `ket_usulan` varchar(500) DEFAULT NULL COMMENT 'Keterangan / alasan status usulan',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = RPJMD 1 = Baru 2 = Luncuran tahun sebelumnya',
  `id_dokumen` int(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranwal_dokumen`
--

DROP TABLE IF EXISTS `trx_rkpd_ranwal_dokumen`;
CREATE TABLE `trx_rkpd_ranwal_dokumen` (
  `id_dokumen_ranwal` int(11) NOT NULL,
  `nomor_ranwal` varchar(255) NOT NULL,
  `tanggal_ranwal` date NOT NULL,
  `tahun_ranwal` int(11) NOT NULL COMMENT 'tahun berlakuknya perkada',
  `uraian_perkada` varchar(500) DEFAULT NULL,
  `id_unit_perencana` int(11) DEFAULT NULL,
  `jabatan_tandatangan` varchar(255) DEFAULT NULL,
  `nama_tandatangan` varchar(255) DEFAULT NULL,
  `nip_tandatangan` varchar(255) DEFAULT NULL,
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '0 draft 1 aktif 2 tidak aktif'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranwal_indikator`
--

DROP TABLE IF EXISTS `trx_rkpd_ranwal_indikator`;
CREATE TABLE `trx_rkpd_ranwal_indikator` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_indikator_program_rkpd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program_rkpd` text,
  `tolok_ukur_indikator` text,
  `target_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `target_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `indikator_input` text,
  `target_input` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan_input` int(255) DEFAULT NULL,
  `indikator_output` text,
  `id_satuan_output` int(255) DEFAULT NULL,
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum direviu 1 sudah direviu',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 data rpjmd 1 data baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranwal_kebijakan`
--

DROP TABLE IF EXISTS `trx_rkpd_ranwal_kebijakan`;
CREATE TABLE `trx_rkpd_ranwal_kebijakan` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_kebijakan_ranwal` int(11) NOT NULL,
  `uraian_kebijakan` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranwal_pelaksana`
--

DROP TABLE IF EXISTS `trx_rkpd_ranwal_pelaksana`;
CREATE TABLE `trx_rkpd_ranwal_pelaksana` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_urusan_rkpd` int(11) NOT NULL,
  `id_pelaksana_rpjmd` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `pagu_rpjmd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_rkpd` decimal(20,2) NOT NULL DEFAULT '0.00',
  `hak_akses` int(11) NOT NULL DEFAULT '0' COMMENT '0 tidak dapat menambah data 1 dapat menambah data',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rpjmd 1 baru',
  `status_pelaksanaan` int(11) NOT NULL DEFAULT '0' COMMENT '0 dilaksanakan 1 dibatalkan',
  `ket_pelaksanaan` varchar(500) DEFAULT NULL COMMENT 'menjelaskan status pelaksanaan',
  `status_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 belum direviu 1 sudah direviu'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_ranwal_urusan`
--

DROP TABLE IF EXISTS `trx_rkpd_ranwal_urusan`;
CREATE TABLE `trx_rkpd_ranwal_urusan` (
  `tahun_rkpd` int(11) NOT NULL,
  `no_urut` int(11) DEFAULT NULL,
  `id_rkpd_ranwal` int(11) NOT NULL,
  `id_urusan_rkpd` int(11) NOT NULL,
  `id_bidang` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 rpjmd 1 baru'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_renstra`
--

DROP TABLE IF EXISTS `trx_rkpd_renstra`;
CREATE TABLE `trx_rkpd_renstra` (
  `tahun_rkpd` int(11) NOT NULL,
  `id_rkpd_renstra` int(11) NOT NULL,
  `id_rkpd_rpjmd` int(11) NOT NULL,
  `id_program_rpjmd` int(11) NOT NULL,
  `pagu_tahun_rpjmd` decimal(20,2) DEFAULT '0.00',
  `id_unit` int(11) NOT NULL,
  `id_visi_renstra` int(11) NOT NULL,
  `uraian_visi_renstra` varchar(500) DEFAULT NULL,
  `id_misi_renstra` int(11) NOT NULL,
  `uraian_misi_renstra` varchar(500) DEFAULT NULL,
  `id_tujuan_renstra` int(11) NOT NULL,
  `uraian_tujuan_renstra` varchar(500) DEFAULT NULL,
  `id_sasaran_renstra` int(11) NOT NULL,
  `uraian_sasaran_renstra` varchar(500) DEFAULT NULL,
  `id_program_renstra` int(11) NOT NULL,
  `uraian_program_renstra` varchar(500) DEFAULT NULL,
  `pagu_tahun_program` decimal(20,2) DEFAULT '0.00',
  `id_kegiatan_renstra` int(11) NOT NULL,
  `uraian_kegiatan_renstra` varchar(500) DEFAULT NULL,
  `pagu_tahun_kegiatan` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0' COMMENT '0 = renstra 1 = insidentil'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_renstra_indikator`
--

DROP TABLE IF EXISTS `trx_rkpd_renstra_indikator`;
CREATE TABLE `trx_rkpd_renstra_indikator` (
  `tahun_rkpd` int(11) NOT NULL,
  `id_rkpd_renstra` int(11) NOT NULL,
  `id_indikator_renstra` int(11) NOT NULL,
  `kd_indikator` int(11) DEFAULT NULL,
  `uraian_indikator_kegiatan` varchar(500) DEFAULT '0',
  `tolokukur_kegiatan` varchar(500) DEFAULT '0',
  `target_output` decimal(20,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_renstra_pelaksana`
--

DROP TABLE IF EXISTS `trx_rkpd_renstra_pelaksana`;
CREATE TABLE `trx_rkpd_renstra_pelaksana` (
  `tahun_rkpd` int(11) NOT NULL,
  `id_rkpd_renstra` int(11) NOT NULL,
  `id_pelaksana_renstra` int(11) NOT NULL,
  `id_sub_unit` int(11) NOT NULL,
  `pagu_tahun` decimal(20,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rpjmd_kebijakan`
--

DROP TABLE IF EXISTS `trx_rkpd_rpjmd_kebijakan`;
CREATE TABLE `trx_rkpd_rpjmd_kebijakan` (
  `tahun_rkpd` int(11) NOT NULL,
  `id_rkpd_rpjmd` int(11) NOT NULL,
  `id_kebijakan_rpjmd` int(11) NOT NULL,
  `uraian_kebijakan` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rpjmd_program_indikator`
--

DROP TABLE IF EXISTS `trx_rkpd_rpjmd_program_indikator`;
CREATE TABLE `trx_rkpd_rpjmd_program_indikator` (
  `tahun_rkpd` int(11) NOT NULL,
  `id_rkpd_rpjmd` int(11) NOT NULL,
  `id_indikator_program_rpjmd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_program_rpjmd` text,
  `tolok_ukur_indikator` text,
  `angka_tahun` decimal(20,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rpjmd_program_pelaksana`
--

DROP TABLE IF EXISTS `trx_rkpd_rpjmd_program_pelaksana`;
CREATE TABLE `trx_rkpd_rpjmd_program_pelaksana` (
  `tahun_rkpd` int(11) NOT NULL,
  `id_pelaksana_rpjmd` int(11) NOT NULL,
  `id_rkpd_rpjmd` int(11) NOT NULL,
  `id_urbid_rpjmd` int(11) NOT NULL,
  `id_bidang` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `pagu_tahun` decimal(20,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rkpd_rpjmd_ranwal`
--

DROP TABLE IF EXISTS `trx_rkpd_rpjmd_ranwal`;
CREATE TABLE `trx_rkpd_rpjmd_ranwal` (
  `id_rkpd_rpjmd` int(11) NOT NULL,
  `tahun_rkpd` int(11) NOT NULL,
  `thn_id_rpjmd` int(11) NOT NULL,
  `id_visi_rpjmd` int(11) NOT NULL,
  `uraian_visi_rpjmd` varchar(500) DEFAULT NULL,
  `id_misi_rpjmd` int(11) NOT NULL,
  `uraian_misi_rpjmd` varchar(500) DEFAULT NULL,
  `id_tujuan_rpjmd` int(11) NOT NULL,
  `uraian_tujuan_rpjmd` varchar(500) DEFAULT NULL,
  `id_sasaran_rpjmd` int(11) NOT NULL,
  `uraian_sasaran_rpjmd` varchar(500) DEFAULT NULL,
  `id_program_rpjmd` int(11) NOT NULL,
  `uraian_program_rpjmd` varchar(500) DEFAULT NULL,
  `pagu_program_rpjmd` decimal(20,2) DEFAULT '0.00',
  `status_data` int(11) NOT NULL COMMENT '0 = data tepat waktu sesuai renstra/rpjmd\\r\\n1 = data pergeseran waktu renstra/rpjmd\\r\\n2 = data baru yang belum ada di renstra/rpjmd'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_dokumen`
--

DROP TABLE IF EXISTS `trx_rpjmd_dokumen`;
CREATE TABLE `trx_rpjmd_dokumen` (
  `id_rpjmd` int(11) NOT NULL COMMENT 'berisi id khusus untuk setiap visi pada periode yang sama',
  `id_rpjmd_old` int(11) NOT NULL DEFAULT '1',
  `thn_dasar` int(11) NOT NULL,
  `tahun_1` int(11) NOT NULL,
  `tahun_2` int(11) NOT NULL,
  `tahun_3` int(11) NOT NULL,
  `tahun_4` int(11) NOT NULL,
  `tahun_5` int(11) NOT NULL,
  `no_perda` varchar(255) DEFAULT NULL,
  `tgl_perda` date DEFAULT NULL,
  `id_revisi` int(11) DEFAULT NULL,
  `id_status_dokumen` int(11) NOT NULL DEFAULT '1' COMMENT '0 = draft , 1 = aktif  2 = direvisi',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_kebijakan`
--

DROP TABLE IF EXISTS `trx_rpjmd_kebijakan`;
CREATE TABLE `trx_rpjmd_kebijakan` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_sasaran_rpjmd` int(11) NOT NULL,
  `id_kebijakan_rpjmd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `uraian_kebijakan_rpjmd` varchar(500) DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_misi`
--

DROP TABLE IF EXISTS `trx_rpjmd_misi`;
CREATE TABLE `trx_rpjmd_misi` (
  `thn_id_rpjmd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_visi_rpjmd` int(11) NOT NULL,
  `id_misi_rpjmd` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL,
  `uraian_misi_rpjmd` varchar(550) NOT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_program`
--

DROP TABLE IF EXISTS `trx_rpjmd_program`;
CREATE TABLE `trx_rpjmd_program` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_sasaran_rpjmd` int(11) NOT NULL,
  `id_program_rpjmd` int(11) NOT NULL,
  `id_perubahan` int(11) DEFAULT NULL,
  `uraian_program_rpjmd` varchar(500) DEFAULT NULL,
  `pagu_tahun1` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun2` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun3` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun4` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun5` decimal(20,2) DEFAULT '0.00',
  `total_pagu` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_program_indikator`
--

DROP TABLE IF EXISTS `trx_rpjmd_program_indikator`;
CREATE TABLE `trx_rpjmd_program_indikator` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_program_rpjmd` int(11) NOT NULL,
  `id_indikator_program_rpjmd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `id_indikator` int(11) NOT NULL,
  `id_indikator_sasaran_rpjmd` int(11) NOT NULL DEFAULT '0',
  `uraian_indikator_program_rpjmd` varchar(500) DEFAULT NULL,
  `tolok_ukur_indikator` varchar(500) DEFAULT NULL,
  `angka_awal_periode` decimal(20,2) DEFAULT '0.00',
  `angka_tahun1` decimal(20,2) DEFAULT '0.00',
  `angka_tahun2` decimal(20,2) DEFAULT '0.00',
  `angka_tahun3` decimal(20,2) DEFAULT '0.00',
  `angka_tahun4` decimal(20,2) DEFAULT '0.00',
  `angka_tahun5` decimal(20,2) DEFAULT '0.00',
  `angka_akhir_periode` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_program_pelaksana`
--

DROP TABLE IF EXISTS `trx_rpjmd_program_pelaksana`;
CREATE TABLE `trx_rpjmd_program_pelaksana` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_urbid_rpjmd` int(11) NOT NULL,
  `id_pelaksana_rpjmd` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL DEFAULT '0',
  `pagu_tahun1` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun2` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun3` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun4` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun5` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_program_urusan`
--

DROP TABLE IF EXISTS `trx_rpjmd_program_urusan`;
CREATE TABLE `trx_rpjmd_program_urusan` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_urbid_rpjmd` int(11) NOT NULL,
  `id_program_rpjmd` int(11) NOT NULL,
  `id_bidang` int(11) NOT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_ranwal_dokumen`
--

DROP TABLE IF EXISTS `trx_rpjmd_ranwal_dokumen`;
CREATE TABLE `trx_rpjmd_ranwal_dokumen` (
  `id_rpjmd` int(11) NOT NULL COMMENT 'berisi id khusus untuk setiap visi pada periode yang sama',
  `periode_awal` int(11) NOT NULL,
  `periode_akhir` int(11) NOT NULL,
  `no_perda` varchar(255) DEFAULT NULL,
  `keterangan_dokumen` varchar(500) DEFAULT NULL,
  `tgl_perda` date DEFAULT NULL,
  `id_revisi` int(11) NOT NULL DEFAULT '1' COMMENT '0 = tekno, 1 = induk, 2= revisi1, 3=revisi2, 4=revisi4',
  `id_status_dokumen` int(11) NOT NULL DEFAULT '1' COMMENT '0 = draft , 1 = aktif  2 = direvisi',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_ranwal_kebijakan`
--

DROP TABLE IF EXISTS `trx_rpjmd_ranwal_kebijakan`;
CREATE TABLE `trx_rpjmd_ranwal_kebijakan` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_strategi_rpjmd` int(11) NOT NULL,
  `id_kebijakan_rpjmd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `uraian_kebijakan_rpjmd` varchar(500) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_ranwal_misi`
--

DROP TABLE IF EXISTS `trx_rpjmd_ranwal_misi`;
CREATE TABLE `trx_rpjmd_ranwal_misi` (
  `thn_id_rpjmd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_visi_rpjmd` int(11) NOT NULL,
  `id_misi_rpjmd` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL,
  `uraian_misi_rpjmd` varchar(550) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_ranwal_program`
--

DROP TABLE IF EXISTS `trx_rpjmd_ranwal_program`;
CREATE TABLE `trx_rpjmd_ranwal_program` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_sasaran_rpjmd` int(11) NOT NULL,
  `id_program_rpjmd` int(11) NOT NULL,
  `id_perubahan` int(11) DEFAULT NULL,
  `uraian_program_rpjmd` varchar(500) DEFAULT NULL,
  `pagu_tahun1` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun2` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun3` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun4` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun5` decimal(20,2) DEFAULT '0.00',
  `total_pagu` decimal(20,2) DEFAULT '0.00',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_ranwal_program_indikator`
--

DROP TABLE IF EXISTS `trx_rpjmd_ranwal_program_indikator`;
CREATE TABLE `trx_rpjmd_ranwal_program_indikator` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_program_rpjmd` int(11) NOT NULL,
  `id_indikator_program_rpjmd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `id_indikator` int(11) NOT NULL,
  `id_indikator_sasaran_rpjmd` int(11) NOT NULL DEFAULT '0',
  `uraian_indikator_program_rpjmd` varchar(500) DEFAULT NULL,
  `tolok_ukur_indikator` varchar(500) DEFAULT NULL,
  `angka_awal_periode` decimal(20,2) DEFAULT '0.00',
  `angka_tahun1` decimal(20,2) DEFAULT '0.00',
  `angka_tahun2` decimal(20,2) DEFAULT '0.00',
  `angka_tahun3` decimal(20,2) DEFAULT '0.00',
  `angka_tahun4` decimal(20,2) DEFAULT '0.00',
  `angka_tahun5` decimal(20,2) DEFAULT '0.00',
  `angka_akhir_periode` decimal(20,2) DEFAULT '0.00',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_ranwal_program_pelaksana`
--

DROP TABLE IF EXISTS `trx_rpjmd_ranwal_program_pelaksana`;
CREATE TABLE `trx_rpjmd_ranwal_program_pelaksana` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_urbid_rpjmd` int(11) NOT NULL,
  `id_pelaksana_rpjmd` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL DEFAULT '0',
  `pagu_tahun1` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun2` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun3` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun4` decimal(20,2) DEFAULT '0.00',
  `pagu_tahun5` decimal(20,2) DEFAULT '0.00',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_ranwal_program_urusan`
--

DROP TABLE IF EXISTS `trx_rpjmd_ranwal_program_urusan`;
CREATE TABLE `trx_rpjmd_ranwal_program_urusan` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_urbid_rpjmd` int(11) NOT NULL,
  `id_program_rpjmd` int(11) NOT NULL,
  `id_bidang` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_ranwal_sasaran`
--

DROP TABLE IF EXISTS `trx_rpjmd_ranwal_sasaran`;
CREATE TABLE `trx_rpjmd_ranwal_sasaran` (
  `thn_id_rpjmd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_tujuan_rpjmd` int(11) NOT NULL,
  `id_sasaran_rpjmd` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL,
  `uraian_sasaran_rpjmd` varchar(500) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_ranwal_sasaran_indikator`
--

DROP TABLE IF EXISTS `trx_rpjmd_ranwal_sasaran_indikator`;
CREATE TABLE `trx_rpjmd_ranwal_sasaran_indikator` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_sasaran_rpjmd` int(11) NOT NULL,
  `id_indikator_sasaran_rpjmd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_sasaran_rpjmd` varchar(500) DEFAULT NULL,
  `tolok_ukur_indikator` varchar(500) DEFAULT NULL,
  `angka_awal_periode` decimal(20,2) DEFAULT '0.00',
  `angka_tahun1` decimal(20,2) DEFAULT '0.00',
  `angka_tahun2` decimal(20,2) DEFAULT '0.00',
  `angka_tahun3` decimal(20,2) DEFAULT '0.00',
  `angka_tahun4` decimal(20,2) DEFAULT '0.00',
  `angka_tahun5` decimal(20,2) DEFAULT '0.00',
  `angka_akhir_periode` decimal(20,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_ranwal_strategi`
--

DROP TABLE IF EXISTS `trx_rpjmd_ranwal_strategi`;
CREATE TABLE `trx_rpjmd_ranwal_strategi` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_sasaran_rpjmd` int(11) NOT NULL,
  `id_strategi_rpjmd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `uraian_strategi_rpjmd` varchar(500) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_ranwal_tujuan`
--

DROP TABLE IF EXISTS `trx_rpjmd_ranwal_tujuan`;
CREATE TABLE `trx_rpjmd_ranwal_tujuan` (
  `thn_id_rpjmd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_misi_rpjmd` int(11) NOT NULL,
  `id_tujuan_rpjmd` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL,
  `uraian_tujuan_rpjmd` varchar(500) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_ranwal_tujuan_indikator`
--

DROP TABLE IF EXISTS `trx_rpjmd_ranwal_tujuan_indikator`;
CREATE TABLE `trx_rpjmd_ranwal_tujuan_indikator` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_tujuan_rpjmd` int(11) NOT NULL,
  `id_indikator_tujuan_rpjmd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_sasaran_rpjmd` varchar(500) DEFAULT NULL,
  `tolok_ukur_indikator` varchar(500) DEFAULT NULL,
  `angka_awal_periode` decimal(20,2) DEFAULT '0.00',
  `angka_tahun1` decimal(20,2) DEFAULT '0.00',
  `angka_tahun2` decimal(20,2) DEFAULT '0.00',
  `angka_tahun3` decimal(20,2) DEFAULT '0.00',
  `angka_tahun4` decimal(20,2) DEFAULT '0.00',
  `angka_tahun5` decimal(20,2) DEFAULT '0.00',
  `angka_akhir_periode` decimal(20,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_ranwal_visi`
--

DROP TABLE IF EXISTS `trx_rpjmd_ranwal_visi`;
CREATE TABLE `trx_rpjmd_ranwal_visi` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_rpjmd` int(11) NOT NULL,
  `id_visi_rpjmd` int(11) NOT NULL COMMENT 'berisi id khusus untuk setiap visi pada periode yang sama',
  `id_perubahan` int(11) NOT NULL DEFAULT '0',
  `uraian_visi_rpjmd` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_sasaran`
--

DROP TABLE IF EXISTS `trx_rpjmd_sasaran`;
CREATE TABLE `trx_rpjmd_sasaran` (
  `thn_id_rpjmd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_tujuan_rpjmd` int(11) NOT NULL,
  `id_sasaran_rpjmd` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL,
  `uraian_sasaran_rpjmd` varchar(500) DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_sasaran_indikator`
--

DROP TABLE IF EXISTS `trx_rpjmd_sasaran_indikator`;
CREATE TABLE `trx_rpjmd_sasaran_indikator` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_sasaran_rpjmd` int(11) NOT NULL,
  `id_indikator_sasaran_rpjmd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_sasaran_rpjmd` varchar(500) DEFAULT NULL,
  `tolok_ukur_indikator` varchar(500) DEFAULT NULL,
  `angka_awal_periode` decimal(20,2) DEFAULT '0.00',
  `angka_tahun1` decimal(20,2) DEFAULT '0.00',
  `angka_tahun2` decimal(20,2) DEFAULT '0.00',
  `angka_tahun3` decimal(20,2) DEFAULT '0.00',
  `angka_tahun4` decimal(20,2) DEFAULT '0.00',
  `angka_tahun5` decimal(20,2) DEFAULT '0.00',
  `angka_akhir_periode` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_strategi`
--

DROP TABLE IF EXISTS `trx_rpjmd_strategi`;
CREATE TABLE `trx_rpjmd_strategi` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_sasaran_rpjmd` int(11) NOT NULL,
  `id_strategi_rpjmd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `uraian_strategi_rpjmd` varchar(500) DEFAULT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_tujuan`
--

DROP TABLE IF EXISTS `trx_rpjmd_tujuan`;
CREATE TABLE `trx_rpjmd_tujuan` (
  `thn_id_rpjmd` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_misi_rpjmd` int(11) NOT NULL,
  `id_tujuan_rpjmd` int(11) NOT NULL,
  `id_perubahan` int(11) NOT NULL,
  `uraian_tujuan_rpjmd` varchar(500) NOT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_tujuan_indikator`
--

DROP TABLE IF EXISTS `trx_rpjmd_tujuan_indikator`;
CREATE TABLE `trx_rpjmd_tujuan_indikator` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_tujuan_rpjmd` int(11) NOT NULL,
  `id_indikator_tujuan_rpjmd` int(11) NOT NULL COMMENT 'nomor urut indikator sasaran',
  `id_perubahan` int(11) NOT NULL,
  `kd_indikator` int(11) NOT NULL,
  `uraian_indikator_sasaran_rpjmd` varchar(500) DEFAULT NULL,
  `tolok_ukur_indikator` varchar(500) DEFAULT NULL,
  `angka_awal_periode` decimal(20,2) DEFAULT '0.00',
  `angka_tahun1` decimal(20,2) DEFAULT '0.00',
  `angka_tahun2` decimal(20,2) DEFAULT '0.00',
  `angka_tahun3` decimal(20,2) DEFAULT '0.00',
  `angka_tahun4` decimal(20,2) DEFAULT '0.00',
  `angka_tahun5` decimal(20,2) DEFAULT '0.00',
  `angka_akhir_periode` decimal(20,2) DEFAULT '0.00',
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_rpjmd_visi`
--

DROP TABLE IF EXISTS `trx_rpjmd_visi`;
CREATE TABLE `trx_rpjmd_visi` (
  `thn_id` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_rpjmd` int(11) NOT NULL,
  `id_visi_rpjmd` int(11) NOT NULL COMMENT 'berisi id khusus untuk setiap visi pada periode yang sama',
  `id_perubahan` int(11) NOT NULL DEFAULT '0',
  `uraian_visi_rpjmd` varchar(255) NOT NULL,
  `sumber_data` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `trx_usulan_kab`
--

DROP TABLE IF EXISTS `trx_usulan_kab`;
CREATE TABLE `trx_usulan_kab` (
  `id_usulan_kab` int(11) NOT NULL,
  `id_tahun` int(11) NOT NULL,
  `id_kab` int(11) NOT NULL,
  `id_unit` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL DEFAULT '0',
  `sumber_usulan` int(11) NOT NULL DEFAULT '0',
  `judul_usulan` varchar(255) DEFAULT NULL,
  `uraian_usulan` varchar(500) DEFAULT NULL,
  `volume` decimal(20,2) NOT NULL DEFAULT '0.00',
  `id_satuan` int(11) DEFAULT NULL,
  `pagu` decimal(20,2) NOT NULL DEFAULT '0.00',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `entry_by` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `trx_usulan_kab_lokasi`
--

DROP TABLE IF EXISTS `trx_usulan_kab_lokasi`;
CREATE TABLE `trx_usulan_kab_lokasi` (
  `id_usulan_kab` int(11) NOT NULL,
  `id_usulan_kab_lokasi` int(11) NOT NULL,
  `no_urut` int(11) NOT NULL DEFAULT '1',
  `id_lokasi` int(11) NOT NULL,
  `volume` decimal(20,2) DEFAULT '0.00',
  `id_satuan` int(11) DEFAULT NULL,
  `uraian_lokasi` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `trx_usulan_rw`
--

DROP TABLE IF EXISTS `trx_usulan_rw`;
CREATE TABLE `trx_usulan_rw` (
  `id_usulan_rw` bigint(20) NOT NULL,
  `no_urut` int(11) NOT NULL,
  `id_desa` int(11) NOT NULL,
  `id_rw` int(11) NOT NULL,
  `id_renja` bigint(20) NOT NULL,
  `id_asb_aktivitas` bigint(20) NOT NULL,
  `uraian_aktivitas` varchar(500) NOT NULL,
  `volume_aktivitas` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pagu_aktivitas` decimal(20,2) NOT NULL DEFAULT '0.00',
  `keterangan_aktivitas` varchar(500) DEFAULT NULL,
  `status_usulan` int(11) NOT NULL COMMENT '0 = draft 1 = musrendes 2 = setuju musrendes'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) UNSIGNED NOT NULL,
  `group_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_unit` int(11) DEFAULT NULL COMMENT 'Diisi dengan kode unit asal operator',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status_user` int(11) NOT NULL DEFAULT '1' COMMENT '0 non aktif 1 aktif'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Triggers `users`
--
DROP TRIGGER IF EXISTS `trg_user`;
DELIMITER $$
CREATE TRIGGER `trg_user` BEFORE DELETE ON `users` FOR EACH ROW IF old.email = 'super@simcan.dev' THEN 
    SIGNAL SQLSTATE '45000' 
     SET MESSAGE_TEXT = 'This record is sacred! You are not allowed to remove it!!';
END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user_app`
--

DROP TABLE IF EXISTS `user_app`;
CREATE TABLE `user_app` (
  `id_app_user` int(11) NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `group_id` int(11) UNSIGNED NOT NULL,
  `app_id` int(11) NOT NULL COMMENT '0',
  `status_app` int(11) NOT NULL COMMENT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `user_desa`
--

DROP TABLE IF EXISTS `user_desa`;
CREATE TABLE `user_desa` (
  `id_user_wil` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `kd_kecamatan` int(11) NOT NULL COMMENT 'prov',
  `kd_desa` int(11) NOT NULL COMMENT 'kab/kota',
  `rw` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `user_sub_unit`
--

DROP TABLE IF EXISTS `user_sub_unit`;
CREATE TABLE `user_sub_unit` (
  `id_user_unit` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `kd_unit` int(11) NOT NULL,
  `kd_sub` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kin_trx_cascading_indikator_kegiatan_pd`
--
ALTER TABLE `kin_trx_cascading_indikator_kegiatan_pd`
  ADD PRIMARY KEY (`id_indikator_kegiatan_pd`),
  ADD KEY `FK_kin_trx_cascading_indikator_program_pd_1` (`id_hasil_kegiatan`);

--
-- Indexes for table `kin_trx_cascading_indikator_program_pd`
--
ALTER TABLE `kin_trx_cascading_indikator_program_pd`
  ADD PRIMARY KEY (`id_indikator_program_pd`),
  ADD KEY `FK_kin_trx_cascading_indikator_program_pd_1` (`id_hasil_program`);

--
-- Indexes for table `kin_trx_cascading_kegiatan_opd`
--
ALTER TABLE `kin_trx_cascading_kegiatan_opd`
  ADD PRIMARY KEY (`id_hasil_kegiatan`),
  ADD KEY `FK_kin_trx_cascading_kegiatan_opd_kin_trx_cascading_program_opd` (`id_hasil_program`);

--
-- Indexes for table `kin_trx_cascading_program_opd`
--
ALTER TABLE `kin_trx_cascading_program_opd`
  ADD PRIMARY KEY (`id_hasil_program`);

--
-- Indexes for table `kin_trx_iku_opd_dok`
--
ALTER TABLE `kin_trx_iku_opd_dok`
  ADD PRIMARY KEY (`id_dokumen`);

--
-- Indexes for table `kin_trx_iku_opd_kegiatan`
--
ALTER TABLE `kin_trx_iku_opd_kegiatan`
  ADD PRIMARY KEY (`id_iku_opd_kegiatan`) USING BTREE,
  ADD KEY `id_dokumen` (`id_iku_opd_program`);

--
-- Indexes for table `kin_trx_iku_opd_program`
--
ALTER TABLE `kin_trx_iku_opd_program`
  ADD PRIMARY KEY (`id_iku_opd_program`) USING BTREE,
  ADD KEY `id_dokumen` (`id_iku_opd_sasaran`);

--
-- Indexes for table `kin_trx_iku_opd_sasaran`
--
ALTER TABLE `kin_trx_iku_opd_sasaran`
  ADD PRIMARY KEY (`id_iku_opd_sasaran`) USING BTREE,
  ADD KEY `id_dokumen` (`id_dokumen`);

--
-- Indexes for table `kin_trx_iku_pemda_dok`
--
ALTER TABLE `kin_trx_iku_pemda_dok`
  ADD PRIMARY KEY (`id_dokumen`);

--
-- Indexes for table `kin_trx_iku_pemda_rinci`
--
ALTER TABLE `kin_trx_iku_pemda_rinci`
  ADD PRIMARY KEY (`id_iku_pemda`),
  ADD KEY `id_dokumen` (`id_dokumen`);

--
-- Indexes for table `kin_trx_perkin_es3_dok`
--
ALTER TABLE `kin_trx_perkin_es3_dok`
  ADD PRIMARY KEY (`id_dokumen_perkin`) USING BTREE,
  ADD KEY `id_unit` (`id_sotk_es3`);

--
-- Indexes for table `kin_trx_perkin_es3_kegiatan`
--
ALTER TABLE `kin_trx_perkin_es3_kegiatan`
  ADD PRIMARY KEY (`id_perkin_kegiatan`) USING BTREE,
  ADD KEY `id_sasaran_kinerja_skpd` (`id_perkin_program`) USING BTREE,
  ADD KEY `id_program` (`id_kegiatan_renstra`) USING BTREE;

--
-- Indexes for table `kin_trx_perkin_es3_program`
--
ALTER TABLE `kin_trx_perkin_es3_program`
  ADD PRIMARY KEY (`id_perkin_program`) USING BTREE,
  ADD KEY `id_program` (`id_program_renstra`) USING BTREE,
  ADD KEY `id_dokumen_perkin` (`id_dokumen_perkin`),
  ADD KEY `id_perkin_program_opd` (`id_perkin_program_opd`);

--
-- Indexes for table `kin_trx_perkin_es3_program_indikator`
--
ALTER TABLE `kin_trx_perkin_es3_program_indikator`
  ADD PRIMARY KEY (`id_perkin_indikator`) USING BTREE,
  ADD KEY `id_sasaran_kinerja_skpd` (`id_perkin_program`) USING BTREE,
  ADD KEY `id_program` (`id_indikator_program_renstra`) USING BTREE;

--
-- Indexes for table `kin_trx_perkin_es4_dok`
--
ALTER TABLE `kin_trx_perkin_es4_dok`
  ADD PRIMARY KEY (`id_dokumen_perkin`) USING BTREE,
  ADD KEY `id_unit` (`id_sotk_es4`);

--
-- Indexes for table `kin_trx_perkin_es4_kegiatan`
--
ALTER TABLE `kin_trx_perkin_es4_kegiatan`
  ADD PRIMARY KEY (`id_perkin_kegiatan`) USING BTREE,
  ADD KEY `id_sasaran_kinerja_skpd` (`id_perkin_kegiatan_es3`) USING BTREE,
  ADD KEY `id_program` (`id_kegiatan_renstra`) USING BTREE,
  ADD KEY `id_dokumen_perkin` (`id_dokumen_perkin`);

--
-- Indexes for table `kin_trx_perkin_es4_kegiatan_indikator`
--
ALTER TABLE `kin_trx_perkin_es4_kegiatan_indikator`
  ADD PRIMARY KEY (`id_perkin_indikator`) USING BTREE,
  ADD KEY `id_sasaran_kinerja_skpd` (`id_perkin_kegiatan`) USING BTREE,
  ADD KEY `id_program` (`id_indikator_kegiatan_renstra`) USING BTREE;

--
-- Indexes for table `kin_trx_perkin_opd_dok`
--
ALTER TABLE `kin_trx_perkin_opd_dok`
  ADD PRIMARY KEY (`id_dokumen_perkin`) USING BTREE,
  ADD KEY `id_unit` (`id_sotk_es2`);

--
-- Indexes for table `kin_trx_perkin_opd_program`
--
ALTER TABLE `kin_trx_perkin_opd_program`
  ADD PRIMARY KEY (`id_perkin_program`) USING BTREE,
  ADD KEY `id_sasaran_kinerja_skpd` (`id_perkin_sasaran`) USING BTREE,
  ADD KEY `id_program` (`id_program_renstra`) USING BTREE;

--
-- Indexes for table `kin_trx_perkin_opd_sasaran`
--
ALTER TABLE `kin_trx_perkin_opd_sasaran`
  ADD PRIMARY KEY (`id_perkin_sasaran`) USING BTREE,
  ADD KEY `id_sasaran_kinerja_skpd` (`id_dokumen_perkin`) USING BTREE,
  ADD KEY `id_program` (`id_sasaran_renstra`) USING BTREE;

--
-- Indexes for table `kin_trx_perkin_opd_sasaran_indikator`
--
ALTER TABLE `kin_trx_perkin_opd_sasaran_indikator`
  ADD PRIMARY KEY (`id_perkin_indikator`) USING BTREE,
  ADD KEY `id_sasaran_kinerja_skpd` (`id_perkin_sasaran`) USING BTREE,
  ADD KEY `id_program` (`id_indikator_sasaran_renstra`) USING BTREE;

--
-- Indexes for table `kin_trx_real_es2_dok`
--
ALTER TABLE `kin_trx_real_es2_dok`
  ADD PRIMARY KEY (`id_dokumen_real`) USING BTREE,
  ADD KEY `id_unit` (`id_sotk_es2`) USING BTREE,
  ADD KEY `id_dokumen_perkin` (`id_dokumen_perkin`);

--
-- Indexes for table `kin_trx_real_es2_program`
--
ALTER TABLE `kin_trx_real_es2_program`
  ADD PRIMARY KEY (`id_real_program`) USING BTREE,
  ADD KEY `id_sasaran_kinerja_skpd` (`id_perkin_program`) USING BTREE,
  ADD KEY `id_program` (`id_program_renstra`) USING BTREE,
  ADD KEY `id_dokumen_perkin` (`id_real_sasaran`) USING BTREE,
  ADD KEY `id_real_program_es3` (`id_real_program_es3`);

--
-- Indexes for table `kin_trx_real_es2_sasaran`
--
ALTER TABLE `kin_trx_real_es2_sasaran`
  ADD PRIMARY KEY (`id_real_sasaran`) USING BTREE,
  ADD KEY `id_sasaran_kinerja_skpd` (`id_dokumen_real`) USING BTREE,
  ADD KEY `id_program` (`id_sasaran_renstra`) USING BTREE;

--
-- Indexes for table `kin_trx_real_es2_sasaran_indikator`
--
ALTER TABLE `kin_trx_real_es2_sasaran_indikator`
  ADD PRIMARY KEY (`id_real_indikator`) USING BTREE,
  ADD KEY `id_sasaran_kinerja_skpd` (`id_real_sasaran`) USING BTREE,
  ADD KEY `id_program` (`id_indikator_sasaran_renstra`) USING BTREE;

--
-- Indexes for table `kin_trx_real_es3_dok`
--
ALTER TABLE `kin_trx_real_es3_dok`
  ADD PRIMARY KEY (`id_dokumen_real`) USING BTREE,
  ADD KEY `id_unit` (`id_sotk_es3`) USING BTREE,
  ADD KEY `id_dokumen_perkin` (`id_dokumen_perkin`);

--
-- Indexes for table `kin_trx_real_es3_kegiatan`
--
ALTER TABLE `kin_trx_real_es3_kegiatan`
  ADD PRIMARY KEY (`id_real_kegiatan`) USING BTREE,
  ADD KEY `id_sasaran_kinerja_skpd` (`id_perkin_kegiatan`) USING BTREE,
  ADD KEY `id_program` (`id_kegiatan_renstra`) USING BTREE,
  ADD KEY `id_dokumen_perkin` (`id_real_program`) USING BTREE,
  ADD KEY `id_real_kegiatan_es4` (`id_real_kegiatan_es4`);

--
-- Indexes for table `kin_trx_real_es3_program`
--
ALTER TABLE `kin_trx_real_es3_program`
  ADD PRIMARY KEY (`id_real_program`) USING BTREE,
  ADD KEY `id_sasaran_kinerja_skpd` (`id_perkin_program`) USING BTREE,
  ADD KEY `id_program` (`id_program_renstra`) USING BTREE,
  ADD KEY `id_dokumen_perkin` (`id_dokumen_real`) USING BTREE;

--
-- Indexes for table `kin_trx_real_es3_program_indikator`
--
ALTER TABLE `kin_trx_real_es3_program_indikator`
  ADD PRIMARY KEY (`id_real_indikator`) USING BTREE,
  ADD KEY `id_program` (`id_indikator_program_renstra`) USING BTREE,
  ADD KEY `id_real_program` (`id_real_program`);

--
-- Indexes for table `kin_trx_real_es4_dok`
--
ALTER TABLE `kin_trx_real_es4_dok`
  ADD PRIMARY KEY (`id_dokumen_real`) USING BTREE,
  ADD KEY `id_unit` (`id_sotk_es4`) USING BTREE,
  ADD KEY `id_dokumen_perkin` (`id_dokumen_perkin`);

--
-- Indexes for table `kin_trx_real_es4_kegiatan`
--
ALTER TABLE `kin_trx_real_es4_kegiatan`
  ADD PRIMARY KEY (`id_real_kegiatan`) USING BTREE,
  ADD KEY `id_sasaran_kinerja_skpd` (`id_perkin_kegiatan`) USING BTREE,
  ADD KEY `id_program` (`id_kegiatan_renstra`) USING BTREE,
  ADD KEY `id_dokumen_perkin` (`id_dokumen_real`) USING BTREE;

--
-- Indexes for table `kin_trx_real_es4_kegiatan_indikator`
--
ALTER TABLE `kin_trx_real_es4_kegiatan_indikator`
  ADD PRIMARY KEY (`id_real_indikator`) USING BTREE,
  ADD KEY `id_sasaran_kinerja_skpd` (`id_real_kegiatan`) USING BTREE,
  ADD KEY `id_program` (`id_indikator_kegiatan_renstra`) USING BTREE;

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `ref_bidang`
--
ALTER TABLE `ref_bidang`
  ADD PRIMARY KEY (`id_bidang`) USING BTREE,
  ADD UNIQUE KEY `idx_ref_bidang` (`kd_urusan`,`kd_bidang`) USING BTREE,
  ADD KEY `fk_ref_fungsi` (`kd_fungsi`) USING BTREE;

--
-- Indexes for table `ref_data_sub_unit`
--
ALTER TABLE `ref_data_sub_unit`
  ADD PRIMARY KEY (`id_rincian_unit`) USING BTREE,
  ADD UNIQUE KEY `tahun` (`tahun`,`id_sub_unit`) USING BTREE,
  ADD KEY `id_sub_unit` (`id_sub_unit`) USING BTREE;

--
-- Indexes for table `ref_desa`
--
ALTER TABLE `ref_desa`
  ADD PRIMARY KEY (`id_desa`) USING BTREE,
  ADD UNIQUE KEY `id_kecamatan` (`id_kecamatan`,`kd_desa`) USING BTREE;

--
-- Indexes for table `ref_dokumen`
--
ALTER TABLE `ref_dokumen`
  ADD PRIMARY KEY (`id_dokumen`) USING BTREE;

--
-- Indexes for table `ref_fungsi`
--
ALTER TABLE `ref_fungsi`
  ADD PRIMARY KEY (`kd_fungsi`) USING BTREE;

--
-- Indexes for table `ref_group`
--
ALTER TABLE `ref_group`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `ref_indikator`
--
ALTER TABLE `ref_indikator`
  ADD PRIMARY KEY (`id_indikator`) USING BTREE;
ALTER TABLE `ref_indikator` ADD FULLTEXT KEY `nm_indikator` (`nm_indikator`);

--
-- Indexes for table `ref_jadwal`
--
ALTER TABLE `ref_jadwal`
  ADD PRIMARY KEY (`id_proses`) USING BTREE,
  ADD UNIQUE KEY `idx_ref_jadwal` (`tahun`,`id_langkah`,`jenis_proses`) USING BTREE;

--
-- Indexes for table `ref_jenis_lokasi`
--
ALTER TABLE `ref_jenis_lokasi`
  ADD PRIMARY KEY (`id_jenis`) USING BTREE,
  ADD UNIQUE KEY `id_jenis` (`id_jenis`) USING BTREE;

--
-- Indexes for table `ref_kabupaten`
--
ALTER TABLE `ref_kabupaten`
  ADD PRIMARY KEY (`id_kab`) USING BTREE,
  ADD UNIQUE KEY `id_pemda` (`id_pemda`,`id_prov`) USING BTREE;

--
-- Indexes for table `ref_kecamatan`
--
ALTER TABLE `ref_kecamatan`
  ADD PRIMARY KEY (`id_kecamatan`) USING BTREE,
  ADD KEY `id_kecamatan` (`id_pemda`) USING BTREE;

--
-- Indexes for table `ref_kegiatan`
--
ALTER TABLE `ref_kegiatan`
  ADD PRIMARY KEY (`id_kegiatan`) USING BTREE,
  ADD UNIQUE KEY `idx_ref_kegiatan` (`id_program`,`kd_kegiatan`) USING BTREE;

--
-- Indexes for table `ref_kolom_tabel_dasar`
--
ALTER TABLE `ref_kolom_tabel_dasar`
  ADD PRIMARY KEY (`id_kolom_tabel_dasar`) USING BTREE,
  ADD KEY `parent_id` (`parent_id`) USING BTREE,
  ADD KEY `id_tabel_dasar` (`id_tabel_dasar`) USING BTREE;

--
-- Indexes for table `ref_langkah`
--
ALTER TABLE `ref_langkah`
  ADD PRIMARY KEY (`id_langkah`,`jenis_dokumen`) USING BTREE,
  ADD UNIQUE KEY `idx_ref_step` (`id_langkah`) USING BTREE;

--
-- Indexes for table `ref_log_akses`
--
ALTER TABLE `ref_log_akses`
  ADD PRIMARY KEY (`id_log`) USING BTREE;

--
-- Indexes for table `ref_lokasi`
--
ALTER TABLE `ref_lokasi`
  ADD PRIMARY KEY (`id_lokasi`) USING BTREE,
  ADD UNIQUE KEY `jenis_lokasi` (`jenis_lokasi`,`nama_lokasi`,`id_desa`) USING BTREE;

--
-- Indexes for table `ref_mapping_asb_renstra`
--
ALTER TABLE `ref_mapping_asb_renstra`
  ADD KEY `idx_ref_mapping_asb_renstra` (`id_aktivitas_asb`,`id_kegiatan_renstra`) USING BTREE,
  ADD KEY `fk_ref_mapping_asb_renstra1` (`id_kegiatan_renstra`) USING BTREE;

--
-- Indexes for table `ref_menu`
--
ALTER TABLE `ref_menu`
  ADD PRIMARY KEY (`id_menu`) USING BTREE,
  ADD UNIQUE KEY `menu` (`menu`,`group_id`) USING BTREE,
  ADD KEY `akses` (`akses`) USING BTREE;

--
-- Indexes for table `ref_pegawai`
--
ALTER TABLE `ref_pegawai`
  ADD PRIMARY KEY (`id_pegawai`),
  ADD UNIQUE KEY `nip_pegawai` (`nip_pegawai`);

--
-- Indexes for table `ref_pegawai_pangkat`
--
ALTER TABLE `ref_pegawai_pangkat`
  ADD PRIMARY KEY (`id_pangkat`),
  ADD UNIQUE KEY `id_pegawai` (`id_pegawai`,`pangkat_pegawai`);

--
-- Indexes for table `ref_pegawai_unit`
--
ALTER TABLE `ref_pegawai_unit`
  ADD PRIMARY KEY (`id_unit_pegawai`) USING BTREE,
  ADD UNIQUE KEY `id_pegawai` (`id_pegawai`,`id_unit`,`tingkat_eselon`,`id_sotk`) USING BTREE,
  ADD KEY `id_unit` (`id_unit`) USING BTREE;

--
-- Indexes for table `ref_pembatalan`
--
ALTER TABLE `ref_pembatalan`
  ADD PRIMARY KEY (`id_batal`);

--
-- Indexes for table `ref_pemda`
--
ALTER TABLE `ref_pemda`
  ADD PRIMARY KEY (`id_pemda`) USING BTREE,
  ADD UNIQUE KEY `kd_prov` (`kd_prov`,`kd_kab`) USING BTREE,
  ADD KEY `id_pemda` (`id_pemda`) USING BTREE;

--
-- Indexes for table `ref_pengusul`
--
ALTER TABLE `ref_pengusul`
  ADD PRIMARY KEY (`id_pengusul`) USING BTREE;

--
-- Indexes for table `ref_prioritas_nasional`
--
ALTER TABLE `ref_prioritas_nasional`
  ADD PRIMARY KEY (`id_prioritas`) USING BTREE;

--
-- Indexes for table `ref_prioritas_provinsi`
--
ALTER TABLE `ref_prioritas_provinsi`
  ADD PRIMARY KEY (`id_prioritas`) USING BTREE;

--
-- Indexes for table `ref_program`
--
ALTER TABLE `ref_program`
  ADD PRIMARY KEY (`id_program`) USING BTREE,
  ADD UNIQUE KEY `idx_ref_program` (`id_bidang`,`kd_program`) USING BTREE;

--
-- Indexes for table `ref_program_nasional`
--
ALTER TABLE `ref_program_nasional`
  ADD PRIMARY KEY (`id_program_nasional`) USING BTREE,
  ADD KEY `id_prioritas` (`id_prioritas`) USING BTREE;

--
-- Indexes for table `ref_program_provinsi`
--
ALTER TABLE `ref_program_provinsi`
  ADD PRIMARY KEY (`id_program_provinsi`) USING BTREE,
  ADD KEY `id_prioritas` (`id_prioritas`) USING BTREE;

--
-- Indexes for table `ref_rek_1`
--
ALTER TABLE `ref_rek_1`
  ADD PRIMARY KEY (`kd_rek_1`) USING BTREE;

--
-- Indexes for table `ref_rek_2`
--
ALTER TABLE `ref_rek_2`
  ADD PRIMARY KEY (`kd_rek_1`,`kd_rek_2`) USING BTREE,
  ADD UNIQUE KEY `kd_rek_1` (`kd_rek_1`,`kd_rek_2`);

--
-- Indexes for table `ref_rek_3`
--
ALTER TABLE `ref_rek_3`
  ADD PRIMARY KEY (`kd_rek_1`,`kd_rek_2`,`kd_rek_3`) USING BTREE,
  ADD KEY `kd_rek_1` (`kd_rek_1`,`kd_rek_2`,`kd_rek_3`);

--
-- Indexes for table `ref_rek_4`
--
ALTER TABLE `ref_rek_4`
  ADD PRIMARY KEY (`kd_rek_1`,`kd_rek_2`,`kd_rek_3`,`kd_rek_4`) USING BTREE,
  ADD UNIQUE KEY `kd_rek_1` (`kd_rek_1`,`kd_rek_2`,`kd_rek_3`,`kd_rek_4`);

--
-- Indexes for table `ref_rek_5`
--
ALTER TABLE `ref_rek_5`
  ADD PRIMARY KEY (`id_rekening`) USING BTREE,
  ADD UNIQUE KEY `kd_rek_1` (`kd_rek_1`,`kd_rek_2`,`kd_rek_3`,`kd_rek_4`,`kd_rek_5`) USING BTREE,
  ADD KEY `id_rekening` (`id_rekening`) USING BTREE;

--
-- Indexes for table `ref_revisi`
--
ALTER TABLE `ref_revisi`
  ADD PRIMARY KEY (`id_revisi`) USING BTREE,
  ADD UNIQUE KEY `idx_ref_revisi` (`id_revisi`) USING BTREE;

--
-- Indexes for table `ref_satuan`
--
ALTER TABLE `ref_satuan`
  ADD PRIMARY KEY (`id_satuan`) USING BTREE;

--
-- Indexes for table `ref_setting`
--
ALTER TABLE `ref_setting`
  ADD PRIMARY KEY (`tahun_rencana`) USING BTREE;

--
-- Indexes for table `ref_sotk_level_1`
--
ALTER TABLE `ref_sotk_level_1`
  ADD PRIMARY KEY (`id_sotk_es2`) USING BTREE,
  ADD KEY `id_unit` (`id_unit`);

--
-- Indexes for table `ref_sotk_level_2`
--
ALTER TABLE `ref_sotk_level_2`
  ADD PRIMARY KEY (`id_sotk_es3`),
  ADD KEY `id_sotk_es2` (`id_sotk_es2`);

--
-- Indexes for table `ref_sotk_level_3`
--
ALTER TABLE `ref_sotk_level_3`
  ADD PRIMARY KEY (`id_sotk_es4`) USING BTREE,
  ADD KEY `id_sotk_es2` (`id_sotk_es3`);

--
-- Indexes for table `ref_ssh_golongan`
--
ALTER TABLE `ref_ssh_golongan`
  ADD PRIMARY KEY (`id_golongan_ssh`) USING BTREE,
  ADD UNIQUE KEY `idx_ref_ssh_golongan` (`id_golongan_ssh`) USING BTREE;

--
-- Indexes for table `ref_ssh_kelompok`
--
ALTER TABLE `ref_ssh_kelompok`
  ADD PRIMARY KEY (`id_kelompok_ssh`) USING BTREE,
  ADD KEY `fk_ssh_kelompok` (`id_golongan_ssh`) USING BTREE;

--
-- Indexes for table `ref_ssh_perkada`
--
ALTER TABLE `ref_ssh_perkada`
  ADD PRIMARY KEY (`id_perkada`) USING BTREE,
  ADD UNIQUE KEY `idx_ref_ssh_perkada_2` (`id_perkada`,`id_perkada_induk`,`id_perubahan`) USING BTREE,
  ADD KEY `idx_ref_ssh_perkada_1` (`id_perkada`,`created_at`,`updated_at`) USING BTREE;

--
-- Indexes for table `ref_ssh_perkada_tarif`
--
ALTER TABLE `ref_ssh_perkada_tarif`
  ADD PRIMARY KEY (`id_tarif_perkada`) USING BTREE,
  ADD UNIQUE KEY `ref_ssh_perkada_tarif_unik` (`id_tarif_ssh`,`id_zona_perkada`) USING BTREE,
  ADD KEY `fk_ref_tarif_jumlah_1` (`id_zona_perkada`) USING BTREE,
  ADD KEY `idx_ref_ssh_tarif_jumlah` (`id_tarif_ssh`,`id_zona_perkada`) USING BTREE;

--
-- Indexes for table `ref_ssh_perkada_zona`
--
ALTER TABLE `ref_ssh_perkada_zona`
  ADD PRIMARY KEY (`id_zona_perkada`) USING BTREE,
  ADD UNIQUE KEY `idx_ref_ssh_tarif_jumlah` (`id_perkada`,`id_zona`,`id_perubahan`) USING BTREE,
  ADD KEY `fk_ref_tarif_jumlah_1` (`id_zona_perkada`,`no_urut`,`id_perkada`,`id_zona`) USING BTREE,
  ADD KEY `ref_ssh_perkada_zona_fk` (`id_zona`) USING BTREE;

--
-- Indexes for table `ref_ssh_rekening`
--
ALTER TABLE `ref_ssh_rekening`
  ADD PRIMARY KEY (`id_rekening_ssh`) USING BTREE,
  ADD UNIQUE KEY `fk_ref_ssh_rekening` (`id_tarif_ssh`,`id_rekening`) USING BTREE;

--
-- Indexes for table `ref_ssh_sub_kelompok`
--
ALTER TABLE `ref_ssh_sub_kelompok`
  ADD PRIMARY KEY (`id_sub_kelompok_ssh`) USING BTREE,
  ADD KEY `fk_ref_ssh_sub_kelompok` (`id_kelompok_ssh`) USING BTREE;

--
-- Indexes for table `ref_ssh_tarif`
--
ALTER TABLE `ref_ssh_tarif`
  ADD PRIMARY KEY (`id_tarif_ssh`) USING BTREE,
  ADD UNIQUE KEY `id_ref_ssh_tarif_1` (`id_tarif_ssh`,`no_urut`,`id_sub_kelompok_ssh`) USING BTREE,
  ADD KEY `id_ref_ssh_tarif` (`id_sub_kelompok_ssh`) USING BTREE;
ALTER TABLE `ref_ssh_tarif` ADD FULLTEXT KEY `uraian_tarif_ssh` (`uraian_tarif_ssh`);

--
-- Indexes for table `ref_ssh_zona`
--
ALTER TABLE `ref_ssh_zona`
  ADD PRIMARY KEY (`id_zona`) USING BTREE;

--
-- Indexes for table `ref_ssh_zona_lokasi`
--
ALTER TABLE `ref_ssh_zona_lokasi`
  ADD PRIMARY KEY (`id_zona_lokasi`) USING BTREE,
  ADD KEY `fk_zona_lokasi` (`id_zona`) USING BTREE;

--
-- Indexes for table `ref_status_usul`
--
ALTER TABLE `ref_status_usul`
  ADD PRIMARY KEY (`id_status_usul`) USING BTREE;

--
-- Indexes for table `ref_sub_unit`
--
ALTER TABLE `ref_sub_unit`
  ADD PRIMARY KEY (`id_sub_unit`) USING BTREE,
  ADD UNIQUE KEY `idx_ref_sub_unit` (`id_unit`,`kd_sub`) USING BTREE;

--
-- Indexes for table `ref_sumber_dana`
--
ALTER TABLE `ref_sumber_dana`
  ADD PRIMARY KEY (`id_sumber_dana`) USING BTREE;

--
-- Indexes for table `ref_tabel_dasar`
--
ALTER TABLE `ref_tabel_dasar`
  ADD PRIMARY KEY (`id_tabel_dasar`) USING BTREE;

--
-- Indexes for table `ref_tahun`
--
ALTER TABLE `ref_tahun`
  ADD PRIMARY KEY (`id_tahun`) USING BTREE;

--
-- Indexes for table `ref_unit`
--
ALTER TABLE `ref_unit`
  ADD PRIMARY KEY (`id_unit`) USING BTREE,
  ADD UNIQUE KEY `idx_ref_unit` (`id_bidang`,`kd_unit`) USING BTREE;

--
-- Indexes for table `ref_urusan`
--
ALTER TABLE `ref_urusan`
  ADD PRIMARY KEY (`kd_urusan`) USING BTREE;

--
-- Indexes for table `ref_user_role`
--
ALTER TABLE `ref_user_role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trx_asb_aktivitas`
--
ALTER TABLE `trx_asb_aktivitas`
  ADD PRIMARY KEY (`id_aktivitas_asb`) USING BTREE,
  ADD KEY `fk_trx_aktivitas_asb` (`id_asb_sub_sub_kelompok`) USING BTREE;

--
-- Indexes for table `trx_asb_kelompok`
--
ALTER TABLE `trx_asb_kelompok`
  ADD PRIMARY KEY (`id_asb_kelompok`) USING BTREE,
  ADD KEY `FK_trx_asb_cluster_trx_asb_perkada` (`id_asb_perkada`) USING BTREE;

--
-- Indexes for table `trx_asb_komponen`
--
ALTER TABLE `trx_asb_komponen`
  ADD PRIMARY KEY (`id_komponen_asb`) USING BTREE,
  ADD KEY `FK_trx_asb_komponen_trx_asb_aktivitas` (`id_aktivitas_asb`) USING BTREE;

--
-- Indexes for table `trx_asb_komponen_rinci`
--
ALTER TABLE `trx_asb_komponen_rinci`
  ADD PRIMARY KEY (`id_komponen_asb_rinci`) USING BTREE,
  ADD KEY `fk_ref_komponen_asb_rinc` (`id_tarif_ssh`) USING BTREE,
  ADD KEY `idx_ref_komponen_asb_rinci` (`id_komponen_asb`) USING BTREE,
  ADD KEY `FK_trx_asb_komponen_rinci_ref_satuan` (`id_satuan1`) USING BTREE,
  ADD KEY `FK_trx_asb_komponen_rinci_ref_satuan_2` (`id_satuan2`) USING BTREE,
  ADD KEY `FK_trx_asb_komponen_rinci_ref_satuan_3` (`id_satuan3`) USING BTREE;
ALTER TABLE `trx_asb_komponen_rinci` ADD FULLTEXT KEY `ket_group` (`ket_group`);

--
-- Indexes for table `trx_asb_perhitungan`
--
ALTER TABLE `trx_asb_perhitungan`
  ADD PRIMARY KEY (`id_perhitungan`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_perhitungan_asb` (`tahun_perhitungan`,`id_perkada`,`flag_aktif`) USING BTREE;

--
-- Indexes for table `trx_asb_perhitungan_rinci`
--
ALTER TABLE `trx_asb_perhitungan_rinci`
  ADD PRIMARY KEY (`id_perhitungan_rinci`) USING BTREE,
  ADD UNIQUE KEY `id_trx_perhitungan_aktivitas` (`id_perhitungan`,`id_asb_kelompok`,`id_asb_sub_kelompok`,`id_aktivitas_asb`,`id_komponen_asb`,`id_komponen_asb_rinci`,`id_zona`) USING BTREE;

--
-- Indexes for table `trx_asb_perkada`
--
ALTER TABLE `trx_asb_perkada`
  ADD PRIMARY KEY (`id_asb_perkada`) USING BTREE;

--
-- Indexes for table `trx_asb_sub_kelompok`
--
ALTER TABLE `trx_asb_sub_kelompok`
  ADD PRIMARY KEY (`id_asb_sub_kelompok`) USING BTREE,
  ADD KEY `FK_trx_asb_cluster_trx_asb_perkada` (`id_asb_kelompok`) USING BTREE;

--
-- Indexes for table `trx_asb_sub_sub_kelompok`
--
ALTER TABLE `trx_asb_sub_sub_kelompok`
  ADD PRIMARY KEY (`id_asb_sub_sub_kelompok`) USING BTREE,
  ADD KEY `FK_trx_asb_cluster_trx_asb_perkada` (`id_asb_sub_kelompok`) USING BTREE;

--
-- Indexes for table `trx_forum_skpd`
--
ALTER TABLE `trx_forum_skpd`
  ADD PRIMARY KEY (`id_forum_skpd`) USING BTREE,
  ADD UNIQUE KEY `id_unit_id_renja_id_kegiatan_ref` (`id_unit`,`id_kegiatan_ref`,`id_forum_program`) USING BTREE,
  ADD KEY `FK_trx_forum_skpd_trx_forum_skpd_program` (`id_forum_program`) USING BTREE;

--
-- Indexes for table `trx_forum_skpd_aktivitas`
--
ALTER TABLE `trx_forum_skpd_aktivitas`
  ADD PRIMARY KEY (`id_aktivitas_forum`) USING BTREE,
  ADD KEY `FK_trx_forum_skpd_aktivitas_trx_forum_skpd` (`id_forum_skpd`) USING BTREE;

--
-- Indexes for table `trx_forum_skpd_belanja`
--
ALTER TABLE `trx_forum_skpd_belanja`
  ADD PRIMARY KEY (`id_belanja_forum`) USING BTREE,
  ADD UNIQUE KEY `id_trx_forum_skpd_belanja` (`tahun_forum`,`no_urut`,`id_belanja_forum`,`id_lokasi_forum`) USING BTREE,
  ADD KEY `fk_trx_forum_skpd_belanja` (`id_lokasi_forum`) USING BTREE;

--
-- Indexes for table `trx_forum_skpd_dokumen`
--
ALTER TABLE `trx_forum_skpd_dokumen`
  ADD PRIMARY KEY (`id_dokumen_ranwal`) USING BTREE,
  ADD UNIQUE KEY `id_unit_renja` (`id_unit_renja`,`tahun_ranwal`) USING BTREE;

--
-- Indexes for table `trx_forum_skpd_kebijakan`
--
ALTER TABLE `trx_forum_skpd_kebijakan`
  ADD PRIMARY KEY (`id_kebijakan_renja`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_rpjmd_program_pelaksana` (`tahun_renja`,`id_unit`,`uraian_kebijakan`,`no_urut`) USING BTREE;

--
-- Indexes for table `trx_forum_skpd_kegiatan_indikator`
--
ALTER TABLE `trx_forum_skpd_kegiatan_indikator`
  ADD PRIMARY KEY (`id_indikator_kegiatan`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_forum_skpd`) USING BTREE,
  ADD KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  ADD KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_forum_skpd`) USING BTREE;

--
-- Indexes for table `trx_forum_skpd_lokasi`
--
ALTER TABLE `trx_forum_skpd_lokasi`
  ADD PRIMARY KEY (`id_lokasi_forum`) USING BTREE,
  ADD UNIQUE KEY `id_trx_forum_lokasi` (`id_pelaksana_forum`,`tahun_forum`,`no_urut`,`id_lokasi_forum`) USING BTREE;

--
-- Indexes for table `trx_forum_skpd_pelaksana`
--
ALTER TABLE `trx_forum_skpd_pelaksana`
  ADD PRIMARY KEY (`id_pelaksana_forum`) USING BTREE,
  ADD UNIQUE KEY `id_trx_forum_pelaksana` (`id_aktivitas_forum`,`tahun_forum`,`no_urut`,`id_pelaksana_forum`,`id_sub_unit`) USING BTREE;

--
-- Indexes for table `trx_forum_skpd_program`
--
ALTER TABLE `trx_forum_skpd_program`
  ADD PRIMARY KEY (`id_forum_program`) USING BTREE,
  ADD UNIQUE KEY `id_unit_id_renja_program_id_program_ref` (`id_unit`,`id_renja_program`,`id_program_ref`) USING BTREE,
  ADD KEY `FK_trx_forum_skpd_program_trx_forum_skpd_program_ranwal` (`id_forum_rkpdprog`) USING BTREE;

--
-- Indexes for table `trx_forum_skpd_program_indikator`
--
ALTER TABLE `trx_forum_skpd_program_indikator`
  ADD PRIMARY KEY (`id_indikator_program`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_forum_program`) USING BTREE,
  ADD KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  ADD KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_forum_program`) USING BTREE;

--
-- Indexes for table `trx_forum_skpd_program_ranwal`
--
ALTER TABLE `trx_forum_skpd_program_ranwal`
  ADD PRIMARY KEY (`id_forum_rkpdprog`) USING BTREE,
  ADD UNIQUE KEY `id_rkpd_ranwal_id_bidang_id_unit` (`id_rkpd_ranwal`,`id_bidang`,`id_unit`) USING BTREE;

--
-- Indexes for table `trx_forum_skpd_usulan`
--
ALTER TABLE `trx_forum_skpd_usulan`
  ADD PRIMARY KEY (`id_sumber_usulan`) USING BTREE,
  ADD KEY `id_trx_forum_skpd_usulan` (`id_ref_usulan`,`id_sumber_usulan`,`id_lokasi_forum`) USING BTREE,
  ADD KEY `FK_trx_forum_skpd_usulan_trx_forum_skpd_lokasi` (`id_lokasi_forum`) USING BTREE;

--
-- Indexes for table `trx_group_menu`
--
ALTER TABLE `trx_group_menu`
  ADD UNIQUE KEY `menu` (`menu`,`group_id`) USING BTREE;

--
-- Indexes for table `trx_isian_data_dasar`
--
ALTER TABLE `trx_isian_data_dasar`
  ADD PRIMARY KEY (`id_isian_tabel_dasar`) USING BTREE,
  ADD KEY `id_kolom_tabel_dasar` (`id_kolom_tabel_dasar`) USING BTREE,
  ADD KEY `id_kecamatan` (`id_kecamatan`) USING BTREE;

--
-- Indexes for table `trx_log_events`
--
ALTER TABLE `trx_log_events`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `trx_musrencam`
--
ALTER TABLE `trx_musrencam`
  ADD PRIMARY KEY (`id_musrencam`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_musrendes` (`id_renja`,`tahun_musren`,`no_urut`,`id_musrencam`,`id_kecamatan`,`id_usulan_desa`) USING BTREE;

--
-- Indexes for table `trx_musrencam_lokasi`
--
ALTER TABLE `trx_musrencam_lokasi`
  ADD PRIMARY KEY (`id_lokasi_musrencam`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_musrendes_lokasi` (`id_musrencam`,`tahun_musren`,`no_urut`,`id_lokasi_musrencam`,`id_desa`,`rt`,`rw`) USING BTREE;

--
-- Indexes for table `trx_musrendes`
--
ALTER TABLE `trx_musrendes`
  ADD PRIMARY KEY (`id_musrendes`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_musrendes` (`id_renja`,`tahun_renja`,`no_urut`,`id_musrendes`,`id_desa`,`id_usulan_rw`) USING BTREE;

--
-- Indexes for table `trx_musrendes_lokasi`
--
ALTER TABLE `trx_musrendes_lokasi`
  ADD PRIMARY KEY (`id_lokasi_musrendes`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_musrendes_lokasi` (`id_musrendes`,`tahun_musren`,`no_urut`,`id_lokasi_musrendes`,`id_desa`,`rt`,`rw`) USING BTREE;

--
-- Indexes for table `trx_musrendes_rw`
--
ALTER TABLE `trx_musrendes_rw`
  ADD PRIMARY KEY (`id_musrendes_rw`) USING BTREE,
  ADD UNIQUE KEY `tahun_musren` (`tahun_musren`,`no_urut`,`id_renja`,`id_desa`,`id_kegiatan`,`id_asb_aktivitas`,`rt`,`rw`) USING BTREE,
  ADD KEY `id_renja` (`id_renja`) USING BTREE;

--
-- Indexes for table `trx_musrendes_rw_lokasi`
--
ALTER TABLE `trx_musrendes_rw_lokasi`
  ADD PRIMARY KEY (`id_musrendes_lokasi`) USING BTREE;

--
-- Indexes for table `trx_musrenkab`
--
ALTER TABLE `trx_musrenkab`
  ADD PRIMARY KEY (`id_musrenkab`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_ranwal` (`tahun_rkpd`,`thn_id_rpjmd`,`id_visi_rpjmd`,`id_misi_rpjmd`,`id_tujuan_rpjmd`,`id_sasaran_rpjmd`,`id_program_rpjmd`,`no_urut`,`id_rkpd_rancangan`) USING BTREE;

--
-- Indexes for table `trx_musrenkab_aktivitas_pd`
--
ALTER TABLE `trx_musrenkab_aktivitas_pd`
  ADD PRIMARY KEY (`id_aktivitas_pd`) USING BTREE,
  ADD KEY `FK_trx_forum_skpd_aktivitas_trx_forum_skpd` (`id_pelaksana_pd`) USING BTREE;

--
-- Indexes for table `trx_musrenkab_belanja_pd`
--
ALTER TABLE `trx_musrenkab_belanja_pd`
  ADD PRIMARY KEY (`id_belanja_pd`) USING BTREE,
  ADD UNIQUE KEY `id_trx_forum_skpd_belanja` (`tahun_forum`,`no_urut`,`id_belanja_pd`,`id_aktivitas_pd`) USING BTREE,
  ADD KEY `fk_trx_forum_skpd_belanja` (`id_aktivitas_pd`) USING BTREE;

--
-- Indexes for table `trx_musrenkab_dokumen`
--
ALTER TABLE `trx_musrenkab_dokumen`
  ADD PRIMARY KEY (`id_dokumen_rkpd`) USING BTREE,
  ADD UNIQUE KEY `tahun_ranwal` (`tahun_rkpd`) USING BTREE;

--
-- Indexes for table `trx_musrenkab_indikator`
--
ALTER TABLE `trx_musrenkab_indikator`
  ADD PRIMARY KEY (`id_indikator_rkpd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_program_indikator` (`tahun_rkpd`,`id_musrenkab`,`kd_indikator`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_indikator` (`id_musrenkab`) USING BTREE;

--
-- Indexes for table `trx_musrenkab_kebijakan`
--
ALTER TABLE `trx_musrenkab_kebijakan`
  ADD PRIMARY KEY (`id_kebijakan_rkpd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_ranwal_kebijakan` (`tahun_rkpd`,`id_musrenkab`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_kebijakan` (`id_musrenkab`) USING BTREE;

--
-- Indexes for table `trx_musrenkab_kebijakan_pd`
--
ALTER TABLE `trx_musrenkab_kebijakan_pd`
  ADD PRIMARY KEY (`id_kebijakan_pd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_rpjmd_program_pelaksana` (`tahun_renja`,`id_unit`,`uraian_kebijakan`,`no_urut`) USING BTREE;

--
-- Indexes for table `trx_musrenkab_kegiatan_pd`
--
ALTER TABLE `trx_musrenkab_kegiatan_pd`
  ADD PRIMARY KEY (`id_kegiatan_pd`) USING BTREE,
  ADD UNIQUE KEY `id_unit_id_renja_id_kegiatan_ref` (`id_unit`,`id_kegiatan_ref`,`id_program_pd`) USING BTREE,
  ADD KEY `FK_trx_forum_skpd_trx_forum_skpd_program` (`id_program_pd`) USING BTREE;

--
-- Indexes for table `trx_musrenkab_keg_indikator_pd`
--
ALTER TABLE `trx_musrenkab_keg_indikator_pd`
  ADD PRIMARY KEY (`id_indikator_kegiatan`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_kegiatan_pd`) USING BTREE,
  ADD KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  ADD KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_kegiatan_pd`) USING BTREE;

--
-- Indexes for table `trx_musrenkab_lokasi_pd`
--
ALTER TABLE `trx_musrenkab_lokasi_pd`
  ADD PRIMARY KEY (`id_lokasi_pd`) USING BTREE,
  ADD UNIQUE KEY `id_trx_forum_lokasi` (`id_aktivitas_pd`,`tahun_forum`,`no_urut`,`id_lokasi_pd`) USING BTREE;

--
-- Indexes for table `trx_musrenkab_pelaksana`
--
ALTER TABLE `trx_musrenkab_pelaksana`
  ADD PRIMARY KEY (`id_pelaksana_rkpd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_program_pelaksana` (`tahun_rkpd`,`id_musrenkab`,`id_unit`,`id_urusan_rkpd`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana` (`id_musrenkab`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana_1` (`id_urusan_rkpd`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana_2` (`id_unit`) USING BTREE;

--
-- Indexes for table `trx_musrenkab_pelaksana_pd`
--
ALTER TABLE `trx_musrenkab_pelaksana_pd`
  ADD PRIMARY KEY (`id_pelaksana_pd`) USING BTREE,
  ADD UNIQUE KEY `id_trx_forum_pelaksana` (`id_kegiatan_pd`,`tahun_forum`,`no_urut`,`id_pelaksana_pd`,`id_sub_unit`) USING BTREE;

--
-- Indexes for table `trx_musrenkab_program_pd`
--
ALTER TABLE `trx_musrenkab_program_pd`
  ADD PRIMARY KEY (`id_program_pd`) USING BTREE,
  ADD UNIQUE KEY `id_unit_id_renja_program_id_program_ref` (`id_unit`,`id_pelaksana_rkpd`,`id_program_ref`,`id_rkpd_rancangan`) USING BTREE,
  ADD KEY `FK_trx_forum_skpd_program_trx_forum_skpd_program_ranwal` (`id_pelaksana_rkpd`) USING BTREE;

--
-- Indexes for table `trx_musrenkab_prog_indikator_pd`
--
ALTER TABLE `trx_musrenkab_prog_indikator_pd`
  ADD PRIMARY KEY (`id_indikator_program`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_program_pd`) USING BTREE,
  ADD KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  ADD KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_program_pd`) USING BTREE;

--
-- Indexes for table `trx_musrenkab_urusan`
--
ALTER TABLE `trx_musrenkab_urusan`
  ADD PRIMARY KEY (`id_urusan_rkpd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_program_pelaksana` (`tahun_rkpd`,`id_musrenkab`,`id_bidang`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana` (`id_musrenkab`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana_1` (`id_bidang`) USING BTREE;

--
-- Indexes for table `trx_pokir`
--
ALTER TABLE `trx_pokir`
  ADD PRIMARY KEY (`id_pokir`) USING BTREE,
  ADD UNIQUE KEY `id_tahun` (`id_tahun`,`tanggal_pengusul`,`asal_pengusul`,`jabatan_pengusul`,`nomor_anggota`) USING BTREE;

--
-- Indexes for table `trx_pokir_lokasi`
--
ALTER TABLE `trx_pokir_lokasi`
  ADD PRIMARY KEY (`id_pokir_lokasi`) USING BTREE,
  ADD UNIQUE KEY `id_pokir_usulan` (`id_pokir_usulan`,`id_kecamatan`,`id_desa`,`rw`,`rt`) USING BTREE;

--
-- Indexes for table `trx_pokir_tl`
--
ALTER TABLE `trx_pokir_tl`
  ADD PRIMARY KEY (`id_pokir_tl`) USING BTREE,
  ADD UNIQUE KEY `id_pokir_usulan` (`id_pokir`,`id_pokir_usulan`,`id_pokir_lokasi`) USING BTREE,
  ADD KEY `trx_pokir_tl_ibfk_1` (`id_pokir_usulan`) USING BTREE;

--
-- Indexes for table `trx_pokir_tl_unit`
--
ALTER TABLE `trx_pokir_tl_unit`
  ADD PRIMARY KEY (`id_pokir_unit`) USING BTREE,
  ADD UNIQUE KEY `id_pokir_usulan` (`id_pokir`,`id_pokir_usulan`,`id_pokir_lokasi`) USING BTREE,
  ADD KEY `trx_pokir_tl_ibfk_1` (`id_pokir_usulan`) USING BTREE,
  ADD KEY `trx_pokir_tl_unit_ibfk_1` (`id_pokir_tl`) USING BTREE;

--
-- Indexes for table `trx_pokir_usulan`
--
ALTER TABLE `trx_pokir_usulan`
  ADD PRIMARY KEY (`id_pokir_usulan`) USING BTREE,
  ADD UNIQUE KEY `id_pokir` (`id_pokir`,`no_urut`) USING BTREE,
  ADD KEY `id_unit` (`id_unit`) USING BTREE;

--
-- Indexes for table `trx_renja_aktivitas`
--
ALTER TABLE `trx_renja_aktivitas`
  ADD PRIMARY KEY (`id_aktivitas_renja`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rancangan_renja_pelaksana` (`id_renja`,`tahun_renja`,`no_urut`,`id_aktivitas_renja`) USING BTREE;

--
-- Indexes for table `trx_renja_belanja`
--
ALTER TABLE `trx_renja_belanja`
  ADD PRIMARY KEY (`id_belanja_renja`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renja_rancangan_belanja` (`id_lokasi_renja`,`tahun_renja`,`no_urut`,`id_belanja_renja`) USING BTREE;

--
-- Indexes for table `trx_renja_dokumen`
--
ALTER TABLE `trx_renja_dokumen`
  ADD PRIMARY KEY (`id_dokumen_ranwal`) USING BTREE,
  ADD UNIQUE KEY `id_unit_renja` (`id_unit_renja`,`tahun_ranwal`) USING BTREE;

--
-- Indexes for table `trx_renja_kebijakan`
--
ALTER TABLE `trx_renja_kebijakan`
  ADD PRIMARY KEY (`id_kebijakan_renja`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renja_rancangan_kebijakan` (`tahun_renja`,`id_unit`,`no_urut`,`id_sasaran_renstra`,`id_kebijakan_renja`,`id_renja`) USING BTREE,
  ADD KEY `fk_trx_renja_rancangan_kebijakan` (`id_sasaran_renstra`) USING BTREE;

--
-- Indexes for table `trx_renja_kegiatan`
--
ALTER TABLE `trx_renja_kegiatan`
  ADD PRIMARY KEY (`id_renja`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rancangan_renja` (`id_rkpd_renstra`,`tahun_renja`,`no_urut`,`id_renja`) USING BTREE,
  ADD KEY `idx_trx_rancangan_renja_1` (`id_rkpd_ranwal`) USING BTREE,
  ADD KEY `id_program_renstra` (`id_program_renstra`) USING BTREE,
  ADD KEY `id_sasaran_renstra` (`id_sasaran_renstra`) USING BTREE,
  ADD KEY `FK_trx_renja_rancangan_trx_renja_rancangan_program` (`id_renja_program`) USING BTREE;

--
-- Indexes for table `trx_renja_kegiatan_indikator`
--
ALTER TABLE `trx_renja_kegiatan_indikator`
  ADD PRIMARY KEY (`id_indikator_kegiatan_renja`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_renja`) USING BTREE,
  ADD KEY `FK_trx_renja_rancangan_indikator_trx_renja_rancangan` (`id_renja`) USING BTREE;

--
-- Indexes for table `trx_renja_lokasi`
--
ALTER TABLE `trx_renja_lokasi`
  ADD PRIMARY KEY (`id_lokasi_renja`) USING BTREE,
  ADD UNIQUE KEY `idx_rancangan_renja_lokasi` (`id_pelaksana_renja`,`tahun_renja`,`no_urut`,`id_lokasi_renja`) USING BTREE;

--
-- Indexes for table `trx_renja_pelaksana`
--
ALTER TABLE `trx_renja_pelaksana`
  ADD PRIMARY KEY (`id_pelaksana_renja`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rancangan_renja_pelaksana` (`id_renja`,`tahun_renja`,`no_urut`,`id_pelaksana_renja`) USING BTREE;

--
-- Indexes for table `trx_renja_program`
--
ALTER TABLE `trx_renja_program`
  ADD PRIMARY KEY (`id_renja_program`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rancangan_renja` (`tahun_renja`,`no_urut`,`id_rkpd_ranwal`,`id_program_rpjmd`,`id_unit`,`id_bidang`,`id_renja_ranwal`) USING BTREE,
  ADD KEY `idx_trx_rancangan_renja_1` (`id_rkpd_ranwal`) USING BTREE,
  ADD KEY `id_program_renstra` (`id_program_renstra`) USING BTREE,
  ADD KEY `id_sasaran_renstra` (`id_sasaran_renstra`) USING BTREE,
  ADD KEY `trx_renja_rancangan_program_ibfk_2` (`id_renja_ranwal`) USING BTREE;

--
-- Indexes for table `trx_renja_program_indikator`
--
ALTER TABLE `trx_renja_program_indikator`
  ADD PRIMARY KEY (`id_indikator_program_renja`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_renja_program`) USING BTREE,
  ADD KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  ADD KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_renja_program`) USING BTREE;

--
-- Indexes for table `trx_renja_program_rkpd`
--
ALTER TABLE `trx_renja_program_rkpd`
  ADD PRIMARY KEY (`id_renja_ranwal`) USING BTREE,
  ADD UNIQUE KEY `tahun_renja_id_rkpd_ranwal_id_unit` (`tahun_renja`,`id_rkpd_ranwal`,`id_unit`) USING BTREE;

--
-- Indexes for table `trx_renja_rancangan`
--
ALTER TABLE `trx_renja_rancangan`
  ADD PRIMARY KEY (`id_renja`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rancangan_renja` (`id_rkpd_renstra`,`tahun_renja`,`no_urut`,`id_renja`) USING BTREE,
  ADD KEY `idx_trx_rancangan_renja_1` (`id_rkpd_ranwal`) USING BTREE,
  ADD KEY `id_program_renstra` (`id_program_renstra`) USING BTREE,
  ADD KEY `id_sasaran_renstra` (`id_sasaran_renstra`) USING BTREE,
  ADD KEY `FK_trx_renja_rancangan_trx_renja_rancangan_program` (`id_renja_program`) USING BTREE;

--
-- Indexes for table `trx_renja_rancangan_aktivitas`
--
ALTER TABLE `trx_renja_rancangan_aktivitas`
  ADD PRIMARY KEY (`id_aktivitas_renja`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rancangan_renja_pelaksana` (`id_renja`,`tahun_renja`,`no_urut`,`id_aktivitas_renja`) USING BTREE;

--
-- Indexes for table `trx_renja_rancangan_belanja`
--
ALTER TABLE `trx_renja_rancangan_belanja`
  ADD PRIMARY KEY (`id_belanja_renja`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renja_rancangan_belanja` (`id_lokasi_renja`,`tahun_renja`,`no_urut`,`id_belanja_renja`) USING BTREE;

--
-- Indexes for table `trx_renja_rancangan_dokumen`
--
ALTER TABLE `trx_renja_rancangan_dokumen`
  ADD PRIMARY KEY (`id_dokumen_ranwal`) USING BTREE,
  ADD UNIQUE KEY `id_unit_renja` (`id_unit_renja`,`tahun_ranwal`) USING BTREE;

--
-- Indexes for table `trx_renja_rancangan_indikator`
--
ALTER TABLE `trx_renja_rancangan_indikator`
  ADD PRIMARY KEY (`id_indikator_kegiatan_renja`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_renja`) USING BTREE,
  ADD KEY `FK_trx_renja_rancangan_indikator_trx_renja_rancangan` (`id_renja`) USING BTREE;

--
-- Indexes for table `trx_renja_rancangan_kebijakan`
--
ALTER TABLE `trx_renja_rancangan_kebijakan`
  ADD PRIMARY KEY (`id_kebijakan_renja`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renja_rancangan_kebijakan` (`tahun_renja`,`id_unit`,`no_urut`,`id_sasaran_renstra`,`id_kebijakan_renja`,`id_renja`) USING BTREE,
  ADD KEY `fk_trx_renja_rancangan_kebijakan` (`id_sasaran_renstra`) USING BTREE;

--
-- Indexes for table `trx_renja_rancangan_lokasi`
--
ALTER TABLE `trx_renja_rancangan_lokasi`
  ADD PRIMARY KEY (`id_lokasi_renja`) USING BTREE,
  ADD UNIQUE KEY `idx_rancangan_renja_lokasi` (`id_pelaksana_renja`,`tahun_renja`,`no_urut`,`id_lokasi_renja`) USING BTREE;

--
-- Indexes for table `trx_renja_rancangan_pelaksana`
--
ALTER TABLE `trx_renja_rancangan_pelaksana`
  ADD PRIMARY KEY (`id_pelaksana_renja`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rancangan_renja_pelaksana` (`id_renja`,`tahun_renja`,`no_urut`,`id_pelaksana_renja`) USING BTREE;

--
-- Indexes for table `trx_renja_rancangan_program`
--
ALTER TABLE `trx_renja_rancangan_program`
  ADD PRIMARY KEY (`id_renja_program`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rancangan_renja` (`tahun_renja`,`no_urut`,`id_rkpd_ranwal`,`id_program_rpjmd`,`id_unit`,`id_bidang`,`id_renja_ranwal`) USING BTREE,
  ADD KEY `idx_trx_rancangan_renja_1` (`id_rkpd_ranwal`) USING BTREE,
  ADD KEY `id_program_renstra` (`id_program_renstra`) USING BTREE,
  ADD KEY `id_sasaran_renstra` (`id_sasaran_renstra`) USING BTREE,
  ADD KEY `trx_renja_rancangan_program_ibfk_2` (`id_renja_ranwal`) USING BTREE;

--
-- Indexes for table `trx_renja_rancangan_program_indikator`
--
ALTER TABLE `trx_renja_rancangan_program_indikator`
  ADD PRIMARY KEY (`id_indikator_program_renja`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_renja_program`) USING BTREE,
  ADD KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  ADD KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_renja_program`) USING BTREE;

--
-- Indexes for table `trx_renja_rancangan_program_ranwal`
--
ALTER TABLE `trx_renja_rancangan_program_ranwal`
  ADD PRIMARY KEY (`id_renja_ranwal`) USING BTREE,
  ADD UNIQUE KEY `tahun_renja_id_rkpd_ranwal_id_unit` (`tahun_renja`,`id_rkpd_ranwal`,`id_unit`) USING BTREE;

--
-- Indexes for table `trx_renja_rancangan_ref_pokir`
--
ALTER TABLE `trx_renja_rancangan_ref_pokir`
  ADD PRIMARY KEY (`id_ref_pokir_renja`) USING BTREE,
  ADD UNIQUE KEY `id_aktivitas_renja` (`id_aktivitas_renja`,`id_pokir_usulan`) USING BTREE,
  ADD KEY `id_pokir_usulan` (`id_pokir_usulan`) USING BTREE;

--
-- Indexes for table `trx_renja_ranwal_aktivitas`
--
ALTER TABLE `trx_renja_ranwal_aktivitas`
  ADD PRIMARY KEY (`id_aktivitas_renja`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rancangan_renja_pelaksana` (`id_renja`,`tahun_renja`,`no_urut`,`id_aktivitas_renja`) USING BTREE;

--
-- Indexes for table `trx_renja_ranwal_dokumen`
--
ALTER TABLE `trx_renja_ranwal_dokumen`
  ADD PRIMARY KEY (`id_dokumen_ranwal`) USING BTREE,
  ADD UNIQUE KEY `id_unit_renja` (`id_unit_renja`,`tahun_ranwal`) USING BTREE;

--
-- Indexes for table `trx_renja_ranwal_kegiatan`
--
ALTER TABLE `trx_renja_ranwal_kegiatan`
  ADD PRIMARY KEY (`id_renja`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rancangan_renja` (`id_rkpd_renstra`,`tahun_renja`,`no_urut`,`id_renja`) USING BTREE,
  ADD KEY `idx_trx_rancangan_renja_1` (`id_rkpd_ranwal`) USING BTREE,
  ADD KEY `id_program_renstra` (`id_program_renstra`) USING BTREE,
  ADD KEY `id_sasaran_renstra` (`id_sasaran_renstra`) USING BTREE,
  ADD KEY `FK_trx_renja_rancangan_trx_renja_rancangan_program` (`id_renja_program`) USING BTREE;

--
-- Indexes for table `trx_renja_ranwal_kegiatan_indikator`
--
ALTER TABLE `trx_renja_ranwal_kegiatan_indikator`
  ADD PRIMARY KEY (`id_indikator_kegiatan_renja`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_renja`) USING BTREE,
  ADD KEY `FK_trx_renja_rancangan_indikator_trx_renja_rancangan` (`id_renja`) USING BTREE;

--
-- Indexes for table `trx_renja_ranwal_pelaksana`
--
ALTER TABLE `trx_renja_ranwal_pelaksana`
  ADD PRIMARY KEY (`id_pelaksana_renja`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rancangan_renja_pelaksana` (`id_renja`,`tahun_renja`,`no_urut`,`id_pelaksana_renja`) USING BTREE;

--
-- Indexes for table `trx_renja_ranwal_program`
--
ALTER TABLE `trx_renja_ranwal_program`
  ADD PRIMARY KEY (`id_renja_program`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rancangan_renja` (`tahun_renja`,`no_urut`,`id_rkpd_ranwal`,`id_program_rpjmd`,`id_unit`,`id_bidang`,`id_renja_ranwal`) USING BTREE,
  ADD KEY `idx_trx_rancangan_renja_1` (`id_rkpd_ranwal`) USING BTREE,
  ADD KEY `id_program_renstra` (`id_program_renstra`) USING BTREE,
  ADD KEY `id_sasaran_renstra` (`id_sasaran_renstra`) USING BTREE,
  ADD KEY `trx_renja_rancangan_program_ibfk_2` (`id_renja_ranwal`) USING BTREE;

--
-- Indexes for table `trx_renja_ranwal_program_indikator`
--
ALTER TABLE `trx_renja_ranwal_program_indikator`
  ADD PRIMARY KEY (`id_indikator_program_renja`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_renja_program`) USING BTREE,
  ADD KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  ADD KEY `trx_renja_ranwal_program_indikator_ibfk_1` (`id_renja_program`) USING BTREE;

--
-- Indexes for table `trx_renja_ranwal_program_rkpd`
--
ALTER TABLE `trx_renja_ranwal_program_rkpd`
  ADD PRIMARY KEY (`id_renja_ranwal`) USING BTREE,
  ADD UNIQUE KEY `tahun_renja_id_rkpd_ranwal_id_unit` (`tahun_renja`,`id_rkpd_ranwal`,`id_unit`) USING BTREE,
  ADD KEY `id_rkpd_ranwal` (`id_rkpd_ranwal`) USING BTREE;

--
-- Indexes for table `trx_renstra_dokumen`
--
ALTER TABLE `trx_renstra_dokumen`
  ADD PRIMARY KEY (`id_renstra`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renstra_dokumen` (`id_rpjmd`,`id_unit`) USING BTREE,
  ADD KEY `fk_trx_renstra_dokumen_1` (`id_unit`) USING BTREE;

--
-- Indexes for table `trx_renstra_kebijakan`
--
ALTER TABLE `trx_renstra_kebijakan`
  ADD PRIMARY KEY (`id_kebijakan_renstra`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renstra_kebijakan` (`thn_id`,`id_sasaran_renstra`,`id_kebijakan_renstra`,`id_perubahan`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_renstra_kebijakan` (`id_sasaran_renstra`) USING BTREE;

--
-- Indexes for table `trx_renstra_kegiatan`
--
ALTER TABLE `trx_renstra_kegiatan`
  ADD PRIMARY KEY (`id_kegiatan_renstra`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renstra_kegiatan` (`thn_id`,`id_program_renstra`,`id_kegiatan_renstra`,`id_perubahan`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_renstra_kegiatan` (`id_program_renstra`) USING BTREE;

--
-- Indexes for table `trx_renstra_kegiatan_indikator`
--
ALTER TABLE `trx_renstra_kegiatan_indikator`
  ADD PRIMARY KEY (`id_indikator_kegiatan_renstra`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renstra_kegiatan_indikator` (`thn_id`,`id_kegiatan_renstra`,`id_perubahan`,`kd_indikator`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_renstra_kegiatan_indikator` (`id_kegiatan_renstra`) USING BTREE;

--
-- Indexes for table `trx_renstra_kegiatan_pelaksana`
--
ALTER TABLE `trx_renstra_kegiatan_pelaksana`
  ADD PRIMARY KEY (`id_kegiatan_renstra_pelaksana`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renstra_kegiatan_pelaksana` (`thn_id`,`id_kegiatan_renstra`,`id_perubahan`,`id_sub_unit`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_renstra_kegiatan_pelaksana` (`id_kegiatan_renstra`) USING BTREE;

--
-- Indexes for table `trx_renstra_misi`
--
ALTER TABLE `trx_renstra_misi`
  ADD PRIMARY KEY (`id_misi_renstra`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renstra_misi` (`id_visi_renstra`,`thn_id`,`no_urut`,`id_misi_renstra`,`id_perubahan`) USING BTREE;

--
-- Indexes for table `trx_renstra_program`
--
ALTER TABLE `trx_renstra_program`
  ADD PRIMARY KEY (`id_program_renstra`) USING BTREE,
  ADD UNIQUE KEY `idx_renstra_program` (`thn_id`,`id_sasaran_renstra`,`id_program_renstra`,`id_perubahan`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_renstra_program` (`id_sasaran_renstra`) USING BTREE,
  ADD KEY `fk_trx_renstra_program_1` (`id_program_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_renstra_program_indikator`
--
ALTER TABLE `trx_renstra_program_indikator`
  ADD PRIMARY KEY (`id_indikator_program_renstra`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renstra_program_indikator` (`thn_id`,`id_program_renstra`,`id_indikator_program_renstra`,`id_perubahan`,`kd_indikator`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_renstra_program_indikator` (`id_program_renstra`) USING BTREE;

--
-- Indexes for table `trx_renstra_sasaran`
--
ALTER TABLE `trx_renstra_sasaran`
  ADD PRIMARY KEY (`id_sasaran_renstra`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renstra_sasaran` (`thn_id`,`id_tujuan_renstra`,`id_sasaran_renstra`,`id_perubahan`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_renstra_sasaran` (`id_tujuan_renstra`) USING BTREE;

--
-- Indexes for table `trx_renstra_sasaran_indikator`
--
ALTER TABLE `trx_renstra_sasaran_indikator`
  ADD PRIMARY KEY (`id_indikator_sasaran_renstra`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_sasaran_indikator` (`thn_id`,`id_sasaran_renstra`,`id_indikator_sasaran_renstra`,`id_perubahan`,`kd_indikator`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_renstra_sasaran_indikator` (`id_sasaran_renstra`) USING BTREE;

--
-- Indexes for table `trx_renstra_strategi`
--
ALTER TABLE `trx_renstra_strategi`
  ADD PRIMARY KEY (`id_strategi_renstra`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renstra_kebijakan` (`thn_id`,`id_sasaran_renstra`,`id_perubahan`,`id_strategi_renstra`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_renstra_strategi` (`id_sasaran_renstra`) USING BTREE;

--
-- Indexes for table `trx_renstra_tujuan`
--
ALTER TABLE `trx_renstra_tujuan`
  ADD PRIMARY KEY (`id_tujuan_renstra`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renstra_tujuan` (`thn_id`,`id_misi_renstra`,`id_tujuan_renstra`,`id_perubahan`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_renstra_tujuan` (`id_misi_renstra`) USING BTREE;

--
-- Indexes for table `trx_renstra_tujuan_indikator`
--
ALTER TABLE `trx_renstra_tujuan_indikator`
  ADD PRIMARY KEY (`id_indikator_tujuan_renstra`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_sasaran_indikator` (`thn_id`,`id_tujuan_renstra`,`id_indikator_tujuan_renstra`,`id_perubahan`,`kd_indikator`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_renstra_sasaran_indikator` (`id_tujuan_renstra`) USING BTREE;

--
-- Indexes for table `trx_renstra_visi`
--
ALTER TABLE `trx_renstra_visi`
  ADD PRIMARY KEY (`id_visi_renstra`) USING BTREE,
  ADD UNIQUE KEY `idx_ta_visi_rpjmd` (`thn_id`,`id_visi_renstra`,`thn_awal_renstra`,`thn_akhir_renstra`,`id_perubahan`,`id_unit`,`no_urut`) USING BTREE,
  ADD KEY `FK_trx_renstra_visi_ref_unit` (`id_unit`) USING BTREE;

--
-- Indexes for table `trx_rkpd_final`
--
ALTER TABLE `trx_rkpd_final`
  ADD PRIMARY KEY (`id_rkpd_rancangan`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_ranwal` (`tahun_rkpd`,`thn_id_rpjmd`,`id_visi_rpjmd`,`id_misi_rpjmd`,`id_tujuan_rpjmd`,`id_sasaran_rpjmd`,`id_program_rpjmd`,`no_urut`,`id_forum_rkpdprog`) USING BTREE;

--
-- Indexes for table `trx_rkpd_final_aktivitas_pd`
--
ALTER TABLE `trx_rkpd_final_aktivitas_pd`
  ADD PRIMARY KEY (`id_aktivitas_pd`) USING BTREE,
  ADD KEY `FK_trx_forum_skpd_aktivitas_trx_forum_skpd` (`id_pelaksana_pd`) USING BTREE;

--
-- Indexes for table `trx_rkpd_final_belanja_pd`
--
ALTER TABLE `trx_rkpd_final_belanja_pd`
  ADD PRIMARY KEY (`id_belanja_pd`) USING BTREE,
  ADD UNIQUE KEY `id_trx_forum_skpd_belanja` (`tahun_forum`,`no_urut`,`id_belanja_pd`,`id_aktivitas_pd`) USING BTREE,
  ADD KEY `fk_trx_forum_skpd_belanja` (`id_aktivitas_pd`) USING BTREE;

--
-- Indexes for table `trx_rkpd_final_dokumen`
--
ALTER TABLE `trx_rkpd_final_dokumen`
  ADD PRIMARY KEY (`id_log`) USING BTREE;

--
-- Indexes for table `trx_rkpd_final_indikator`
--
ALTER TABLE `trx_rkpd_final_indikator`
  ADD PRIMARY KEY (`id_indikator_rkpd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_program_indikator` (`tahun_rkpd`,`id_rkpd_rancangan`,`kd_indikator`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_indikator` (`id_rkpd_rancangan`) USING BTREE;

--
-- Indexes for table `trx_rkpd_final_kebijakan`
--
ALTER TABLE `trx_rkpd_final_kebijakan`
  ADD PRIMARY KEY (`id_kebijakan_rkpd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_ranwal_kebijakan` (`tahun_rkpd`,`id_rkpd_rancangan`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_kebijakan` (`id_rkpd_rancangan`) USING BTREE;

--
-- Indexes for table `trx_rkpd_final_kebijakan_pd`
--
ALTER TABLE `trx_rkpd_final_kebijakan_pd`
  ADD PRIMARY KEY (`id_kebijakan_pd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_rpjmd_program_pelaksana` (`tahun_renja`,`id_unit`,`uraian_kebijakan`,`no_urut`) USING BTREE;

--
-- Indexes for table `trx_rkpd_final_kegiatan_pd`
--
ALTER TABLE `trx_rkpd_final_kegiatan_pd`
  ADD PRIMARY KEY (`id_kegiatan_pd`) USING BTREE,
  ADD UNIQUE KEY `id_unit_id_renja_id_kegiatan_ref` (`id_unit`,`id_kegiatan_ref`,`id_program_pd`) USING BTREE,
  ADD KEY `FK_trx_forum_skpd_trx_forum_skpd_program` (`id_program_pd`) USING BTREE;

--
-- Indexes for table `trx_rkpd_final_keg_indikator_pd`
--
ALTER TABLE `trx_rkpd_final_keg_indikator_pd`
  ADD PRIMARY KEY (`id_indikator_kegiatan`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_kegiatan_pd`) USING BTREE,
  ADD KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  ADD KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_kegiatan_pd`) USING BTREE;

--
-- Indexes for table `trx_rkpd_final_lokasi_pd`
--
ALTER TABLE `trx_rkpd_final_lokasi_pd`
  ADD PRIMARY KEY (`id_lokasi_pd`) USING BTREE,
  ADD UNIQUE KEY `id_trx_forum_lokasi` (`id_aktivitas_pd`,`tahun_forum`,`no_urut`,`id_lokasi_pd`) USING BTREE;

--
-- Indexes for table `trx_rkpd_final_pelaksana`
--
ALTER TABLE `trx_rkpd_final_pelaksana`
  ADD PRIMARY KEY (`id_pelaksana_rkpd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_rancangan`,`id_unit`,`id_urusan_rkpd`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana` (`id_rkpd_rancangan`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana_1` (`id_urusan_rkpd`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana_2` (`id_unit`) USING BTREE;

--
-- Indexes for table `trx_rkpd_final_pelaksana_pd`
--
ALTER TABLE `trx_rkpd_final_pelaksana_pd`
  ADD PRIMARY KEY (`id_pelaksana_pd`) USING BTREE,
  ADD UNIQUE KEY `id_trx_forum_pelaksana` (`id_kegiatan_pd`,`tahun_forum`,`no_urut`,`id_pelaksana_pd`,`id_sub_unit`) USING BTREE;

--
-- Indexes for table `trx_rkpd_final_program_pd`
--
ALTER TABLE `trx_rkpd_final_program_pd`
  ADD PRIMARY KEY (`id_program_pd`) USING BTREE,
  ADD UNIQUE KEY `id_unit_id_renja_program_id_program_ref` (`id_unit`,`id_renja_program`,`id_program_ref`,`id_forum_program`) USING BTREE,
  ADD KEY `FK_trx_forum_skpd_program_trx_forum_skpd_program_ranwal` (`id_rkpd_rancangan`) USING BTREE;

--
-- Indexes for table `trx_rkpd_final_prog_indikator_pd`
--
ALTER TABLE `trx_rkpd_final_prog_indikator_pd`
  ADD PRIMARY KEY (`id_indikator_program`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_program_pd`) USING BTREE,
  ADD KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  ADD KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_program_pd`) USING BTREE;

--
-- Indexes for table `trx_rkpd_final_urusan`
--
ALTER TABLE `trx_rkpd_final_urusan`
  ADD PRIMARY KEY (`id_urusan_rkpd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_rancangan`,`id_bidang`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana` (`id_rkpd_rancangan`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana_1` (`id_bidang`) USING BTREE;

--
-- Indexes for table `trx_rkpd_rancangan`
--
ALTER TABLE `trx_rkpd_rancangan`
  ADD PRIMARY KEY (`id_rkpd_rancangan`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_ranwal` (`tahun_rkpd`,`thn_id_rpjmd`,`id_visi_rpjmd`,`id_misi_rpjmd`,`id_tujuan_rpjmd`,`id_sasaran_rpjmd`,`id_program_rpjmd`,`no_urut`,`id_forum_rkpdprog`) USING BTREE;

--
-- Indexes for table `trx_rkpd_rancangan_aktivitas_pd`
--
ALTER TABLE `trx_rkpd_rancangan_aktivitas_pd`
  ADD PRIMARY KEY (`id_aktivitas_pd`) USING BTREE,
  ADD KEY `FK_trx_forum_skpd_aktivitas_trx_forum_skpd` (`id_pelaksana_pd`) USING BTREE;

--
-- Indexes for table `trx_rkpd_rancangan_belanja_pd`
--
ALTER TABLE `trx_rkpd_rancangan_belanja_pd`
  ADD PRIMARY KEY (`id_belanja_pd`) USING BTREE,
  ADD UNIQUE KEY `id_trx_forum_skpd_belanja` (`tahun_forum`,`no_urut`,`id_belanja_pd`,`id_aktivitas_pd`) USING BTREE,
  ADD KEY `fk_trx_forum_skpd_belanja` (`id_aktivitas_pd`) USING BTREE;

--
-- Indexes for table `trx_rkpd_rancangan_dokumen`
--
ALTER TABLE `trx_rkpd_rancangan_dokumen`
  ADD PRIMARY KEY (`id_dokumen_rkpd`) USING BTREE,
  ADD UNIQUE KEY `tahun_ranwal` (`tahun_rkpd`) USING BTREE;

--
-- Indexes for table `trx_rkpd_rancangan_indikator`
--
ALTER TABLE `trx_rkpd_rancangan_indikator`
  ADD PRIMARY KEY (`id_indikator_rkpd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_program_indikator` (`tahun_rkpd`,`id_rkpd_rancangan`,`kd_indikator`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_indikator` (`id_rkpd_rancangan`) USING BTREE;

--
-- Indexes for table `trx_rkpd_rancangan_kebijakan`
--
ALTER TABLE `trx_rkpd_rancangan_kebijakan`
  ADD PRIMARY KEY (`id_kebijakan_rkpd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_ranwal_kebijakan` (`tahun_rkpd`,`id_rkpd_rancangan`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_kebijakan` (`id_rkpd_rancangan`) USING BTREE;

--
-- Indexes for table `trx_rkpd_rancangan_kebijakan_pd`
--
ALTER TABLE `trx_rkpd_rancangan_kebijakan_pd`
  ADD PRIMARY KEY (`id_kebijakan_pd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_rpjmd_program_pelaksana` (`tahun_renja`,`id_unit`,`uraian_kebijakan`,`no_urut`) USING BTREE;

--
-- Indexes for table `trx_rkpd_rancangan_kegiatan_pd`
--
ALTER TABLE `trx_rkpd_rancangan_kegiatan_pd`
  ADD PRIMARY KEY (`id_kegiatan_pd`) USING BTREE,
  ADD UNIQUE KEY `id_unit_id_renja_id_kegiatan_ref` (`id_unit`,`id_kegiatan_ref`,`id_program_pd`) USING BTREE,
  ADD KEY `FK_trx_forum_skpd_trx_forum_skpd_program` (`id_program_pd`) USING BTREE;

--
-- Indexes for table `trx_rkpd_rancangan_keg_indikator_pd`
--
ALTER TABLE `trx_rkpd_rancangan_keg_indikator_pd`
  ADD PRIMARY KEY (`id_indikator_kegiatan`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_kegiatan_pd`) USING BTREE,
  ADD KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  ADD KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_kegiatan_pd`) USING BTREE;

--
-- Indexes for table `trx_rkpd_rancangan_lokasi_pd`
--
ALTER TABLE `trx_rkpd_rancangan_lokasi_pd`
  ADD PRIMARY KEY (`id_lokasi_pd`) USING BTREE,
  ADD UNIQUE KEY `id_trx_forum_lokasi` (`id_aktivitas_pd`,`tahun_forum`,`no_urut`,`id_lokasi_pd`) USING BTREE;

--
-- Indexes for table `trx_rkpd_rancangan_pelaksana`
--
ALTER TABLE `trx_rkpd_rancangan_pelaksana`
  ADD PRIMARY KEY (`id_pelaksana_rkpd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_rancangan`,`id_unit`,`id_urusan_rkpd`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana` (`id_rkpd_rancangan`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana_1` (`id_urusan_rkpd`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana_2` (`id_unit`) USING BTREE;

--
-- Indexes for table `trx_rkpd_rancangan_pelaksana_pd`
--
ALTER TABLE `trx_rkpd_rancangan_pelaksana_pd`
  ADD PRIMARY KEY (`id_pelaksana_pd`) USING BTREE,
  ADD UNIQUE KEY `id_trx_forum_pelaksana` (`id_kegiatan_pd`,`tahun_forum`,`no_urut`,`id_pelaksana_pd`,`id_sub_unit`) USING BTREE;

--
-- Indexes for table `trx_rkpd_rancangan_program_pd`
--
ALTER TABLE `trx_rkpd_rancangan_program_pd`
  ADD PRIMARY KEY (`id_program_pd`) USING BTREE,
  ADD UNIQUE KEY `id_unit_id_renja_program_id_program_ref` (`id_unit`,`id_renja_program`,`id_program_ref`,`id_forum_program`) USING BTREE,
  ADD KEY `FK_trx_forum_skpd_program_trx_forum_skpd_program_ranwal` (`id_rkpd_rancangan`) USING BTREE;

--
-- Indexes for table `trx_rkpd_rancangan_prog_indikator_pd`
--
ALTER TABLE `trx_rkpd_rancangan_prog_indikator_pd`
  ADD PRIMARY KEY (`id_indikator_program`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_program_pd`) USING BTREE,
  ADD KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  ADD KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_program_pd`) USING BTREE;

--
-- Indexes for table `trx_rkpd_rancangan_urusan`
--
ALTER TABLE `trx_rkpd_rancangan_urusan`
  ADD PRIMARY KEY (`id_urusan_rkpd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_rancangan`,`id_bidang`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana` (`id_rkpd_rancangan`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana_1` (`id_bidang`) USING BTREE;

--
-- Indexes for table `trx_rkpd_ranhir`
--
ALTER TABLE `trx_rkpd_ranhir`
  ADD PRIMARY KEY (`id_rkpd_rancangan`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_ranwal` (`tahun_rkpd`,`thn_id_rpjmd`,`id_visi_rpjmd`,`id_misi_rpjmd`,`id_tujuan_rpjmd`,`id_sasaran_rpjmd`,`id_program_rpjmd`,`no_urut`,`id_forum_rkpdprog`) USING BTREE;

--
-- Indexes for table `trx_rkpd_ranhir_aktivitas_pd`
--
ALTER TABLE `trx_rkpd_ranhir_aktivitas_pd`
  ADD PRIMARY KEY (`id_aktivitas_pd`) USING BTREE,
  ADD KEY `FK_trx_forum_skpd_aktivitas_trx_forum_skpd` (`id_pelaksana_pd`) USING BTREE;

--
-- Indexes for table `trx_rkpd_ranhir_belanja_pd`
--
ALTER TABLE `trx_rkpd_ranhir_belanja_pd`
  ADD PRIMARY KEY (`id_belanja_pd`) USING BTREE,
  ADD UNIQUE KEY `id_trx_forum_skpd_belanja` (`tahun_forum`,`no_urut`,`id_belanja_pd`,`id_aktivitas_pd`) USING BTREE,
  ADD KEY `fk_trx_forum_skpd_belanja` (`id_aktivitas_pd`) USING BTREE;

--
-- Indexes for table `trx_rkpd_ranhir_dokumen`
--
ALTER TABLE `trx_rkpd_ranhir_dokumen`
  ADD PRIMARY KEY (`id_dokumen_rkpd`) USING BTREE,
  ADD UNIQUE KEY `tahun_ranwal` (`tahun_rkpd`) USING BTREE;

--
-- Indexes for table `trx_rkpd_ranhir_indikator`
--
ALTER TABLE `trx_rkpd_ranhir_indikator`
  ADD PRIMARY KEY (`id_indikator_rkpd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_program_indikator` (`tahun_rkpd`,`id_rkpd_rancangan`,`kd_indikator`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_indikator` (`id_rkpd_rancangan`) USING BTREE;

--
-- Indexes for table `trx_rkpd_ranhir_kebijakan`
--
ALTER TABLE `trx_rkpd_ranhir_kebijakan`
  ADD PRIMARY KEY (`id_kebijakan_rkpd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_ranwal_kebijakan` (`tahun_rkpd`,`id_rkpd_rancangan`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_kebijakan` (`id_rkpd_rancangan`) USING BTREE;

--
-- Indexes for table `trx_rkpd_ranhir_kebijakan_pd`
--
ALTER TABLE `trx_rkpd_ranhir_kebijakan_pd`
  ADD PRIMARY KEY (`id_kebijakan_pd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_rpjmd_program_pelaksana` (`tahun_renja`,`id_unit`,`uraian_kebijakan`,`no_urut`) USING BTREE;

--
-- Indexes for table `trx_rkpd_ranhir_kegiatan_pd`
--
ALTER TABLE `trx_rkpd_ranhir_kegiatan_pd`
  ADD PRIMARY KEY (`id_kegiatan_pd`) USING BTREE,
  ADD UNIQUE KEY `id_unit_id_renja_id_kegiatan_ref` (`id_unit`,`id_kegiatan_ref`,`id_program_pd`) USING BTREE,
  ADD KEY `FK_trx_forum_skpd_trx_forum_skpd_program` (`id_program_pd`) USING BTREE;

--
-- Indexes for table `trx_rkpd_ranhir_keg_indikator_pd`
--
ALTER TABLE `trx_rkpd_ranhir_keg_indikator_pd`
  ADD PRIMARY KEY (`id_indikator_kegiatan`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_kegiatan_pd`) USING BTREE,
  ADD KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  ADD KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_kegiatan_pd`) USING BTREE;

--
-- Indexes for table `trx_rkpd_ranhir_lokasi_pd`
--
ALTER TABLE `trx_rkpd_ranhir_lokasi_pd`
  ADD PRIMARY KEY (`id_lokasi_pd`) USING BTREE,
  ADD UNIQUE KEY `id_trx_forum_lokasi` (`id_aktivitas_pd`,`tahun_forum`,`no_urut`,`id_lokasi_pd`) USING BTREE;

--
-- Indexes for table `trx_rkpd_ranhir_pelaksana`
--
ALTER TABLE `trx_rkpd_ranhir_pelaksana`
  ADD PRIMARY KEY (`id_pelaksana_rkpd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_rancangan`,`id_unit`,`id_urusan_rkpd`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana` (`id_rkpd_rancangan`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana_1` (`id_urusan_rkpd`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana_2` (`id_unit`) USING BTREE;

--
-- Indexes for table `trx_rkpd_ranhir_pelaksana_pd`
--
ALTER TABLE `trx_rkpd_ranhir_pelaksana_pd`
  ADD PRIMARY KEY (`id_pelaksana_pd`) USING BTREE,
  ADD UNIQUE KEY `id_trx_forum_pelaksana` (`id_kegiatan_pd`,`tahun_forum`,`no_urut`,`id_pelaksana_pd`,`id_sub_unit`) USING BTREE;

--
-- Indexes for table `trx_rkpd_ranhir_program_pd`
--
ALTER TABLE `trx_rkpd_ranhir_program_pd`
  ADD PRIMARY KEY (`id_program_pd`) USING BTREE,
  ADD UNIQUE KEY `id_unit_id_renja_program_id_program_ref` (`id_unit`,`id_renja_program`,`id_program_ref`,`id_forum_program`) USING BTREE,
  ADD KEY `FK_trx_forum_skpd_program_trx_forum_skpd_program_ranwal` (`id_rkpd_rancangan`) USING BTREE;

--
-- Indexes for table `trx_rkpd_ranhir_prog_indikator_pd`
--
ALTER TABLE `trx_rkpd_ranhir_prog_indikator_pd`
  ADD PRIMARY KEY (`id_indikator_program`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_renja_rancangan_indikator` (`tahun_renja`,`id_program_renstra`,`kd_indikator`,`no_urut`,`id_perubahan`,`id_program_pd`) USING BTREE,
  ADD KEY `fk_trx_renja_rancangan_indikator` (`id_program_renstra`) USING BTREE,
  ADD KEY `trx_renja_rancangan_program_indikator_ibfk_1` (`id_program_pd`) USING BTREE;

--
-- Indexes for table `trx_rkpd_ranhir_urusan`
--
ALTER TABLE `trx_rkpd_ranhir_urusan`
  ADD PRIMARY KEY (`id_urusan_rkpd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_rancangan`,`id_bidang`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana` (`id_rkpd_rancangan`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana_1` (`id_bidang`) USING BTREE;

--
-- Indexes for table `trx_rkpd_ranwal`
--
ALTER TABLE `trx_rkpd_ranwal`
  ADD PRIMARY KEY (`id_rkpd_ranwal`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_ranwal` (`tahun_rkpd`,`thn_id_rpjmd`,`id_visi_rpjmd`,`id_misi_rpjmd`,`id_tujuan_rpjmd`,`id_sasaran_rpjmd`,`id_program_rpjmd`,`no_urut`) USING BTREE;

--
-- Indexes for table `trx_rkpd_ranwal_dokumen`
--
ALTER TABLE `trx_rkpd_ranwal_dokumen`
  ADD PRIMARY KEY (`id_dokumen_ranwal`) USING BTREE,
  ADD UNIQUE KEY `tahun_ranwal` (`tahun_ranwal`) USING BTREE;

--
-- Indexes for table `trx_rkpd_ranwal_indikator`
--
ALTER TABLE `trx_rkpd_ranwal_indikator`
  ADD PRIMARY KEY (`id_indikator_program_rkpd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_program_indikator` (`tahun_rkpd`,`id_rkpd_ranwal`,`kd_indikator`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_indikator` (`id_rkpd_ranwal`) USING BTREE;

--
-- Indexes for table `trx_rkpd_ranwal_kebijakan`
--
ALTER TABLE `trx_rkpd_ranwal_kebijakan`
  ADD PRIMARY KEY (`id_kebijakan_ranwal`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_ranwal_kebijakan` (`tahun_rkpd`,`id_rkpd_ranwal`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_kebijakan` (`id_rkpd_ranwal`) USING BTREE;

--
-- Indexes for table `trx_rkpd_ranwal_pelaksana`
--
ALTER TABLE `trx_rkpd_ranwal_pelaksana`
  ADD PRIMARY KEY (`id_pelaksana_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_ranwal`,`id_unit`,`id_urusan_rkpd`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana` (`id_rkpd_ranwal`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana_1` (`id_urusan_rkpd`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana_2` (`id_unit`) USING BTREE;

--
-- Indexes for table `trx_rkpd_ranwal_urusan`
--
ALTER TABLE `trx_rkpd_ranwal_urusan`
  ADD PRIMARY KEY (`id_urusan_rkpd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_ranwal`,`id_bidang`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana` (`id_rkpd_ranwal`) USING BTREE,
  ADD KEY `fk_trx_rkpd_ranwal_pelaksana_1` (`id_bidang`) USING BTREE;

--
-- Indexes for table `trx_rkpd_renstra`
--
ALTER TABLE `trx_rkpd_renstra`
  ADD PRIMARY KEY (`id_rkpd_renstra`) USING BTREE,
  ADD KEY `idx_trx_rkpd_renstra` (`id_rkpd_rpjmd`,`tahun_rkpd`,`id_rkpd_renstra`,`id_program_rpjmd`,`id_unit`) USING BTREE;

--
-- Indexes for table `trx_rkpd_renstra_indikator`
--
ALTER TABLE `trx_rkpd_renstra_indikator`
  ADD PRIMARY KEY (`id_indikator_renstra`) USING BTREE,
  ADD KEY `fk_trx_rkpd_renstra_pelaksana` (`id_rkpd_renstra`) USING BTREE,
  ADD KEY `idx_trx_rkpd_rpjmd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_renstra`,`kd_indikator`) USING BTREE;

--
-- Indexes for table `trx_rkpd_renstra_pelaksana`
--
ALTER TABLE `trx_rkpd_renstra_pelaksana`
  ADD PRIMARY KEY (`id_pelaksana_renstra`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_rpjmd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_renstra`,`id_sub_unit`) USING BTREE,
  ADD KEY `fk_trx_rkpd_renstra_pelaksana` (`id_rkpd_renstra`) USING BTREE;

--
-- Indexes for table `trx_rkpd_rpjmd_kebijakan`
--
ALTER TABLE `trx_rkpd_rpjmd_kebijakan`
  ADD PRIMARY KEY (`id_kebijakan_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_rpjmd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_rpjmd`,`uraian_kebijakan`) USING BTREE,
  ADD KEY `fk_trx_rkpd_rpjmd_kebijakan` (`id_rkpd_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rkpd_rpjmd_program_indikator`
--
ALTER TABLE `trx_rkpd_rpjmd_program_indikator`
  ADD PRIMARY KEY (`id_indikator_program_rpjmd`) USING BTREE,
  ADD KEY `fk_rkpd_rpjmd_indikator` (`id_rkpd_rpjmd`) USING BTREE,
  ADD KEY `idx_trx_rkpd_rpjmd_program_indikator` (`tahun_rkpd`,`id_rkpd_rpjmd`,`kd_indikator`) USING BTREE;

--
-- Indexes for table `trx_rkpd_rpjmd_program_pelaksana`
--
ALTER TABLE `trx_rkpd_rpjmd_program_pelaksana`
  ADD PRIMARY KEY (`id_pelaksana_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rkpd_rpjmd_program_pelaksana` (`tahun_rkpd`,`id_rkpd_rpjmd`,`id_urbid_rpjmd`,`id_unit`) USING BTREE,
  ADD KEY `fk_rkpd_rpjmd_pelaksana` (`id_rkpd_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rkpd_rpjmd_ranwal`
--
ALTER TABLE `trx_rkpd_rpjmd_ranwal`
  ADD PRIMARY KEY (`id_rkpd_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_rkpd_rpjmd_ranwal` (`id_rkpd_rpjmd`,`tahun_rkpd`,`thn_id_rpjmd`,`id_visi_rpjmd`,`id_misi_rpjmd`,`id_tujuan_rpjmd`,`id_sasaran_rpjmd`,`id_program_rpjmd`) USING BTREE,
  ADD KEY `FK_trx_rkpd_rpjmd_ranwal_trx_rpjmd_visi` (`id_visi_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_dokumen`
--
ALTER TABLE `trx_rpjmd_dokumen`
  ADD PRIMARY KEY (`id_rpjmd`) USING BTREE,
  ADD KEY `id_rpjmd_old` (`id_rpjmd_old`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_kebijakan`
--
ALTER TABLE `trx_rpjmd_kebijakan`
  ADD PRIMARY KEY (`id_kebijakan_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_kebijakan` (`thn_id`,`id_sasaran_rpjmd`,`id_kebijakan_rpjmd`,`id_perubahan`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rpjmd_kebijakan` (`id_sasaran_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_misi`
--
ALTER TABLE `trx_rpjmd_misi`
  ADD PRIMARY KEY (`id_misi_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_ta_misi_rpjmd` (`thn_id_rpjmd`,`id_visi_rpjmd`,`id_perubahan`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rpjmd_misi` (`id_visi_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_program`
--
ALTER TABLE `trx_rpjmd_program`
  ADD PRIMARY KEY (`id_program_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_program` (`thn_id`,`id_sasaran_rpjmd`,`id_perubahan`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rpjmd_program` (`id_sasaran_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_program_indikator`
--
ALTER TABLE `trx_rpjmd_program_indikator`
  ADD PRIMARY KEY (`id_indikator_program_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_program_indikator` (`thn_id`,`id_program_rpjmd`,`id_indikator`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rpjmd_program_indikator` (`id_program_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_program_pelaksana`
--
ALTER TABLE `trx_rpjmd_program_pelaksana`
  ADD PRIMARY KEY (`id_pelaksana_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_program_pelaksana` (`thn_id`,`id_urbid_rpjmd`,`id_unit`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rpjmd_program_pelaksana` (`id_urbid_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_program_urusan`
--
ALTER TABLE `trx_rpjmd_program_urusan`
  ADD PRIMARY KEY (`id_urbid_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_program_pelaksana` (`thn_id`,`id_program_rpjmd`,`id_bidang`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rpjmd_program_urusan` (`id_program_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_ranwal_dokumen`
--
ALTER TABLE `trx_rpjmd_ranwal_dokumen`
  ADD PRIMARY KEY (`id_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_ranwal_kebijakan`
--
ALTER TABLE `trx_rpjmd_ranwal_kebijakan`
  ADD PRIMARY KEY (`id_kebijakan_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_kebijakan` (`thn_id`,`id_strategi_rpjmd`,`id_kebijakan_rpjmd`,`id_perubahan`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rpjmd_kebijakan` (`id_strategi_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_ranwal_misi`
--
ALTER TABLE `trx_rpjmd_ranwal_misi`
  ADD PRIMARY KEY (`id_misi_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_ta_misi_rpjmd` (`thn_id_rpjmd`,`id_visi_rpjmd`,`id_perubahan`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rpjmd_misi` (`id_visi_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_ranwal_program`
--
ALTER TABLE `trx_rpjmd_ranwal_program`
  ADD PRIMARY KEY (`id_program_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_program` (`thn_id`,`id_sasaran_rpjmd`,`id_perubahan`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rpjmd_program` (`id_sasaran_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_ranwal_program_indikator`
--
ALTER TABLE `trx_rpjmd_ranwal_program_indikator`
  ADD PRIMARY KEY (`id_indikator_program_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_program_indikator` (`thn_id`,`id_program_rpjmd`,`id_indikator`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rpjmd_program_indikator` (`id_program_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_ranwal_program_pelaksana`
--
ALTER TABLE `trx_rpjmd_ranwal_program_pelaksana`
  ADD PRIMARY KEY (`id_pelaksana_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_program_pelaksana` (`thn_id`,`id_urbid_rpjmd`,`id_unit`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rpjmd_program_pelaksana` (`id_urbid_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_ranwal_program_urusan`
--
ALTER TABLE `trx_rpjmd_ranwal_program_urusan`
  ADD PRIMARY KEY (`id_urbid_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_program_pelaksana` (`thn_id`,`id_program_rpjmd`,`id_bidang`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rpjmd_program_urusan` (`id_program_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_ranwal_sasaran`
--
ALTER TABLE `trx_rpjmd_ranwal_sasaran`
  ADD PRIMARY KEY (`id_sasaran_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_sasaran` (`thn_id_rpjmd`,`id_tujuan_rpjmd`,`id_sasaran_rpjmd`,`id_perubahan`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rpjmd_sasaran` (`id_tujuan_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_ranwal_sasaran_indikator`
--
ALTER TABLE `trx_rpjmd_ranwal_sasaran_indikator`
  ADD PRIMARY KEY (`id_indikator_sasaran_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_sasaran_indikator` (`thn_id`,`id_sasaran_rpjmd`,`id_indikator_sasaran_rpjmd`,`id_perubahan`,`kd_indikator`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rpjmd_sasaran_indikator` (`id_sasaran_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_ranwal_strategi`
--
ALTER TABLE `trx_rpjmd_ranwal_strategi`
  ADD PRIMARY KEY (`id_strategi_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_strategi` (`thn_id`,`id_sasaran_rpjmd`,`id_strategi_rpjmd`,`id_perubahan`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rpjmd_strategi` (`id_sasaran_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_ranwal_tujuan`
--
ALTER TABLE `trx_rpjmd_ranwal_tujuan`
  ADD PRIMARY KEY (`id_tujuan_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_tujuan` (`thn_id_rpjmd`,`id_misi_rpjmd`,`id_perubahan`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rpjmd_tujuan` (`id_misi_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_ranwal_tujuan_indikator`
--
ALTER TABLE `trx_rpjmd_ranwal_tujuan_indikator`
  ADD PRIMARY KEY (`id_indikator_tujuan_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_tujuan_indikator` (`thn_id`,`id_tujuan_rpjmd`,`id_indikator_tujuan_rpjmd`,`id_perubahan`,`kd_indikator`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rpjmd_tujuan_indikator` (`id_tujuan_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_ranwal_visi`
--
ALTER TABLE `trx_rpjmd_ranwal_visi`
  ADD PRIMARY KEY (`id_visi_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_visi` (`id_rpjmd`,`no_urut`,`thn_id`,`id_visi_rpjmd`,`id_perubahan`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_sasaran`
--
ALTER TABLE `trx_rpjmd_sasaran`
  ADD PRIMARY KEY (`id_sasaran_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_sasaran` (`thn_id_rpjmd`,`id_tujuan_rpjmd`,`id_sasaran_rpjmd`,`id_perubahan`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rpjmd_sasaran` (`id_tujuan_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_sasaran_indikator`
--
ALTER TABLE `trx_rpjmd_sasaran_indikator`
  ADD PRIMARY KEY (`id_indikator_sasaran_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_sasaran_indikator` (`thn_id`,`id_sasaran_rpjmd`,`id_indikator_sasaran_rpjmd`,`id_perubahan`,`kd_indikator`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rpjmd_sasaran_indikator` (`id_sasaran_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_strategi`
--
ALTER TABLE `trx_rpjmd_strategi`
  ADD PRIMARY KEY (`id_strategi_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_strategi` (`thn_id`,`id_sasaran_rpjmd`,`id_strategi_rpjmd`,`id_perubahan`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rpjmd_strategi` (`id_sasaran_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_tujuan`
--
ALTER TABLE `trx_rpjmd_tujuan`
  ADD PRIMARY KEY (`id_tujuan_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_tujuan` (`thn_id_rpjmd`,`id_misi_rpjmd`,`id_perubahan`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rpjmd_tujuan` (`id_misi_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_tujuan_indikator`
--
ALTER TABLE `trx_rpjmd_tujuan_indikator`
  ADD PRIMARY KEY (`id_indikator_tujuan_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_tujuan_indikator` (`thn_id`,`id_tujuan_rpjmd`,`id_indikator_tujuan_rpjmd`,`id_perubahan`,`kd_indikator`,`no_urut`) USING BTREE,
  ADD KEY `fk_trx_rpjmd_tujuan_indikator` (`id_tujuan_rpjmd`) USING BTREE;

--
-- Indexes for table `trx_rpjmd_visi`
--
ALTER TABLE `trx_rpjmd_visi`
  ADD PRIMARY KEY (`id_visi_rpjmd`) USING BTREE,
  ADD UNIQUE KEY `idx_trx_rpjmd_visi` (`id_rpjmd`,`no_urut`,`thn_id`,`id_visi_rpjmd`,`id_perubahan`) USING BTREE;

--
-- Indexes for table `trx_usulan_kab`
--
ALTER TABLE `trx_usulan_kab`
  ADD PRIMARY KEY (`id_usulan_kab`) USING BTREE,
  ADD UNIQUE KEY `id_tahun` (`id_tahun`,`id_kab`,`id_unit`,`no_urut`) USING BTREE,
  ADD KEY `id_kab` (`id_kab`) USING BTREE,
  ADD KEY `id_unit` (`id_unit`) USING BTREE;

--
-- Indexes for table `trx_usulan_kab_lokasi`
--
ALTER TABLE `trx_usulan_kab_lokasi`
  ADD PRIMARY KEY (`id_usulan_kab_lokasi`) USING BTREE,
  ADD UNIQUE KEY `id_usulan_kab` (`id_usulan_kab`,`no_urut`,`id_lokasi`) USING BTREE,
  ADD KEY `id_lokasi` (`id_lokasi`) USING BTREE;

--
-- Indexes for table `trx_usulan_rw`
--
ALTER TABLE `trx_usulan_rw`
  ADD PRIMARY KEY (`id_usulan_rw`) USING BTREE;

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `group_id` (`group_id`) USING BTREE;

--
-- Indexes for table `user_app`
--
ALTER TABLE `user_app`
  ADD PRIMARY KEY (`id_app_user`),
  ADD UNIQUE KEY `user_id` (`user_id`,`group_id`,`app_id`),
  ADD KEY `group_id` (`group_id`);

--
-- Indexes for table `user_desa`
--
ALTER TABLE `user_desa`
  ADD PRIMARY KEY (`id_user_wil`) USING BTREE,
  ADD UNIQUE KEY `user_id` (`user_id`,`kd_kecamatan`,`kd_desa`) USING BTREE;

--
-- Indexes for table `user_sub_unit`
--
ALTER TABLE `user_sub_unit`
  ADD PRIMARY KEY (`id_user_unit`) USING BTREE,
  ADD UNIQUE KEY `kd_unit` (`kd_unit`,`user_id`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kin_trx_cascading_indikator_kegiatan_pd`
--
ALTER TABLE `kin_trx_cascading_indikator_kegiatan_pd`
  MODIFY `id_indikator_kegiatan_pd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_cascading_indikator_program_pd`
--
ALTER TABLE `kin_trx_cascading_indikator_program_pd`
  MODIFY `id_indikator_program_pd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_cascading_kegiatan_opd`
--
ALTER TABLE `kin_trx_cascading_kegiatan_opd`
  MODIFY `id_hasil_kegiatan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_cascading_program_opd`
--
ALTER TABLE `kin_trx_cascading_program_opd`
  MODIFY `id_hasil_program` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_iku_opd_dok`
--
ALTER TABLE `kin_trx_iku_opd_dok`
  MODIFY `id_dokumen` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_iku_opd_kegiatan`
--
ALTER TABLE `kin_trx_iku_opd_kegiatan`
  MODIFY `id_iku_opd_kegiatan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_iku_opd_program`
--
ALTER TABLE `kin_trx_iku_opd_program`
  MODIFY `id_iku_opd_program` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_iku_opd_sasaran`
--
ALTER TABLE `kin_trx_iku_opd_sasaran`
  MODIFY `id_iku_opd_sasaran` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_iku_pemda_dok`
--
ALTER TABLE `kin_trx_iku_pemda_dok`
  MODIFY `id_dokumen` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_iku_pemda_rinci`
--
ALTER TABLE `kin_trx_iku_pemda_rinci`
  MODIFY `id_iku_pemda` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_perkin_es3_dok`
--
ALTER TABLE `kin_trx_perkin_es3_dok`
  MODIFY `id_dokumen_perkin` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_perkin_es3_kegiatan`
--
ALTER TABLE `kin_trx_perkin_es3_kegiatan`
  MODIFY `id_perkin_kegiatan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_perkin_es3_program`
--
ALTER TABLE `kin_trx_perkin_es3_program`
  MODIFY `id_perkin_program` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_perkin_es3_program_indikator`
--
ALTER TABLE `kin_trx_perkin_es3_program_indikator`
  MODIFY `id_perkin_indikator` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_perkin_es4_dok`
--
ALTER TABLE `kin_trx_perkin_es4_dok`
  MODIFY `id_dokumen_perkin` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_perkin_es4_kegiatan`
--
ALTER TABLE `kin_trx_perkin_es4_kegiatan`
  MODIFY `id_perkin_kegiatan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_perkin_es4_kegiatan_indikator`
--
ALTER TABLE `kin_trx_perkin_es4_kegiatan_indikator`
  MODIFY `id_perkin_indikator` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_perkin_opd_dok`
--
ALTER TABLE `kin_trx_perkin_opd_dok`
  MODIFY `id_dokumen_perkin` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_perkin_opd_program`
--
ALTER TABLE `kin_trx_perkin_opd_program`
  MODIFY `id_perkin_program` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_perkin_opd_sasaran`
--
ALTER TABLE `kin_trx_perkin_opd_sasaran`
  MODIFY `id_perkin_sasaran` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_perkin_opd_sasaran_indikator`
--
ALTER TABLE `kin_trx_perkin_opd_sasaran_indikator`
  MODIFY `id_perkin_indikator` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_real_es2_dok`
--
ALTER TABLE `kin_trx_real_es2_dok`
  MODIFY `id_dokumen_real` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_real_es2_program`
--
ALTER TABLE `kin_trx_real_es2_program`
  MODIFY `id_real_program` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_real_es2_sasaran`
--
ALTER TABLE `kin_trx_real_es2_sasaran`
  MODIFY `id_real_sasaran` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_real_es2_sasaran_indikator`
--
ALTER TABLE `kin_trx_real_es2_sasaran_indikator`
  MODIFY `id_real_indikator` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_real_es3_dok`
--
ALTER TABLE `kin_trx_real_es3_dok`
  MODIFY `id_dokumen_real` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_real_es3_kegiatan`
--
ALTER TABLE `kin_trx_real_es3_kegiatan`
  MODIFY `id_real_kegiatan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_real_es3_program`
--
ALTER TABLE `kin_trx_real_es3_program`
  MODIFY `id_real_program` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_real_es3_program_indikator`
--
ALTER TABLE `kin_trx_real_es3_program_indikator`
  MODIFY `id_real_indikator` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_real_es4_dok`
--
ALTER TABLE `kin_trx_real_es4_dok`
  MODIFY `id_dokumen_real` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_real_es4_kegiatan`
--
ALTER TABLE `kin_trx_real_es4_kegiatan`
  MODIFY `id_real_kegiatan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kin_trx_real_es4_kegiatan_indikator`
--
ALTER TABLE `kin_trx_real_es4_kegiatan_indikator`
  MODIFY `id_real_indikator` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_bidang`
--
ALTER TABLE `ref_bidang`
  MODIFY `id_bidang` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_data_sub_unit`
--
ALTER TABLE `ref_data_sub_unit`
  MODIFY `id_rincian_unit` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_desa`
--
ALTER TABLE `ref_desa`
  MODIFY `id_desa` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_group`
--
ALTER TABLE `ref_group`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_indikator`
--
ALTER TABLE `ref_indikator`
  MODIFY `id_indikator` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_jadwal`
--
ALTER TABLE `ref_jadwal`
  MODIFY `id_proses` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_kabupaten`
--
ALTER TABLE `ref_kabupaten`
  MODIFY `id_kab` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_kecamatan`
--
ALTER TABLE `ref_kecamatan`
  MODIFY `id_kecamatan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_kegiatan`
--
ALTER TABLE `ref_kegiatan`
  MODIFY `id_kegiatan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_lokasi`
--
ALTER TABLE `ref_lokasi`
  MODIFY `id_lokasi` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_menu`
--
ALTER TABLE `ref_menu`
  MODIFY `id_menu` bigint(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_pegawai`
--
ALTER TABLE `ref_pegawai`
  MODIFY `id_pegawai` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_pegawai_pangkat`
--
ALTER TABLE `ref_pegawai_pangkat`
  MODIFY `id_pangkat` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_pegawai_unit`
--
ALTER TABLE `ref_pegawai_unit`
  MODIFY `id_unit_pegawai` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_pembatalan`
--
ALTER TABLE `ref_pembatalan`
  MODIFY `id_batal` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_prioritas_nasional`
--
ALTER TABLE `ref_prioritas_nasional`
  MODIFY `id_prioritas` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_prioritas_provinsi`
--
ALTER TABLE `ref_prioritas_provinsi`
  MODIFY `id_prioritas` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_program`
--
ALTER TABLE `ref_program`
  MODIFY `id_program` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_rek_5`
--
ALTER TABLE `ref_rek_5`
  MODIFY `id_rekening` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_satuan`
--
ALTER TABLE `ref_satuan`
  MODIFY `id_satuan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_sotk_level_1`
--
ALTER TABLE `ref_sotk_level_1`
  MODIFY `id_sotk_es2` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_sotk_level_2`
--
ALTER TABLE `ref_sotk_level_2`
  MODIFY `id_sotk_es3` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_sotk_level_3`
--
ALTER TABLE `ref_sotk_level_3`
  MODIFY `id_sotk_es4` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_ssh_golongan`
--
ALTER TABLE `ref_ssh_golongan`
  MODIFY `id_golongan_ssh` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_ssh_kelompok`
--
ALTER TABLE `ref_ssh_kelompok`
  MODIFY `id_kelompok_ssh` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_ssh_perkada`
--
ALTER TABLE `ref_ssh_perkada`
  MODIFY `id_perkada` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_ssh_perkada_tarif`
--
ALTER TABLE `ref_ssh_perkada_tarif`
  MODIFY `id_tarif_perkada` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_ssh_perkada_zona`
--
ALTER TABLE `ref_ssh_perkada_zona`
  MODIFY `id_zona_perkada` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_ssh_rekening`
--
ALTER TABLE `ref_ssh_rekening`
  MODIFY `id_rekening_ssh` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_ssh_sub_kelompok`
--
ALTER TABLE `ref_ssh_sub_kelompok`
  MODIFY `id_sub_kelompok_ssh` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_ssh_tarif`
--
ALTER TABLE `ref_ssh_tarif`
  MODIFY `id_tarif_ssh` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_ssh_zona`
--
ALTER TABLE `ref_ssh_zona`
  MODIFY `id_zona` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_ssh_zona_lokasi`
--
ALTER TABLE `ref_ssh_zona_lokasi`
  MODIFY `id_zona_lokasi` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_sub_unit`
--
ALTER TABLE `ref_sub_unit`
  MODIFY `id_sub_unit` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_tahun`
--
ALTER TABLE `ref_tahun`
  MODIFY `id_tahun` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_unit`
--
ALTER TABLE `ref_unit`
  MODIFY `id_unit` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ref_user_role`
--
ALTER TABLE `ref_user_role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_asb_aktivitas`
--
ALTER TABLE `trx_asb_aktivitas`
  MODIFY `id_aktivitas_asb` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_asb_kelompok`
--
ALTER TABLE `trx_asb_kelompok`
  MODIFY `id_asb_kelompok` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_asb_komponen`
--
ALTER TABLE `trx_asb_komponen`
  MODIFY `id_komponen_asb` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_asb_komponen_rinci`
--
ALTER TABLE `trx_asb_komponen_rinci`
  MODIFY `id_komponen_asb_rinci` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_asb_perhitungan`
--
ALTER TABLE `trx_asb_perhitungan`
  MODIFY `id_perhitungan` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_asb_perhitungan_rinci`
--
ALTER TABLE `trx_asb_perhitungan_rinci`
  MODIFY `id_perhitungan_rinci` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_asb_perkada`
--
ALTER TABLE `trx_asb_perkada`
  MODIFY `id_asb_perkada` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_asb_sub_kelompok`
--
ALTER TABLE `trx_asb_sub_kelompok`
  MODIFY `id_asb_sub_kelompok` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_asb_sub_sub_kelompok`
--
ALTER TABLE `trx_asb_sub_sub_kelompok`
  MODIFY `id_asb_sub_sub_kelompok` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_forum_skpd`
--
ALTER TABLE `trx_forum_skpd`
  MODIFY `id_forum_skpd` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_forum_skpd_aktivitas`
--
ALTER TABLE `trx_forum_skpd_aktivitas`
  MODIFY `id_aktivitas_forum` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_forum_skpd_belanja`
--
ALTER TABLE `trx_forum_skpd_belanja`
  MODIFY `id_belanja_forum` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_forum_skpd_dokumen`
--
ALTER TABLE `trx_forum_skpd_dokumen`
  MODIFY `id_dokumen_ranwal` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_forum_skpd_kebijakan`
--
ALTER TABLE `trx_forum_skpd_kebijakan`
  MODIFY `id_kebijakan_renja` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_forum_skpd_kegiatan_indikator`
--
ALTER TABLE `trx_forum_skpd_kegiatan_indikator`
  MODIFY `id_indikator_kegiatan` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_forum_skpd_lokasi`
--
ALTER TABLE `trx_forum_skpd_lokasi`
  MODIFY `id_lokasi_forum` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_forum_skpd_pelaksana`
--
ALTER TABLE `trx_forum_skpd_pelaksana`
  MODIFY `id_pelaksana_forum` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_forum_skpd_program`
--
ALTER TABLE `trx_forum_skpd_program`
  MODIFY `id_forum_program` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_forum_skpd_program_indikator`
--
ALTER TABLE `trx_forum_skpd_program_indikator`
  MODIFY `id_indikator_program` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_forum_skpd_program_ranwal`
--
ALTER TABLE `trx_forum_skpd_program_ranwal`
  MODIFY `id_forum_rkpdprog` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_forum_skpd_usulan`
--
ALTER TABLE `trx_forum_skpd_usulan`
  MODIFY `id_sumber_usulan` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_isian_data_dasar`
--
ALTER TABLE `trx_isian_data_dasar`
  MODIFY `id_isian_tabel_dasar` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_log_events`
--
ALTER TABLE `trx_log_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_musrencam`
--
ALTER TABLE `trx_musrencam`
  MODIFY `id_musrencam` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_musrencam_lokasi`
--
ALTER TABLE `trx_musrencam_lokasi`
  MODIFY `id_lokasi_musrencam` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_musrendes`
--
ALTER TABLE `trx_musrendes`
  MODIFY `id_musrendes` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_musrendes_lokasi`
--
ALTER TABLE `trx_musrendes_lokasi`
  MODIFY `id_lokasi_musrendes` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_musrendes_rw`
--
ALTER TABLE `trx_musrendes_rw`
  MODIFY `id_musrendes_rw` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_musrendes_rw_lokasi`
--
ALTER TABLE `trx_musrendes_rw_lokasi`
  MODIFY `id_musrendes_lokasi` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_musrenkab`
--
ALTER TABLE `trx_musrenkab`
  MODIFY `id_musrenkab` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_musrenkab_aktivitas_pd`
--
ALTER TABLE `trx_musrenkab_aktivitas_pd`
  MODIFY `id_aktivitas_pd` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_musrenkab_belanja_pd`
--
ALTER TABLE `trx_musrenkab_belanja_pd`
  MODIFY `id_belanja_pd` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_musrenkab_dokumen`
--
ALTER TABLE `trx_musrenkab_dokumen`
  MODIFY `id_dokumen_rkpd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_musrenkab_indikator`
--
ALTER TABLE `trx_musrenkab_indikator`
  MODIFY `id_indikator_rkpd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_musrenkab_kebijakan`
--
ALTER TABLE `trx_musrenkab_kebijakan`
  MODIFY `id_kebijakan_rkpd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_musrenkab_kebijakan_pd`
--
ALTER TABLE `trx_musrenkab_kebijakan_pd`
  MODIFY `id_kebijakan_pd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_musrenkab_kegiatan_pd`
--
ALTER TABLE `trx_musrenkab_kegiatan_pd`
  MODIFY `id_kegiatan_pd` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_musrenkab_keg_indikator_pd`
--
ALTER TABLE `trx_musrenkab_keg_indikator_pd`
  MODIFY `id_indikator_kegiatan` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_musrenkab_lokasi_pd`
--
ALTER TABLE `trx_musrenkab_lokasi_pd`
  MODIFY `id_lokasi_pd` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_musrenkab_pelaksana`
--
ALTER TABLE `trx_musrenkab_pelaksana`
  MODIFY `id_pelaksana_rkpd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_musrenkab_pelaksana_pd`
--
ALTER TABLE `trx_musrenkab_pelaksana_pd`
  MODIFY `id_pelaksana_pd` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_musrenkab_program_pd`
--
ALTER TABLE `trx_musrenkab_program_pd`
  MODIFY `id_program_pd` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_musrenkab_prog_indikator_pd`
--
ALTER TABLE `trx_musrenkab_prog_indikator_pd`
  MODIFY `id_indikator_program` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_musrenkab_urusan`
--
ALTER TABLE `trx_musrenkab_urusan`
  MODIFY `id_urusan_rkpd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_pokir`
--
ALTER TABLE `trx_pokir`
  MODIFY `id_pokir` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_pokir_lokasi`
--
ALTER TABLE `trx_pokir_lokasi`
  MODIFY `id_pokir_lokasi` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_pokir_tl`
--
ALTER TABLE `trx_pokir_tl`
  MODIFY `id_pokir_tl` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_pokir_tl_unit`
--
ALTER TABLE `trx_pokir_tl_unit`
  MODIFY `id_pokir_unit` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_pokir_usulan`
--
ALTER TABLE `trx_pokir_usulan`
  MODIFY `id_pokir_usulan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_aktivitas`
--
ALTER TABLE `trx_renja_aktivitas`
  MODIFY `id_aktivitas_renja` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_belanja`
--
ALTER TABLE `trx_renja_belanja`
  MODIFY `id_belanja_renja` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_dokumen`
--
ALTER TABLE `trx_renja_dokumen`
  MODIFY `id_dokumen_ranwal` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_kebijakan`
--
ALTER TABLE `trx_renja_kebijakan`
  MODIFY `id_kebijakan_renja` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_kegiatan`
--
ALTER TABLE `trx_renja_kegiatan`
  MODIFY `id_renja` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_kegiatan_indikator`
--
ALTER TABLE `trx_renja_kegiatan_indikator`
  MODIFY `id_indikator_kegiatan_renja` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_renja_lokasi`
--
ALTER TABLE `trx_renja_lokasi`
  MODIFY `id_lokasi_renja` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_pelaksana`
--
ALTER TABLE `trx_renja_pelaksana`
  MODIFY `id_pelaksana_renja` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_program`
--
ALTER TABLE `trx_renja_program`
  MODIFY `id_renja_program` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_program_indikator`
--
ALTER TABLE `trx_renja_program_indikator`
  MODIFY `id_indikator_program_renja` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_renja_program_rkpd`
--
ALTER TABLE `trx_renja_program_rkpd`
  MODIFY `id_renja_ranwal` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_rancangan`
--
ALTER TABLE `trx_renja_rancangan`
  MODIFY `id_renja` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_rancangan_aktivitas`
--
ALTER TABLE `trx_renja_rancangan_aktivitas`
  MODIFY `id_aktivitas_renja` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_rancangan_belanja`
--
ALTER TABLE `trx_renja_rancangan_belanja`
  MODIFY `id_belanja_renja` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_rancangan_dokumen`
--
ALTER TABLE `trx_renja_rancangan_dokumen`
  MODIFY `id_dokumen_ranwal` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_rancangan_indikator`
--
ALTER TABLE `trx_renja_rancangan_indikator`
  MODIFY `id_indikator_kegiatan_renja` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_renja_rancangan_kebijakan`
--
ALTER TABLE `trx_renja_rancangan_kebijakan`
  MODIFY `id_kebijakan_renja` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_rancangan_lokasi`
--
ALTER TABLE `trx_renja_rancangan_lokasi`
  MODIFY `id_lokasi_renja` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_rancangan_pelaksana`
--
ALTER TABLE `trx_renja_rancangan_pelaksana`
  MODIFY `id_pelaksana_renja` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_rancangan_program`
--
ALTER TABLE `trx_renja_rancangan_program`
  MODIFY `id_renja_program` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_rancangan_program_indikator`
--
ALTER TABLE `trx_renja_rancangan_program_indikator`
  MODIFY `id_indikator_program_renja` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_renja_rancangan_program_ranwal`
--
ALTER TABLE `trx_renja_rancangan_program_ranwal`
  MODIFY `id_renja_ranwal` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_ranwal_aktivitas`
--
ALTER TABLE `trx_renja_ranwal_aktivitas`
  MODIFY `id_aktivitas_renja` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_ranwal_dokumen`
--
ALTER TABLE `trx_renja_ranwal_dokumen`
  MODIFY `id_dokumen_ranwal` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_ranwal_kegiatan`
--
ALTER TABLE `trx_renja_ranwal_kegiatan`
  MODIFY `id_renja` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_ranwal_kegiatan_indikator`
--
ALTER TABLE `trx_renja_ranwal_kegiatan_indikator`
  MODIFY `id_indikator_kegiatan_renja` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_renja_ranwal_pelaksana`
--
ALTER TABLE `trx_renja_ranwal_pelaksana`
  MODIFY `id_pelaksana_renja` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_ranwal_program`
--
ALTER TABLE `trx_renja_ranwal_program`
  MODIFY `id_renja_program` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renja_ranwal_program_indikator`
--
ALTER TABLE `trx_renja_ranwal_program_indikator`
  MODIFY `id_indikator_program_renja` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_renja_ranwal_program_rkpd`
--
ALTER TABLE `trx_renja_ranwal_program_rkpd`
  MODIFY `id_renja_ranwal` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renstra_kebijakan`
--
ALTER TABLE `trx_renstra_kebijakan`
  MODIFY `id_kebijakan_renstra` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_renstra_kegiatan`
--
ALTER TABLE `trx_renstra_kegiatan`
  MODIFY `id_kegiatan_renstra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renstra_kegiatan_indikator`
--
ALTER TABLE `trx_renstra_kegiatan_indikator`
  MODIFY `id_indikator_kegiatan_renstra` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_renstra_misi`
--
ALTER TABLE `trx_renstra_misi`
  MODIFY `id_misi_renstra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renstra_program`
--
ALTER TABLE `trx_renstra_program`
  MODIFY `id_program_renstra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renstra_program_indikator`
--
ALTER TABLE `trx_renstra_program_indikator`
  MODIFY `id_indikator_program_renstra` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_renstra_sasaran`
--
ALTER TABLE `trx_renstra_sasaran`
  MODIFY `id_sasaran_renstra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renstra_sasaran_indikator`
--
ALTER TABLE `trx_renstra_sasaran_indikator`
  MODIFY `id_indikator_sasaran_renstra` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_renstra_strategi`
--
ALTER TABLE `trx_renstra_strategi`
  MODIFY `id_strategi_renstra` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_renstra_tujuan`
--
ALTER TABLE `trx_renstra_tujuan`
  MODIFY `id_tujuan_renstra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_renstra_tujuan_indikator`
--
ALTER TABLE `trx_renstra_tujuan_indikator`
  MODIFY `id_indikator_tujuan_renstra` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_renstra_visi`
--
ALTER TABLE `trx_renstra_visi`
  MODIFY `id_visi_renstra` int(11) NOT NULL AUTO_INCREMENT COMMENT 'berisi id khusus untuk setiap visi pada periode yang sama';

--
-- AUTO_INCREMENT for table `trx_rkpd_final`
--
ALTER TABLE `trx_rkpd_final`
  MODIFY `id_rkpd_rancangan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_final_aktivitas_pd`
--
ALTER TABLE `trx_rkpd_final_aktivitas_pd`
  MODIFY `id_aktivitas_pd` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_final_belanja_pd`
--
ALTER TABLE `trx_rkpd_final_belanja_pd`
  MODIFY `id_belanja_pd` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_final_dokumen`
--
ALTER TABLE `trx_rkpd_final_dokumen`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_final_indikator`
--
ALTER TABLE `trx_rkpd_final_indikator`
  MODIFY `id_indikator_rkpd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_rkpd_final_kebijakan`
--
ALTER TABLE `trx_rkpd_final_kebijakan`
  MODIFY `id_kebijakan_rkpd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_final_kebijakan_pd`
--
ALTER TABLE `trx_rkpd_final_kebijakan_pd`
  MODIFY `id_kebijakan_pd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_final_kegiatan_pd`
--
ALTER TABLE `trx_rkpd_final_kegiatan_pd`
  MODIFY `id_kegiatan_pd` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_final_keg_indikator_pd`
--
ALTER TABLE `trx_rkpd_final_keg_indikator_pd`
  MODIFY `id_indikator_kegiatan` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_rkpd_final_lokasi_pd`
--
ALTER TABLE `trx_rkpd_final_lokasi_pd`
  MODIFY `id_lokasi_pd` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_final_pelaksana`
--
ALTER TABLE `trx_rkpd_final_pelaksana`
  MODIFY `id_pelaksana_rkpd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_final_pelaksana_pd`
--
ALTER TABLE `trx_rkpd_final_pelaksana_pd`
  MODIFY `id_pelaksana_pd` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_final_program_pd`
--
ALTER TABLE `trx_rkpd_final_program_pd`
  MODIFY `id_program_pd` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_final_prog_indikator_pd`
--
ALTER TABLE `trx_rkpd_final_prog_indikator_pd`
  MODIFY `id_indikator_program` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_rkpd_final_urusan`
--
ALTER TABLE `trx_rkpd_final_urusan`
  MODIFY `id_urusan_rkpd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_rancangan`
--
ALTER TABLE `trx_rkpd_rancangan`
  MODIFY `id_rkpd_rancangan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_rancangan_aktivitas_pd`
--
ALTER TABLE `trx_rkpd_rancangan_aktivitas_pd`
  MODIFY `id_aktivitas_pd` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_rancangan_belanja_pd`
--
ALTER TABLE `trx_rkpd_rancangan_belanja_pd`
  MODIFY `id_belanja_pd` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_rancangan_dokumen`
--
ALTER TABLE `trx_rkpd_rancangan_dokumen`
  MODIFY `id_dokumen_rkpd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_rancangan_indikator`
--
ALTER TABLE `trx_rkpd_rancangan_indikator`
  MODIFY `id_indikator_rkpd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_rkpd_rancangan_kebijakan`
--
ALTER TABLE `trx_rkpd_rancangan_kebijakan`
  MODIFY `id_kebijakan_rkpd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_rancangan_kebijakan_pd`
--
ALTER TABLE `trx_rkpd_rancangan_kebijakan_pd`
  MODIFY `id_kebijakan_pd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_rancangan_kegiatan_pd`
--
ALTER TABLE `trx_rkpd_rancangan_kegiatan_pd`
  MODIFY `id_kegiatan_pd` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_rancangan_keg_indikator_pd`
--
ALTER TABLE `trx_rkpd_rancangan_keg_indikator_pd`
  MODIFY `id_indikator_kegiatan` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_rkpd_rancangan_lokasi_pd`
--
ALTER TABLE `trx_rkpd_rancangan_lokasi_pd`
  MODIFY `id_lokasi_pd` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_rancangan_pelaksana`
--
ALTER TABLE `trx_rkpd_rancangan_pelaksana`
  MODIFY `id_pelaksana_rkpd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_rancangan_pelaksana_pd`
--
ALTER TABLE `trx_rkpd_rancangan_pelaksana_pd`
  MODIFY `id_pelaksana_pd` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_rancangan_program_pd`
--
ALTER TABLE `trx_rkpd_rancangan_program_pd`
  MODIFY `id_program_pd` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_rancangan_prog_indikator_pd`
--
ALTER TABLE `trx_rkpd_rancangan_prog_indikator_pd`
  MODIFY `id_indikator_program` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_rkpd_rancangan_urusan`
--
ALTER TABLE `trx_rkpd_rancangan_urusan`
  MODIFY `id_urusan_rkpd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_ranhir`
--
ALTER TABLE `trx_rkpd_ranhir`
  MODIFY `id_rkpd_rancangan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_ranhir_aktivitas_pd`
--
ALTER TABLE `trx_rkpd_ranhir_aktivitas_pd`
  MODIFY `id_aktivitas_pd` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_ranhir_belanja_pd`
--
ALTER TABLE `trx_rkpd_ranhir_belanja_pd`
  MODIFY `id_belanja_pd` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_ranhir_dokumen`
--
ALTER TABLE `trx_rkpd_ranhir_dokumen`
  MODIFY `id_dokumen_rkpd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_ranhir_indikator`
--
ALTER TABLE `trx_rkpd_ranhir_indikator`
  MODIFY `id_indikator_rkpd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_rkpd_ranhir_kebijakan`
--
ALTER TABLE `trx_rkpd_ranhir_kebijakan`
  MODIFY `id_kebijakan_rkpd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_ranhir_kebijakan_pd`
--
ALTER TABLE `trx_rkpd_ranhir_kebijakan_pd`
  MODIFY `id_kebijakan_pd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_ranhir_kegiatan_pd`
--
ALTER TABLE `trx_rkpd_ranhir_kegiatan_pd`
  MODIFY `id_kegiatan_pd` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_ranhir_keg_indikator_pd`
--
ALTER TABLE `trx_rkpd_ranhir_keg_indikator_pd`
  MODIFY `id_indikator_kegiatan` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_rkpd_ranhir_lokasi_pd`
--
ALTER TABLE `trx_rkpd_ranhir_lokasi_pd`
  MODIFY `id_lokasi_pd` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_ranhir_pelaksana`
--
ALTER TABLE `trx_rkpd_ranhir_pelaksana`
  MODIFY `id_pelaksana_rkpd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_ranhir_pelaksana_pd`
--
ALTER TABLE `trx_rkpd_ranhir_pelaksana_pd`
  MODIFY `id_pelaksana_pd` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_ranhir_program_pd`
--
ALTER TABLE `trx_rkpd_ranhir_program_pd`
  MODIFY `id_program_pd` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_ranhir_prog_indikator_pd`
--
ALTER TABLE `trx_rkpd_ranhir_prog_indikator_pd`
  MODIFY `id_indikator_program` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_rkpd_ranhir_urusan`
--
ALTER TABLE `trx_rkpd_ranhir_urusan`
  MODIFY `id_urusan_rkpd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_ranwal`
--
ALTER TABLE `trx_rkpd_ranwal`
  MODIFY `id_rkpd_ranwal` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_ranwal_dokumen`
--
ALTER TABLE `trx_rkpd_ranwal_dokumen`
  MODIFY `id_dokumen_ranwal` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_ranwal_indikator`
--
ALTER TABLE `trx_rkpd_ranwal_indikator`
  MODIFY `id_indikator_program_rkpd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_rkpd_ranwal_kebijakan`
--
ALTER TABLE `trx_rkpd_ranwal_kebijakan`
  MODIFY `id_kebijakan_ranwal` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_ranwal_pelaksana`
--
ALTER TABLE `trx_rkpd_ranwal_pelaksana`
  MODIFY `id_pelaksana_rpjmd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_ranwal_urusan`
--
ALTER TABLE `trx_rkpd_ranwal_urusan`
  MODIFY `id_urusan_rkpd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_renstra`
--
ALTER TABLE `trx_rkpd_renstra`
  MODIFY `id_rkpd_renstra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_renstra_indikator`
--
ALTER TABLE `trx_rkpd_renstra_indikator`
  MODIFY `id_indikator_renstra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_renstra_pelaksana`
--
ALTER TABLE `trx_rkpd_renstra_pelaksana`
  MODIFY `id_pelaksana_renstra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_rpjmd_kebijakan`
--
ALTER TABLE `trx_rkpd_rpjmd_kebijakan`
  MODIFY `id_kebijakan_rpjmd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_rpjmd_program_indikator`
--
ALTER TABLE `trx_rkpd_rpjmd_program_indikator`
  MODIFY `id_indikator_program_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_rkpd_rpjmd_program_pelaksana`
--
ALTER TABLE `trx_rkpd_rpjmd_program_pelaksana`
  MODIFY `id_pelaksana_rpjmd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rkpd_rpjmd_ranwal`
--
ALTER TABLE `trx_rkpd_rpjmd_ranwal`
  MODIFY `id_rkpd_rpjmd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rpjmd_dokumen`
--
ALTER TABLE `trx_rpjmd_dokumen`
  MODIFY `id_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'berisi id khusus untuk setiap visi pada periode yang sama';

--
-- AUTO_INCREMENT for table `trx_rpjmd_kebijakan`
--
ALTER TABLE `trx_rpjmd_kebijakan`
  MODIFY `id_kebijakan_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_rpjmd_misi`
--
ALTER TABLE `trx_rpjmd_misi`
  MODIFY `id_misi_rpjmd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rpjmd_program`
--
ALTER TABLE `trx_rpjmd_program`
  MODIFY `id_program_rpjmd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rpjmd_program_indikator`
--
ALTER TABLE `trx_rpjmd_program_indikator`
  MODIFY `id_indikator_program_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_rpjmd_program_pelaksana`
--
ALTER TABLE `trx_rpjmd_program_pelaksana`
  MODIFY `id_pelaksana_rpjmd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rpjmd_program_urusan`
--
ALTER TABLE `trx_rpjmd_program_urusan`
  MODIFY `id_urbid_rpjmd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rpjmd_ranwal_dokumen`
--
ALTER TABLE `trx_rpjmd_ranwal_dokumen`
  MODIFY `id_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'berisi id khusus untuk setiap visi pada periode yang sama';

--
-- AUTO_INCREMENT for table `trx_rpjmd_ranwal_kebijakan`
--
ALTER TABLE `trx_rpjmd_ranwal_kebijakan`
  MODIFY `id_kebijakan_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_rpjmd_ranwal_misi`
--
ALTER TABLE `trx_rpjmd_ranwal_misi`
  MODIFY `id_misi_rpjmd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rpjmd_ranwal_program`
--
ALTER TABLE `trx_rpjmd_ranwal_program`
  MODIFY `id_program_rpjmd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rpjmd_ranwal_program_indikator`
--
ALTER TABLE `trx_rpjmd_ranwal_program_indikator`
  MODIFY `id_indikator_program_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_rpjmd_ranwal_program_pelaksana`
--
ALTER TABLE `trx_rpjmd_ranwal_program_pelaksana`
  MODIFY `id_pelaksana_rpjmd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rpjmd_ranwal_program_urusan`
--
ALTER TABLE `trx_rpjmd_ranwal_program_urusan`
  MODIFY `id_urbid_rpjmd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rpjmd_ranwal_sasaran`
--
ALTER TABLE `trx_rpjmd_ranwal_sasaran`
  MODIFY `id_sasaran_rpjmd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rpjmd_ranwal_sasaran_indikator`
--
ALTER TABLE `trx_rpjmd_ranwal_sasaran_indikator`
  MODIFY `id_indikator_sasaran_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_rpjmd_ranwal_strategi`
--
ALTER TABLE `trx_rpjmd_ranwal_strategi`
  MODIFY `id_strategi_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_rpjmd_ranwal_tujuan`
--
ALTER TABLE `trx_rpjmd_ranwal_tujuan`
  MODIFY `id_tujuan_rpjmd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rpjmd_ranwal_tujuan_indikator`
--
ALTER TABLE `trx_rpjmd_ranwal_tujuan_indikator`
  MODIFY `id_indikator_tujuan_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_rpjmd_ranwal_visi`
--
ALTER TABLE `trx_rpjmd_ranwal_visi`
  MODIFY `id_visi_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'berisi id khusus untuk setiap visi pada periode yang sama';

--
-- AUTO_INCREMENT for table `trx_rpjmd_sasaran`
--
ALTER TABLE `trx_rpjmd_sasaran`
  MODIFY `id_sasaran_rpjmd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rpjmd_sasaran_indikator`
--
ALTER TABLE `trx_rpjmd_sasaran_indikator`
  MODIFY `id_indikator_sasaran_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_rpjmd_strategi`
--
ALTER TABLE `trx_rpjmd_strategi`
  MODIFY `id_strategi_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_rpjmd_tujuan`
--
ALTER TABLE `trx_rpjmd_tujuan`
  MODIFY `id_tujuan_rpjmd` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_rpjmd_tujuan_indikator`
--
ALTER TABLE `trx_rpjmd_tujuan_indikator`
  MODIFY `id_indikator_tujuan_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'nomor urut indikator sasaran';

--
-- AUTO_INCREMENT for table `trx_rpjmd_visi`
--
ALTER TABLE `trx_rpjmd_visi`
  MODIFY `id_visi_rpjmd` int(11) NOT NULL AUTO_INCREMENT COMMENT 'berisi id khusus untuk setiap visi pada periode yang sama';

--
-- AUTO_INCREMENT for table `trx_usulan_kab`
--
ALTER TABLE `trx_usulan_kab`
  MODIFY `id_usulan_kab` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trx_usulan_rw`
--
ALTER TABLE `trx_usulan_rw`
  MODIFY `id_usulan_rw` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_app`
--
ALTER TABLE `user_app`
  MODIFY `id_app_user` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_desa`
--
ALTER TABLE `user_desa`
  MODIFY `id_user_wil` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_sub_unit`
--
ALTER TABLE `user_sub_unit`
  MODIFY `id_user_unit` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `kin_trx_cascading_indikator_kegiatan_pd`
--
ALTER TABLE `kin_trx_cascading_indikator_kegiatan_pd`
  ADD CONSTRAINT `FK_kin_trx_cascading_indikator_kegiatan_pd_kin_1` FOREIGN KEY (`id_hasil_kegiatan`) REFERENCES `kin_trx_cascading_kegiatan_opd` (`id_hasil_kegiatan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_cascading_indikator_program_pd`
--
ALTER TABLE `kin_trx_cascading_indikator_program_pd`
  ADD CONSTRAINT `FK_kin_trx_cascading_indikator_program_pd_1` FOREIGN KEY (`id_hasil_program`) REFERENCES `kin_trx_cascading_program_opd` (`id_hasil_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_cascading_kegiatan_opd`
--
ALTER TABLE `kin_trx_cascading_kegiatan_opd`
  ADD CONSTRAINT `FK_kin_trx_cascading_kegiatan_opd_kin_trx_cascading_program_opd` FOREIGN KEY (`id_hasil_program`) REFERENCES `kin_trx_cascading_program_opd` (`id_hasil_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_iku_opd_kegiatan`
--
ALTER TABLE `kin_trx_iku_opd_kegiatan`
  ADD CONSTRAINT `kin_trx_iku_opd_kegiatan_ibfk_1` FOREIGN KEY (`id_iku_opd_program`) REFERENCES `kin_trx_iku_opd_program` (`id_iku_opd_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_iku_opd_program`
--
ALTER TABLE `kin_trx_iku_opd_program`
  ADD CONSTRAINT `kin_trx_iku_opd_program_ibfk_1` FOREIGN KEY (`id_iku_opd_sasaran`) REFERENCES `kin_trx_iku_opd_sasaran` (`id_iku_opd_sasaran`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_iku_opd_sasaran`
--
ALTER TABLE `kin_trx_iku_opd_sasaran`
  ADD CONSTRAINT `kin_trx_iku_opd_sasaran_ibfk_1` FOREIGN KEY (`id_dokumen`) REFERENCES `kin_trx_iku_opd_dok` (`id_dokumen`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_iku_pemda_rinci`
--
ALTER TABLE `kin_trx_iku_pemda_rinci`
  ADD CONSTRAINT `kin_trx_iku_pemda_rinci_ibfk_1` FOREIGN KEY (`id_dokumen`) REFERENCES `kin_trx_iku_pemda_dok` (`id_dokumen`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_perkin_es3_kegiatan`
--
ALTER TABLE `kin_trx_perkin_es3_kegiatan`
  ADD CONSTRAINT `kin_trx_perkin_es3_kegiatan_ibfk_1` FOREIGN KEY (`id_perkin_program`) REFERENCES `kin_trx_perkin_es3_program` (`id_perkin_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_perkin_es3_program`
--
ALTER TABLE `kin_trx_perkin_es3_program`
  ADD CONSTRAINT `kin_trx_perkin_es3_program_ibfk_1` FOREIGN KEY (`id_dokumen_perkin`) REFERENCES `kin_trx_perkin_es3_dok` (`id_dokumen_perkin`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kin_trx_perkin_es3_program_ibfk_2` FOREIGN KEY (`id_perkin_program_opd`) REFERENCES `kin_trx_perkin_opd_program` (`id_perkin_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_perkin_es3_program_indikator`
--
ALTER TABLE `kin_trx_perkin_es3_program_indikator`
  ADD CONSTRAINT `kin_trx_perkin_es3_program_indikator_ibfk_1` FOREIGN KEY (`id_perkin_program`) REFERENCES `kin_trx_perkin_es3_program` (`id_perkin_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_perkin_es4_kegiatan`
--
ALTER TABLE `kin_trx_perkin_es4_kegiatan`
  ADD CONSTRAINT `kin_trx_perkin_es4_kegiatan_ibfk_1` FOREIGN KEY (`id_perkin_kegiatan_es3`) REFERENCES `kin_trx_perkin_es3_kegiatan` (`id_perkin_kegiatan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kin_trx_perkin_es4_kegiatan_ibfk_2` FOREIGN KEY (`id_dokumen_perkin`) REFERENCES `kin_trx_perkin_es4_dok` (`id_dokumen_perkin`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_perkin_es4_kegiatan_indikator`
--
ALTER TABLE `kin_trx_perkin_es4_kegiatan_indikator`
  ADD CONSTRAINT `kin_trx_perkin_es4_kegiatan_indikator_ibfk_1` FOREIGN KEY (`id_perkin_kegiatan`) REFERENCES `kin_trx_perkin_es4_kegiatan` (`id_perkin_kegiatan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_perkin_opd_program`
--
ALTER TABLE `kin_trx_perkin_opd_program`
  ADD CONSTRAINT `kin_trx_perkin_opd_program_ibfk_1` FOREIGN KEY (`id_perkin_sasaran`) REFERENCES `kin_trx_perkin_opd_sasaran` (`id_perkin_sasaran`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_perkin_opd_sasaran`
--
ALTER TABLE `kin_trx_perkin_opd_sasaran`
  ADD CONSTRAINT `kin_trx_perkin_opd_sasaran_ibfk_1` FOREIGN KEY (`id_dokumen_perkin`) REFERENCES `kin_trx_perkin_opd_dok` (`id_dokumen_perkin`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_perkin_opd_sasaran_indikator`
--
ALTER TABLE `kin_trx_perkin_opd_sasaran_indikator`
  ADD CONSTRAINT `kin_trx_perkin_opd_sasaran_indikator_ibfk_1` FOREIGN KEY (`id_perkin_sasaran`) REFERENCES `kin_trx_perkin_opd_sasaran` (`id_perkin_sasaran`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_real_es2_dok`
--
ALTER TABLE `kin_trx_real_es2_dok`
  ADD CONSTRAINT `kin_trx_real_es2_dok_ibfk_1` FOREIGN KEY (`id_dokumen_perkin`) REFERENCES `kin_trx_perkin_opd_dok` (`id_dokumen_perkin`),
  ADD CONSTRAINT `kin_trx_real_es2_dok_ibfk_2` FOREIGN KEY (`id_sotk_es2`) REFERENCES `ref_sotk_level_1` (`id_sotk_es2`);

--
-- Constraints for table `kin_trx_real_es2_program`
--
ALTER TABLE `kin_trx_real_es2_program`
  ADD CONSTRAINT `kin_trx_real_es2_program_ibfk_1` FOREIGN KEY (`id_real_sasaran`) REFERENCES `kin_trx_real_es2_sasaran` (`id_real_sasaran`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kin_trx_real_es2_program_ibfk_2` FOREIGN KEY (`id_perkin_program`) REFERENCES `kin_trx_perkin_opd_program` (`id_perkin_program`),
  ADD CONSTRAINT `kin_trx_real_es2_program_ibfk_3` FOREIGN KEY (`id_real_program_es3`) REFERENCES `kin_trx_real_es3_program` (`id_real_program`);

--
-- Constraints for table `kin_trx_real_es2_sasaran`
--
ALTER TABLE `kin_trx_real_es2_sasaran`
  ADD CONSTRAINT `kin_trx_real_es2_sasaran_ibfk_1` FOREIGN KEY (`id_dokumen_real`) REFERENCES `kin_trx_real_es2_dok` (`id_dokumen_real`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_real_es2_sasaran_indikator`
--
ALTER TABLE `kin_trx_real_es2_sasaran_indikator`
  ADD CONSTRAINT `kin_trx_real_es2_sasaran_indikator_ibfk_1` FOREIGN KEY (`id_real_sasaran`) REFERENCES `kin_trx_real_es2_sasaran` (`id_real_sasaran`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_real_es3_dok`
--
ALTER TABLE `kin_trx_real_es3_dok`
  ADD CONSTRAINT `kin_trx_real_es3_dok_ibfk_1` FOREIGN KEY (`id_dokumen_perkin`) REFERENCES `kin_trx_perkin_es3_dok` (`id_dokumen_perkin`),
  ADD CONSTRAINT `kin_trx_real_es3_dok_ibfk_2` FOREIGN KEY (`id_sotk_es3`) REFERENCES `ref_sotk_level_2` (`id_sotk_es3`);

--
-- Constraints for table `kin_trx_real_es3_kegiatan`
--
ALTER TABLE `kin_trx_real_es3_kegiatan`
  ADD CONSTRAINT `kin_trx_real_es3_kegiatan_ibfk_1` FOREIGN KEY (`id_real_program`) REFERENCES `kin_trx_real_es3_program` (`id_real_program`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kin_trx_real_es3_kegiatan_ibfk_2` FOREIGN KEY (`id_real_kegiatan_es4`) REFERENCES `kin_trx_real_es4_kegiatan` (`id_real_kegiatan`);

--
-- Constraints for table `kin_trx_real_es3_program`
--
ALTER TABLE `kin_trx_real_es3_program`
  ADD CONSTRAINT `kin_trx_real_es3_program_ibfk_1` FOREIGN KEY (`id_dokumen_real`) REFERENCES `kin_trx_real_es3_dok` (`id_dokumen_real`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kin_trx_real_es3_program_ibfk_2` FOREIGN KEY (`id_perkin_program`) REFERENCES `kin_trx_perkin_es3_program` (`id_perkin_program`);

--
-- Constraints for table `kin_trx_real_es3_program_indikator`
--
ALTER TABLE `kin_trx_real_es3_program_indikator`
  ADD CONSTRAINT `kin_trx_real_es3_program_indikator_ibfk_1` FOREIGN KEY (`id_real_program`) REFERENCES `kin_trx_real_es3_program` (`id_real_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kin_trx_real_es4_dok`
--
ALTER TABLE `kin_trx_real_es4_dok`
  ADD CONSTRAINT `kin_trx_real_es4_dok_ibfk_1` FOREIGN KEY (`id_dokumen_perkin`) REFERENCES `kin_trx_perkin_es4_dok` (`id_dokumen_perkin`),
  ADD CONSTRAINT `kin_trx_real_es4_dok_ibfk_2` FOREIGN KEY (`id_sotk_es4`) REFERENCES `ref_sotk_level_3` (`id_sotk_es4`);

--
-- Constraints for table `kin_trx_real_es4_kegiatan`
--
ALTER TABLE `kin_trx_real_es4_kegiatan`
  ADD CONSTRAINT `kin_trx_real_es4_kegiatan_ibfk_1` FOREIGN KEY (`id_dokumen_real`) REFERENCES `kin_trx_real_es4_dok` (`id_dokumen_real`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kin_trx_real_es4_kegiatan_ibfk_2` FOREIGN KEY (`id_perkin_kegiatan`) REFERENCES `kin_trx_perkin_es4_kegiatan` (`id_perkin_kegiatan`);

--
-- Constraints for table `kin_trx_real_es4_kegiatan_indikator`
--
ALTER TABLE `kin_trx_real_es4_kegiatan_indikator`
  ADD CONSTRAINT `kin_trx_real_es4_kegiatan_indikator_ibfk_1` FOREIGN KEY (`id_real_kegiatan`) REFERENCES `kin_trx_real_es4_kegiatan` (`id_real_kegiatan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_bidang`
--
ALTER TABLE `ref_bidang`
  ADD CONSTRAINT `fk_ref_bidang` FOREIGN KEY (`kd_urusan`) REFERENCES `ref_urusan` (`kd_urusan`),
  ADD CONSTRAINT `fk_ref_fungsi` FOREIGN KEY (`kd_fungsi`) REFERENCES `ref_fungsi` (`kd_fungsi`);

--
-- Constraints for table `ref_data_sub_unit`
--
ALTER TABLE `ref_data_sub_unit`
  ADD CONSTRAINT `fk_data_sub_unit` FOREIGN KEY (`id_sub_unit`) REFERENCES `ref_sub_unit` (`id_sub_unit`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_desa`
--
ALTER TABLE `ref_desa`
  ADD CONSTRAINT `ref_desa_ibfk_1` FOREIGN KEY (`id_kecamatan`) REFERENCES `ref_kecamatan` (`id_kecamatan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_kecamatan`
--
ALTER TABLE `ref_kecamatan`
  ADD CONSTRAINT `fk_ref_kecamatan` FOREIGN KEY (`id_pemda`) REFERENCES `ref_kabupaten` (`id_kab`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_kegiatan`
--
ALTER TABLE `ref_kegiatan`
  ADD CONSTRAINT `fk_ref_kegiatan` FOREIGN KEY (`id_program`) REFERENCES `ref_program` (`id_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_kolom_tabel_dasar`
--
ALTER TABLE `ref_kolom_tabel_dasar`
  ADD CONSTRAINT `ref_kolom_tabel_dasar_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `ref_kolom_tabel_dasar` (`id_kolom_tabel_dasar`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ref_kolom_tabel_dasar_ibfk_2` FOREIGN KEY (`id_tabel_dasar`) REFERENCES `ref_tabel_dasar` (`id_tabel_dasar`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_mapping_asb_renstra`
--
ALTER TABLE `ref_mapping_asb_renstra`
  ADD CONSTRAINT `fk_ref_mapping_asb_renstra` FOREIGN KEY (`id_aktivitas_asb`) REFERENCES `trx_asb_aktivitas` (`id_aktivitas_asb`),
  ADD CONSTRAINT `fk_ref_mapping_asb_renstra1` FOREIGN KEY (`id_kegiatan_renstra`) REFERENCES `trx_renstra_kegiatan` (`id_kegiatan_renstra`);

--
-- Constraints for table `ref_pegawai_pangkat`
--
ALTER TABLE `ref_pegawai_pangkat`
  ADD CONSTRAINT `ref_pegawai_pangkat_ibfk_1` FOREIGN KEY (`id_pegawai`) REFERENCES `ref_pegawai` (`id_pegawai`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_pegawai_unit`
--
ALTER TABLE `ref_pegawai_unit`
  ADD CONSTRAINT `ref_pegawai_unit_ibfk_1` FOREIGN KEY (`id_pegawai`) REFERENCES `ref_pegawai` (`id_pegawai`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ref_pegawai_unit_ibfk_2` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_program`
--
ALTER TABLE `ref_program`
  ADD CONSTRAINT `fk_ref_program` FOREIGN KEY (`id_bidang`) REFERENCES `ref_bidang` (`id_bidang`);

--
-- Constraints for table `ref_program_nasional`
--
ALTER TABLE `ref_program_nasional`
  ADD CONSTRAINT `ref_program_nasional_ibfk_1` FOREIGN KEY (`id_prioritas`) REFERENCES `ref_prioritas_nasional` (`id_prioritas`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_program_provinsi`
--
ALTER TABLE `ref_program_provinsi`
  ADD CONSTRAINT `ref_program_provinsi_ibfk_1` FOREIGN KEY (`id_prioritas`) REFERENCES `ref_prioritas_provinsi` (`id_prioritas`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_rek_2`
--
ALTER TABLE `ref_rek_2`
  ADD CONSTRAINT `fk_ref_rek_2` FOREIGN KEY (`kd_rek_1`) REFERENCES `ref_rek_1` (`kd_rek_1`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ref_rek_3`
--
ALTER TABLE `ref_rek_3`
  ADD CONSTRAINT `fk_ref_rek_3` FOREIGN KEY (`kd_rek_1`,`kd_rek_2`) REFERENCES `ref_rek_2` (`kd_rek_1`, `kd_rek_2`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ref_rek_4`
--
ALTER TABLE `ref_rek_4`
  ADD CONSTRAINT `fk_ref_rek_4` FOREIGN KEY (`kd_rek_1`,`kd_rek_2`,`kd_rek_3`) REFERENCES `ref_rek_3` (`kd_rek_1`, `kd_rek_2`, `kd_rek_3`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ref_rek_5`
--
ALTER TABLE `ref_rek_5`
  ADD CONSTRAINT `ref_rek_5_ibfk_1` FOREIGN KEY (`kd_rek_1`,`kd_rek_2`,`kd_rek_3`,`kd_rek_4`) REFERENCES `ref_rek_4` (`kd_rek_1`, `kd_rek_2`, `kd_rek_3`, `kd_rek_4`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_sotk_level_1`
--
ALTER TABLE `ref_sotk_level_1`
  ADD CONSTRAINT `ref_sotk_level_1_ibfk_2` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_sotk_level_2`
--
ALTER TABLE `ref_sotk_level_2`
  ADD CONSTRAINT `ref_sotk_level_2_ibfk_1` FOREIGN KEY (`id_sotk_es2`) REFERENCES `ref_sotk_level_1` (`id_sotk_es2`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_sotk_level_3`
--
ALTER TABLE `ref_sotk_level_3`
  ADD CONSTRAINT `ref_sotk_level_3_ibfk_1` FOREIGN KEY (`id_sotk_es3`) REFERENCES `ref_sotk_level_2` (`id_sotk_es3`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_ssh_kelompok`
--
ALTER TABLE `ref_ssh_kelompok`
  ADD CONSTRAINT `fk_ssh_kelompok` FOREIGN KEY (`id_golongan_ssh`) REFERENCES `ref_ssh_golongan` (`id_golongan_ssh`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_ssh_perkada_tarif`
--
ALTER TABLE `ref_ssh_perkada_tarif`
  ADD CONSTRAINT `fk_ref_tarif_jumlah` FOREIGN KEY (`id_tarif_ssh`) REFERENCES `ref_ssh_tarif` (`id_tarif_ssh`),
  ADD CONSTRAINT `fk_ref_tarif_jumlah_1` FOREIGN KEY (`id_zona_perkada`) REFERENCES `ref_ssh_perkada_zona` (`id_zona_perkada`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_ssh_perkada_zona`
--
ALTER TABLE `ref_ssh_perkada_zona`
  ADD CONSTRAINT `FK_ref_ssh_perkada_zona_ref_ssh_zona` FOREIGN KEY (`id_zona`) REFERENCES `ref_ssh_zona` (`id_zona`),
  ADD CONSTRAINT `FK_ref_ssh_perkada_zona_ref_ssh_zona_1` FOREIGN KEY (`id_perkada`) REFERENCES `ref_ssh_perkada` (`id_perkada`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_ssh_rekening`
--
ALTER TABLE `ref_ssh_rekening`
  ADD CONSTRAINT `fk_ref_ssh_rekening` FOREIGN KEY (`id_tarif_ssh`) REFERENCES `ref_ssh_tarif` (`id_tarif_ssh`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_ssh_sub_kelompok`
--
ALTER TABLE `ref_ssh_sub_kelompok`
  ADD CONSTRAINT `fk_ref_ssh_sub_kelompok` FOREIGN KEY (`id_kelompok_ssh`) REFERENCES `ref_ssh_kelompok` (`id_kelompok_ssh`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_ssh_tarif`
--
ALTER TABLE `ref_ssh_tarif`
  ADD CONSTRAINT `fk_ref_ssh_tarif` FOREIGN KEY (`id_sub_kelompok_ssh`) REFERENCES `ref_ssh_sub_kelompok` (`id_sub_kelompok_ssh`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_ssh_zona_lokasi`
--
ALTER TABLE `ref_ssh_zona_lokasi`
  ADD CONSTRAINT `fk_zona_lokasi` FOREIGN KEY (`id_zona`) REFERENCES `ref_ssh_zona` (`id_zona`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ref_sub_unit`
--
ALTER TABLE `ref_sub_unit`
  ADD CONSTRAINT `fk_ref_sub_unit` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`);

--
-- Constraints for table `ref_unit`
--
ALTER TABLE `ref_unit`
  ADD CONSTRAINT `fk_ref_unit` FOREIGN KEY (`id_bidang`) REFERENCES `ref_bidang` (`id_bidang`);

--
-- Constraints for table `trx_asb_aktivitas`
--
ALTER TABLE `trx_asb_aktivitas`
  ADD CONSTRAINT `FK_trx_asb_aktivitas_trx_asb_sub_sub_kelompok` FOREIGN KEY (`id_asb_sub_sub_kelompok`) REFERENCES `trx_asb_sub_sub_kelompok` (`id_asb_sub_sub_kelompok`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_asb_kelompok`
--
ALTER TABLE `trx_asb_kelompok`
  ADD CONSTRAINT `FK_trx_asb_cluster_trx_asb_perkada` FOREIGN KEY (`id_asb_perkada`) REFERENCES `trx_asb_perkada` (`id_asb_perkada`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_asb_komponen`
--
ALTER TABLE `trx_asb_komponen`
  ADD CONSTRAINT `FK_trx_asb_komponen_trx_asb_aktivitas` FOREIGN KEY (`id_aktivitas_asb`) REFERENCES `trx_asb_aktivitas` (`id_aktivitas_asb`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_asb_komponen_rinci`
--
ALTER TABLE `trx_asb_komponen_rinci`
  ADD CONSTRAINT `FK_trx_asb_komponen_rinci_ref_ssh_tarif` FOREIGN KEY (`id_tarif_ssh`) REFERENCES `ref_ssh_tarif` (`id_tarif_ssh`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_trx_asb_komponen_rinci_trx_asb_komponen` FOREIGN KEY (`id_komponen_asb`) REFERENCES `trx_asb_komponen` (`id_komponen_asb`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_asb_perhitungan_rinci`
--
ALTER TABLE `trx_asb_perhitungan_rinci`
  ADD CONSTRAINT `trx_asb_perhitungan_rinci_ibfk_1` FOREIGN KEY (`id_perhitungan`) REFERENCES `trx_asb_perhitungan` (`id_perhitungan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_asb_sub_kelompok`
--
ALTER TABLE `trx_asb_sub_kelompok`
  ADD CONSTRAINT `trx_asb_sub_kelompok_ibfk_1` FOREIGN KEY (`id_asb_kelompok`) REFERENCES `trx_asb_kelompok` (`id_asb_kelompok`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_asb_sub_sub_kelompok`
--
ALTER TABLE `trx_asb_sub_sub_kelompok`
  ADD CONSTRAINT `FK_trx_asb_sub_sub_kelompok_trx_asb_sub_kelompok` FOREIGN KEY (`id_asb_sub_kelompok`) REFERENCES `trx_asb_sub_kelompok` (`id_asb_sub_kelompok`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_forum_skpd`
--
ALTER TABLE `trx_forum_skpd`
  ADD CONSTRAINT `FK_trx_forum_skpd_trx_forum_skpd_program` FOREIGN KEY (`id_forum_program`) REFERENCES `trx_forum_skpd_program` (`id_forum_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_forum_skpd_aktivitas`
--
ALTER TABLE `trx_forum_skpd_aktivitas`
  ADD CONSTRAINT `FK_trx_forum_skpd_aktivitas_trx_forum_skpd` FOREIGN KEY (`id_forum_skpd`) REFERENCES `trx_forum_skpd_pelaksana` (`id_pelaksana_forum`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_forum_skpd_belanja`
--
ALTER TABLE `trx_forum_skpd_belanja`
  ADD CONSTRAINT `trx_forum_skpd_belanja_ibfk_1` FOREIGN KEY (`id_lokasi_forum`) REFERENCES `trx_forum_skpd_aktivitas` (`id_aktivitas_forum`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_forum_skpd_kegiatan_indikator`
--
ALTER TABLE `trx_forum_skpd_kegiatan_indikator`
  ADD CONSTRAINT `trx_forum_skpd_kegiatan_indikator_ibfk_1` FOREIGN KEY (`id_forum_skpd`) REFERENCES `trx_forum_skpd` (`id_forum_skpd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_forum_skpd_lokasi`
--
ALTER TABLE `trx_forum_skpd_lokasi`
  ADD CONSTRAINT `trx_forum_skpd_lokasi_ibfk_1` FOREIGN KEY (`id_pelaksana_forum`) REFERENCES `trx_forum_skpd_aktivitas` (`id_aktivitas_forum`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_forum_skpd_pelaksana`
--
ALTER TABLE `trx_forum_skpd_pelaksana`
  ADD CONSTRAINT `trx_forum_skpd_pelaksana_ibfk_1` FOREIGN KEY (`id_aktivitas_forum`) REFERENCES `trx_forum_skpd` (`id_forum_skpd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_forum_skpd_program`
--
ALTER TABLE `trx_forum_skpd_program`
  ADD CONSTRAINT `FK_trx_forum_skpd_program_trx_forum_skpd_program_ranwal` FOREIGN KEY (`id_forum_rkpdprog`) REFERENCES `trx_forum_skpd_program_ranwal` (`id_forum_rkpdprog`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_forum_skpd_program_indikator`
--
ALTER TABLE `trx_forum_skpd_program_indikator`
  ADD CONSTRAINT `trx_forum_skpd_program_indikator_ibfk_1` FOREIGN KEY (`id_forum_program`) REFERENCES `trx_forum_skpd_program` (`id_forum_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_forum_skpd_usulan`
--
ALTER TABLE `trx_forum_skpd_usulan`
  ADD CONSTRAINT `FK_trx_forum_skpd_usulan_trx_forum_skpd_lokasi` FOREIGN KEY (`id_lokasi_forum`) REFERENCES `trx_forum_skpd_lokasi` (`id_lokasi_forum`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_isian_data_dasar`
--
ALTER TABLE `trx_isian_data_dasar`
  ADD CONSTRAINT `trx_isian_data_dasar_ibfk_1` FOREIGN KEY (`id_kolom_tabel_dasar`) REFERENCES `ref_kolom_tabel_dasar` (`id_kolom_tabel_dasar`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_isian_data_dasar_ibfk_2` FOREIGN KEY (`id_kecamatan`) REFERENCES `ref_kecamatan` (`id_kecamatan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrencam`
--
ALTER TABLE `trx_musrencam`
  ADD CONSTRAINT `trx_musrencam_ibfk_1` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_ranwal_kegiatan` (`id_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrencam_lokasi`
--
ALTER TABLE `trx_musrencam_lokasi`
  ADD CONSTRAINT `trx_musrencam_lokasi_ibfk_1` FOREIGN KEY (`id_musrencam`) REFERENCES `trx_musrencam` (`id_musrencam`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrendes`
--
ALTER TABLE `trx_musrendes`
  ADD CONSTRAINT `fk_trx_musrendes` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_ranwal_kegiatan` (`id_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrendes_lokasi`
--
ALTER TABLE `trx_musrendes_lokasi`
  ADD CONSTRAINT `fk_trx_musrendes_lokasi` FOREIGN KEY (`id_musrendes`) REFERENCES `trx_musrendes` (`id_musrendes`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrendes_rw`
--
ALTER TABLE `trx_musrendes_rw`
  ADD CONSTRAINT `trx_musrendes_rw_ibfk_1` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_ranwal_kegiatan` (`id_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrenkab_aktivitas_pd`
--
ALTER TABLE `trx_musrenkab_aktivitas_pd`
  ADD CONSTRAINT `trx_musrenkab_aktivitas_pd_ibfk_1` FOREIGN KEY (`id_pelaksana_pd`) REFERENCES `trx_musrenkab_pelaksana_pd` (`id_pelaksana_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrenkab_belanja_pd`
--
ALTER TABLE `trx_musrenkab_belanja_pd`
  ADD CONSTRAINT `trx_musrenkab_belanja_pd_ibfk_1` FOREIGN KEY (`id_aktivitas_pd`) REFERENCES `trx_musrenkab_aktivitas_pd` (`id_aktivitas_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrenkab_indikator`
--
ALTER TABLE `trx_musrenkab_indikator`
  ADD CONSTRAINT `trx_musrenkab_indikator_ibfk_1` FOREIGN KEY (`id_musrenkab`) REFERENCES `trx_musrenkab` (`id_musrenkab`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrenkab_kegiatan_pd`
--
ALTER TABLE `trx_musrenkab_kegiatan_pd`
  ADD CONSTRAINT `trx_musrenkab_kegiatan_pd_ibfk_1` FOREIGN KEY (`id_program_pd`) REFERENCES `trx_musrenkab_program_pd` (`id_program_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrenkab_keg_indikator_pd`
--
ALTER TABLE `trx_musrenkab_keg_indikator_pd`
  ADD CONSTRAINT `trx_musrenkab_keg_indikator_pd_ibfk_1` FOREIGN KEY (`id_kegiatan_pd`) REFERENCES `trx_musrenkab_kegiatan_pd` (`id_kegiatan_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrenkab_lokasi_pd`
--
ALTER TABLE `trx_musrenkab_lokasi_pd`
  ADD CONSTRAINT `trx_musrenkab_lokasi_pd_ibfk_1` FOREIGN KEY (`id_aktivitas_pd`) REFERENCES `trx_musrenkab_aktivitas_pd` (`id_aktivitas_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrenkab_pelaksana`
--
ALTER TABLE `trx_musrenkab_pelaksana`
  ADD CONSTRAINT `trx_musrenkab_pelaksana_ibfk_1` FOREIGN KEY (`id_urusan_rkpd`) REFERENCES `trx_musrenkab_urusan` (`id_urusan_rkpd`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_musrenkab_pelaksana_ibfk_2` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrenkab_pelaksana_pd`
--
ALTER TABLE `trx_musrenkab_pelaksana_pd`
  ADD CONSTRAINT `trx_musrenkab_pelaksana_pd_ibfk_1` FOREIGN KEY (`id_kegiatan_pd`) REFERENCES `trx_musrenkab_kegiatan_pd` (`id_kegiatan_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrenkab_program_pd`
--
ALTER TABLE `trx_musrenkab_program_pd`
  ADD CONSTRAINT `trx_musrenkab_program_pd_ibfk_1` FOREIGN KEY (`id_pelaksana_rkpd`) REFERENCES `trx_musrenkab_pelaksana` (`id_pelaksana_rkpd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrenkab_prog_indikator_pd`
--
ALTER TABLE `trx_musrenkab_prog_indikator_pd`
  ADD CONSTRAINT `trx_musrenkab_prog_indikator_pd_ibfk_1` FOREIGN KEY (`id_program_pd`) REFERENCES `trx_musrenkab_program_pd` (`id_program_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_musrenkab_urusan`
--
ALTER TABLE `trx_musrenkab_urusan`
  ADD CONSTRAINT `trx_musrenkab_urusan_ibfk_1` FOREIGN KEY (`id_bidang`) REFERENCES `ref_bidang` (`id_bidang`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_musrenkab_urusan_ibfk_2` FOREIGN KEY (`id_musrenkab`) REFERENCES `trx_musrenkab` (`id_musrenkab`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_pokir_lokasi`
--
ALTER TABLE `trx_pokir_lokasi`
  ADD CONSTRAINT `trx_pokir_lokasi_ibfk_1` FOREIGN KEY (`id_pokir_usulan`) REFERENCES `trx_pokir_usulan` (`id_pokir_usulan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_pokir_tl`
--
ALTER TABLE `trx_pokir_tl`
  ADD CONSTRAINT `trx_pokir_tl_ibfk_1` FOREIGN KEY (`id_pokir_usulan`) REFERENCES `trx_pokir_usulan` (`id_pokir_usulan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_pokir_tl_unit`
--
ALTER TABLE `trx_pokir_tl_unit`
  ADD CONSTRAINT `trx_pokir_tl_unit_ibfk_1` FOREIGN KEY (`id_pokir_tl`) REFERENCES `trx_pokir_tl` (`id_pokir_tl`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_pokir_usulan`
--
ALTER TABLE `trx_pokir_usulan`
  ADD CONSTRAINT `trx_pokir_usulan_ibfk_1` FOREIGN KEY (`id_pokir`) REFERENCES `trx_pokir` (`id_pokir`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_pokir_usulan_ibfk_2` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_aktivitas`
--
ALTER TABLE `trx_renja_aktivitas`
  ADD CONSTRAINT `trx_renja_aktivitas_ibfk_1` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_pelaksana` (`id_pelaksana_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_belanja`
--
ALTER TABLE `trx_renja_belanja`
  ADD CONSTRAINT `trx_renja_belanja_ibfk_1` FOREIGN KEY (`id_lokasi_renja`) REFERENCES `trx_renja_aktivitas` (`id_aktivitas_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_kebijakan`
--
ALTER TABLE `trx_renja_kebijakan`
  ADD CONSTRAINT `trx_renja_kebijakan_ibfk_1` FOREIGN KEY (`id_sasaran_renstra`) REFERENCES `trx_renja_rancangan` (`id_sasaran_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_kegiatan`
--
ALTER TABLE `trx_renja_kegiatan`
  ADD CONSTRAINT `trx_renja_kegiatan_ibfk_2` FOREIGN KEY (`id_rkpd_renstra`) REFERENCES `trx_rkpd_renstra` (`id_rkpd_renstra`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_renja_kegiatan_ibfk_3` FOREIGN KEY (`id_rkpd_ranwal`) REFERENCES `trx_rkpd_ranwal` (`id_rkpd_ranwal`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_renja_kegiatan_ibfk_4` FOREIGN KEY (`id_renja_program`) REFERENCES `trx_renja_program` (`id_renja_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_kegiatan_indikator`
--
ALTER TABLE `trx_renja_kegiatan_indikator`
  ADD CONSTRAINT `trx_renja_kegiatan_indikator_ibfk_1` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_kegiatan` (`id_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_lokasi`
--
ALTER TABLE `trx_renja_lokasi`
  ADD CONSTRAINT `trx_renja_lokasi_ibfk_1` FOREIGN KEY (`id_pelaksana_renja`) REFERENCES `trx_renja_aktivitas` (`id_aktivitas_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_pelaksana`
--
ALTER TABLE `trx_renja_pelaksana`
  ADD CONSTRAINT `trx_renja_pelaksana_ibfk_1` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_kegiatan` (`id_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_program_indikator`
--
ALTER TABLE `trx_renja_program_indikator`
  ADD CONSTRAINT `trx_renja_program_indikator_ibfk_1` FOREIGN KEY (`id_renja_program`) REFERENCES `trx_renja_program` (`id_renja_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_rancangan`
--
ALTER TABLE `trx_renja_rancangan`
  ADD CONSTRAINT `FK_trx_renja_rancangan_trx_renja_rancangan_program` FOREIGN KEY (`id_renja_program`) REFERENCES `trx_renja_rancangan_program` (`id_renja_program`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_trx_rancangan_renja` FOREIGN KEY (`id_rkpd_renstra`) REFERENCES `trx_rkpd_renstra` (`id_rkpd_renstra`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_trx_rancangan_renja_1` FOREIGN KEY (`id_rkpd_ranwal`) REFERENCES `trx_rkpd_ranwal` (`id_rkpd_ranwal`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_rancangan_aktivitas`
--
ALTER TABLE `trx_renja_rancangan_aktivitas`
  ADD CONSTRAINT `trx_renja_rancangan_aktivitas_ibfk_1` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_rancangan_pelaksana` (`id_pelaksana_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_rancangan_belanja`
--
ALTER TABLE `trx_renja_rancangan_belanja`
  ADD CONSTRAINT `FK_trx_renja_rancangan_belanja_trx_renja_rancangan_lokasi` FOREIGN KEY (`id_lokasi_renja`) REFERENCES `trx_renja_rancangan_aktivitas` (`id_aktivitas_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_rancangan_indikator`
--
ALTER TABLE `trx_renja_rancangan_indikator`
  ADD CONSTRAINT `FK_trx_renja_rancangan_indikator_trx_renja_rancangan` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_rancangan` (`id_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_rancangan_kebijakan`
--
ALTER TABLE `trx_renja_rancangan_kebijakan`
  ADD CONSTRAINT `fk_trx_renja_rancangan_kebijakan` FOREIGN KEY (`id_sasaran_renstra`) REFERENCES `trx_renja_rancangan` (`id_sasaran_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_rancangan_lokasi`
--
ALTER TABLE `trx_renja_rancangan_lokasi`
  ADD CONSTRAINT `fk_rancangan_renja_lokasi` FOREIGN KEY (`id_pelaksana_renja`) REFERENCES `trx_renja_rancangan_aktivitas` (`id_aktivitas_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_rancangan_pelaksana`
--
ALTER TABLE `trx_renja_rancangan_pelaksana`
  ADD CONSTRAINT `fk_trx_rancangan_renja_pelaksana` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_rancangan` (`id_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_rancangan_program_indikator`
--
ALTER TABLE `trx_renja_rancangan_program_indikator`
  ADD CONSTRAINT `trx_renja_rancangan_program_indikator_ibfk_1` FOREIGN KEY (`id_renja_program`) REFERENCES `trx_renja_rancangan_program` (`id_renja_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_rancangan_ref_pokir`
--
ALTER TABLE `trx_renja_rancangan_ref_pokir`
  ADD CONSTRAINT `trx_renja_rancangan_ref_pokir_ibfk_1` FOREIGN KEY (`id_aktivitas_renja`) REFERENCES `trx_renja_rancangan_aktivitas` (`id_aktivitas_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_ranwal_aktivitas`
--
ALTER TABLE `trx_renja_ranwal_aktivitas`
  ADD CONSTRAINT `trx_renja_ranwal_aktivitas_ibfk_1` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_ranwal_pelaksana` (`id_pelaksana_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_ranwal_kegiatan`
--
ALTER TABLE `trx_renja_ranwal_kegiatan`
  ADD CONSTRAINT `trx_renja_ranwal_kegiatan_ibfk_1` FOREIGN KEY (`id_renja_program`) REFERENCES `trx_renja_ranwal_program` (`id_renja_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_ranwal_kegiatan_indikator`
--
ALTER TABLE `trx_renja_ranwal_kegiatan_indikator`
  ADD CONSTRAINT `trx_renja_ranwal_kegiatan_indikator_ibfk_1` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_ranwal_kegiatan` (`id_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_ranwal_pelaksana`
--
ALTER TABLE `trx_renja_ranwal_pelaksana`
  ADD CONSTRAINT `trx_renja_ranwal_pelaksana_ibfk_1` FOREIGN KEY (`id_renja`) REFERENCES `trx_renja_ranwal_kegiatan` (`id_renja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_ranwal_program`
--
ALTER TABLE `trx_renja_ranwal_program`
  ADD CONSTRAINT `trx_renja_ranwal_program_ibfk_1` FOREIGN KEY (`id_renja_ranwal`) REFERENCES `trx_renja_ranwal_program_rkpd` (`id_renja_ranwal`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renja_ranwal_program_indikator`
--
ALTER TABLE `trx_renja_ranwal_program_indikator`
  ADD CONSTRAINT `trx_renja_ranwal_program_indikator_ibfk_1` FOREIGN KEY (`id_renja_program`) REFERENCES `trx_renja_ranwal_program` (`id_renja_program`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_dokumen`
--
ALTER TABLE `trx_renstra_dokumen`
  ADD CONSTRAINT `fk_trx_renstra_dokumen` FOREIGN KEY (`id_rpjmd`) REFERENCES `trx_rpjmd_dokumen` (`id_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_trx_renstra_dokumen_1` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_kebijakan`
--
ALTER TABLE `trx_renstra_kebijakan`
  ADD CONSTRAINT `fk_trx_renstra_kebijakan` FOREIGN KEY (`id_sasaran_renstra`) REFERENCES `trx_renstra_sasaran` (`id_sasaran_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_kegiatan`
--
ALTER TABLE `trx_renstra_kegiatan`
  ADD CONSTRAINT `fk_trx_renstra_kegiatan` FOREIGN KEY (`id_program_renstra`) REFERENCES `trx_renstra_program` (`id_program_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_kegiatan_indikator`
--
ALTER TABLE `trx_renstra_kegiatan_indikator`
  ADD CONSTRAINT `fk_trx_renstra_kegiatan_indikator` FOREIGN KEY (`id_kegiatan_renstra`) REFERENCES `trx_renstra_kegiatan` (`id_kegiatan_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_kegiatan_pelaksana`
--
ALTER TABLE `trx_renstra_kegiatan_pelaksana`
  ADD CONSTRAINT `fk_trx_renstra_kegiatan_pelaksana` FOREIGN KEY (`id_kegiatan_renstra`) REFERENCES `trx_renstra_kegiatan` (`id_kegiatan_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_misi`
--
ALTER TABLE `trx_renstra_misi`
  ADD CONSTRAINT `fk_trx_renstra_misi` FOREIGN KEY (`id_visi_renstra`) REFERENCES `trx_renstra_visi` (`id_visi_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_program`
--
ALTER TABLE `trx_renstra_program`
  ADD CONSTRAINT `fk_trx_renstra_program` FOREIGN KEY (`id_sasaran_renstra`) REFERENCES `trx_renstra_sasaran` (`id_sasaran_renstra`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_trx_renstra_program_1` FOREIGN KEY (`id_program_rpjmd`) REFERENCES `trx_rpjmd_program` (`id_program_rpjmd`) ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_program_indikator`
--
ALTER TABLE `trx_renstra_program_indikator`
  ADD CONSTRAINT `fk_trx_renstra_program_indikator` FOREIGN KEY (`id_program_renstra`) REFERENCES `trx_renstra_program` (`id_program_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_sasaran`
--
ALTER TABLE `trx_renstra_sasaran`
  ADD CONSTRAINT `fk_trx_renstra_sasaran` FOREIGN KEY (`id_tujuan_renstra`) REFERENCES `trx_renstra_tujuan` (`id_tujuan_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_sasaran_indikator`
--
ALTER TABLE `trx_renstra_sasaran_indikator`
  ADD CONSTRAINT `fk_trx_renstra_sasaran_indikator` FOREIGN KEY (`id_sasaran_renstra`) REFERENCES `trx_renstra_sasaran` (`id_sasaran_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_strategi`
--
ALTER TABLE `trx_renstra_strategi`
  ADD CONSTRAINT `fk_trx_renstra_strategi` FOREIGN KEY (`id_sasaran_renstra`) REFERENCES `trx_renstra_sasaran` (`id_sasaran_renstra`);

--
-- Constraints for table `trx_renstra_tujuan`
--
ALTER TABLE `trx_renstra_tujuan`
  ADD CONSTRAINT `fk_trx_renstra_tujuan` FOREIGN KEY (`id_misi_renstra`) REFERENCES `trx_renstra_misi` (`id_misi_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_tujuan_indikator`
--
ALTER TABLE `trx_renstra_tujuan_indikator`
  ADD CONSTRAINT `trx_renstra_tujuan_indikator_ibfk_1` FOREIGN KEY (`id_tujuan_renstra`) REFERENCES `trx_renstra_tujuan` (`id_tujuan_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_renstra_visi`
--
ALTER TABLE `trx_renstra_visi`
  ADD CONSTRAINT `FK_trx_renstra_visi_ref_unit` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`) ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_final_aktivitas_pd`
--
ALTER TABLE `trx_rkpd_final_aktivitas_pd`
  ADD CONSTRAINT `trx_rkpd_final_aktivitas_pd_ibfk_1` FOREIGN KEY (`id_pelaksana_pd`) REFERENCES `trx_rkpd_final_pelaksana_pd` (`id_pelaksana_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_final_belanja_pd`
--
ALTER TABLE `trx_rkpd_final_belanja_pd`
  ADD CONSTRAINT `trx_rkpd_final_belanja_pd_ibfk_1` FOREIGN KEY (`id_aktivitas_pd`) REFERENCES `trx_rkpd_final_aktivitas_pd` (`id_aktivitas_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_final_indikator`
--
ALTER TABLE `trx_rkpd_final_indikator`
  ADD CONSTRAINT `trx_rkpd_final_indikator_ibfk_1` FOREIGN KEY (`id_rkpd_rancangan`) REFERENCES `trx_rkpd_final` (`id_rkpd_rancangan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_final_kegiatan_pd`
--
ALTER TABLE `trx_rkpd_final_kegiatan_pd`
  ADD CONSTRAINT `trx_rkpd_final_kegiatan_pd_ibfk_1` FOREIGN KEY (`id_program_pd`) REFERENCES `trx_rkpd_final_program_pd` (`id_program_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_final_keg_indikator_pd`
--
ALTER TABLE `trx_rkpd_final_keg_indikator_pd`
  ADD CONSTRAINT `trx_rkpd_final_keg_indikator_pd_ibfk_1` FOREIGN KEY (`id_kegiatan_pd`) REFERENCES `trx_rkpd_final_kegiatan_pd` (`id_kegiatan_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_final_lokasi_pd`
--
ALTER TABLE `trx_rkpd_final_lokasi_pd`
  ADD CONSTRAINT `trx_rkpd_final_lokasi_pd_ibfk_1` FOREIGN KEY (`id_aktivitas_pd`) REFERENCES `trx_rkpd_final_aktivitas_pd` (`id_aktivitas_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_final_pelaksana`
--
ALTER TABLE `trx_rkpd_final_pelaksana`
  ADD CONSTRAINT `trx_rkpd_final_pelaksana_ibfk_1` FOREIGN KEY (`id_urusan_rkpd`) REFERENCES `trx_rkpd_final_urusan` (`id_urusan_rkpd`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_rkpd_final_pelaksana_ibfk_2` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_final_pelaksana_pd`
--
ALTER TABLE `trx_rkpd_final_pelaksana_pd`
  ADD CONSTRAINT `trx_rkpd_final_pelaksana_pd_ibfk_1` FOREIGN KEY (`id_kegiatan_pd`) REFERENCES `trx_rkpd_final_kegiatan_pd` (`id_kegiatan_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_final_program_pd`
--
ALTER TABLE `trx_rkpd_final_program_pd`
  ADD CONSTRAINT `trx_rkpd_final_program_pd_ibfk_1` FOREIGN KEY (`id_rkpd_rancangan`) REFERENCES `trx_rkpd_final_pelaksana` (`id_pelaksana_rkpd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_final_prog_indikator_pd`
--
ALTER TABLE `trx_rkpd_final_prog_indikator_pd`
  ADD CONSTRAINT `trx_rkpd_final_prog_indikator_pd_ibfk_1` FOREIGN KEY (`id_program_pd`) REFERENCES `trx_rkpd_final_program_pd` (`id_program_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_final_urusan`
--
ALTER TABLE `trx_rkpd_final_urusan`
  ADD CONSTRAINT `trx_rkpd_final_urusan_ibfk_1` FOREIGN KEY (`id_bidang`) REFERENCES `ref_bidang` (`id_bidang`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_rkpd_final_urusan_ibfk_2` FOREIGN KEY (`id_rkpd_rancangan`) REFERENCES `trx_rkpd_final` (`id_rkpd_rancangan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rancangan_aktivitas_pd`
--
ALTER TABLE `trx_rkpd_rancangan_aktivitas_pd`
  ADD CONSTRAINT `trx_rkpd_rancangan_aktivitas_pd_ibfk_1` FOREIGN KEY (`id_pelaksana_pd`) REFERENCES `trx_rkpd_rancangan_pelaksana_pd` (`id_pelaksana_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rancangan_belanja_pd`
--
ALTER TABLE `trx_rkpd_rancangan_belanja_pd`
  ADD CONSTRAINT `trx_rkpd_rancangan_belanja_pd_ibfk_1` FOREIGN KEY (`id_aktivitas_pd`) REFERENCES `trx_rkpd_rancangan_aktivitas_pd` (`id_aktivitas_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rancangan_indikator`
--
ALTER TABLE `trx_rkpd_rancangan_indikator`
  ADD CONSTRAINT `trx_rkpd_rancangan_indikator_ibfk_1` FOREIGN KEY (`id_rkpd_rancangan`) REFERENCES `trx_rkpd_rancangan` (`id_rkpd_rancangan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rancangan_kegiatan_pd`
--
ALTER TABLE `trx_rkpd_rancangan_kegiatan_pd`
  ADD CONSTRAINT `FK_trx_rkpd_rancangan_kegiatan_pd_trx_rkpd_rancangan_program_pd` FOREIGN KEY (`id_program_pd`) REFERENCES `trx_rkpd_rancangan_program_pd` (`id_program_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rancangan_keg_indikator_pd`
--
ALTER TABLE `trx_rkpd_rancangan_keg_indikator_pd`
  ADD CONSTRAINT `trx_rkpd_rancangan_keg_indikator_pd_ibfk_1` FOREIGN KEY (`id_kegiatan_pd`) REFERENCES `trx_rkpd_rancangan_kegiatan_pd` (`id_kegiatan_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rancangan_lokasi_pd`
--
ALTER TABLE `trx_rkpd_rancangan_lokasi_pd`
  ADD CONSTRAINT `trx_rkpd_rancangan_lokasi_pd_ibfk_1` FOREIGN KEY (`id_aktivitas_pd`) REFERENCES `trx_rkpd_rancangan_aktivitas_pd` (`id_aktivitas_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rancangan_pelaksana`
--
ALTER TABLE `trx_rkpd_rancangan_pelaksana`
  ADD CONSTRAINT `trx_rkpd_rancangan_pelaksana_ibfk_1` FOREIGN KEY (`id_urusan_rkpd`) REFERENCES `trx_rkpd_rancangan_urusan` (`id_urusan_rkpd`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_rkpd_rancangan_pelaksana_ibfk_2` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rancangan_pelaksana_pd`
--
ALTER TABLE `trx_rkpd_rancangan_pelaksana_pd`
  ADD CONSTRAINT `trx_rkpd_rancangan_pelaksana_pd_ibfk_1` FOREIGN KEY (`id_kegiatan_pd`) REFERENCES `trx_rkpd_rancangan_kegiatan_pd` (`id_kegiatan_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rancangan_program_pd`
--
ALTER TABLE `trx_rkpd_rancangan_program_pd`
  ADD CONSTRAINT `test` FOREIGN KEY (`id_rkpd_rancangan`) REFERENCES `trx_rkpd_rancangan_pelaksana` (`id_pelaksana_rkpd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rancangan_prog_indikator_pd`
--
ALTER TABLE `trx_rkpd_rancangan_prog_indikator_pd`
  ADD CONSTRAINT `trx_rkpd_rancangan_prog_indikator_pd_ibfk_1` FOREIGN KEY (`id_program_pd`) REFERENCES `trx_rkpd_rancangan_program_pd` (`id_program_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rancangan_urusan`
--
ALTER TABLE `trx_rkpd_rancangan_urusan`
  ADD CONSTRAINT `trx_rkpd_rancangan_urusan_ibfk_2` FOREIGN KEY (`id_bidang`) REFERENCES `ref_bidang` (`id_bidang`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_rkpd_rancangan_urusan_ibfk_3` FOREIGN KEY (`id_rkpd_rancangan`) REFERENCES `trx_rkpd_rancangan` (`id_rkpd_rancangan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranhir_aktivitas_pd`
--
ALTER TABLE `trx_rkpd_ranhir_aktivitas_pd`
  ADD CONSTRAINT `trx_rkpd_ranhir_aktivitas_pd_ibfk_1` FOREIGN KEY (`id_pelaksana_pd`) REFERENCES `trx_rkpd_ranhir_pelaksana_pd` (`id_pelaksana_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranhir_belanja_pd`
--
ALTER TABLE `trx_rkpd_ranhir_belanja_pd`
  ADD CONSTRAINT `trx_rkpd_ranhir_belanja_pd_ibfk_1` FOREIGN KEY (`id_aktivitas_pd`) REFERENCES `trx_rkpd_ranhir_aktivitas_pd` (`id_aktivitas_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranhir_indikator`
--
ALTER TABLE `trx_rkpd_ranhir_indikator`
  ADD CONSTRAINT `trx_rkpd_ranhir_indikator_ibfk_1` FOREIGN KEY (`id_rkpd_rancangan`) REFERENCES `trx_rkpd_ranhir` (`id_rkpd_rancangan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranhir_kegiatan_pd`
--
ALTER TABLE `trx_rkpd_ranhir_kegiatan_pd`
  ADD CONSTRAINT `trx_rkpd_ranhir_kegiatan_pd_ibfk_1` FOREIGN KEY (`id_program_pd`) REFERENCES `trx_rkpd_ranhir_program_pd` (`id_program_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranhir_keg_indikator_pd`
--
ALTER TABLE `trx_rkpd_ranhir_keg_indikator_pd`
  ADD CONSTRAINT `trx_rkpd_ranhir_keg_indikator_pd_ibfk_1` FOREIGN KEY (`id_kegiatan_pd`) REFERENCES `trx_rkpd_ranhir_kegiatan_pd` (`id_kegiatan_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranhir_lokasi_pd`
--
ALTER TABLE `trx_rkpd_ranhir_lokasi_pd`
  ADD CONSTRAINT `trx_rkpd_ranhir_lokasi_pd_ibfk_1` FOREIGN KEY (`id_aktivitas_pd`) REFERENCES `trx_rkpd_ranhir_aktivitas_pd` (`id_aktivitas_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranhir_pelaksana`
--
ALTER TABLE `trx_rkpd_ranhir_pelaksana`
  ADD CONSTRAINT `trx_rkpd_ranhir_pelaksana_ibfk_1` FOREIGN KEY (`id_urusan_rkpd`) REFERENCES `trx_rkpd_ranhir_urusan` (`id_urusan_rkpd`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_rkpd_ranhir_pelaksana_ibfk_2` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranhir_pelaksana_pd`
--
ALTER TABLE `trx_rkpd_ranhir_pelaksana_pd`
  ADD CONSTRAINT `trx_rkpd_ranhir_pelaksana_pd_ibfk_1` FOREIGN KEY (`id_kegiatan_pd`) REFERENCES `trx_rkpd_ranhir_kegiatan_pd` (`id_kegiatan_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranhir_program_pd`
--
ALTER TABLE `trx_rkpd_ranhir_program_pd`
  ADD CONSTRAINT `trx_rkpd_ranhir_program_pd_ibfk_1` FOREIGN KEY (`id_rkpd_rancangan`) REFERENCES `trx_rkpd_ranhir_pelaksana` (`id_pelaksana_rkpd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranhir_prog_indikator_pd`
--
ALTER TABLE `trx_rkpd_ranhir_prog_indikator_pd`
  ADD CONSTRAINT `trx_rkpd_ranhir_prog_indikator_pd_ibfk_1` FOREIGN KEY (`id_program_pd`) REFERENCES `trx_rkpd_ranhir_program_pd` (`id_program_pd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranhir_urusan`
--
ALTER TABLE `trx_rkpd_ranhir_urusan`
  ADD CONSTRAINT `trx_rkpd_ranhir_urusan_ibfk_1` FOREIGN KEY (`id_bidang`) REFERENCES `ref_bidang` (`id_bidang`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_rkpd_ranhir_urusan_ibfk_2` FOREIGN KEY (`id_rkpd_rancangan`) REFERENCES `trx_rkpd_ranhir` (`id_rkpd_rancangan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranwal_indikator`
--
ALTER TABLE `trx_rkpd_ranwal_indikator`
  ADD CONSTRAINT `fk_trx_rkpd_ranwal_indikator` FOREIGN KEY (`id_rkpd_ranwal`) REFERENCES `trx_rkpd_ranwal` (`id_rkpd_ranwal`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranwal_kebijakan`
--
ALTER TABLE `trx_rkpd_ranwal_kebijakan`
  ADD CONSTRAINT `fk_trx_rkpd_ranwal_kebijakan` FOREIGN KEY (`id_rkpd_ranwal`) REFERENCES `trx_rkpd_ranwal` (`id_rkpd_ranwal`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranwal_pelaksana`
--
ALTER TABLE `trx_rkpd_ranwal_pelaksana`
  ADD CONSTRAINT `FK_trx_rkpd_ranwal_pelaksana_trx_rkpd_ranwal_urusan` FOREIGN KEY (`id_urusan_rkpd`) REFERENCES `trx_rkpd_ranwal_urusan` (`id_urusan_rkpd`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_trx_rkpd_ranwal_pelaksana_2` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`) ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_ranwal_urusan`
--
ALTER TABLE `trx_rkpd_ranwal_urusan`
  ADD CONSTRAINT `trx_rkpd_ranwal_urusan_ibfk_1` FOREIGN KEY (`id_rkpd_ranwal`) REFERENCES `trx_rkpd_ranwal` (`id_rkpd_ranwal`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_rkpd_ranwal_urusan_ibfk_2` FOREIGN KEY (`id_bidang`) REFERENCES `ref_bidang` (`id_bidang`) ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_renstra`
--
ALTER TABLE `trx_rkpd_renstra`
  ADD CONSTRAINT `fk_trx_rkpd_renstra` FOREIGN KEY (`id_rkpd_rpjmd`) REFERENCES `trx_rkpd_rpjmd_ranwal` (`id_rkpd_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_renstra_indikator`
--
ALTER TABLE `trx_rkpd_renstra_indikator`
  ADD CONSTRAINT `trx_rkpd_renstra_indikator_ibfk_1` FOREIGN KEY (`id_rkpd_renstra`) REFERENCES `trx_rkpd_renstra` (`id_rkpd_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_renstra_pelaksana`
--
ALTER TABLE `trx_rkpd_renstra_pelaksana`
  ADD CONSTRAINT `fk_trx_rkpd_renstra_pelaksana` FOREIGN KEY (`id_rkpd_renstra`) REFERENCES `trx_rkpd_renstra` (`id_rkpd_renstra`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rpjmd_kebijakan`
--
ALTER TABLE `trx_rkpd_rpjmd_kebijakan`
  ADD CONSTRAINT `fk_trx_rkpd_rpjmd_kebijakan` FOREIGN KEY (`id_rkpd_rpjmd`) REFERENCES `trx_rkpd_rpjmd_ranwal` (`id_rkpd_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rpjmd_program_indikator`
--
ALTER TABLE `trx_rkpd_rpjmd_program_indikator`
  ADD CONSTRAINT `fk_rkpd_rpjmd_indikator` FOREIGN KEY (`id_rkpd_rpjmd`) REFERENCES `trx_rkpd_rpjmd_ranwal` (`id_rkpd_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rpjmd_program_pelaksana`
--
ALTER TABLE `trx_rkpd_rpjmd_program_pelaksana`
  ADD CONSTRAINT `fk_rkpd_rpjmd_pelaksana` FOREIGN KEY (`id_rkpd_rpjmd`) REFERENCES `trx_rkpd_rpjmd_ranwal` (`id_rkpd_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rkpd_rpjmd_ranwal`
--
ALTER TABLE `trx_rkpd_rpjmd_ranwal`
  ADD CONSTRAINT `FK_trx_rkpd_rpjmd_ranwal_trx_rpjmd_visi` FOREIGN KEY (`id_visi_rpjmd`) REFERENCES `trx_rpjmd_visi` (`id_visi_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_kebijakan`
--
ALTER TABLE `trx_rpjmd_kebijakan`
  ADD CONSTRAINT `fk_trx_rpjmd_kebijakan` FOREIGN KEY (`id_sasaran_rpjmd`) REFERENCES `trx_rpjmd_sasaran` (`id_sasaran_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_misi`
--
ALTER TABLE `trx_rpjmd_misi`
  ADD CONSTRAINT `fk_trx_rpjmd_misi` FOREIGN KEY (`id_visi_rpjmd`) REFERENCES `trx_rpjmd_visi` (`id_visi_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_program`
--
ALTER TABLE `trx_rpjmd_program`
  ADD CONSTRAINT `fk_trx_rpjmd_program` FOREIGN KEY (`id_sasaran_rpjmd`) REFERENCES `trx_rpjmd_sasaran` (`id_sasaran_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_program_indikator`
--
ALTER TABLE `trx_rpjmd_program_indikator`
  ADD CONSTRAINT `fk_trx_rpjmd_program_indikator` FOREIGN KEY (`id_program_rpjmd`) REFERENCES `trx_rpjmd_program` (`id_program_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_program_pelaksana`
--
ALTER TABLE `trx_rpjmd_program_pelaksana`
  ADD CONSTRAINT `fk_trx_rpjmd_program_pelaksana` FOREIGN KEY (`id_urbid_rpjmd`) REFERENCES `trx_rpjmd_program_urusan` (`id_urbid_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_program_urusan`
--
ALTER TABLE `trx_rpjmd_program_urusan`
  ADD CONSTRAINT `fk_trx_rpjmd_program_urusan` FOREIGN KEY (`id_program_rpjmd`) REFERENCES `trx_rpjmd_program` (`id_program_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_ranwal_kebijakan`
--
ALTER TABLE `trx_rpjmd_ranwal_kebijakan`
  ADD CONSTRAINT `trx_rpjmd_ranwal_kebijakan_ibfk_1` FOREIGN KEY (`id_strategi_rpjmd`) REFERENCES `trx_rpjmd_ranwal_strategi` (`id_strategi_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_ranwal_misi`
--
ALTER TABLE `trx_rpjmd_ranwal_misi`
  ADD CONSTRAINT `trx_rpjmd_ranwal_misi_ibfk_1` FOREIGN KEY (`id_visi_rpjmd`) REFERENCES `trx_rpjmd_ranwal_visi` (`id_visi_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_ranwal_program`
--
ALTER TABLE `trx_rpjmd_ranwal_program`
  ADD CONSTRAINT `trx_rpjmd_ranwal_program_ibfk_1` FOREIGN KEY (`id_sasaran_rpjmd`) REFERENCES `trx_rpjmd_ranwal_sasaran` (`id_sasaran_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_ranwal_program_indikator`
--
ALTER TABLE `trx_rpjmd_ranwal_program_indikator`
  ADD CONSTRAINT `trx_rpjmd_ranwal_program_indikator_ibfk_1` FOREIGN KEY (`id_program_rpjmd`) REFERENCES `trx_rpjmd_ranwal_program` (`id_program_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_ranwal_program_pelaksana`
--
ALTER TABLE `trx_rpjmd_ranwal_program_pelaksana`
  ADD CONSTRAINT `trx_rpjmd_ranwal_program_pelaksana_ibfk_1` FOREIGN KEY (`id_urbid_rpjmd`) REFERENCES `trx_rpjmd_ranwal_program_urusan` (`id_urbid_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_ranwal_program_urusan`
--
ALTER TABLE `trx_rpjmd_ranwal_program_urusan`
  ADD CONSTRAINT `trx_rpjmd_ranwal_program_urusan_ibfk_1` FOREIGN KEY (`id_program_rpjmd`) REFERENCES `trx_rpjmd_ranwal_program` (`id_program_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_ranwal_sasaran`
--
ALTER TABLE `trx_rpjmd_ranwal_sasaran`
  ADD CONSTRAINT `trx_rpjmd_ranwal_sasaran_ibfk_1` FOREIGN KEY (`id_tujuan_rpjmd`) REFERENCES `trx_rpjmd_ranwal_tujuan` (`id_tujuan_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_ranwal_sasaran_indikator`
--
ALTER TABLE `trx_rpjmd_ranwal_sasaran_indikator`
  ADD CONSTRAINT `trx_rpjmd_ranwal_sasaran_indikator_ibfk_1` FOREIGN KEY (`id_sasaran_rpjmd`) REFERENCES `trx_rpjmd_ranwal_sasaran` (`id_sasaran_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_ranwal_strategi`
--
ALTER TABLE `trx_rpjmd_ranwal_strategi`
  ADD CONSTRAINT `trx_rpjmd_ranwal_strategi_ibfk_1` FOREIGN KEY (`id_sasaran_rpjmd`) REFERENCES `trx_rpjmd_ranwal_sasaran` (`id_sasaran_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_ranwal_tujuan`
--
ALTER TABLE `trx_rpjmd_ranwal_tujuan`
  ADD CONSTRAINT `trx_rpjmd_ranwal_tujuan_ibfk_1` FOREIGN KEY (`id_misi_rpjmd`) REFERENCES `trx_rpjmd_ranwal_misi` (`id_misi_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_ranwal_tujuan_indikator`
--
ALTER TABLE `trx_rpjmd_ranwal_tujuan_indikator`
  ADD CONSTRAINT `trx_rpjmd_ranwal_tujuan_indikator_ibfk_1` FOREIGN KEY (`id_tujuan_rpjmd`) REFERENCES `trx_rpjmd_ranwal_tujuan` (`id_tujuan_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_ranwal_visi`
--
ALTER TABLE `trx_rpjmd_ranwal_visi`
  ADD CONSTRAINT `trx_rpjmd_ranwal_visi_ibfk_1` FOREIGN KEY (`id_rpjmd`) REFERENCES `trx_rpjmd_ranwal_dokumen` (`id_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_sasaran`
--
ALTER TABLE `trx_rpjmd_sasaran`
  ADD CONSTRAINT `FK_trx_rpjmd_sasaran_trx_rpjmd_tujuan` FOREIGN KEY (`id_tujuan_rpjmd`) REFERENCES `trx_rpjmd_tujuan` (`id_tujuan_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_sasaran_indikator`
--
ALTER TABLE `trx_rpjmd_sasaran_indikator`
  ADD CONSTRAINT `fk_trx_rpjmd_sasaran_indikator` FOREIGN KEY (`id_sasaran_rpjmd`) REFERENCES `trx_rpjmd_sasaran` (`id_sasaran_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_strategi`
--
ALTER TABLE `trx_rpjmd_strategi`
  ADD CONSTRAINT `fk_trx_rpjmd_strategi` FOREIGN KEY (`id_sasaran_rpjmd`) REFERENCES `trx_rpjmd_sasaran` (`id_sasaran_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_tujuan`
--
ALTER TABLE `trx_rpjmd_tujuan`
  ADD CONSTRAINT `fk_trx_rpjmd_tujuan` FOREIGN KEY (`id_misi_rpjmd`) REFERENCES `trx_rpjmd_misi` (`id_misi_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_tujuan_indikator`
--
ALTER TABLE `trx_rpjmd_tujuan_indikator`
  ADD CONSTRAINT `trx_rpjmd_tujuan_indikator_ibfk_1` FOREIGN KEY (`id_tujuan_rpjmd`) REFERENCES `trx_rpjmd_tujuan` (`id_tujuan_rpjmd`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_rpjmd_visi`
--
ALTER TABLE `trx_rpjmd_visi`
  ADD CONSTRAINT `fk_trx_rpjmd_visi` FOREIGN KEY (`id_rpjmd`) REFERENCES `trx_rpjmd_dokumen` (`id_rpjmd_old`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_usulan_kab`
--
ALTER TABLE `trx_usulan_kab`
  ADD CONSTRAINT `trx_usulan_kab_ibfk_1` FOREIGN KEY (`id_kab`) REFERENCES `ref_kabupaten` (`id_kab`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_usulan_kab_ibfk_2` FOREIGN KEY (`id_unit`) REFERENCES `ref_unit` (`id_unit`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `trx_usulan_kab_lokasi`
--
ALTER TABLE `trx_usulan_kab_lokasi`
  ADD CONSTRAINT `trx_usulan_kab_lokasi_ibfk_1` FOREIGN KEY (`id_usulan_kab`) REFERENCES `trx_usulan_kab` (`id_usulan_kab`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_usulan_kab_lokasi_ibfk_2` FOREIGN KEY (`id_lokasi`) REFERENCES `ref_lokasi` (`id_lokasi`) ON UPDATE CASCADE;

--
-- Constraints for table `user_app`
--
ALTER TABLE `user_app`
  ADD CONSTRAINT `user_app_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_app_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `ref_group` (`id`);
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
