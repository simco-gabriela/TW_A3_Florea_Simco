const crypto = require('crypto');
const jwt = require('jsonwebtoken');
const MariaDBConnection = require('./db.js');
const SECRET_KEY = 'XDD';


class Auth {


    static hashPassword(password) {
        const salt = crypto.randomBytes(16).toString('hex');
        const hash = crypto.pbkdf2Sync(password, salt, 1000, 64, 'sha512').toString('hex');
        return `${salt}${hash}`;
    }

    static verifyPassword(storedHash, password) {
        const salt = storedHash.substring(0,32);
        const hash = storedHash.substring(32);


        const derivedHash = crypto.pbkdf2Sync(password, salt, 1000, 64, 'sha512').toString('hex');

        return hash === derivedHash;
    }

    static async signin(email, password) {
        const result = await MariaDBConnection.query('SELECT * FROM users WHERE email = ?', [email]);
        if (result.length === 0) {
            throw new Error('User not found');
        }
        const user = result[0];
        if (!this.verifyPassword(user.password_hash, password)) {
            throw new Error('Invalid password');
        }
        console.log(user.username);
        return { message: 'Signin successful!', token: jwt.sign({ username: user.username }, SECRET_KEY, { algorithm: 'HS256' }) };
    }
    
    // TO DO: Move this to another class and centralize SECRET_KEY
    static async getCurrentAccountData(token){
        const decoded = jwt.verify(token, SECRET_KEY, { algorithms: ['HS256'] });
        if(!decoded) {
            throw new Error('Invalid token');
        }
        console.log("username ", decoded.username);

        const result = await MariaDBConnection.query('SELECT * FROM users WHERE username = ?', [decoded.username]);
        if (result.length === 0) {
            throw new Error('User not found');
        }
        const user = result[0];
        return { 
            username: user.username,
            name: user.name,
            email: user.email,
            date_of_birth: user.date_of_birth,
            address: user.address,
            pfp_url: user.pfp_url
        };
    }

    static async getCurrentGardenData(token){
        const decoded = jwt.verify(token, SECRET_KEY, { algorithms: ['HS256'] });
        if(!decoded) {
            throw new Error('Invalid token');
        }
        console.log("username ", decoded.username);
        console.log("user id: ", decoded.id);
        const result = await MariaDBConnection.query('SELECT * FROM gardens WHERE username = ?', [decoded.username]);
        if (result.length === 0) {
            throw new Error('User not found');
        }
        const garden = result[0];
        return { 
            name: garden.name,
            created_on: garden.created_on,
            latitude: garden.latitude,
            longitude: garden.longitude,
            description: garden.description,
            image: garden.image,
            color: garden.color_type,
            flower: garden.flower_type
        };
    }


    static async signup(username, name, email, password) {
        const passwordHash = this.hashPassword(password);
        await MariaDBConnection.query(
            'INSERT INTO user (username, name, email, password_hash) VALUES (?, ?, ?, ?)',
            [username, name, email, passwordHash]
        );
        return { message: 'User created successfully' };
    }
}

module.exports = Auth;
