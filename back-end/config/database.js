const mysql = require('mysql2/promise');

const connexion = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'cybershield'
});

module.exports = connexion;