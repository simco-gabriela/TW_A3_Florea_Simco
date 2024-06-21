const crypto = require('crypto');
const MariaDBConnection = require('./db.js');


class Auth {

    
    static hashPassword(password) {
        const salt = crypto.randomBytes(16).toString('hex');
        const hash = crypto.pbkdf2Sync(password, salt, 1000, 64, 'sha512').toString('hex');
        return `${salt}$${hash}`;
    }

    static verifyPassword(storedHash, password) {
        const [salt, hash] = storedHash.split('$');
        const derivedHash = crypto.pbkdf2Sync(password, salt, 1000, 64, 'sha512').toString('hex');
        return hash === derivedHash;
    }

    static async signin(email, password) {
        try {
            const result = await MariaDBConnection.query('SELECT * FROM users WHERE email = ?', [email]);
            if (result.length === 0) {
                throw new Error('User not found');
            }
            const user = result[0];
            if (!this.verifyPassword(user.password_hash, password)) {
                throw new Error('Invalid password');
            }
            return { message: 'Signin successful!' };
        } catch (error) {
            throw error;
        }
    }
    

    static async signup(username, name, email, password) {
        try {
            const passwordHash = this.hashPassword(password);
            await MariaDBConnection.query(
                'INSERT INTO user (username, name, email, password_hash) VALUES (?, ?, ?, ?)',
                [username, name, email, passwordHash]
            );
            return { message: 'User created successfully' };
        } catch (error) {
            throw error;
        }
    }
}

module.exports = Auth;
