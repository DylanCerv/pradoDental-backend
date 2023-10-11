-- Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS pradodentaldb;

-- Usar la base de datos
USE pradodentaldb;

-- Crear la tabla "admin" con columnas para el inicio de sesión
CREATE TABLE IF NOT EXISTS admin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(45) NOT NULL UNIQUE,
    password VARCHAR(128) NOT NULL,  -- Recomendado usar algoritmo de hash para almacenar contraseñas
    name VARCHAR(45),
);