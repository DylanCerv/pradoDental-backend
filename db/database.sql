-- Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS pradodentaldb;

-- Usar la base de datos
USE pradodentaldb;

-- Crear la tabla "users" para gestionar a los administradores y clientes
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(45) NOT NULL UNIQUE,
    password VARCHAR(128) NOT NULL,  -- Recomendado usar algoritmo de hash para almacenar contraseñas
    name VARCHAR(45),
    role ENUM('admin', 'client') NOT NULL
);

-- Insertar el administrador predeterminado
INSERT INTO users (username, password, name, role) VALUES ('admin', 'admin', 'Administrador', 'admin');