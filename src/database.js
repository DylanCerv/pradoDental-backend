import {createPool} from 'mysql2/promise'
//CREDENCIALES DE LA BASE DE DATOS
export const pool= createPool ({
    host:'localhost',
    user:'root',
    password:'jhonnyPJ10@',
    port:'3306',
    database:'pradodentaldb'
}) 