const mysql = require('mysql2');

class MariaDBConnection {
  static pool = mysql.createPool({
    host: '127.0.0.1',
    user: 'root',
    password: '2003',
    database: 'webgardening',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
  });

  static getPool() {
    return this.pool.promise();
  }

  // Simplified method to execute a query with parameter support
  static async query(sql, params) {
    const [rows, fields] = await this.getPool().query(sql, params);
    return rows;
  }
}

module.exports = MariaDBConnection;
