import app from './app.js'
import {pool} from './database.js'


app.get('/ping', async(req, res) =>{
    const [result]= await pool.query('SELECT 1+1 AS result')
    res.json(result[0])
});


app.listen(3000)
console.log('Server Run', 3000)
