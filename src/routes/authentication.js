import express from 'express';
import jwt from 'jsonwebtoken';
import bcrypt from 'bcrypt';
import { pool } from '../database.js';
import { TABLES, TABLES_DENTAL } from '../data/tables.js';

const router = express.Router();


async function createUser(username, hashedPassword, role, name) {
  const [result] = await pool.query(
    'INSERT INTO users (username, password, role, name) VALUES (?, ?, ?, ?)',
    [username, hashedPassword, role, name]
  );

  return result;
}

async function createTablesAndInitialData(userId) {
  let tableDiagnosticoGeneral;
  
  for (const table of TABLES) {
    const [createRelation] = await pool.query(
      `INSERT INTO ${table} (user_id) VALUES (?)`,
      [userId]
    );
  }

  for (const table of TABLES_DENTAL) {
    if (table !== 'Dental_Dientes' && table !== 'Dental_TratamientoAdicional') {
      const [createRelation] = await pool.query(
        `INSERT INTO ${table} (user_id) VALUES (?)`,
        [userId]
      );
      tableDiagnosticoGeneral = createRelation;
    }
  
    if (table === 'Dental_Dientes') {
      const initialTeeth = [
        { numero: 11, posicion: 'arriba-izquierda' },
        { numero: 12, posicion: 'arriba-izquierda' },
        { numero: 13, posicion: 'arriba-izquierda' },
        { numero: 14, posicion: 'arriba-izquierda' },
        { numero: 15, posicion: 'arriba-izquierda' },
        { numero: 16, posicion: 'arriba-izquierda' },
        { numero: 17, posicion: 'arriba-izquierda' },
        { numero: 18, posicion: 'arriba-izquierda' },
        { numero: 21, posicion: 'arriba-derecha' },
        { numero: 22, posicion: 'arriba-derecha' },
        { numero: 23, posicion: 'arriba-derecha' },
        { numero: 24, posicion: 'arriba-derecha' },
        { numero: 25, posicion: 'arriba-derecha' },
        { numero: 26, posicion: 'arriba-derecha' },
        { numero: 27, posicion: 'arriba-derecha' },
        { numero: 28, posicion: 'arriba-derecha' },
        { numero: 38, posicion: 'abajo-derecha' },
        { numero: 37, posicion: 'abajo-derecha' },
        { numero: 36, posicion: 'abajo-derecha' },
        { numero: 35, posicion: 'abajo-derecha' },
        { numero: 34, posicion: 'abajo-derecha' },
        { numero: 33, posicion: 'abajo-derecha' },
        { numero: 32, posicion: 'abajo-derecha' },
        { numero: 31, posicion: 'abajo-derecha' },
        { numero: 41, posicion: 'abajo-izquierda' },
        { numero: 42, posicion: 'abajo-izquierda' },
        { numero: 43, posicion: 'abajo-izquierda' },
        { numero: 44, posicion: 'abajo-izquierda' },
        { numero: 45, posicion: 'abajo-izquierda' },
        { numero: 46, posicion: 'abajo-izquierda' },
        { numero: 47, posicion: 'abajo-izquierda' },
        { numero: 48, posicion: 'abajo-izquierda' },
      ];
  
      for (const tooth of initialTeeth) {
        await pool.query(
          `INSERT INTO Dental_Dientes (numero, posicion, id_diagnostico_general) VALUES (?, ?, ?)`,
          [tooth.numero, tooth.posicion, tableDiagnosticoGeneral.insertId]
        );
      }
    } else if (table === 'Dental_TratamientoAdicional') {
      await pool.query(
        `INSERT INTO Dental_TratamientoAdicional (quirurgico, periodental, ortodontico, otro, quirurgico_presupuesto, periodental_presupuesto, ortodontico_presupuesto, otro_presupuesto, id_diagnostico_general) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
        ['', '', '', '', 0, 0, 0, 0, tableDiagnosticoGeneral.insertId]
      );
    }
  }
}


router.post('/register', async (req, res) => {
  try {
    const { email, password, role, name } = req.body;
    const username = email;

    // Hash de la contraseña antes de almacenarla en la base de datos
    const hashedPassword = await bcrypt.hash(password, 10);

    // Crear usuario
    const result = await createUser(username, hashedPassword, role, name);

    // Crear tablas y datos iniciales
    await createTablesAndInitialData(result.insertId);

    // Genera un token JWT para el usuario recién registrado
    const token = jwt.sign({ username }, 'secreto_dental', {
      expiresIn: '1h', // Cambia la duración del token según tus necesidades
    });
    // console.log({username, hashedPassword, role, name})

    res.json({
      token,
      role,
      id: result.insertId,
    });
    
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error en el servidor' });
  }
});

router.post('/login', async (req, res) => {
  try {
    const { username, password } = req.body;

    // Buscar el usuario en la base de datos por nombre de usuario
    const [rows] = await pool.query('SELECT * FROM users WHERE username = ?', [
      username,
    ]);

    // Verificar si se encontró un usuario con el nombre de usuario proporcionado
    if (rows.length === 0) {
      return res.status(401).json({ error: 'Credenciales inválidas' });
    }
    const user = rows[0];

    if (user.role === 'admin' && user.password === password) {
      // Generar un token JWT para el usuario autenticado como administrador
      const token = jwt.sign({ username: user.username }, 'secreto_dental', {
        expiresIn: '1h', // Cambia la duración del token según tus necesidades
      });
      const role = user.role;

      return res.json({
        token,
        role,
        name: user.name,
        // uuid: role.id,
      });
    }

    // Verificar la contraseña
    const passwordMatch = await bcrypt.compare(password, user.password);
    if (!passwordMatch) {
      return res.status(401).json({ error: 'Credenciales inválidas' });
    }

    // Generar un token JWT para el usuario autenticado
    const token = jwt.sign({ username: user.username }, 'secreto_dental', {
      expiresIn: '1h', // Cambia la duración del token según tus necesidades
    });

    const role = user.role;

    res.json({
      token,
      role,
      name: user.name,
      id: user.id,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error en el servidor' });
  }
});

export default router;
