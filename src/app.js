import  express  from 'express';
import morgan from 'morgan';
import cors from 'cors';

import routes from './routes/index.js';
import authentication from './routes/authentication.js';
import userController from './controllers/usersControllers.js';
import fileController from './controllers/filesControllers.js';
import agendaController from './controllers/agendaController.js';
import diagnosticoDentalController from './controllers/diagnosticoDentalController.js';

const app= express();
app.use(morgan('dev'));
app.use(express.json());
app.use(cors());
app.use(routes);
app.use(authentication);
app.use(userController)
app.use(fileController)
app.use(agendaController)
app.use(diagnosticoDentalController)

export default app;

// {
//     "diagnosticoGeneral": {
//         "fecha": ""
//     },
//     "dientes": {
//         "11": {
//             "diagnostico": "",
//             "presupuesto": "",
//             "fecha": "",
//             "tratamiento": "",
//             "abono": ""
//         },
//         "12": {
//             "diagnostico": "",
//             "presupuesto": "",
//             "fecha": "",
//             "tratamiento": "",
//             "abono": ""
//         },
//     },
//     "tratamientoAdicional": {
//         "quirurgico": "",
//         "quirurgico_presupuesto": "",
//         "periodental": "",
//         "periodental_presupuesto": "",
//         "ortodontico": "",
//         "ortodontico_presupuesto": "",
//         "otro": "",
//         "otro_presupuesto": ""
//     }
// }