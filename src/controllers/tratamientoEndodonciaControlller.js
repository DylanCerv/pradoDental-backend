import express from 'express';
import jwt from 'jsonwebtoken';
import bcrypt from 'bcrypt';
import { pool } from '../database.js';
import isAdmin from '../middlewares/authMiddleware.js';
import { TABLES_TRATAMIENTO_ENDODONCIA } from '../data/tables.js';

const tratamientoEndodonciaControlller = express.Router();

// Endpoint para obtener
tratamientoEndodonciaControlller.get('/tratamiento/endodoncia/:id', async (req, res) => {
  const userID = req.params.id;

  try {
    const result = {};

    // Realiza una consulta para cada tabla y almacena los resultados en el objeto 'result'
    for (const table of TABLES_TRATAMIENTO_ENDODONCIA) {
      const [rows] = await pool.query(`SELECT * FROM ${table} WHERE user_id = ?`, [userID]);
      result[table] = rows[0];
    }
    
    const [rows_tratamiento_endodoncia_datos_del_examen] = await pool.query(`SELECT * FROM tratamiento_endodoncia_datos_del_examen WHERE user_id = ?`, [userID]);
    const [rows_tratamiento_endodoncia] = await pool.query(`SELECT * FROM tratamiento_endodoncia WHERE user_id = ?`, [userID]);
    result.tratamiento_endodoncia_datos_del_examen = rows_tratamiento_endodoncia_datos_del_examen;
    result.tratamiento_endodoncia = rows_tratamiento_endodoncia;
    console.log(result)

    res.json(result);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error en el servidor' });
  }
});

tratamientoEndodonciaControlller.put('/tratamiento/endodoncia/:id', async (req, res) => {
  const { id: userId } = req.params;
  const newData = req.body;
  // console.log(newData)

  try {

    await pool.query('START TRANSACTION');

    // Recorre cada tabla en el objeto newData y actualiza los campos correspondientes
    for (const [tableName, tableData] of Object.entries(newData)) {
      if (tableName === "tratamiento_endodoncia_datos_del_examen" || tableName === "tratamiento_endodoncia") {
        for (const element of tableData) {
          const { id, ...updateValues } = element;
          await pool.query(`UPDATE ${tableName} SET ? WHERE id = ?`, [updateValues, id]);
          // console.log(element)
        }
        continue;
      }
      const updateFields = Object.keys(tableData).map(field => `${field} = ?`).join(', ');
      const updateValues = Object.values(tableData);
      // Actualiza la tabla actual con los campos y valores proporcionados
      await pool.query(`UPDATE ${tableName} SET ${updateFields} WHERE user_id = ?`, [...updateValues, userId]);
    }
    
    await pool.query('COMMIT');

    res.json({ message: 'Datos actualizados con éxito' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error en el servidor' });
  }
});

// Endpoint para crear elemento individual del tratamiendo de endodoncia
tratamientoEndodonciaControlller.post('/tratamiento/endodoncia/element/:user_id/:tratamiento_id', isAdmin, async (req, res) => {
  const {user_id, tratamiento_id} = req.params;
  const newData = req.body;

  try {
      newData.user_id = user_id;
      newData.tratamiento_endodoncia_tabla_unida_id = tratamiento_id;

      const [result] = await pool.query('INSERT INTO tratamiento_endodoncia SET ?', [newData]);
      // Devolver la respuesta exitosa
      res.status(201).json({ message: 'Elemento creado exitosamente.' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error en el servidor' });
    }
});

tratamientoEndodonciaControlller.delete('/tratamiento/endodoncia/element/:user_id/:element_id', isAdmin, async (req, res) => {
  const {user_id, element_id} = req.params;

  try {
    // Utiliza la instrucción DELETE para eliminar un registro específico
    const [result] = await pool.query('DELETE FROM tratamiento_endodoncia WHERE id = ? AND user_id = ?', [element_id, user_id]);

    // Verifica si se eliminó algún registro
    if (result.affectedRows > 0) {
      res.status(200).json({ message: 'Elemento eliminado exitosamente.' });
    } else {
      res.status(404).json({ error: 'Elemento no encontrado.' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error en el servidor' });
  }
});




export default tratamientoEndodonciaControlller;
