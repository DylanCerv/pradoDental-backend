import express from 'express';
import jwt from 'jsonwebtoken';
import bcrypt from 'bcrypt';
import { pool } from '../database.js';
import isAdmin from '../middlewares/authMiddleware.js';

const cartaConsentimientoController = express.Router();

// Endpoint para obtener
cartaConsentimientoController.get('/consentimiento/:id', async (req, res) => {
  const userID = req.params.id;

  try {
    let [rows] = await pool.query(`SELECT * FROM carta_de_consentimiento WHERE user_id = ?`, [userID]);
    rows[0].direccion = JSON.parse(rows[0].direccion)
    res.json(rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error en el servidor' });
  }
});

// Endpoint para actualizar
cartaConsentimientoController.put('/consentimiento/:id', isAdmin, async (req, res) => {
  const userID = req.params.id;
  const newData = req.body;

  try {
      // Crear un objeto para almacenar las columnas actualizadas
      const updateData = {};
      
      // Filtrar solo las columnas no nulas y no vacías
      for (const key in newData) {
        if (newData[key] !== null && newData[key] !== undefined && newData[key] !== "") {
          // Si la columna es 'direccion' y no es nula ni vacía, convertir el objeto a una cadena JSON
          if (key === 'direccion' && typeof newData[key] === 'object' && Object.keys(newData[key]).length > 0) {
            updateData[key] = JSON.stringify(newData[key]);
          } else {
            updateData[key] = newData[key];
          }
        }
      }
      
      // Verificar si hay alguna columna para actualizar
      if (Object.keys(updateData).length === 0) {
        return res.status(400).json({ error: 'No hay datos válidos para actualizar.' });
      }

      await pool.query('START TRANSACTION');
      await pool.query('UPDATE carta_de_consentimiento SET ? WHERE user_id = ?', [updateData, userID]);
      await pool.query('COMMIT');

      // Devolver la respuesta exitosa
      res.status(201).json({ message: 'Actualización exitosa.' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error en el servidor' });
    }
});


export default cartaConsentimientoController;
