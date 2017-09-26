-- MySQL dump 10.13  Distrib 5.7.15, for Linux (x86_64)
--
-- Host: localhost    Database: Leave_Management
-- ------------------------------------------------------
-- Server version	5.7.15-0ubuntu0.16.04.1

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
-- Table structure for table `administrator`
--

DROP TABLE IF EXISTS `administrator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `administrator` (
  `admin_id` varchar(10) NOT NULL,
  `password` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrator`
--

LOCK TABLES `administrator` WRITE;
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
INSERT INTO `administrator` VALUES ('admin1','pqrs1357'),('admin2A','pqrs2468');
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permissi_content_type_id_2f476e4b_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add group',4,'add_group'),(11,'Can change group',4,'change_group'),(12,'Can delete group',4,'delete_group'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$30000$SLeS4w4ZH4Zb$8v7Bl2BQuNXR5fFiYnNfAQHaEjdy5csz8+QTyed7B8Y=','2016-10-21 18:45:00.026611',1,'leave_admin','','','',1,1,'2016-10-19 15:08:11.057900'),(2,'pbkdf2_sha256$30000$azz7a9n563l4$on5Gtl3eopVRgRHFX8lqNzw9oA6b23B8qOIniU3nFsQ=','2016-10-22 10:17:02.307055',0,'f001','','','',0,1,'2016-10-19 18:14:24.488795'),(3,'pbkdf2_sha256$30000$8SvqrafWohdI$8AlHeaa/ZNNyoaVfGbr0Co2Q0DkaQF7iXxcpyc+XZUk=','2016-10-21 15:41:54.841995',0,'f042','','','',0,1,'2016-10-19 18:14:58.980792'),(4,'pbkdf2_sha256$30000$K5wJutpGfJy0$EvV/48H186hZw0/AlmoXqeITOiWnpk8aXsGtP3pWNl0=','2016-10-21 16:41:40.434682',0,'f372','','','',0,1,'2016-10-19 18:15:47.199465'),(5,'pbkdf2_sha256$30000$Pb0J5dgfngmJ$Sw/Ug0yVWBx9EWEmuGj4zqSfWEB994T46HUZZrEVLYg=','2016-10-22 10:17:18.920616',0,'admin1','','','',1,1,'2016-10-21 09:59:42.000000'),(6,'pbkdf2_sha256$30000$GqcwATpUznwY$zQ6B4rhnskCbx0ztkuNPg9dsZbLZs/WD/OYNlafqpgs=','2016-10-22 09:04:08.151336',0,'admin2A','','','',1,1,'2016-10-21 10:00:04.000000'),(7,'pbkdf2_sha256$30000$EhL4E2L75ybu$EqPNrhZD5b4AhDFPRfSY09luSNfqFl09SxHMM/8oQeI=',NULL,0,'f053','','','',0,1,'2016-10-21 18:59:17.363944'),(8,'pbkdf2_sha256$30000$AZqSUBNsEvZ2$WLZ2xcODTXUacnN4WAldwOXfpxinvwkFx/rfXv7y+3o=',NULL,0,'f189','','','',0,1,'2016-10-21 19:26:43.935501'),(9,'pbkdf2_sha256$30000$4Ycrt6zSbzoM$YLwa83htOAWDulXY3AM7vUhOWbz3gB/ER44ddYtM3hk=',NULL,0,'f063','','','',0,1,'2016-10-21 19:28:17.706127'),(10,'pbkdf2_sha256$30000$r1sSY24tgv5N$lupc2cydOxYM6KlJCwyBcivgn3TV2nhxodAFEzPskPM=',NULL,0,'f023','','','',0,1,'2016-10-21 19:30:10.360927'),(11,'pbkdf2_sha256$30000$yQbNeeLB4cGE$+bqPgVe2fDyslpmCVleV97lytfQRfaNwzaM8X3A0bdI=',NULL,0,'f070','','','',0,1,'2016-10-21 19:31:09.793585'),(12,'pbkdf2_sha256$30000$zCd41dD0FqaN$y4kl6xZ8PL+mOD23uhMfMpMAu6sp+JfzCwLczVOUjac=',NULL,0,'f123','','','',0,1,'2016-10-21 19:32:27.933286');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `days_left`
--

DROP TABLE IF EXISTS `days_left`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `days_left` (
  `faculty_id` varchar(10) NOT NULL,
  `leave_type` varchar(30) NOT NULL,
  `no_days_left` int(10) unsigned NOT NULL,
  PRIMARY KEY (`faculty_id`,`leave_type`),
  KEY `leave_type` (`leave_type`),
  CONSTRAINT `days_left_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `faculty_member` (`faculty_id`),
  CONSTRAINT `days_left_ibfk_2` FOREIGN KEY (`leave_type`) REFERENCES `leave_info` (`leave_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `days_left`
--

LOCK TABLES `days_left` WRITE;
/*!40000 ALTER TABLE `days_left` DISABLE KEYS */;
INSERT INTO `days_left` VALUES ('f001','Casual',8),('f001','Duty',30),('f001','Earned',12),('f001','Extraordinary without pay',1095),('f001','Halfpay',20),('f001','Paternity',15),('f001','Restricted',2),('f001','Sabbatical',730),('f001','Special Casual',10),('f001','Study',1500),('f023','Casual',8),('f023','Duty',30),('f023','Earned',12),('f023','Extraordinary without pay',1095),('f023','Halfpay',20),('f023','Paternity',15),('f023','Restricted',2),('f023','Sabbatical',730),('f023','Special Casual',10),('f023','Study',1500),('f042','Casual',8),('f042','Duty',30),('f042','Earned',12),('f042','Extraordinary without pay',1095),('f042','Halfpay',0),('f042','Paternity',15),('f042','Restricted',2),('f042','Sabbatical',730),('f042','Special Casual',10),('f042','Study',1500),('f053','Casual',8),('f053','Duty',30),('f053','Earned',12),('f053','Extraordinary without pay',1095),('f053','Halfpay',20),('f053','Paternity',15),('f053','Restricted',2),('f053','Sabbatical',730),('f053','Special Casual',10),('f053','Study',1500),('f063','Casual',8),('f063','Duty',30),('f063','Earned',12),('f063','Extraordinary without pay',1095),('f063','Halfpay',20),('f063','Paternity',15),('f063','Restricted',2),('f063','Sabbatical',730),('f063','Special Casual',10),('f063','Study',1500),('f070','Casual',8),('f070','Duty',30),('f070','Earned',12),('f070','Extraordinary without pay',1095),('f070','Halfpay',20),('f070','Paternity',15),('f070','Restricted',2),('f070','Sabbatical',730),('f070','Special Casual',10),('f070','Study',1500),('f123','Casual',8),('f123','Duty',30),('f123','Earned',12),('f123','Extraordinary without pay',1095),('f123','Halfpay',20),('f123','Paternity',15),('f123','Restricted',2),('f123','Sabbatical',730),('f123','Special Casual',10),('f123','Study',1500),('f189','Casual',8),('f189','Childcare',730),('f189','Duty',30),('f189','Earned',12),('f189','Extraordinary without pay',1095),('f189','Halfpay',20),('f189','Miscarriage',45),('f189','Restricted',2),('f189','Sabbatical',730),('f189','Special Casual',10),('f189','Study',1500),('f372','Casual',8),('f372','Childcare',730),('f372','Duty',30),('f372','Earned',12),('f372','Extraordinary without pay',1095),('f372','Halfpay',20),('f372','Miscarriage',45),('f372','Restricted',2),('f372','Sabbatical',730),('f372','Special Casual',10),('f372','Study',1500);
/*!40000 ALTER TABLE `days_left` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `dept_id` varchar(10) NOT NULL,
  `dept_name` varchar(20) NOT NULL,
  `faculty` varchar(20) NOT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES ('dbio1','Zoology','Biology'),('dbio2','Botany','Biology'),('diit1','Computer Science','IIT'),('diit2','Electronics','IIT'),('diit3','Electrical','IIT'),('diit4','Mechanical','IIT'),('diit5','Chemical','IIT'),('diit6','Civil','IIT'),('diit7','Ceramic','IIT'),('diit8','MnC','IIT'),('diit9','Physics','IIT'),('dims1','Physio','Medical'),('dims2','Paediatrics','Medical'),('dims3','Radiology','Medical'),('dlaw2','Criminology','Law'),('dlaw3','Pro Bono','Law');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2016-10-19 18:14:24.519850','2','f001',1,'[{\"added\": {}}]',3,1),(2,'2016-10-19 18:14:59.010091','3','f042',1,'[{\"added\": {}}]',3,1),(3,'2016-10-19 18:15:47.229270','4','f372',1,'[{\"added\": {}}]',3,1),(4,'2016-10-19 21:55:25.209339','2','f001',2,'[{\"changed\": {\"fields\": [\"password\"]}}]',3,1),(5,'2016-10-19 21:55:46.116770','3','f042',2,'[{\"changed\": {\"fields\": [\"password\"]}}]',3,1),(6,'2016-10-19 21:56:07.993656','4','f372',2,'[{\"changed\": {\"fields\": [\"password\"]}}]',3,1),(7,'2016-10-21 09:59:42.415112','5','admin1',1,'[{\"added\": {}}]',3,1),(8,'2016-10-21 10:00:04.213592','6','admin2A',1,'[{\"added\": {}}]',3,1),(9,'2016-10-21 10:01:31.962919','5','admin1',2,'[{\"changed\": {\"fields\": [\"is_staff\"]}}]',3,1),(10,'2016-10-21 10:01:54.090151','6','admin2A',2,'[{\"changed\": {\"fields\": [\"is_staff\"]}}]',3,1),(11,'2016-10-21 10:33:54.323380','5','admin1',2,'[{\"changed\": {\"fields\": [\"password\"]}}]',3,1),(12,'2016-10-21 10:42:11.061506','6','admin2A',2,'[{\"changed\": {\"fields\": [\"password\"]}}]',3,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(4,'auth','group'),(2,'auth','permission'),(3,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2016-10-19 14:50:52.826576'),(2,'auth','0001_initial','2016-10-19 14:50:54.266843'),(3,'admin','0001_initial','2016-10-19 14:50:54.493671'),(4,'admin','0002_logentry_remove_auto_add','2016-10-19 14:50:54.515535'),(5,'contenttypes','0002_remove_content_type_name','2016-10-19 14:50:54.657775'),(6,'auth','0002_alter_permission_name_max_length','2016-10-19 14:50:54.680100'),(7,'auth','0003_alter_user_email_max_length','2016-10-19 14:50:54.704107'),(8,'auth','0004_alter_user_username_opts','2016-10-19 14:50:54.717671'),(9,'auth','0005_alter_user_last_login_null','2016-10-19 14:50:54.778466'),(10,'auth','0006_require_contenttypes_0002','2016-10-19 14:50:54.783494'),(11,'auth','0007_alter_validators_add_error_messages','2016-10-19 14:50:54.796023'),(12,'auth','0008_alter_user_username_max_length','2016-10-19 14:50:54.836859'),(13,'sessions','0001_initial','2016-10-19 14:50:54.893728');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('aq4737ashornsnghklh6f8yix8kzc3rd','ZDY5YzIyNDc2YjU0NTEyMTRlMDI2NmI2NzAwMzI2MjA2NTllODUzNjp7Il9hdXRoX3VzZXJfaGFzaCI6IjIzMWRlMjFkMjhjMWM1NDI0ODY1MDAyOTEzMjRiYmIxYzEwMDNiOGUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2016-11-04 09:25:19.260418'),('e713c9kd0ztepik9uwz28v777hebvzk7','ZDY5YzIyNDc2YjU0NTEyMTRlMDI2NmI2NzAwMzI2MjA2NTllODUzNjp7Il9hdXRoX3VzZXJfaGFzaCI6IjIzMWRlMjFkMjhjMWM1NDI0ODY1MDAyOTEzMjRiYmIxYzEwMDNiOGUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2016-11-04 17:38:42.596314'),('et2ejmqvn1jxtzshfqu2stvvtnkumjn9','MmI1ZWViMDE1NWM4Y2E0YzU3MzQ5ZjU0ZDc3OWI2MGM4YWY2YjY5Mjp7Il9hdXRoX3VzZXJfaGFzaCI6IjFjZDIyNjFhYTAwMDEwNTJkNmMxZGRiMjhmM2YzZWFhN2Y4NjgwYmYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-11-04 18:45:00.033779'),('t0o62a1j3ecedm2pmojf6v0f19st3tbk','ZDY5YzIyNDc2YjU0NTEyMTRlMDI2NmI2NzAwMzI2MjA2NTllODUzNjp7Il9hdXRoX3VzZXJfaGFzaCI6IjIzMWRlMjFkMjhjMWM1NDI0ODY1MDAyOTEzMjRiYmIxYzEwMDNiOGUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2016-11-03 20:22:56.033598'),('w7hzkjfxjucqsqjt6m54hkn9es3ayyjd','ZDY5YzIyNDc2YjU0NTEyMTRlMDI2NmI2NzAwMzI2MjA2NTllODUzNjp7Il9hdXRoX3VzZXJfaGFzaCI6IjIzMWRlMjFkMjhjMWM1NDI0ODY1MDAyOTEzMjRiYmIxYzEwMDNiOGUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2016-11-03 20:43:43.549611');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty_member`
--

DROP TABLE IF EXISTS `faculty_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faculty_member` (
  `faculty_id` varchar(10) NOT NULL,
  `password` varchar(40) DEFAULT NULL,
  `dept_id` varchar(10) DEFAULT NULL,
  `first_name` varchar(20) NOT NULL,
  `middle_name` varchar(20) DEFAULT '',
  `last_name` varchar(20) DEFAULT '',
  `designation` enum('Professor','Associate Professor','Assistant Professor','Visiting Professor') NOT NULL,
  `gender` enum('Male','Female') NOT NULL,
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`faculty_id`),
  KEY `dept_id` (`dept_id`),
  CONSTRAINT `faculty_member_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty_member`
--

LOCK TABLES `faculty_member` WRITE;
/*!40000 ALTER TABLE `faculty_member` DISABLE KEYS */;
INSERT INTO `faculty_member` VALUES ('f001','abcde1234','diit1','K.','K.','Shukla','Professor','Male','kkshukla.cse@iitbhu.ac.in'),('f023','asdf','dims1','R.','K.','Tripathi','Associate Professor','Male','rktripathi@bhu.ac.in'),('f042','defg5678','diit4','J.','N.','Dubey','Associate Professor','Male','jndubey.mec@iitbhu.ac.in'),('f053','efgh1234','diit1','A.','K.','Singh','Assistant Professor','Male','aksingh.cse@iitbhu.ac.in'),('f063','qwerty','diit6','R.','K.','Mandal','Professor','Male','rkmandal@iitbhu.ac.in'),('f070','hijk','dlaw3','M.','N.','Rao','Assistant Professor','Male','mnrao@iitbhu.ac.in'),('f123','abcd','diit7','Sanjay','','Shrivastava','Professor','Male','sanjay@iitbhu.ac.in'),('f189','lmn123','dims2','Shruti','','Singh','Visiting Professor','Female','shruti123@gmail.com'),('f372','wxyz1357','dlaw2','A.','B.','Jain','Assistant Professor','Female','abjain.law@bhu.ac.in');
/*!40000 ALTER TABLE `faculty_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leave_checked`
--

DROP TABLE IF EXISTS `leave_checked`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leave_checked` (
  `leave_id` int(10) unsigned NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` enum('Approved','Rejected','Not reviewed') NOT NULL DEFAULT 'Not reviewed',
  `remarks` varchar(30) DEFAULT '',
  `admin_id` varchar(10) NOT NULL,
  `faculty_id` varchar(10) NOT NULL,
  `leave_type` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`leave_id`),
  KEY `admin_id` (`admin_id`),
  KEY `faculty_id` (`faculty_id`),
  KEY `leave_type` (`leave_type`),
  CONSTRAINT `leave_checked_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `administrator` (`admin_id`),
  CONSTRAINT `leave_checked_ibfk_2` FOREIGN KEY (`faculty_id`) REFERENCES `faculty_member` (`faculty_id`),
  CONSTRAINT `leave_checked_ibfk_3` FOREIGN KEY (`leave_type`) REFERENCES `leave_info` (`leave_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leave_checked`
--

LOCK TABLES `leave_checked` WRITE;
/*!40000 ALTER TABLE `leave_checked` DISABLE KEYS */;
INSERT INTO `leave_checked` VALUES (1,'2016-01-01','2016-09-30','Rejected','Nil','admin1','f001','Study'),(13,'2017-10-04','2017-10-08','Approved','','admin1','f001','Halfpay'),(421,'2016-10-27','2016-10-30','Approved','','admin1','f042','Study'),(422,'2017-08-28','2017-10-31','Approved','Approved by admin2A','admin2A','f042','Halfpay'),(3722,'2016-11-07','2016-11-04','Approved','','admin1','f372','Childcare');
/*!40000 ALTER TABLE `leave_checked` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leave_info`
--

DROP TABLE IF EXISTS `leave_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leave_info` (
  `leave_type` varchar(30) NOT NULL,
  `leave_description` varchar(200) DEFAULT NULL,
  `max_days` int(10) unsigned NOT NULL,
  `lapsable` enum('Y','N') NOT NULL,
  `gender_spec` enum('M','F','All') NOT NULL,
  PRIMARY KEY (`leave_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leave_info`
--

LOCK TABLES `leave_info` WRITE;
/*!40000 ALTER TABLE `leave_info` DISABLE KEYS */;
INSERT INTO `leave_info` VALUES ('Casual','Casual leave',8,'Y','All'),('Childcare','Granted to female teachers',730,'N','F'),('Duty','Granted for attending conferences, delivering lectures and seminars',30,'Y','All'),('Earned','1/30 of actual service including vacation',12,'N','All'),('Extraordinary without pay','This is granted when no other leave is admissible, for three years at a time, extendable to five years',1095,'N','All'),('Halfpay','Granted on the basis of medical certificate from a medical practitioner',20,'N','All'),('Miscarriage','Granted to female employees for 45 days in case of an unfortunate miscarriage',45,'N','F'),('Paternity','Granted to male teachers for 15 days, up to two surviving children',15,'N','M'),('Restricted','Two restricted holidays are allowed in a year',2,'Y','All'),('Sabbatical','Granted to undertake study or research pursuits such as book authoring',730,'N','All'),('Special Casual','Granted to conduct examination in a university',10,'Y','All'),('Study','Granted to assistant professors only after a minimum of three years',1500,'N','All');
/*!40000 ALTER TABLE `leave_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leave_request`
--

DROP TABLE IF EXISTS `leave_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leave_request` (
  `leave_id` int(10) unsigned NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `faculty_id` varchar(10) NOT NULL,
  `leave_type` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`leave_id`),
  KEY `faculty_id` (`faculty_id`),
  KEY `leave_type` (`leave_type`),
  CONSTRAINT `leave_request_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `faculty_member` (`faculty_id`),
  CONSTRAINT `leave_request_ibfk_2` FOREIGN KEY (`leave_type`) REFERENCES `leave_info` (`leave_type`),
  CONSTRAINT `leave_request_ibfk_3` FOREIGN KEY (`leave_type`) REFERENCES `leave_info` (`leave_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leave_request`
--

LOCK TABLES `leave_request` WRITE;
/*!40000 ALTER TABLE `leave_request` DISABLE KEYS */;
INSERT INTO `leave_request` VALUES (16,'2016-11-07','2016-11-04','f001','Halfpay'),(423,'2017-08-08','2017-10-04','f042','Study'),(424,'2017-04-28','2017-06-11','f042','Study'),(3721,'2016-12-17','2016-12-31','f372','Halfpay');
/*!40000 ALTER TABLE `leave_request` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-22 15:48:04
