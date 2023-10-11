import express from 'express';
import jwt from 'jsonwebtoken';
import bcrypt from 'bcrypt';
import { pool } from '../database.js';

const router = express.Router();

router.post('/register', async (req, res) => {
  try {
    const { email, password } = req.body;
    const username=email;
    // Hash de la contraseña antes de almacenarla en la base de datos
    const hashedPassword = await bcrypt.hash(password, 10);

    // Inserta el usuario en la base de datos usando la pool de conexiones
    const [result] = await pool.query(
      'INSERT INTO admin (username, password) VALUES (?, ?)',
      [username, hashedPassword]
    );

    // Genera un token JWT para el usuario recién registrado
    const token = jwt.sign({ username }, 'secreto_dental', {
      expiresIn: '1h', // Cambia la duración del token según tus necesidades
    });

    res.json({ token });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error en el servidor' });
  }
});

router.post('/login', async (req, res) => {
    try {
      const { username, password } = req.body;
  
      // Buscar el usuario en la base de datos por nombre de usuario
      const [rows] = await pool.query('SELECT * FROM admin WHERE username = ?', [
        username,
      ]);
  
      // Verificar si se encontró un usuario con el nombre de usuario proporcionado
      if (rows.length === 0) {
        return res.status(401).json({ error: 'Credenciales inválidas' });
      }
  
      // Verificar la contraseña
      const user = rows[0];
      const passwordMatch = await bcrypt.compare(password, user.password);
  
      if (!passwordMatch) {
        return res.status(401).json({ error: 'Credenciales inválidas' });
      }
  
      // Generar un token JWT para el usuario autenticado
      const token = jwt.sign({ username: user.username }, 'secreto_dental', {
        expiresIn: '1h', // Cambia la duración del token según tus necesidades
      });
  
      res.json({ token });
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Error en el servidor' });
    }
  });

export default router;