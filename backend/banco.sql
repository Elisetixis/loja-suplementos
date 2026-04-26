-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: loja_suplementos
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `carrinho`
--

DROP TABLE IF EXISTS `carrinho`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carrinho` (
  `id_carrinho` int NOT NULL AUTO_INCREMENT,
  `usuario_id` int NOT NULL,
  `produto_id` int NOT NULL,
  `quantidade` int DEFAULT '1',
  PRIMARY KEY (`id_carrinho`),
  KEY `usuario_id` (`usuario_id`),
  KEY `produto_id` (`produto_id`),
  CONSTRAINT `carrinho_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `carrinho_ibfk_2` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id_produto`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrinho`
--

LOCK TABLES `carrinho` WRITE;
/*!40000 ALTER TABLE `carrinho` DISABLE KEYS */;
/*!40000 ALTER TABLE `carrinho` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido_itens`
--

DROP TABLE IF EXISTS `pedido_itens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido_itens` (
  `id_itens` int NOT NULL AUTO_INCREMENT,
  `pedido_id` int NOT NULL,
  `produto_id` int NOT NULL,
  `quantidade` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_itens`),
  KEY `pedido_id` (`pedido_id`),
  KEY `produto_id` (`produto_id`),
  CONSTRAINT `pedido_itens_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id_pedido`),
  CONSTRAINT `pedido_itens_ibfk_2` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id_produto`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido_itens`
--

LOCK TABLES `pedido_itens` WRITE;
/*!40000 ALTER TABLE `pedido_itens` DISABLE KEYS */;
INSERT INTO `pedido_itens` VALUES (1,1,1,2),(2,2,5,1),(3,2,18,1),(4,2,28,1),(5,2,34,1),(6,3,6,3),(7,3,18,1),(8,3,26,2),(9,4,2,1),(10,4,14,2),(11,5,4,1),(12,5,14,2),(13,5,21,2),(14,6,3,1),(15,6,5,1),(16,6,20,1);
/*!40000 ALTER TABLE `pedido_itens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `id_pedido` int NOT NULL AUTO_INCREMENT,
  `usuario_id` int NOT NULL,
  `data` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_pedido`),
  KEY `fk_usuario_pedido` (`usuario_id`),
  CONSTRAINT `fk_usuario_pedido` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,3,'2026-04-25 18:06:53'),(2,3,'2026-04-25 18:24:51'),(3,3,'2026-04-25 18:45:04'),(4,3,'2026-04-26 09:34:41'),(5,3,'2026-04-26 09:39:22'),(6,3,'2026-04-26 09:41:01');
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `id_produto` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descricao` text,
  `preco` decimal(10,2) NOT NULL,
  `imagem` varchar(255) NOT NULL,
  `marca` varchar(50) DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_produto`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'Whey Black Pump Morango','Whey protein premium sabor morango',119.90,'img/bp-morango.png','Black Pump','Whey'),(2,'Whey Black Pump Chocolate','Whey protein premium sabor chocolate',119.90,'img/bp-chocolate.png','Black Pump','Whey'),(3,'Whey Black Pump Baunilha','Whey protein premium sabor baunilha',119.90,'img/bp-baunilha.png','Black Pump','Whey'),(4,'Whey Black Pump Torta de Limão','Whey protein premium sabor torta de limão',119.90,'img/bp-limao.png','Black Pump','Whey'),(5,'Pré Treino Black Pump Açaí','Pré treino premium sabor açaí',79.90,'img/bp-pt-acai.png','Black Pump','Pré Treino'),(6,'Pré Treino Black Pump Energético','Pré treino premium sabor energético',89.90,'img/bp-pt-energetico.png','Black Pump','Pré Treino'),(7,'Pré Treino Black Pump Limão','Pré treino premium sabor limão',79.90,'img/bp-pt-limao.png','Black Pump','Pré Treino'),(8,'Pré Treino Black Pump Frutas Vermelhas','Pré treino premium sabor frutas vermelhas',79.90,'img/bp-pt-fv.png','Black Pump','Pré Treino'),(13,'Creatina Black Pump','Creatina premium',89.90,'img/bp-creatina.png','Black Pump','Creatina'),(14,'BCA Black Pump','Bca premium',69.90,'img/bp-bca.png','Black Pump','BCAA'),(15,'Creatina em Gomas Black Pump Frutas Vermelhas','Creatina em gomas premium sabor frutas vermelhas',89.90,'img/bp-creatina-gomafv.png','Black Pump','Creatina'),(16,'Creatina em Gomas Black Pump Tutifruti','Creatina em gomas premium sabor Tutifruti',89.90,'img/bp-creatina-gomatf.png','Black Pump','Creatina'),(17,'Whey Growth Morango','Whey protein growth morango',149.90,'img/g-morango.png','Growth','Whey'),(18,'Whey Growth Brigadeiro','Whey protein growth brigadeiro',149.90,'img/g-brigadeiro.png','Growth','Whey'),(19,'Whey Growth Sorvete de Creme','Whey protein growth sorvete de creme',149.90,'img/g-creme.png','Growth','Whey'),(20,'Creatina Growth','Creatina growth',109.90,'img/g-creatina.png','Growth','Creatina'),(21,'BCAA Growth','BCAA growth',89.90,'img/g-bcaa.png','Growth','BCAA'),(22,'BCAA em Pó Growth','BCAA pó growth',99.90,'img/g-bcaap.png','Growth','BCAA'),(23,'Pré Treino Growth Haze','Pré treino growth',119.90,'img/g-pt.png','Growth','Pré Treino'),(24,'Camiseta Growth','Camiseta growth',69.90,'img/g-camisa.png','Growth','Vestuario'),(25,'Manga Longa Growth','Manga longa growth',79.90,'img/g-manga.png','Growth','Vestuario'),(26,'Galão 2L Growth','Galão growth',39.90,'img/g-galao.png','Growth','Garrafas'),(27,'Whey Max Titanium Paçoca','Whey protein max paçoca',129.90,'img/m-pacoca.png','Max Titanium','Whey'),(28,'Whey Max Titanium Avelã','Whey protein max avela',129.90,'img/m-avela.png','Max Titanium','Whey'),(29,'Whey Max Titanium Buenissimo','Whey protein max buenissimo',129.90,'img/m-bueno.png','Max Titanium','Whey'),(30,'Pré Treino Max Titanium Horus','Pré treino max horus',109.90,'img/m-pth.png','Max Titanium','Pré Treino'),(31,'Pré Treino Max Titanium','Pré treino max',99.90,'img/m-pt.png','Max Titanium','Pré Treino'),(32,'Creatina Max Titanium','Creatina max',99.90,'img/m-creatina.png','Max Titanium','Creatina'),(33,'BCAA Max Titanium','Bcaa max',89.90,'img/m-bcaa.png','Max Titanium','BCAA'),(34,'Camiseta Max Titanium','Camiseta max',59.90,'img/m-camisa.png','Max Titanium','Vestuario'),(35,'Regata Max Titanium','Regata max',49.90,'img/m-regata.png','Max Titanium','Vestuario'),(36,'Coqueteleira Max Titanium','Coqueteleira max',29.90,'img/m-coq.png','Max Titanium','Garrafas'),(37,'Galão Max Titanium','Galão max',29.90,'img/m-galao.png','Max Titanium','Garrafas'),(38,'Whey Morango Backyardigans','Whey protein concentrado sabor morango',119.90,'img/b-morango.png','Backyardigans','Whey'),(39,'Whey Uva Backyardigans','Whey protein concentrado sabor uva',119.90,'img/b-uva.png','Backyardigans','Whey'),(40,'Whey Blueberry Backyardigans','Whey protein concentrado sabor blueberry',119.90,'img/b-blueberry.png','Backyardigans','Whey'),(41,'Whey Abacaxi Backyardigans','Whey protein concentrado sabor abacaxi',119.90,'img/b-abacaxi.png','Backyardigans','Whey'),(42,'Whey Laranja Backyardigans','Whey protein concentrado sabor laranja',119.90,'img/b-laranja.png','Backyardigans','Whey'),(43,'Pré Treino Morango Backyardigans','Pré treino explosão de energia sabor morango',79.90,'img/b-pre-morango.png','Backyardigans','Pré Treino'),(44,'Pré Treino Blue Ice Backyardigans','Pré treino explosão de energia sabor blue ice',79.90,'img/b-pre-blue.png','Backyardigans','Pré Treino'),(45,'Pré Treino Uva Roxa Backyardigans','Pré treino explosão de energia sabor uva roxa',79.90,'img/b-pre-uva.png','Backyardigans','Pré Treino'),(46,'Creatina Monohidratada Backyardigans','Creatina monohidratada 100% pura sem sabor',89.90,'img/b-creatina.png','Backyardigans','Creatina'),(47,'Creatina em Goma Tutti Frutti','Creatina em goma sabor tutti frutti prática e deliciosa',99.90,'img/b-creatina-goma.png','Backyardigans','Creatina'),(48,'BCAA 2:1:1 Frutas Tropicais','BCAA com leucina, isoleucina e valina sabor frutas tropicais',79.90,'img/b-bcaa.png','Backyardigans','BCAA'),(49,'Camisa Black Pump x Backyardigans','Camisa oficial dry-fit edição limitada',59.90,'img/b-camisa.png','Backyardigans','Vestuário'),(50,'Garrafa Black Pump 700ml','Garrafa resistente com design exclusivo Backyardigans',39.90,'img/b-garrafa.png','Backyardigans','Garrafas'),(51,'Camisa Black Pump Dry Fit','Camisa dry-fit premium confortável para treinos',59.90,'img/bp-camisa.png','Black Pump','Vestuário'),(52,'Garrafa Black Pump 2L','Garrafa resistente 2 litros com marcação e alça reforçada',39.90,'img/bp-garrafa.png','Black Pump','Garrafas'),(53,'Whey Chocolate Integral Médica','Whey protein concentrado sabor chocolate',129.90,'img/i-chocolate.png','Integral','Whey'),(54,'Whey Sorvete de Creme Integral Médica','Whey protein concentrado sabor sorvete de creme',129.90,'img/i-creme.png','Integral','Whey'),(55,'Pré Treino REDCHAOS Integral Médica','Pré treino redchaos integral',109.90,'img/i-pchaos.png','Integral','Pré Treino'),(56,'Pré Treino HUGER Integral Médica','Pré treino huger integral',109.90,'img/i-phuger.png','Integral','Pré Treino'),(57,'Creatina Integral Médica','Creatina integral',89.90,'img/i-creatina.png','Integral','Creatina'),(58,'BCAA Integral Médica','BCAA integral',49.90,'img/i-bcaa.png','Integral','BCAA'),(59,'Camisa Integral Médica','Camisa integral',69.90,'img/i-camisav.png','Integral','Vestuário'),(60,'Garrafa Galão Integral Médica','Galão integral',45.90,'img/i-galao.png','Integral','Garrafas');
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  `endereco` varchar(150) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `estado` varchar(50) NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Luiz','luiz@email.com','$2b$10$E/XJWtfTNyE1MvMUyGNjNuT7kEfX1yXkqho6cHedMM4ADtZb/KHKW','','','','',NULL),(2,'Pietro','pietro@email.com','$2b$10$jALCAkAEZsY2UXtUHwwa7.E9Qof4u4H8M/Hc9uZMvVhlsyA1ShlZa','1240028922','Rua dos Viados 24','São José dos Campos','São Paulo','1776948756929.jpeg'),(3,'Márcia','marcia@email.com','$2b$10$d5Z52T8lkWDLXKsCahRRxeMzYd7dK9mRLgfVpCQLipLUdUvpjjaBK','12996807420','Rua Medina 302','São José dos Campos','São Paulo','1777131750454.jpeg');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-26 16:12:16
