-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: pradodentaldb
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `start` varchar(255) NOT NULL,
  `end` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_id` (`user_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `carta_de_consentimiento`
--

DROP TABLE IF EXISTS `carta_de_consentimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carta_de_consentimiento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `estomatologo` varchar(255) DEFAULT NULL,
  `direccion` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `descripcion_intervencion` text,
  `objetivos_perseguidos` text,
  `molestias_riesgos` text,
  `beneficios_esperados` text,
  `alternativas_factibles` text,
  `curso_espontaneo_padecimiento` text,
  `opiniones_recomendaciones_estomatologo` text,
  `declaracion_paciente` text,
  `aceptacion_paciente` text,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `carta_de_consentimiento_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `carta_de_consentimiento_chk_1` CHECK (json_valid(`direccion`))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dental_diagnosticogeneral`
--

DROP TABLE IF EXISTS `dental_diagnosticogeneral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dental_diagnosticogeneral` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `dental_diagnosticogeneral_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dental_dientes`
--

DROP TABLE IF EXISTS `dental_dientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dental_dientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero` int DEFAULT NULL,
  `diagnostico` varchar(255) DEFAULT NULL,
  `presupuesto` decimal(10,2) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `tratamiento` varchar(255) DEFAULT NULL,
  `abono` decimal(10,2) DEFAULT NULL,
  `posicion` varchar(255) DEFAULT NULL,
  `id_diagnostico_general` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_diagnostico_general` (`id_diagnostico_general`),
  CONSTRAINT `dental_dientes_ibfk_1` FOREIGN KEY (`id_diagnostico_general`) REFERENCES `dental_diagnosticogeneral` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=577 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dental_tratamientoadicional`
--

DROP TABLE IF EXISTS `dental_tratamientoadicional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dental_tratamientoadicional` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quirurgico` varchar(255) DEFAULT NULL,
  `periodental` varchar(255) DEFAULT NULL,
  `ortodontico` varchar(255) DEFAULT NULL,
  `otro` varchar(255) DEFAULT NULL,
  `quirurgico_presupuesto` decimal(10,2) DEFAULT NULL,
  `periodental_presupuesto` decimal(10,2) DEFAULT NULL,
  `ortodontico_presupuesto` decimal(10,2) DEFAULT NULL,
  `otro_presupuesto` decimal(10,2) DEFAULT NULL,
  `id_diagnostico_general` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_diagnostico_general` (`id_diagnostico_general`),
  CONSTRAINT `dental_tratamientoadicional_ibfk_1` FOREIGN KEY (`id_diagnostico_general`) REFERENCES `dental_diagnosticogeneral` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dentalhealthanswers`
--

DROP TABLE IF EXISTS `dentalhealthanswers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dentalhealthanswers` (
  `dental_answers_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `sangrado_encias` varchar(255) DEFAULT NULL,
  `tratamiento_periodontal` varchar(255) DEFAULT NULL,
  `tratamiento_ortodoncia` varchar(255) DEFAULT NULL,
  `dientes_sensibles` varchar(255) DEFAULT NULL,
  `dientes_flojos` varchar(255) DEFAULT NULL,
  `dolor_oido_o_cuello` varchar(255) DEFAULT NULL,
  `usa_dentadura` varchar(255) DEFAULT NULL,
  `experiencia_dental_desagradable` varchar(255) DEFAULT NULL,
  `descripcion_experiencia_desagradable` varchar(255) DEFAULT NULL,
  `motivo_consulta` varchar(255) DEFAULT NULL,
  `fecha_ultima_consulta` varchar(255) DEFAULT NULL,
  `tratamiento_anterior` varchar(255) DEFAULT NULL,
  `fecha_ultimos_rayos_x` varchar(255) DEFAULT NULL,
  `veces_cepillado_diario` int DEFAULT NULL,
  `usa_hilo_dental` varchar(255) DEFAULT NULL,
  `tecnica_cepillado_hilo_dental_ensenada` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`dental_answers_id`),
  KEY `fk_user_dentalhealthanswers` (`user_id`),
  CONSTRAINT `fk_user_dentalhealthanswers` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dentistahistorialmedico`
--

DROP TABLE IF EXISTS `dentistahistorialmedico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dentistahistorialmedico` (
  `dentista_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `comentarios_entrevista` text,
  `hallazgos_entrevista` text,
  `hallazgos_exploracion` text,
  `cuello` text,
  `encias` text,
  `atm` text,
  `fondo_saco` text,
  `labios` text,
  `carrillos` text,
  `comisuras` text,
  `piso_boca` text,
  `paladar` text,
  `lengua` text,
  `consideraciones_manjeo` text,
  PRIMARY KEY (`dentista_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `dentistahistorialmedico_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `files` (
  `id` int NOT NULL AUTO_INCREMENT,
  `path` text NOT NULL,
  `category` varchar(255) NOT NULL,
  `user_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `historial_medico`
--

DROP TABLE IF EXISTS `historial_medico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historial_medico` (
  `historial_medico_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `anemia` varchar(255) DEFAULT NULL,
  `hemofilia` varchar(255) DEFAULT NULL,
  `artritis` varchar(255) DEFAULT NULL,
  `hepatitis` varchar(255) DEFAULT NULL,
  `artritis_reumatoide` varchar(255) DEFAULT NULL,
  `infecciones_frecuentes` varchar(255) DEFAULT NULL,
  `asma` varchar(255) DEFAULT NULL,
  `tipo_infeccion` varchar(255) DEFAULT NULL,
  `ataque_cerebral` varchar(255) DEFAULT NULL,
  `inmunosupresion` varchar(255) DEFAULT NULL,
  `boca_seca` varchar(255) DEFAULT NULL,
  `lupus_eritematoso` varchar(255) DEFAULT NULL,
  `cancer_quimioterapia_radioterapia` varchar(255) DEFAULT NULL,
  `miccion_excesiva` varchar(255) DEFAULT NULL,
  `desmayos_ataques` varchar(255) DEFAULT NULL,
  `osteoporosis` varchar(255) DEFAULT NULL,
  `desnutricion` varchar(255) DEFAULT NULL,
  `perdida_peso_severa_rapida` varchar(255) DEFAULT NULL,
  `diabetes` varchar(255) DEFAULT NULL,
  `problemas_tiroides` varchar(255) DEFAULT NULL,
  `dolor_cronico` varchar(255) DEFAULT NULL,
  `problemas_rinon` varchar(255) DEFAULT NULL,
  `dolor_pecho_esforzarse` varchar(255) DEFAULT NULL,
  `problemas_respiratorios` varchar(255) DEFAULT NULL,
  `dolores_cabeza_severos_migrana` varchar(255) DEFAULT NULL,
  `reflujo_gastrointestinal` varchar(255) DEFAULT NULL,
  `enfermedad_gastrointestinal` varchar(255) DEFAULT NULL,
  `sangrado_anormal` varchar(255) DEFAULT NULL,
  `enfermedad_transmision_sexual` varchar(255) DEFAULT NULL,
  `sida_infeccion_vi_h` varchar(255) DEFAULT NULL,
  `epilepsia` varchar(255) DEFAULT NULL,
  `sinusitis` varchar(255) DEFAULT NULL,
  `glaucoma` varchar(255) DEFAULT NULL,
  `sudores_nocturnos` varchar(255) DEFAULT NULL,
  `glandulas_cuello_hinchadas_frecuentemente` varchar(255) DEFAULT NULL,
  `transfusion_sangre` varchar(255) DEFAULT NULL,
  `enfermedad_cardiovascular` varchar(255) DEFAULT NULL,
  `fecha_enfermedad_cardiovascular` varchar(255) DEFAULT NULL,
  `trastornos_alimenticios` varchar(255) DEFAULT NULL,
  `trastornos_salud_mental` varchar(255) DEFAULT NULL,
  `trastornos_sueno` varchar(255) DEFAULT NULL,
  `especificacion_sueno` varchar(255) DEFAULT NULL,
  `trastornos_neurologicos` varchar(255) DEFAULT NULL,
  `tuberculosis` varchar(255) DEFAULT NULL,
  `ulceras` varchar(255) DEFAULT NULL,
  `ulceras_boca` varchar(255) DEFAULT NULL,
  `angina_pecho` varchar(255) DEFAULT NULL,
  `arritmias` varchar(255) DEFAULT NULL,
  `arterosclerosis` varchar(255) DEFAULT NULL,
  `ataque_corazon_infarto` varchar(255) DEFAULT NULL,
  `defectos_congenitos` varchar(255) DEFAULT NULL,
  `enfermedad_arterias` varchar(255) DEFAULT NULL,
  `fiebre_reumatica` varchar(255) DEFAULT NULL,
  `marcapasos` varchar(255) DEFAULT NULL,
  `insuficiencia_cardiaca` varchar(255) DEFAULT NULL,
  `presion_alta` varchar(255) DEFAULT NULL,
  `presion_baja` varchar(255) DEFAULT NULL,
  `soplo` varchar(255) DEFAULT NULL,
  `taquicardia` varchar(255) DEFAULT NULL,
  `valvulas_artificiales` varchar(255) DEFAULT NULL,
  `valvulas_danadas` varchar(255) DEFAULT NULL,
  `otra` varchar(255) DEFAULT NULL,
  `otras_enfermedades` text,
  PRIMARY KEY (`historial_medico_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `historial_medico_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `medicalinformation`
--

DROP TABLE IF EXISTS `medicalinformation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicalinformation` (
  `informacion_medica_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `tuberculosis_activa` varchar(255) DEFAULT NULL,
  `tos_persistente` varchar(255) DEFAULT NULL,
  `tos_con_sangre` varchar(255) DEFAULT NULL,
  `toma_bebidas_alcoholicas` varchar(255) DEFAULT NULL,
  `fuma` varchar(255) DEFAULT NULL,
  `usa_drogas` varchar(255) DEFAULT NULL,
  `dependencia_alcohol_drogas` varchar(255) DEFAULT NULL,
  `cambio_salud_ultimos_dos_anios` varchar(255) DEFAULT NULL,
  `bajo_tratamiento_medico` varchar(255) DEFAULT NULL,
  `enfermedad_en_tratamiento` varchar(255) DEFAULT NULL,
  `alergico_medicamento` varchar(255) DEFAULT NULL,
  `alergias_descripcion` varchar(255) DEFAULT NULL,
  `buen_estado_salud_general` varchar(255) DEFAULT NULL,
  `medicamento_reciente` varchar(255) DEFAULT NULL,
  `motivo_medicamento` varchar(255) DEFAULT NULL,
  `recomendacion_antibiotico` varchar(255) DEFAULT NULL,
  `tipo_y_dosis_antibiotico` varchar(255) DEFAULT NULL,
  `hospitalizacion_ultimos_dos_anios` varchar(255) DEFAULT NULL,
  `reemplazo_articulacion` varchar(255) DEFAULT NULL,
  `embarazo` varchar(255) DEFAULT NULL,
  `amamantando` varchar(255) DEFAULT NULL,
  `anticonceptivos_hormonas` varchar(255) DEFAULT NULL,
  `cual_anticonceptivos_hormonas` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`informacion_medica_id`),
  KEY `medicalinformation_ibfk_1` (`user_id`),
  CONSTRAINT `medicalinformation_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `parentorguardianofpatient`
--

DROP TABLE IF EXISTS `parentorguardianofpatient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parentorguardianofpatient` (
  `parent_guardian_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `relationship` varchar(255) DEFAULT NULL,
  `cell_phone` varchar(255) DEFAULT NULL,
  `paternal_last_name` varchar(255) DEFAULT NULL,
  `maternal_last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`parent_guardian_id`),
  KEY `parentorguardianofpatient_ibfk_1` (`user_id`),
  CONSTRAINT `parentorguardianofpatient_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `personaldatatable`
--

DROP TABLE IF EXISTS `personaldatatable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personaldatatable` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `dental_answers_id` int DEFAULT NULL,
  `informacion_medica_id` int DEFAULT NULL,
  `parent_guardian_id` int DEFAULT NULL,
  `personal_information_id` int DEFAULT NULL,
  `alerta_medica` varchar(255) DEFAULT NULL,
  `condicion` varchar(255) DEFAULT NULL,
  `premedicacion` varchar(255) DEFAULT NULL,
  `alergias` varchar(255) DEFAULT NULL,
  `anestesia` varchar(255) DEFAULT NULL,
  `fecha` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dental_answers_id` (`dental_answers_id`),
  KEY `informacion_medica_id` (`informacion_medica_id`),
  KEY `parent_guardian_id` (`parent_guardian_id`),
  KEY `personal_information_id` (`personal_information_id`),
  KEY `personaldatatable_ibfk_1` (`user_id`),
  CONSTRAINT `personaldatatable_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `personaldatatable_ibfk_2` FOREIGN KEY (`dental_answers_id`) REFERENCES `dentalhealthanswers` (`dental_answers_id`),
  CONSTRAINT `personaldatatable_ibfk_3` FOREIGN KEY (`informacion_medica_id`) REFERENCES `medicalinformation` (`informacion_medica_id`),
  CONSTRAINT `personaldatatable_ibfk_4` FOREIGN KEY (`parent_guardian_id`) REFERENCES `parentorguardianofpatient` (`parent_guardian_id`),
  CONSTRAINT `personaldatatable_ibfk_5` FOREIGN KEY (`personal_information_id`) REFERENCES `personalinformation` (`personal_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `personalinformation`
--

DROP TABLE IF EXISTS `personalinformation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personalinformation` (
  `personal_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `paternal_last_name` varchar(255) DEFAULT NULL,
  `maternal_last_name` varchar(255) DEFAULT NULL,
  `cell_phone` varchar(255) DEFAULT NULL,
  `work_phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `date_of_birth` varchar(255) DEFAULT NULL,
  `height_cm` decimal(5,2) DEFAULT NULL,
  `weight_kg` decimal(5,2) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `nationality` varchar(255) DEFAULT NULL,
  `marital_status` varchar(255) DEFAULT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `emergency_contact` varchar(255) DEFAULT NULL,
  `relationship` varchar(255) DEFAULT NULL,
  `emergency_phone` varchar(255) DEFAULT NULL,
  `emergency_medical_service` varchar(255) DEFAULT NULL,
  `insurance` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`personal_id`),
  KEY `personalinformation_ibfk_1` (`user_id`),
  CONSTRAINT `personalinformation_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tratamiento_endodoncia`
--

DROP TABLE IF EXISTS `tratamiento_endodoncia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tratamiento_endodoncia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `fecha` date DEFAULT NULL,
  `procedimiento` varchar(255) DEFAULT NULL,
  `conducto` varchar(255) DEFAULT NULL,
  `conducto_tentativa` varchar(255) DEFAULT NULL,
  `conducto_definitiva` varchar(255) DEFAULT NULL,
  `referencia` varchar(255) DEFAULT NULL,
  `ultima_lima_apical` varchar(255) DEFAULT NULL,
  `notas` text,
  `abono` decimal(10,2) DEFAULT NULL,
  `balance` decimal(10,2) DEFAULT NULL,
  `tratamiento_endodoncia_tabla_unida_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tratamiento_endodoncia_user` (`user_id`),
  KEY `fk_tratamiento_endodoncia_tabla_unida` (`tratamiento_endodoncia_tabla_unida_id`),
  CONSTRAINT `fk_tratamiento_endodoncia_tabla_unida` FOREIGN KEY (`tratamiento_endodoncia_tabla_unida_id`) REFERENCES `tratamiento_endodoncia_tabla_unida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tratamiento_endodoncia_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tratamiento_endodoncia_datos_del_examen`
--

DROP TABLE IF EXISTS `tratamiento_endodoncia_datos_del_examen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tratamiento_endodoncia_datos_del_examen` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `column_option` enum('si','no') DEFAULT NULL,
  `column_last` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `tratamiento_endodoncia_datos_del_examen_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=239 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tratamiento_endodoncia_diagnostico`
--

DROP TABLE IF EXISTS `tratamiento_endodoncia_diagnostico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tratamiento_endodoncia_diagnostico` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `diagnostico_pulpar_presuncion` varchar(255) DEFAULT NULL,
  `diagnostico_periapical` varchar(255) DEFAULT NULL,
  `diagnostico_definitivo` varchar(255) DEFAULT NULL,
  `tratamiento_indicado` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tratamiento_endodoncia_diagnostico_user` (`user_id`),
  CONSTRAINT `fk_tratamiento_endodoncia_diagnostico_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tratamiento_endodoncia_general`
--

DROP TABLE IF EXISTS `tratamiento_endodoncia_general`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tratamiento_endodoncia_general` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `consentimiento_firmado` varchar(255) DEFAULT NULL,
  `doctor` varchar(255) DEFAULT NULL,
  `paciente` varchar(255) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tratamiento_endodoncia_general_user` (`user_id`),
  CONSTRAINT `fk_tratamiento_endodoncia_general_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tratamiento_endodoncia_tabla_unida`
--

DROP TABLE IF EXISTS `tratamiento_endodoncia_tabla_unida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tratamiento_endodoncia_tabla_unida` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `vital` varchar(255) DEFAULT NULL,
  `necrotico` varchar(255) DEFAULT NULL,
  `costo` int DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_obturacion` date DEFAULT NULL,
  `diente` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tratamiento_endodoncia_tabla_unida_ibfk_1` (`user_id`),
  CONSTRAINT `tratamiento_endodoncia_tabla_unida_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `role` enum('admin','client') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-02 14:52:13
