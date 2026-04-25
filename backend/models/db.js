const mysql = require('mysql2');

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '1234',
  database: 'loja_suplementos'
});

db.connect(err => {
  if (err) {
    console.log(err);
  } else {
    console.log('MySQL conectado');
  }
});

module.exports = db;