import jwt from 'jsonwebtoken';

function isAdmin(req, res, next) {
  // Verifica si el usuario tiene el rol 'admin' en el token JWT
  const authHeader = req.headers.authorization; // Asumo que el token se envía en el encabezado Authorization
  console.log(authHeader);

  if (!authHeader) {
    return res.status(401).json({ error: 'Token no proporcionado' });
  }

  const token = authHeader.split(' ')[1]; // Elimina el prefijo "Bearer" y obtén solo el token

  // Decodificar el token JWT para verificar el rol
  jwt.verify(token, 'secreto_dental', (err, decoded) => {
    if (err) {
      return res.status(401).json({ error: 'Token inválido' });
    }

    if (decoded.username !== 'admin@pradodental.com') {
      console.log(decoded)
      return res.status(403).json({ error: 'Acceso no autorizado' });
    }

    // Si el usuario es administrador, permite el acceso al controlador
    next();
  });
}

export default isAdmin;
