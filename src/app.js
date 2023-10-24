import  express  from 'express';
import morgan from 'morgan';
import cors from 'cors';

import routes from './routes/index.js';
import authentication from './routes/authentication.js';
import userController from './controllers/usersControllers.js';

const app= express();
app.use(morgan('dev'));
app.use(express.json());
app.use(cors());
app.use(routes);
app.use(authentication);
app.use(userController)

export default app;