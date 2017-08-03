-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: dulzuras_artesanales
-- ------------------------------------------------------
-- Server version	5.7.11

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
-- Table structure for table `direccion`
--

DROP TABLE IF EXISTS `direccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `direccion` (
  `id` int(11) NOT NULL,
  `calle` varchar(45) DEFAULT NULL,
  `numero` int(11) DEFAULT NULL,
  `piso` int(11) DEFAULT NULL,
  `departamento` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `idUsuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Direccion_Usuario_idx` (`idUsuario`),
  CONSTRAINT `FK_Direccion_Usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `direccion`
--

LOCK TABLES `direccion` WRITE;
/*!40000 ALTER TABLE `direccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `direccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `envio`
--

DROP TABLE IF EXISTS `envio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `envio` (
  `id` int(11) NOT NULL,
  `detalle` varchar(85) DEFAULT NULL,
  `idDireccion` int(11) DEFAULT NULL,
  `importe` decimal(8,2) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `idFormaDePago` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Envio_Direccion_idx` (`idDireccion`),
  KEY `FK_Envio_FormaDePAgo_idx` (`idFormaDePago`),
  CONSTRAINT `FK_Envio_Direccion` FOREIGN KEY (`idDireccion`) REFERENCES `direccion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Envio_FormaDePAgo` FOREIGN KEY (`idFormaDePago`) REFERENCES `forma_de_pago` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='				';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `envio`
--

LOCK TABLES `envio` WRITE;
/*!40000 ALTER TABLE `envio` DISABLE KEYS */;
/*!40000 ALTER TABLE `envio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forma_de_pago`
--

DROP TABLE IF EXISTS `forma_de_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forma_de_pago` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forma_de_pago`
--

LOCK TABLES `forma_de_pago` WRITE;
/*!40000 ALTER TABLE `forma_de_pago` DISABLE KEYS */;
INSERT INTO `forma_de_pago` VALUES (1,'Efectivo');
/*!40000 ALTER TABLE `forma_de_pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedido` (
  `id` int(11) NOT NULL,
  `numero` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `idUsuario` int(11) DEFAULT NULL,
  `idEnvio` int(11) DEFAULT NULL,
  `total` decimal(8,2) DEFAULT NULL,
  `idFormaDePago` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Pedido_Usuario_idx` (`idUsuario`),
  KEY `FK_Pedido_Envio_idx` (`idEnvio`),
  KEY `FK_Pedido_FormaDePago_idx` (`idFormaDePago`),
  CONSTRAINT `FK_Pedido_Envio` FOREIGN KEY (`idEnvio`) REFERENCES `envio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Pedido_FormaDePago` FOREIGN KEY (`idFormaDePago`) REFERENCES `forma_de_pago` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Pedido_Usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido_detalle`
--

DROP TABLE IF EXISTS `pedido_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedido_detalle` (
  `id` int(11) NOT NULL,
  `idPedido` int(11) DEFAULT NULL,
  `idProductoPedido` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precioUnitario` decimal(8,2) DEFAULT NULL,
  `precioTotal` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_PedidoDetalle_Pedido_idx` (`idPedido`),
  KEY `FK_PedidoDetalle_ProductoPedido_idx` (`idProductoPedido`),
  CONSTRAINT `FK_PedidoDetalle_Pedido` FOREIGN KEY (`idPedido`) REFERENCES `pedido` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_PedidoDetalle_ProductoPedido` FOREIGN KEY (`idProductoPedido`) REFERENCES `producto_pedido` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido_detalle`
--

LOCK TABLES `pedido_detalle` WRITE;
/*!40000 ALTER TABLE `pedido_detalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedido_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido_producto_detalle`
--

DROP TABLE IF EXISTS `pedido_producto_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedido_producto_detalle` (
  `id` int(11) NOT NULL,
  `idPedidoProducto` int(11) DEFAULT NULL,
  `idProductoDetalle` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_PedidoProductoDetalle_PedidoProducto_idx` (`idPedidoProducto`),
  KEY `FK_PedidoProductoDetalle_ProductoDetalle_idx` (`idProductoDetalle`),
  CONSTRAINT `FK_PedidoProductoDetalle_PedidoProducto` FOREIGN KEY (`idPedidoProducto`) REFERENCES `producto_pedido` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_PedidoProductoDetalle_ProductoDetalle` FOREIGN KEY (`idProductoDetalle`) REFERENCES `producto_detalle` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido_producto_detalle`
--

LOCK TABLES `pedido_producto_detalle` WRITE;
/*!40000 ALTER TABLE `pedido_producto_detalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedido_producto_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producto` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(85) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='															';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,'Alfajores'),(2,'Cubanitos'),(3,'Muffins'),(4,'Chocotorta'),(5,'Torta de coco');
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto_detalle`
--

DROP TABLE IF EXISTS `producto_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producto_detalle` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(85) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='		';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto_detalle`
--

LOCK TABLES `producto_detalle` WRITE;
/*!40000 ALTER TABLE `producto_detalle` DISABLE KEYS */;
INSERT INTO `producto_detalle` VALUES (1,'Dulce de Leche'),(2,'Rojo'),(3,'Rosa'),(4,'Verde'),(5,'Nueces'),(6,'Almendras'),(7,'Coco'),(8,'Chips Chocolate Negro'),(9,'Chips Chocolate Blanco'),(10,'Marroc'),(11,'Nugget'),(12,'Baño Chocolate Negro'),(13,'Frutos Del Bosque'),(14,'Baño Chocolate Blanco');
/*!40000 ALTER TABLE `producto_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto_pedido`
--

DROP TABLE IF EXISTS `producto_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producto_pedido` (
  `id` int(11) NOT NULL,
  `idProducto` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ProductoPedido_Producto_idx` (`idProducto`),
  CONSTRAINT `FK_ProductoPedido_Producto` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto_pedido`
--

LOCK TABLES `producto_pedido` WRITE;
/*!40000 ALTER TABLE `producto_pedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `producto_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `alias` varchar(45) DEFAULT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `facebook` varchar(45) DEFAULT NULL,
  `contrasenia` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-08-03 12:48:14
