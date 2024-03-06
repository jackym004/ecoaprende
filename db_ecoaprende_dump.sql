-- MariaDB dump 10.19  Distrib 10.4.28-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: db_ecoaprende
-- ------------------------------------------------------
-- Server version	10.4.28-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tb_autor`
--

DROP TABLE IF EXISTS `tb_autor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_autor` (
  `id_autor` varchar(36) NOT NULL,
  `nombre_autor` varchar(50) NOT NULL,
  PRIMARY KEY (`id_autor`),
  UNIQUE KEY `unique_idautor` (`id_autor`),
  UNIQUE KEY `unique_nombreautor` (`nombre_autor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_autor`
--

LOCK TABLES `tb_autor` WRITE;
/*!40000 ALTER TABLE `tb_autor` DISABLE KEYS */;
INSERT INTO `tb_autor` VALUES ('A0014','Andrew S. Tanenbaum'),('A006','Charles E. Leiserson'),('A007','Clifford Stein'),('A009','David C. Lay'),('A001','David J. Griffiths'),('A0022','Donald A. McQuarrie'),('A0023','Douglas A. Skoog'),('A0020','Eugene Hecht'),('A0013','Gerald Jay Sussman'),('A008','Gilbert Strang'),('A0012','Harold Abelson'),('A0015','Jeffrey D. Ullman'),('A0016','John E. Hopcroft'),('A0025','José Antonio Marina'),('A0018','Kenneth H. Rosen'),('A0024','Martha Alicia Alles'),('A0010','Michael Spivak'),('A002','Michael T. Goodrich'),('A0019','Paul A. Tipler'),('A0017','Rajiv Motwani'),('A0021','Raymond Chang'),('A003','Roberto Tamassia'),('A005','Ronald L. Graham'),('A0011','Steven E. Landsburg'),('A004','Thomas H. Cormen');
/*!40000 ALTER TABLE `tb_autor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_carrera`
--

DROP TABLE IF EXISTS `tb_carrera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_carrera` (
  `id_carrera` varchar(36) NOT NULL,
  `nombre_carrera` varchar(100) NOT NULL,
  `especialidad_carrera` varchar(100) NOT NULL,
  `pensum_carrera` mediumblob NOT NULL,
  `id_universidad` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id_carrera`),
  KEY `fk_universidad_carrera` (`id_universidad`),
  CONSTRAINT `fk_universidad_carrera` FOREIGN KEY (`id_universidad`) REFERENCES `tb_universidad` (`id_universidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_carrera`
--

LOCK TABLES `tb_carrera` WRITE;
/*!40000 ALTER TABLE `tb_carrera` DISABLE KEYS */;
INSERT INTO `tb_carrera` VALUES ('C001','Ingeniería en Sistemas Informáticos','Desarrollo de software','Pensum en formato PDF','UN001'),('C0010','Ingeniería Eléctrica','Energías Renovables','Pensum en formato PDF','UN0010'),('C0011','Ciencias de la Educación','Pedagogía Infantil','Pensum en formato PDF','UN0011'),('C0012','Comunicación Social','Periodismo','Pensum en formato PDF','UN0012'),('C0013','Ingeniería Industrial','Gestión de la Producción','Pensum en formato PDF','UN0013'),('C0014','Biología','Ecología','Pensum en formato PDF','UN0014'),('C0015','Turismo','Gestión Hotelera','Pensum en formato PDF','UN0015'),('C0016','Ingeniería Mecánica','Diseño de Máquinas','Pensum en formato PDF','UN0016'),('C0017','Arte y Diseño','Diseño Gráfico','Pensum en formato PDF','UN0017'),('C0018','Química','Química Orgánica','Pensum en formato PDF','UN0018'),('C0019','Educación Física','Entrenamiento Deportivo','Pensum en formato PDF','UN0019'),('C002','Medicina','Cirugía General','Pensum en formato PDF','UN002'),('C0020','Ingeniería en Informática','Seguridad Informática','Pensum en formato PDF','UN0020'),('C0021','Nutrición y Dietética','Nutrición Clínica','Pensum en formato PDF','UN0021'),('C0022','Ciencias Ambientales','Gestión Ambiental','Pensum en formato PDF','UN0022'),('C0023','Ingeniería en Telecomunicaciones','Redes de Comunicación','Pensum en formato PDF','UN0023'),('C0024','Matemáticas','Estadística','Pensum en formato PDF','UN0024'),('C0025','Ingeniería Agronómica','Agricultura Sostenible','Pensum en formato PDF','UN0025'),('C003','Derecho','Derecho Penal','Pensum en formato PDF','UN003'),('C004','Ingeniería Civil','Construcción de Obras Civiles','Pensum en formato PDF','UN004'),('C005','Administración de Empresas','Finanzas Corporativas','Pensum en formato PDF','UN005'),('C006','Psicología','Psicología Clínica','Pensum en formato PDF','UN006'),('C007','Arquitectura','Diseño Urbano','Pensum en formato PDF','UN007'),('C008','Enfermería','Cuidados Intensivos','Pensum en formato PDF','UN008'),('C009','Contaduría Pública','Auditoría Financiera','Pensum en formato PDF','UN009');
/*!40000 ALTER TABLE `tb_carrera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_categoria`
--

DROP TABLE IF EXISTS `tb_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_categoria` (
  `id_categoria` varchar(36) NOT NULL,
  `nombre_categoria` varchar(50) NOT NULL,
  `descripcion_categoria` varchar(500) NOT NULL,
  PRIMARY KEY (`id_categoria`),
  UNIQUE KEY `unique_idcategoria` (`id_categoria`),
  UNIQUE KEY `unique_nombrecategoria` (`nombre_categoria`),
  CONSTRAINT `descripcion_categoria_check` CHECK (`descripcion_categoria` <> '')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_categoria`
--

LOCK TABLES `tb_categoria` WRITE;
/*!40000 ALTER TABLE `tb_categoria` DISABLE KEYS */;
INSERT INTO `tb_categoria` VALUES ('CT001','Matemáticas','Libros relacionados con conceptos, teorías y aplicaciones matemáticas.'),('CT0010','Ciencias de la Computación','Libros que tratan sobre teoría y fundamentos de la informática.'),('CT0011','Economía','Libros relacionados con teoría económica, políticas económicas y análisis económico.'),('CT0012','Administración de Empresas','Libros que cubren principios y prácticas de gestión empresarial.'),('CT0013','Contabilidad','Libros que abordan principios contables, auditoría y análisis financiero.'),('CT0014','Finanzas','Libros relacionados con inversiones, mercados financieros y gestión financiera.'),('CT0015','Derecho','Libros sobre teoría del derecho, legislación y sistemas legales.'),('CT0016','Psicología','Libros que tratan sobre la mente, el comportamiento humano y la psicología clínica.'),('CT0017','Sociología','Libros que abordan teoría sociológica, métodos de investigación y análisis social.'),('CT0018','Historia','Libros sobre acontecimientos pasados, sociedades antiguas y movimientos históricos.'),('CT0019','Filosofía','Libros que tratan sobre la búsqueda del conocimiento, la moral y la existencia humana.'),('CT002','Física','Libros que abarcan principios fundamentales, teorías y aplicaciones en el campo de la física.'),('CT0020','Literatura','Libros que incluyen obras literarias clásicas y análisis literario.'),('CT0021','Lingüística','Libros que abordan la estructura y evolución de los idiomas.'),('CT0022','Educación','Libros sobre teoría pedagógica, métodos de enseñanza y psicología educativa.'),('CT0023','Arte y Diseño','Libros que cubren historia del arte, técnicas de diseño y apreciación artística.'),('CT0024','Arquitectura','Libros sobre diseño arquitectónico, planificación urbana y construcción sostenible.'),('CT0025','Medicina','Libros relacionados con anatomía, fisiología, diagnóstico y tratamiento médico.'),('CT003','Química','Libros que cubren conceptos, experimentos y aplicaciones químicas.'),('CT004','Biología','Libros que tratan sobre la ciencia de la vida, incluyendo genética, ecología, y biología celular.'),('CT005','Ingeniería Eléctrica','Libros relacionados con circuitos eléctricos, electrónica, y sistemas de potencia.'),('CT006','Ingeniería Mecánica','Libros que abordan principios de mecánica, termodinámica, y diseño de máquinas.'),('CT007','Ingeniería Civil','Libros sobre diseño, construcción y mantenimiento de infraestructuras civiles.'),('CT008','Ingeniería de Sistemas','Libros que cubren teoría y aplicaciones de sistemas de información y comunicación.'),('CT009','Informática','Libros que abordan programación, algoritmos, y estructuras de datos.');
/*!40000 ALTER TABLE `tb_categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_detalle_valoracion`
--

DROP TABLE IF EXISTS `tb_detalle_valoracion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_detalle_valoracion` (
  `id_detalle_valoracion` varchar(36) NOT NULL,
  `id_libro` varchar(36) NOT NULL,
  `id_usuario` varchar(36) NOT NULL,
  PRIMARY KEY (`id_detalle_valoracion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_detalle_valoracion`
--

LOCK TABLES `tb_detalle_valoracion` WRITE;
/*!40000 ALTER TABLE `tb_detalle_valoracion` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_detalle_valoracion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_detallepedido`
--

DROP TABLE IF EXISTS `tb_detallepedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_detallepedido` (
  `id_detallepedido` varchar(36) NOT NULL,
  `cantidad_libro_pedido` int(11) NOT NULL,
  `direccion_pedido` varchar(300) NOT NULL DEFAULT 'Dirección por defecto',
  `preciototal_libro_pedido` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id_detallepedido`),
  UNIQUE KEY `unique_id_detalle_pedido` (`id_detallepedido`),
  CONSTRAINT `cantidad_libro_pedido_check` CHECK (`cantidad_libro_pedido` <> ''),
  CONSTRAINT `preciototal_libro_pedido_check` CHECK (`preciototal_libro_pedido` <> '')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_detallepedido`
--

LOCK TABLES `tb_detallepedido` WRITE;
/*!40000 ALTER TABLE `tb_detallepedido` DISABLE KEYS */;
INSERT INTO `tb_detallepedido` VALUES ('DP001',5,'Dirección 1',50.00),('DP00110',5,'Dirección 10',50.00),('DP00111',3,'Dirección 11',30.00),('DP00112',2,'Dirección 12',20.00),('DP00113',4,'Dirección 13',40.00),('DP00114',6,'Dirección 14',60.00),('DP00115',1,'Dirección 15',10.00),('DP00116',3,'Dirección 16',30.00),('DP00117',2,'Dirección 17',20.00),('DP00118',4,'Dirección 18',40.00),('DP00119',5,'Dirección 19',50.00),('DP0012',3,'Dirección 2',30.00),('DP00120',3,'Dirección 20',30.00),('DP00121',2,'Dirección 21',20.00),('DP00122',4,'Dirección 22',40.00),('DP00123',6,'Dirección 23',60.00),('DP00124',1,'Dirección 24',10.00),('DP00125',3,'Dirección 25',30.00),('DP0013',2,'Dirección 3',20.00),('DP0014',4,'Dirección 4',40.00),('DP0015',6,'Dirección 5',60.00),('DP0016',1,'Dirección 6',10.00),('DP0017',3,'Dirección 7',30.00),('DP0018',2,'Dirección 8',20.00),('DP0019',4,'Dirección 9',40.00);
/*!40000 ALTER TABLE `tb_detallepedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_editorial`
--

DROP TABLE IF EXISTS `tb_editorial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_editorial` (
  `id_editorial` varchar(36) NOT NULL,
  `nombre_editorial` varchar(120) NOT NULL,
  PRIMARY KEY (`id_editorial`),
  UNIQUE KEY `unique_ideditorial` (`id_editorial`),
  UNIQUE KEY `unique_nombreeditorial` (`nombre_editorial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_editorial`
--

LOCK TABLES `tb_editorial` WRITE;
/*!40000 ALTER TABLE `tb_editorial` DISABLE KEYS */;
INSERT INTO `tb_editorial` VALUES ('E0024','Bedford/St. Martin´s'),('E004','Cambridge University Press'),('E009','Cengage Learning'),('E0016','Columbia University Press'),('E008','Elsevier'),('E0010','Harvard University Press'),('E0023','Houghton Mifflin Harcourt'),('E006','John Wiley & Sons'),('E0022','Macmillan Education'),('E002','McGraw-Hill Education'),('E0013','MIT Press'),('E003','Oxford University Press'),('E0021','Palgrave Macmillan'),('E001','Pearson Education'),('E005','Prentice Hall'),('E0011','Princeton University Press'),('E0018','Routledge'),('E0020','Sage Publications'),('E007','Springer Nature'),('E0015','Stanford University Press'),('E0019','Taylor & Francis'),('E0017','University of California Press'),('E0014','University of Chicago Press'),('E0025','W.W. Norton & Company'),('E0012','Yale University Press');
/*!40000 ALTER TABLE `tb_editorial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_iniciosesion`
--

DROP TABLE IF EXISTS `tb_iniciosesion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_iniciosesion` (
  `id_iniciosesion` varchar(36) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `clave_usuario` varchar(30) NOT NULL,
  `id_usuario` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id_iniciosesion`),
  UNIQUE KEY `unique_id_inicio_sesion` (`id_iniciosesion`),
  KEY `fk_iniciosesion_usuario` (`id_usuario`),
  CONSTRAINT `fk_iniciosesion_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_iniciosesion`
--

LOCK TABLES `tb_iniciosesion` WRITE;
/*!40000 ALTER TABLE `tb_iniciosesion` DISABLE KEYS */;
INSERT INTO `tb_iniciosesion` VALUES ('IS001','usuario1','clave1','U001'),('IS0010','usuario10','clave10','U0010'),('IS0011','usuario11','clave11','U0011'),('IS0012','usuario12','clave12','U0012'),('IS0013','usuario13','clave13','U0013'),('IS0014','usuario14','clave14','U0014'),('IS0015','usuario15','clave15','U0015'),('IS0016','usuario16','clave16','U0016'),('IS0017','usuario17','clave17','U0017'),('IS0018','usuario18','clave18','U0018'),('IS0019','usuario19','clave19','U0019'),('IS002','usuario2','clave2','U002'),('IS0020','usuario20','clave20','U0020'),('IS0021','usuario21','clave21','U0021'),('IS0022','usuario22','clave22','U0022'),('IS0023','usuario23','clave23','U0023'),('IS0024','usuario24','clave24','U0024'),('IS0025','usuario25','clave25','U0025'),('IS003','usuario3','clave3','U003'),('IS004','usuario4','clave4','U004'),('IS005','usuario5','clave5','U005'),('IS006','usuario6','clave6','U006'),('IS007','usuario7','clave7','U007'),('IS008','usuario8','clave8','U008'),('IS009','usuario9','clave9','U009');
/*!40000 ALTER TABLE `tb_iniciosesion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_libro`
--

DROP TABLE IF EXISTS `tb_libro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_libro` (
  `id_libro` varchar(36) NOT NULL,
  `id_autor` varchar(36) NOT NULL,
  `id_editorial` varchar(36) NOT NULL,
  `id_categoria` varchar(36) NOT NULL,
  `descripcion_libro` varchar(800) NOT NULL,
  PRIMARY KEY (`id_libro`),
  UNIQUE KEY `unique_idlibro` (`id_libro`),
  KEY `fk_libro_autor` (`id_autor`),
  KEY `fk_libro_editorial` (`id_editorial`),
  KEY `fk_libro_categoria` (`id_categoria`),
  CONSTRAINT `fk_libro_autor` FOREIGN KEY (`id_autor`) REFERENCES `tb_autor` (`id_autor`),
  CONSTRAINT `fk_libro_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `tb_categoria` (`id_categoria`),
  CONSTRAINT `fk_libro_editorial` FOREIGN KEY (`id_editorial`) REFERENCES `tb_editorial` (`id_editorial`),
  CONSTRAINT `descripcion_libro_check` CHECK (`descripcion_libro` <> '')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_libro`
--

LOCK TABLES `tb_libro` WRITE;
/*!40000 ALTER TABLE `tb_libro` DISABLE KEYS */;
INSERT INTO `tb_libro` VALUES ('L001','A001','E001','CT001','Descripción del libro 1'),('L0010','A0010','E0010','CT0010','Descripción del libro 10'),('L0011','A0011','E0011','CT0011','Descripción del libro 11'),('L0012','A0012','E0012','CT0012','Descripción del libro 12'),('L0013','A0013','E0013','CT0013','Descripción del libro 13'),('L0014','A0014','E0014','CT0014','Descripción del libro 14'),('L0015','A0015','E0015','CT0015','Descripción del libro 15'),('L0016','A0016','E0016','CT0016','Descripción del libro 16'),('L0017','A0017','E0017','CT0017','Descripción del libro 17'),('L0018','A0018','E0018','CT0018','Descripción del libro 18'),('L0019','A0019','E0019','CT0019','Descripción del libro 19'),('L002','A002','E002','CT002','Descripción del libro 2'),('L0020','A0020','E0020','CT0020','Descripción del libro 20'),('L0021','A0021','E0021','CT0021','Descripción del libro 21'),('L0022','A0022','E0022','CT0022','Descripción del libro 22'),('L0023','A0023','E0023','CT0023','Descripción del libro 23'),('L0024','A0024','E0024','CT0024','Descripción del libro 24'),('L0025','A0025','E0025','CT0025','Descripción del libro 25'),('L003','A003','E003','CT003','Descripción del libro 3'),('L004','A004','E004','CT004','Descripción del libro 4'),('L005','A005','E005','CT005','Descripción del libro 5'),('L006','A006','E006','CT006','Descripción del libro 6'),('L007','A007','E007','CT007','Descripción del libro 7'),('L008','A008','E008','CT008','Descripción del libro 8'),('L009','A009','E009','CT009','Descripción del libro 9');
/*!40000 ALTER TABLE `tb_libro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_pedido`
--

DROP TABLE IF EXISTS `tb_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_pedido` (
  `id_pedido` varchar(36) NOT NULL,
  `descripcion_pedido` varchar(300) DEFAULT NULL,
  `id_usuario` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id_pedido`),
  UNIQUE KEY `unique_idpedido` (`id_pedido`),
  KEY `fk_pedido_usuario` (`id_usuario`),
  CONSTRAINT `fk_pedido_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_pedido`
--

LOCK TABLES `tb_pedido` WRITE;
/*!40000 ALTER TABLE `tb_pedido` DISABLE KEYS */;
INSERT INTO `tb_pedido` VALUES ('P001','Descripción del pedido 1','U001'),('P0010','Descripción del pedido 10','U0010'),('P0011','Descripción del pedido 11','U0011'),('P0012','Descripción del pedido 12','U0012'),('P0013','Descripción del pedido 13','U0013'),('P0014','Descripción del pedido 14','U0014'),('P0015','Descripción del pedido 15','U0015'),('P0016','Descripción del pedido 16','U0016'),('P0017','Descripción del pedido 17','U0017'),('P0018','Descripción del pedido 18','U0018'),('P0019','Descripción del pedido 19','U0019'),('P002','Descripción del pedido 2','U002'),('P0020','Descripción del pedido 20','U0020'),('P0021','Descripción del pedido 21','U0021'),('P0022','Descripción del pedido 22','U0022'),('P0023','Descripción del pedido 23','U0023'),('P0024','Descripción del pedido 24','U0024'),('P0025','Descripción del pedido 25','U0025'),('P003','Descripción del pedido 3','U003'),('P004','Descripción del pedido 4','U004'),('P005','Descripción del pedido 5','U005'),('P006','Descripción del pedido 6','U006'),('P007','Descripción del pedido 7','U007'),('P008','Descripción del pedido 8','U008'),('P009','Descripción del pedido 9','U009');
/*!40000 ALTER TABLE `tb_pedido` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_nuevo_pedido AFTER INSERT ON tb_pedido
FOR EACH ROW
BEGIN
    DECLARE mensaje VARCHAR(100);
    SET mensaje = CONCAT('Se ha insertado un nuevo pedido con el ID: ', NEW.id_pedido);
    SELECT mensaje INTO @mensaje;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @mensaje;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_universidad`
--

DROP TABLE IF EXISTS `tb_universidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_universidad` (
  `id_universidad` varchar(36) NOT NULL,
  `nombre_universidad` varchar(100) NOT NULL,
  PRIMARY KEY (`id_universidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_universidad`
--

LOCK TABLES `tb_universidad` WRITE;
/*!40000 ALTER TABLE `tb_universidad` DISABLE KEYS */;
INSERT INTO `tb_universidad` VALUES ('UN001','Universidad de El Salvador'),('UN0010','Universidad de Oriente'),('UN0011','Universidad Pedagógica de El Salvador'),('UN0012','Universidad Albert Einstein'),('UN0013','Universidad Católica de El Salvador'),('UN0014','Universidad Internacional Iberoamericana'),('UN0015','Universidad Salvadoreña Alberto Masferrer'),('UN0016','Universidad Dr. Andrés Bello'),('UN0017','Universidad de Sonsonate'),('UN0018','Universidad de San Miguel'),('UN0019','Universidad Gerardo Barrios'),('UN002','Universidad Tecnológica de El Salvador'),('UN0020','Universidad Modular Abierta'),('UN0021','Universidad Católica de Occidente'),('UN0022','Universidad Internacional de San Isidro Labrador'),('UN0023','Universidad Panamericana'),('UN0024','Universidad del Istmo'),('UN0025','Universidad Tecnológica de El Salvador \"UTESA\"'),('UN003','Universidad Francisco Gavidia'),('UN004','Universidad Dr. José Matías Delgado'),('UN005','Universidad Centroamericana \"José Simeón Cañas\"'),('UN006','Universidad Don Bosco'),('UN007','Universidad Evangélica de El Salvador'),('UN008','Universidad Luterana Salvadoreña'),('UN009','Universidad Politécnica de El Salvador');
/*!40000 ALTER TABLE `tb_universidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_usuario`
--

DROP TABLE IF EXISTS `tb_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_usuario` (
  `id_usuario` varchar(36) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `correo_usuario` varchar(100) NOT NULL,
  `clave_usuario` varchar(30) NOT NULL,
  `telefono_usuario` varchar(9) NOT NULL,
  `dui_usuario` varchar(10) NOT NULL,
  `id_carrera` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `unique_idusuario` (`id_usuario`),
  UNIQUE KEY `unique_correousuario` (`correo_usuario`),
  UNIQUE KEY `unique_telefonousuario` (`telefono_usuario`),
  UNIQUE KEY `unique_duiusuario` (`dui_usuario`),
  KEY `fk_usuario_carrera` (`id_carrera`),
  CONSTRAINT `fk_usuario_carrera` FOREIGN KEY (`id_carrera`) REFERENCES `tb_carrera` (`id_carrera`),
  CONSTRAINT `check_telefonousuario` CHECK (`telefono_usuario` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_usuario`
--

LOCK TABLES `tb_usuario` WRITE;
/*!40000 ALTER TABLE `tb_usuario` DISABLE KEYS */;
INSERT INTO `tb_usuario` VALUES ('U001','Juan Pérez','juan@example.com','clave123','123','1234567890','C001'),('U0010','Javier Ramírez','javier@example.com','clavexyz','829','8888888888','C0010'),('U0011','Lucía Gómez','lucia@example.com','clave123','486','9999999999','C0011'),('U0012','Andrés Pérez','andres@example.com','clave456','234','0000000000','C0012'),('U0013','Gabriela Rodríguez','gabriela@example.com','563','444525666','1112223333','C0013'),('U0014','Daniel González','daniel@example.com','claveabc','349','2224','C0014'),('U0015','Marta López','marta@example.com','clavexyz','563','3445555','C0015'),('U0016','José Martínez','jose@example.com','clave123','423','44456666','C0016'),('U0017','Patricia Pérez','patricia@example.com','clave456','589','5556777','C0017'),('U0018','Manuel Gómez','manuel@example.com','clave789','645','6778888','C0018'),('U0019','Ana Ramírez','ana_r@example.com','claveabc','674','777889','C0019'),('U002','María González','maria@example.com','clave456','456','0987654321','C002'),('U0020','David García','david@example.com','clavexyz','111','8889390000','C0020'),('U0021','Carmen López','carmen@example.com','clave123','222','9990111','C0021'),('U0022','Roberto Díaz','roberto@example.com','clave456','333','0112222','C0022'),('U0023','Sara Sánchez','sara@example.com','clave789','444','11122','C0023'),('U0024','Diego Castro','diego@example.com','claveabc','555','2223334','C0024'),('U0025','Fernanda Ramírez','fernanda@example.com','clavexyz','666','33344555','C0025'),('U003','Carlos López','carlos@example.com','clave789','789','1111111111','C003'),('U004','Ana Martínez','ana@example.com','claveabc','987','2222222222','C004'),('U005','Pedro Rodríguez','pedro@example.com','clavexyz','654','3333333333','C005'),('U006','Laura García','laura@example.com','clave123','321','4444444444','C006'),('U007','Luis Hernández','luis@example.com','clave456','135','5555555555','C007'),('U008','Sofía Díaz','sofia@example.com','clave789','246','6666666666','C008'),('U009','Elena Castro','elena@example.com','claveabc','369','7777777777','C009');
/*!40000 ALTER TABLE `tb_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_valoracion`
--

DROP TABLE IF EXISTS `tb_valoracion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_valoracion` (
  `id_valoracion` varchar(36) NOT NULL,
  `id_libro` varchar(36) NOT NULL,
  `id_usuario` varchar(36) NOT NULL,
  `id_pedido` varchar(36) NOT NULL,
  `valoracion_pedido` decimal(5,2) DEFAULT NULL,
  `descripcion_valoracion` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id_valoracion`),
  UNIQUE KEY `unique_idvaloracion` (`id_valoracion`),
  KEY `fk_valoracion_libro` (`id_libro`),
  KEY `fk_valoracion_usuario` (`id_usuario`),
  KEY `fk_valoracion_pedido` (`id_pedido`),
  CONSTRAINT `fk_valoracion_libro` FOREIGN KEY (`id_libro`) REFERENCES `tb_libro` (`id_libro`),
  CONSTRAINT `fk_valoracion_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `tb_pedido` (`id_pedido`),
  CONSTRAINT `fk_valoracion_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `tb_usuario` (`id_usuario`),
  CONSTRAINT `descripcion_valoracion_check` CHECK (`descripcion_valoracion` <> '')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_valoracion`
--

LOCK TABLES `tb_valoracion` WRITE;
/*!40000 ALTER TABLE `tb_valoracion` DISABLE KEYS */;
INSERT INTO `tb_valoracion` VALUES ('V001','L001','U001','P001',4.50,'Descripción de la valoración 1'),('V0010','L0010','U0010','P0010',4.40,'Descripción de la valoración 10'),('V0011','L0011','U0011','P0011',3.70,'Descripción de la valoración 11'),('V0012','L0012','U0012','P0012',4.80,'Descripción de la valoración 12'),('V0013','L0013','U0013','P0013',3.50,'Descripción de la valoración 13'),('V0014','L0014','U0014','P0014',4.90,'Descripción de la valoración 14'),('V0015','L0015','U0015','P0015',4.30,'Descripción de la valoración 15'),('V0016','L0016','U0016','P0016',3.80,'Descripción de la valoración 16'),('V0017','L0017','U0017','P0017',4.20,'Descripción de la valoración 17'),('V0018','L0018','U0018','P0018',4.50,'Descripción de la valoración 18'),('V0019','L0019','U0019','P0019',4.00,'Descripción de la valoración 19'),('V002','L002','U002','P002',4.00,'Descripción de la valoración 2'),('V0020','L0020','U0020','P0020',3.60,'Descripción de la valoración 20'),('V0021','L0021','U0021','P0021',4.70,'Descripción de la valoración 21'),('V0022','L0022','U0022','P0022',3.90,'Descripción de la valoración 22'),('V0023','L0023','U0023','P0023',4.10,'Descripción de la valoración 23'),('V0024','L0024','U0024','P0024',4.40,'Descripción de la valoración 24'),('V0025','L0025','U0025','P0025',3.70,'Descripción de la valoración 25'),('V003','L003','U003','P003',3.80,'Descripción de la valoración 3'),('V004','L004','U004','P004',4.20,'Descripción de la valoración 4'),('V005','L005','U005','P005',4.70,'Descripción de la valoración 5'),('V006','L006','U006','P006',4.10,'Descripción de la valoración 6'),('V007','L007','U007','P007',4.30,'Descripción de la valoración 7'),('V008','L008','U008','P008',3.90,'Descripción de la valoración 8'),('V009','L009','U009','P009',4.60,'Descripción de la valoración 9');
/*!40000 ALTER TABLE `tb_valoracion` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-06 15:15:36
