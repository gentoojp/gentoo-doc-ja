-- MySQL dump 8.22
--
-- Host: localhost    Database: mailsql
-- -------------------------------------------------------
-- Server version	3.23.52-log

--
-- Table structure for table 'alias'
--

DROP TABLE IF EXISTS alias;
CREATE TABLE alias (
  id int(11) NOT NULL auto_increment,
  alias varchar(128) NOT NULL default '',
  destination varchar(128) NOT NULL default '',
  PRIMARY KEY  (id)
) TYPE=MyISAM;

/*!40000 ALTER TABLE alias DISABLE KEYS */;

--
-- Dumping data for table 'alias'
--


LOCK TABLES alias WRITE;
INSERT INTO alias VALUES (1,'root','root@domain.com'),(2,'postmaster','postmaster@domain.com');

/*!40000 ALTER TABLE alias ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table 'relocated'
--

DROP TABLE IF EXISTS relocated;
CREATE TABLE relocated (
  id int(11) NOT NULL auto_increment,
  email varchar(128) NOT NULL default '',
  destination varchar(128) NOT NULL default '',
  PRIMARY KEY  (id)
) TYPE=MyISAM;

/*!40000 ALTER TABLE relocated DISABLE KEYS */;

--
-- Dumping data for table 'relocated'
--


LOCK TABLES relocated WRITE;

/*!40000 ALTER TABLE relocated ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table 'transport'
--

DROP TABLE IF EXISTS transport;
CREATE TABLE transport (
  id int(11) NOT NULL auto_increment,
  domain varchar(128) NOT NULL default '',
  destination varchar(128) NOT NULL default '',
  PRIMARY KEY  (id),
  UNIQUE KEY domain (domain)
) TYPE=MyISAM;

/*!40000 ALTER TABLE transport DISABLE KEYS */;

--
-- Dumping data for table 'transport'
--


LOCK TABLES transport WRITE;
INSERT INTO transport VALUES (1,'domain.com','local:'),(2,'domain2.com','virtual:');

/*!40000 ALTER TABLE transport ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table 'users'
--

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id int(11) NOT NULL auto_increment,
  email varchar(128) NOT NULL default '',
  clear varchar(128) NOT NULL default '',
  name tinytext NOT NULL,
  uid int(11) NOT NULL default '1101',
  gid int(11) NOT NULL default '1101',
  homedir tinytext NOT NULL,
  maildir tinytext NOT NULL,
  quota tinytext NOT NULL,
  postfix enum('n','y') NOT NULL default 'y',
  PRIMARY KEY  (id),
  UNIQUE KEY email (email)
) TYPE=MyISAM;

/*!40000 ALTER TABLE users DISABLE KEYS */;

--
-- Dumping data for table 'users'
--


LOCK TABLES users WRITE;
INSERT INTO users VALUES (1,'first@domain.com','password','first local user',1200,1200,'/home/first','/home/first/.maildir/','','y'),(2,'second@domain2.com','password','second user who lives in a virtual domain',1101,1101,'/home/vmail','/home/vmail/domain2.com/second/.maildir/','','y');

/*!40000 ALTER TABLE users ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table 'virtual'
--

DROP TABLE IF EXISTS virtual;
CREATE TABLE virtual (
  id int(11) NOT NULL auto_increment,
  email varchar(128) NOT NULL default '',
  destination varchar(128) NOT NULL default '',
  PRIMARY KEY  (id)
) TYPE=MyISAM;

/*!40000 ALTER TABLE virtual DISABLE KEYS */;

--
-- Dumping data for table 'virtual'
--


LOCK TABLES virtual WRITE;

/*!40000 ALTER TABLE virtual ENABLE KEYS */;
UNLOCK TABLES;

