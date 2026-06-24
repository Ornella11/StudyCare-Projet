const mysql = require('mysql2/promise');

const connexion = mysql.createPool({
    host: 'localhost',
    user: 'melek',
    password: 'password',
    database: 'studycare'
});

module.exports = connexion;