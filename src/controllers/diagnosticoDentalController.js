import express from 'express';
import jwt from 'jsonwebtoken';
import bcrypt from 'bcrypt';
import { pool } from '../database.js';
import isAdmin from '../middlewares/authMiddleware.js';

const diagnosticoDentalController = express.Router();

// Endpoint 
diagnosticoDentalController.get('/diagnostico-dental/byId/:id', async (req, res) => {
  const {id} = req.params;
  try {
    const [dental_diagnosticogeneral] = await pool.query(`SELECT * FROM dental_diagnosticogeneral WHERE user_id = ?`, [id]);
    const [dental_dientes] = await pool.query(`SELECT * FROM dental_dientes WHERE id_diagnostico_general = ?`, [dental_diagnosticogeneral[0].id]);
    const [dental_tratamientoadicional] = await pool.query(`SELECT * FROM dental_tratamientoadicional WHERE id_diagnostico_general = ?`, [dental_diagnosticogeneral[0].id]);

    res.json({
      dental_diagnosticogeneral: dental_diagnosticogeneral[0],
      dental_dientes,
      dental_tratamientoadicional
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error en el servidor' });
  }
});


diagnosticoDentalController.put('/diagnostico-dental/byId/:id', isAdmin, async (req, res) => {
  const { id } = req.params;
  const data = req.body;

  try {
    // Actualizar la tabla dental_diagnosticogeneral
    const [result] = await pool.query(`SELECT id FROM dental_diagnosticogeneral WHERE user_id = ?`, [id]);
    const id_diagnostico_general = result[0].id
    // console.log(id_diagnostico_general)
    if (data.diagnosticoGeneral.fecha != null && data.diagnosticoGeneral.fecha !== "") {
      await pool.query(`UPDATE dental_diagnosticogeneral SET fecha = ? WHERE user_id = ?`, [data.diagnosticoGeneral.fecha, id]);
    }

    // Actualizar la tabla dental_dientes
    for (const numero in data.dientes) {
      const dienteData = data.dientes[numero];
      const updateValues = [
        dienteData.diagnostico || null,
        dienteData.presupuesto || null,
        dienteData.fecha || null,
        dienteData.tratamiento || null,
        dienteData.abono || null,
        id_diagnostico_general,
        numero,
      ];

      await pool.query(`UPDATE dental_dientes SET diagnostico = IFNULL(?, diagnostico), presupuesto = IFNULL(?, presupuesto), fecha = IFNULL(?, fecha), tratamiento = IFNULL(?, tratamiento), abono = IFNULL(?, abono) WHERE id_diagnostico_general = ? AND numero = ?`, updateValues);
    }

    // Actualizar la tabla dental_tratamientoadicional
    const tratamientoAdicionalValues = [
      data.tratamientoAdicional.quirurgico || null,
      data.tratamientoAdicional.quirurgico_presupuesto || null,
      data.tratamientoAdicional.periodental || null,
      data.tratamientoAdicional.periodental_presupuesto || null,
      data.tratamientoAdicional.ortodontico || null,
      data.tratamientoAdicional.ortodontico_presupuesto || null,
      data.tratamientoAdicional.otro || null,
      data.tratamientoAdicional.otro_presupuesto || null,
      id_diagnostico_general,
    ];

    await pool.query(`UPDATE dental_tratamientoadicional SET quirurgico = IFNULL(?, quirurgico), quirurgico_presupuesto = IFNULL(?, quirurgico_presupuesto), periodental = IFNULL(?, periodental), periodental_presupuesto = IFNULL(?, periodental_presupuesto), ortodontico = IFNULL(?, ortodontico), ortodontico_presupuesto = IFNULL(?, ortodontico_presupuesto), otro = IFNULL(?, otro), otro_presupuesto = IFNULL(?, otro_presupuesto) WHERE id_diagnostico_general = ?`, tratamientoAdicionalValues);

    res.json({ message: 'Datos actualizados con éxito' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error en el servidor' });
  }
});


export default diagnosticoDentalController;
