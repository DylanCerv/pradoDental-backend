import  express  from 'express';
import morgan from 'morgan';
import cors from 'cors';
import routes from './routes/index.js';
import authentication from './routes/authentication.js';

const app= express();
app.use(morgan('dev'));
app.use(express.json());
app.use(cors());
app.use(routes);
app.use(authentication);

export default app;