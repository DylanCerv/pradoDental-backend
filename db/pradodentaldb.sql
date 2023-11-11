-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-11-2023 a las 20:28:52
-- Versión del servidor: 10.4.22-MariaDB
-- Versión de PHP: 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pradodentaldb`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dentalhealthanswers`
--

CREATE TABLE `dentalhealthanswers` (
  `dental_answers_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `sangrado_encias` varchar(25) DEFAULT NULL,
  `tratamiento_periodontal` varchar(25) DEFAULT NULL,
  `tratamiento_ortodoncia` varchar(25) DEFAULT NULL,
  `dientes_sensibles` varchar(25) DEFAULT NULL,
  `dientes_flojos` varchar(25) DEFAULT NULL,
  `dolor_oido_o_cuello` varchar(25) DEFAULT NULL,
  `usa_dentadura` varchar(25) DEFAULT NULL,
  `experiencia_dental_desagradable` varchar(25) DEFAULT NULL,
  `descripcion_experiencia_desagradable` varchar(255) DEFAULT NULL,
  `motivo_consulta` varchar(255) DEFAULT NULL,
  `fecha_ultima_consulta` varchar(255) DEFAULT NULL,
  `tratamiento_anterior` varchar(255) DEFAULT NULL,
  `fecha_ultimos_rayos_x` varchar(255) DEFAULT NULL,
  `veces_cepillado_diario` int(11) DEFAULT NULL,
  `usa_hilo_dental` varchar(25) DEFAULT NULL,
  `tecnica_cepillado_hilo_dental_ensenada` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `dentalhealthanswers`
--

INSERT INTO `dentalhealthanswers` (`dental_answers_id`, `user_id`, `sangrado_encias`, `tratamiento_periodontal`, `tratamiento_ortodoncia`, `dientes_sensibles`, `dientes_flojos`, `dolor_oido_o_cuello`, `usa_dentadura`, `experiencia_dental_desagradable`, `descripcion_experiencia_desagradable`, `motivo_consulta`, `fecha_ultima_consulta`, `tratamiento_anterior`, `fecha_ultimos_rayos_x`, `veces_cepillado_diario`, `usa_hilo_dental`, `tecnica_cepillado_hilo_dental_ensenada`) VALUES
(5, 16, 'no', 'si', 'si', 'si', 'no', 'no', 'no', 'no', 'dsadasdsadsad', NULL, '2023-11-08T05:00:00.000Z', NULL, '2023-11-22T05:00:00.000Z', 5, 'no', 'no');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dentistahistorialmedico`
--

CREATE TABLE `dentistahistorialmedico` (
  `dentista_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `comentarios_entrevista` text DEFAULT NULL,
  `hallazgos_entrevista` text DEFAULT NULL,
  `hallazgos_exploracion` text DEFAULT NULL,
  `cuello` text DEFAULT NULL,
  `encias` text DEFAULT NULL,
  `atm` text DEFAULT NULL,
  `fondo_saco` text DEFAULT NULL,
  `labios` text DEFAULT NULL,
  `carrillos` text DEFAULT NULL,
  `comisuras` text DEFAULT NULL,
  `piso_boca` text DEFAULT NULL,
  `paladar` text DEFAULT NULL,
  `lengua` text DEFAULT NULL,
  `consideraciones_manjeo` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `dentistahistorialmedico`
--

INSERT INTO `dentistahistorialmedico` (`dentista_id`, `user_id`, `comentarios_entrevista`, `hallazgos_entrevista`, `hallazgos_exploracion`, `cuello`, `encias`, `atm`, `fondo_saco`, `labios`, `carrillos`, `comisuras`, `piso_boca`, `paladar`, `lengua`, `consideraciones_manjeo`) VALUES
(1, 16, 'no tengo idea', 'no tengo idea', 'no tengo idea', 'no tengo idea', 'adadasda dsad sa depd s', 'no tengo idea', 'no tengo idea', 'no tengo idea', 'no tengo idea', 'no tengo idea', 'no tengo idea', 'no tengo idea', 'no tengo idea', 'no tengo idea');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_medico`
--

CREATE TABLE `historial_medico` (
  `historial_medico_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `anemia` varchar(25) DEFAULT NULL,
  `hemofilia` varchar(25) DEFAULT NULL,
  `artritis` varchar(25) DEFAULT NULL,
  `hepatitis` varchar(25) DEFAULT NULL,
  `artritis_reumatoide` varchar(25) DEFAULT NULL,
  `infecciones_frecuentes` varchar(25) DEFAULT NULL,
  `asma` varchar(25) DEFAULT NULL,
  `tipo_infeccion` varchar(25) DEFAULT NULL,
  `ataque_cerebral` varchar(25) DEFAULT NULL,
  `inmunosupresion` varchar(25) DEFAULT NULL,
  `boca_seca` varchar(25) DEFAULT NULL,
  `lupus_eritematoso` varchar(25) DEFAULT NULL,
  `cancer_quimioterapia_radioterapia` varchar(25) DEFAULT NULL,
  `miccion_excesiva` varchar(25) DEFAULT NULL,
  `desmayos_ataques` varchar(25) DEFAULT NULL,
  `osteoporosis` varchar(25) DEFAULT NULL,
  `desnutricion` varchar(25) DEFAULT NULL,
  `perdida_peso_severa_rapida` varchar(25) DEFAULT NULL,
  `diabetes` varchar(25) DEFAULT NULL,
  `problemas_tiroides` varchar(25) DEFAULT NULL,
  `dolor_cronico` varchar(25) DEFAULT NULL,
  `problemas_rinon` varchar(25) DEFAULT NULL,
  `dolor_pecho_esforzarse` varchar(25) DEFAULT NULL,
  `problemas_respiratorios` varchar(25) DEFAULT NULL,
  `dolores_cabeza_severos_migrana` varchar(25) DEFAULT NULL,
  `reflujo_gastrointestinal` varchar(25) DEFAULT NULL,
  `enfermedad_gastrointestinal` varchar(25) DEFAULT NULL,
  `sangrado_anormal` varchar(25) DEFAULT NULL,
  `enfermedad_transmision_sexual` varchar(25) DEFAULT NULL,
  `sida_infeccion_vi_h` varchar(25) DEFAULT NULL,
  `epilepsia` varchar(25) DEFAULT NULL,
  `sinusitis` varchar(25) DEFAULT NULL,
  `glaucoma` varchar(25) DEFAULT NULL,
  `sudores_nocturnos` varchar(25) DEFAULT NULL,
  `glandulas_cuello_hinchadas_frecuentemente` varchar(25) DEFAULT NULL,
  `transfusion_sangre` varchar(25) DEFAULT NULL,
  `enfermedad_cardiovascular` varchar(25) DEFAULT NULL,
  `fecha_enfermedad_cardiovascular` varchar(255) DEFAULT NULL,
  `trastornos_alimenticios` varchar(25) DEFAULT NULL,
  `trastornos_salud_mental` varchar(25) DEFAULT NULL,
  `trastornos_sueno` varchar(25) DEFAULT NULL,
  `especificacion_sueno` varchar(25) DEFAULT NULL,
  `trastornos_neurologicos` varchar(25) DEFAULT NULL,
  `tuberculosis` varchar(25) DEFAULT NULL,
  `ulceras` varchar(25) DEFAULT NULL,
  `ulceras_boca` varchar(25) DEFAULT NULL,
  `angina_pecho` varchar(25) DEFAULT NULL,
  `arritmias` varchar(25) DEFAULT NULL,
  `arterosclerosis` varchar(25) DEFAULT NULL,
  `ataque_corazon_infarto` varchar(25) DEFAULT NULL,
  `defectos_congenitos` varchar(25) DEFAULT NULL,
  `enfermedad_arterias` varchar(25) DEFAULT NULL,
  `fiebre_reumatica` varchar(25) DEFAULT NULL,
  `marcapasos` varchar(25) DEFAULT NULL,
  `insuficiencia_cardiaca` varchar(25) DEFAULT NULL,
  `presion_alta` varchar(25) DEFAULT NULL,
  `presion_baja` varchar(25) DEFAULT NULL,
  `soplo` varchar(25) DEFAULT NULL,
  `taquicardia` varchar(25) DEFAULT NULL,
  `valvulas_artificiales` varchar(25) DEFAULT NULL,
  `valvulas_danadas` varchar(25) DEFAULT NULL,
  `otra` varchar(25) DEFAULT NULL,
  `otras_enfermedades` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `historial_medico`
--

INSERT INTO `historial_medico` (`historial_medico_id`, `user_id`, `anemia`, `hemofilia`, `artritis`, `hepatitis`, `artritis_reumatoide`, `infecciones_frecuentes`, `asma`, `tipo_infeccion`, `ataque_cerebral`, `inmunosupresion`, `boca_seca`, `lupus_eritematoso`, `cancer_quimioterapia_radioterapia`, `miccion_excesiva`, `desmayos_ataques`, `osteoporosis`, `desnutricion`, `perdida_peso_severa_rapida`, `diabetes`, `problemas_tiroides`, `dolor_cronico`, `problemas_rinon`, `dolor_pecho_esforzarse`, `problemas_respiratorios`, `dolores_cabeza_severos_migrana`, `reflujo_gastrointestinal`, `enfermedad_gastrointestinal`, `sangrado_anormal`, `enfermedad_transmision_sexual`, `sida_infeccion_vi_h`, `epilepsia`, `sinusitis`, `glaucoma`, `sudores_nocturnos`, `glandulas_cuello_hinchadas_frecuentemente`, `transfusion_sangre`, `enfermedad_cardiovascular`, `fecha_enfermedad_cardiovascular`, `trastornos_alimenticios`, `trastornos_salud_mental`, `trastornos_sueno`, `especificacion_sueno`, `trastornos_neurologicos`, `tuberculosis`, `ulceras`, `ulceras_boca`, `angina_pecho`, `arritmias`, `arterosclerosis`, `ataque_corazon_infarto`, `defectos_congenitos`, `enfermedad_arterias`, `fiebre_reumatica`, `marcapasos`, `insuficiencia_cardiaca`, `presion_alta`, `presion_baja`, `soplo`, `taquicardia`, `valvulas_artificiales`, `valvulas_danadas`, `otra`, `otras_enfermedades`) VALUES
(1, 16, 'no', 'no', 'si', 'no', 'si', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', '22/05/2005', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'si', 'si', 'si', 'si', 'si', 'si', 'si', 'si', 'si', 'si', 'si', 'si', 'si', 'si', 'si', 'ninguna', 'no parezco de nada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicalinformation`
--

CREATE TABLE `medicalinformation` (
  `informacion_medica_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `tuberculosis_activa` varchar(25) DEFAULT NULL,
  `tos_persistente` varchar(25) DEFAULT NULL,
  `tos_con_sangre` varchar(25) DEFAULT NULL,
  `toma_bebidas_alcoholicas` varchar(25) DEFAULT NULL,
  `fuma` varchar(25) DEFAULT NULL,
  `usa_drogas` varchar(25) DEFAULT NULL,
  `dependencia_alcohol_drogas` varchar(25) DEFAULT NULL,
  `cambio_salud_ultimos_dos_anios` varchar(25) DEFAULT NULL,
  `bajo_tratamiento_medico` varchar(25) DEFAULT NULL,
  `enfermedad_en_tratamiento` varchar(255) DEFAULT NULL,
  `alergico_medicamento` varchar(25) DEFAULT NULL,
  `alergias_descripcion` varchar(255) DEFAULT NULL,
  `buen_estado_salud_general` varchar(25) DEFAULT NULL,
  `medicamento_reciente` varchar(25) DEFAULT NULL,
  `motivo_medicamento` varchar(255) DEFAULT NULL,
  `recomendacion_antibiotico` varchar(25) DEFAULT NULL,
  `tipo_y_dosis_antibiotico` varchar(255) DEFAULT NULL,
  `hospitalizacion_ultimos_dos_anios` varchar(25) DEFAULT NULL,
  `reemplazo_articulacion` varchar(25) DEFAULT NULL,
  `embarazo` varchar(25) DEFAULT NULL,
  `amamantando` varchar(25) DEFAULT NULL,
  `anticonceptivos_hormonas` varchar(25) DEFAULT NULL,
  `cual_anticonceptivos_hormonas` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `medicalinformation`
--

INSERT INTO `medicalinformation` (`informacion_medica_id`, `user_id`, `tuberculosis_activa`, `tos_persistente`, `tos_con_sangre`, `toma_bebidas_alcoholicas`, `fuma`, `usa_drogas`, `dependencia_alcohol_drogas`, `cambio_salud_ultimos_dos_anios`, `bajo_tratamiento_medico`, `enfermedad_en_tratamiento`, `alergico_medicamento`, `alergias_descripcion`, `buen_estado_salud_general`, `medicamento_reciente`, `motivo_medicamento`, `recomendacion_antibiotico`, `tipo_y_dosis_antibiotico`, `hospitalizacion_ultimos_dos_anios`, `reemplazo_articulacion`, `embarazo`, `amamantando`, `anticonceptivos_hormonas`, `cual_anticonceptivos_hormonas`) VALUES
(3, 16, 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'no', 'enfermedad en tratamiento, descripcion', 'no', 'descripcion alergias', 'no', 'no', 'o motivo', 'no', 'nononoo', 'no', 'no', 'no', 'no', 'no', 'nada de nada\r\n');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parentorguardianofpatient`
--

CREATE TABLE `parentorguardianofpatient` (
  `parent_guardian_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `relationship` varchar(50) DEFAULT NULL,
  `cell_phone` varchar(20) DEFAULT NULL,
  `paternal_last_name` varchar(255) DEFAULT NULL,
  `maternal_last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `postal_code` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `parentorguardianofpatient`
--

INSERT INTO `parentorguardianofpatient` (`parent_guardian_id`, `user_id`, `name`, `age`, `relationship`, `cell_phone`, `paternal_last_name`, `maternal_last_name`, `email`, `address`, `city`, `postal_code`) VALUES
(3, 16, 'W', 85, 'P', '0997237902', 'Esp', 'Ba', 'de@example.cpm', NULL, NULL, '098');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personaldatatable`
--

CREATE TABLE `personaldatatable` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `dental_answers_id` int(11) DEFAULT NULL,
  `informacion_medica_id` int(11) DEFAULT NULL,
  `parent_guardian_id` int(11) DEFAULT NULL,
  `personal_information_id` int(11) DEFAULT NULL,
  `alerta_medica` varchar(250) DEFAULT NULL,
  `condicion` varchar(255) DEFAULT NULL,
  `premedicacion` varchar(255) DEFAULT NULL,
  `alergias` varchar(255) DEFAULT NULL,
  `anestesia` varchar(255) DEFAULT NULL,
  `fecha` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `personaldatatable`
--

INSERT INTO `personaldatatable` (`id`, `user_id`, `dental_answers_id`, `informacion_medica_id`, `parent_guardian_id`, `personal_information_id`, `alerta_medica`, `condicion`, `premedicacion`, `alergias`, `anestesia`, `fecha`) VALUES
(6, 16, NULL, NULL, NULL, NULL, 'nooo', 'pda', 'ada', 'no', 'no', '10/10/2004');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personalinformation`
--

CREATE TABLE `personalinformation` (
  `personal_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `paternal_last_name` varchar(255) DEFAULT NULL,
  `maternal_last_name` varchar(255) DEFAULT NULL,
  `cell_phone` varchar(20) DEFAULT NULL,
  `work_phone` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `date_of_birth` varchar(255) DEFAULT NULL,
  `height_cm` decimal(5,2) DEFAULT NULL,
  `weight_kg` decimal(5,2) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `nationality` varchar(100) DEFAULT NULL,
  `marital_status` varchar(50) DEFAULT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `postal_code` varchar(15) DEFAULT NULL,
  `emergency_contact` varchar(255) DEFAULT NULL,
  `relationship` varchar(50) DEFAULT NULL,
  `emergency_phone` varchar(20) DEFAULT NULL,
  `emergency_medical_service` varchar(255) DEFAULT NULL,
  `insurance` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `personalinformation`
--

INSERT INTO `personalinformation` (`personal_id`, `user_id`, `name`, `paternal_last_name`, `maternal_last_name`, `cell_phone`, `work_phone`, `email`, `age`, `date_of_birth`, `height_cm`, `weight_kg`, `gender`, `nationality`, `marital_status`, `occupation`, `address`, `postal_code`, `emergency_contact`, `relationship`, `emergency_phone`, `emergency_medical_service`, `insurance`) VALUES
(4, 16, 'Dylan', 'España', 'Cervantes', '0997237902', '0997237902', 'dylan@example.com', 19, '2023-11-14T05:00:00.000Z', '170.00', '50.00', 'male', 'ecuatoriano', 'soltero', 'freelancer', 'Voluntad de Dios', '080143565', '0997237902', '', '0997237902', 'sdad', 'dasdasd');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(128) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `role` enum('admin','client') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `name`, `role`) VALUES
(1, 'admin', 'admin', 'Administrador', 'admin'),
(4, 'admin@pradodental.com', '$2b$10$Mv668ZOF9hROXmTN61daRODDNzK8glTQ9L199icSayCosu8WgL9ky', 'prado', 'admin'),
(16, 'dylan@example.com', '$2b$10$ML9gF0X1P9RJzECDGM6UrOivwvAfrFas3Yw9FpnlaDXWYww4Giv76', 'Dylan Españan', 'client');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `dentalhealthanswers`
--
ALTER TABLE `dentalhealthanswers`
  ADD PRIMARY KEY (`dental_answers_id`),
  ADD KEY `fk_user_dentalhealthanswers` (`user_id`);

--
-- Indices de la tabla `dentistahistorialmedico`
--
ALTER TABLE `dentistahistorialmedico`
  ADD PRIMARY KEY (`dentista_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `historial_medico`
--
ALTER TABLE `historial_medico`
  ADD PRIMARY KEY (`historial_medico_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `medicalinformation`
--
ALTER TABLE `medicalinformation`
  ADD PRIMARY KEY (`informacion_medica_id`),
  ADD KEY `medicalinformation_ibfk_1` (`user_id`);

--
-- Indices de la tabla `parentorguardianofpatient`
--
ALTER TABLE `parentorguardianofpatient`
  ADD PRIMARY KEY (`parent_guardian_id`),
  ADD KEY `parentorguardianofpatient_ibfk_1` (`user_id`);

--
-- Indices de la tabla `personaldatatable`
--
ALTER TABLE `personaldatatable`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dental_answers_id` (`dental_answers_id`),
  ADD KEY `informacion_medica_id` (`informacion_medica_id`),
  ADD KEY `parent_guardian_id` (`parent_guardian_id`),
  ADD KEY `personal_information_id` (`personal_information_id`),
  ADD KEY `personaldatatable_ibfk_1` (`user_id`);

--
-- Indices de la tabla `personalinformation`
--
ALTER TABLE `personalinformation`
  ADD PRIMARY KEY (`personal_id`),
  ADD KEY `personalinformation_ibfk_1` (`user_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `dentalhealthanswers`
--
ALTER TABLE `dentalhealthanswers`
  MODIFY `dental_answers_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `dentistahistorialmedico`
--
ALTER TABLE `dentistahistorialmedico`
  MODIFY `dentista_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `historial_medico`
--
ALTER TABLE `historial_medico`
  MODIFY `historial_medico_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `medicalinformation`
--
ALTER TABLE `medicalinformation`
  MODIFY `informacion_medica_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `parentorguardianofpatient`
--
ALTER TABLE `parentorguardianofpatient`
  MODIFY `parent_guardian_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `personaldatatable`
--
ALTER TABLE `personaldatatable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `personalinformation`
--
ALTER TABLE `personalinformation`
  MODIFY `personal_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `dentalhealthanswers`
--
ALTER TABLE `dentalhealthanswers`
  ADD CONSTRAINT `fk_user_dentalhealthanswers` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `dentistahistorialmedico`
--
ALTER TABLE `dentistahistorialmedico`
  ADD CONSTRAINT `dentistahistorialmedico_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `historial_medico`
--
ALTER TABLE `historial_medico`
  ADD CONSTRAINT `historial_medico_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `medicalinformation`
--
ALTER TABLE `medicalinformation`
  ADD CONSTRAINT `medicalinformation_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `parentorguardianofpatient`
--
ALTER TABLE `parentorguardianofpatient`
  ADD CONSTRAINT `parentorguardianofpatient_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `personaldatatable`
--
ALTER TABLE `personaldatatable`
  ADD CONSTRAINT `personaldatatable_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `personaldatatable_ibfk_2` FOREIGN KEY (`dental_answers_id`) REFERENCES `dentalhealthanswers` (`dental_answers_id`),
  ADD CONSTRAINT `personaldatatable_ibfk_3` FOREIGN KEY (`informacion_medica_id`) REFERENCES `medicalinformation` (`informacion_medica_id`),
  ADD CONSTRAINT `personaldatatable_ibfk_4` FOREIGN KEY (`parent_guardian_id`) REFERENCES `parentorguardianofpatient` (`parent_guardian_id`),
  ADD CONSTRAINT `personaldatatable_ibfk_5` FOREIGN KEY (`personal_information_id`) REFERENCES `personalinformation` (`personal_id`);

--
-- Filtros para la tabla `personalinformation`
--
ALTER TABLE `personalinformation`
  ADD CONSTRAINT `personalinformation_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
