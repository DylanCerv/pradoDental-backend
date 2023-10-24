import express from 'express';
import jwt from 'jsonwebtoken';
import bcrypt from 'bcrypt';
import { pool } from '../database.js';
import isAdmin from '../middlewares/authMiddleware.js';

const userController = express.Router();

// Endpoint para obtener todos los usuarios con el rol 'Client'
userController.get('/clients/all', isAdmin, async (req, res) => {
  try {
    // Realiza una consulta a la base de datos para obtener usuarios con el rol 'Client'
    const [rows] = await pool.query('SELECT id, username, name FROM users WHERE role = ?', ['client']);
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error en el servidor' });
  }
});

// Endpoint para eliminar un usuario por su ID
userController.delete('/users/:id', isAdmin, async (req, res) => {
  const userId = req.params.id;
  try {
    // Realiza una consulta para eliminar el usuario con el ID proporcionado
    const [result] = await pool.query('DELETE FROM users WHERE id = ?', [userId]);
    if (result.affectedRows > 0) {
      res.json({ message: 'Usuario eliminado con éxito' });
    } else {
      res.status(404).json({ error: 'Usuario no encontrado' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error en el servidor' });
  }
});

export default userController;