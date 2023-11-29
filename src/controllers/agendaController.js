import express from 'express';
import jwt from 'jsonwebtoken';
import bcrypt from 'bcrypt';
import { pool } from '../database.js';
import isAdmin from '../middlewares/authMiddleware.js';

const agendaController = express.Router();

// Endpoint para obtener todas las agendas
agendaController.get('/agenda/all', isAdmin, async (req, res) => {
  try {
    const [rows] = await pool.query(`
      SELECT
        appointments.title,
        appointments.user_id,
        DATE_FORMAT(appointments.start, '%a %b %e %Y %H:%i:%s GMT-0500 (hora de Ecuador)') AS start,
        DATE_FORMAT(appointments.end, '%a %b %e %Y %H:%i:%s GMT-0500 (hora de Ecuador)') AS end,
        users.username AS user_username,
        users.name AS user_name
      FROM appointments
      INNER JOIN users ON appointments.user_id = users.id
    `);
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error en el servidor' });
  }
});

// Endpoint para agenda byId
agendaController.get('/agenda/user/:id', async (req, res) => {
  const {id} = req.params;
  try {
    // Realiza una consulta a la base de datos para obtener usuarios con el rol 'Client'
    // const [rows] = await pool.query('SELECT * FROM appointments');
    const [rows] = await pool.query('SELECT * FROM appointments WHERE user_id = ?', [id]);
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error en el servidor' });
  }
});

// Endpoint para guardar las agendas
agendaController.post('/agenda', isAdmin, async (req, res) => {
    try {
        const { title, user_id, start, end } = req.body;
        console.log({start, end})

        // const formattedStart = new Date(start).toISOString();
        // const formattedEnd = new Date(end).toISOString();

        // Validar que se hayan proporcionado title, start y end
        if (!title || !user_id || !start || !end) {
            return res.status(400).json({ error: 'Se requieren title, user_id, start y end para guardar la cita.' });
        }

        // Aquí podrías realizar alguna validación adicional si es necesario

        // Realizar la inserción en la base de datos
        const result = await pool.query('INSERT INTO appointments (title, user_id, start, end) VALUES (?, ?, ?, ?)', [title, user_id, start, end]);

        // Devolver la respuesta exitosa
        res.status(201).json({ message: 'Cita guardada exitosamente.', insertedId: result.insertId });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error en el servidor' });
    }
});


export default agendaController;
