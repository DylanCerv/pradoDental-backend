import express from 'express';
import jwt from 'jsonwebtoken';
import bcrypt from 'bcrypt';
import { pool } from '../database.js';
import isAdmin from '../middlewares/authMiddleware.js';
import multer from 'multer';
import path, { dirname } from 'path';
import { fileURLToPath } from 'url';
import fs from 'fs';
import * as fsPromises from 'fs/promises';

const fileController = express.Router();


const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const folderPath = '../uploadsFiles/';

// Carpeta local donde se guardarán los archivos
const uploadPath = path.join(__dirname, folderPath);

// Verificar si la carpeta 'uploads' existe, si no, créala
if (!fs.existsSync(uploadPath)) {
  fs.mkdirSync(uploadPath);
}

// Configuración de Multer para la carga de archivos
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, uploadPath);
  },
  filename: (req, file, cb) => {
    const ext = path.extname(file.originalname);
    const name = `${Date.now()}${ext}`;
    file.uploadedFileName = name;
    cb(null, name);
  },
});

const upload = multer({ storage: storage });


// Endpoint para subir archivos
fileController.post('/file/upload/:user_id', upload.single('file'), async (req, res) => {

  const userId = req.params.user_id;
  const { category } = req.body;

  try {
        // Verificar si se subió un archivo
        if (!req.file) {
          return res.status(400).json({ error: 'No se proporcionó ningún archivo' });
        }
        
        const filePath = req.file.path; // Ruta del archivo local
        const fileName = req.file.uploadedFileName;

        // Verificar si ya existe un archivo con la misma categoría para el usuario
        const resultExist = await pool.query('SELECT * FROM files WHERE user_id = ? AND category = ?', [userId, category]);
        
        for (const result of resultExist) {
          if (result.length > 0) {
            // Si ya existe, actualizar el archivo existente
            await pool.query('UPDATE files SET path = ?, name = ? WHERE user_id = ? AND category = ?', [filePath, fileName, userId, category]);
          } else {
            // Si no existe, insertar un nuevo registro
            await pool.query('INSERT INTO files (path, category, name, user_id) VALUES (?, ?, ?, ?)', [filePath, category, fileName, userId]);
          }
        }

        res.status(200).json({ message: 'Archivo subido con éxito'});
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error en el servidor' });
    }
});

// Endpoint para descargar archivos
fileController.get('/file/download/:filename', async (req, res) => {
    try {
        const filename = req.params.filename;
        const filePath = path.join(__dirname, folderPath, filename); // Ajusta la ruta según tu estructura de carpetas
        res.download(filePath, (err) => {
          if (err) {
            console.error('Error al descargar el archivo', err);
            res.status(500).json({ error: 'Error al descargar el archivo' });
          }
        });
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Error en el servidor' });
    }
});
  
// Endpoint para obtener la info de archivos
fileController.get('/file/:user_id', async (req, res) => {
    const userId = req.params.user_id;

    try {
      const result = await pool.query('SELECT * FROM files WHERE user_id = ?', [userId]);
  
      res.status(200).json({ files: result[0] });
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Error en el servidor' });
    }
});
  
// Endpoint para obtener la info de archivos
fileController.get('/file/by-category/:user_id/:category', async (req, res) => {
  const {user_id, category} = req.params;

  try {
    const result = await pool.query('SELECT * FROM files WHERE user_id = ? AND category = ?', [user_id, category]);

    res.status(200).json({ files: result[0] });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error en el servidor' });
  }
});
  
export default fileController;