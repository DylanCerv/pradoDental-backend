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

// Endpoint para obtener los datos personales de un usuario por su ID
userController.get('/users/:id/personal-information', isAdmin, async (req, res) => {
  const userId = req.params.id;
  try {
    
    // Define la estructura de datos para las tablas y campos relacionados.
    const tablesAndFields = [
      { table: 'personaldatatable', alias: 'personaldatatable' },
      { table: 'dentalhealthanswers', alias: 'dentalhealthanswers' },
      { table: 'medicalinformation', alias: 'medicalinformation' },
      { table: 'parentorguardianofpatient', alias: 'parentorguardianofpatient' },
      { table: 'personalinformation', alias: 'personalinformation' },
    ];

    const formattedData = {};

    // Realiza una consulta para cada tabla y almacena los resultados en formattedData.
    for (const { table, alias } of tablesAndFields) {
      const [relatedData] = await pool.query(`
        SELECT ${alias}.*
        FROM users
        LEFT JOIN ${table} ON users.id = ${alias}.user_id
        WHERE users.id = ?
      `, [userId]);

      formattedData[alias] = relatedData[0] || null;
    }

    if (Object.values(formattedData).every(data => data === null)) {
      return res.status(404).json({ error: 'Usuario no encontrado' });
    }

    res.json(formattedData);
    
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error en el servidor' });
  }
});

userController.put('/users/:id/personal-information', isAdmin, async (req, res) => {
  const userId = req.params.id;
  const newData = req.body;

  try {
    await pool.query('START TRANSACTION');

    // Recorre cada tabla en el objeto newData y actualiza los campos correspondientes
    for (const [tableName, tableData] of Object.entries(newData)) {
      const updateFields = Object.keys(tableData).map(field => `${field} = ?`).join(', ');
      const updateValues = Object.values(tableData);

      // Actualiza la tabla actual con los campos y valores proporcionados
      await pool.query(`UPDATE ${tableName} SET ${updateFields} WHERE user_id = ?`, [...updateValues, userId]);
    }

    await pool.query('COMMIT');

    res.json({
      message: "Successfully updated"
    });

  } catch (error) {
    await pool.query('ROLLBACK');
    console.error(error);
    res.status(500).json({ error: 'Error en el servidor' });
  }
});


// Endpoint para obtener el historial medico de un usuario por su ID
userController.get('/users/:id/historial-medico', isAdmin, async (req, res) => {
  const userId = req.params.id;
  try {
    
    // Obtener datos del historial médico
    const [historialMedicoData] = await pool.query('SELECT * FROM historial_medico WHERE user_id = ?', [userId]);

    // Obtener datos del dentista
    const [dentistaData] = await pool.query('SELECT * FROM dentistahistorialmedico WHERE user_id = ?', [userId]);

    // Combina los datos en un objeto antes de enviar la respuesta
    const historialData = {
      historial_medico: historialMedicoData[0] || {},
      dentistahistorialmedico: dentistaData[0] || {},
    };

    res.json(historialData);
    
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error en el servidor' });
  }
});

userController.put('/users/:id/historial-medico', isAdmin, async (req, res) => {
  const userId = req.params.id;
  const newData = req.body;

  try {
    
    await pool.query('START TRANSACTION');

    // Actualizar datos del historial médico
    await pool.query('UPDATE historial_medico SET ? WHERE user_id = ?', [newData.historial_medico, userId]);

    // Actualizar datos del dentista
    await pool.query('UPDATE dentistahistorialmedico SET ? WHERE user_id = ?', [newData.dentistahistorialmedico, userId]);

    await pool.query('COMMIT');

    res.json({
      message: "Successfully updated"
    });

  } catch (error) {
    await pool.query('ROLLBACK');
    console.error(error);
    res.status(500).json({ error: 'Error en el servidor' });
  }
});

export default userController;