const crypto = require('crypto');
const jwt = require('jsonwebtoken');
const MariaDBConnection = require('./db.js');
const { title } = require('process');
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
    

    static async getCurrentAccountData(token){
        const decoded = jwt.verify(token, SECRET_KEY, { algorithms: ['HS256'] });
        if(!decoded) {
            throw new Error('Invalid token');
        }


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

    
    static async getCurrentAccountReviews(token) {
        const decoded = jwt.verify(token, SECRET_KEY, { algorithms: ['HS256'] });
        if (!decoded) {
            throw new Error('Invalid token');
        }

        const result = await MariaDBConnection.query('SELECT r.*, p.image_url FROM reviews r JOIN products p ON r.product_id = p.id WHERE r.username = ?', [decoded.username]);
        
        if (result.length === 0) {
            return null;
        }

        const reviews = result.map(user => ({
            username: user.username,
            rating: user.rating,
            comment: user.comment,
            created_on: user.created_on,
            image_url: user.image_url,
            product_id: user.product_id
        }));
    
        return reviews;
    }

    static async getCurrentAccountOrders(token) {
        const decoded = jwt.verify(token, SECRET_KEY, { algorithms: ['HS256'] });
        if (!decoded) {
            throw new Error('Invalid token');
        }

        const result = await MariaDBConnection.query('SELECT p.image_url, o.date, o.status, od.price, u.username FROM orders_details od JOIN products p ON od.product_id = p.id JOIN orders o ON od.order_id = o.id JOIN users u ON o.user_id = u.id WHERE u.username = ?', [decoded.username]);
        
        if (result.length === 0) {
            return null;
        }

        const orders = result.map(user => ({
            username: user.username,
            date: user.date,
            image_url: user.image_url,
            status: user.status,
            price: user.price
        }));    
    
        return orders;
    }

    static async getCurrentAccountInbox(token) {
        const decoded = jwt.verify(token, SECRET_KEY, { algorithms: ['HS256'] });
        if (!decoded) {
            throw new Error('Invalid token');
        }
        const result = await MariaDBConnection.query('SELECT i.type, i.timestamp, i.sender FROM inbox i JOIN users u ON i.user_id = u.id WHERE u.username = ? ORDER BY i.timestamp DESC;', [decoded.username]);
        
        if (result.length === 0) {
            return null;
        }

        const inbox = result.map(user => ({
            date: user.timestamp,
            sender: user.sender,
            type: user.type,
        }));
    
        return inbox;
    }
    

    static async getCurrentGardenData(token){
        const decoded = jwt.verify(token, SECRET_KEY, { algorithms: ['HS256'] });
        if(!decoded) {
            throw new Error('Invalid token');
        }
        const userResult = await MariaDBConnection.query('SELECT id FROM users WHERE username = ?', [decoded.username]);
        if (userResult.length === 0) {
            throw new Error('User not found');
        }
        const userId = userResult[0].id;
        const gardenResult = await MariaDBConnection.query('SELECT * FROM gardens WHERE user_id = ?', [userId]);
        if (gardenResult.length === 0) {
            return null; // No garden found for this user
        }
        const garden = gardenResult[0];
        return { 
            name: garden.name,
            created_on: garden.created_on,
            latitude: garden.latitude,
            longitude: garden.longitude,
            description: garden.description,
            image: garden.image,
            color: garden.color_type,
            flower: garden.flower_type,
            is_shop: garden.is_shop
        };
    }
    static async getCurrentAccountBlogs(token){
        const decoded = jwt.verify(token, SECRET_KEY, { algorithms: ['HS256'] });
        if (!decoded) {
            throw new Error('Invalid token');
        }
    
        console.log(decoded.username);
        const result = await MariaDBConnection.query(
            `SELECT b.id, b.title, b.description, b.image_url 
             FROM blogs b 
             JOIN users u ON b.author_id = u.id 
             WHERE u.username = ?`, [decoded.username]
        );
    
        if (result.length === 0) {
            throw new Error('No blogs found');
        }
    
        return result.map(blog => ({
            id: blog.id,
            title: blog.title,
            description: blog.description,
            image: blog.image_url
        }));
    }

    static async signup(username, name, email, password) {
        const passwordHash = this.hashPassword(password);
        try {
            // Insert the new user into the database
            await MariaDBConnection.query(
                'INSERT INTO users (username, name, email, password_hash) VALUES (?, ?, ?, ?)',
                [username, name, email, passwordHash]
            );

            // Retrieve the user ID using the email
            const userResult = await MariaDBConnection.query(
                'SELECT id FROM users WHERE email = ?',
                [email]
            );

            if (userResult.length === 0) {
                console.log('No user found with that email after registration.');
                throw new Error('Failed to retrieve user ID after signup');
            }

            const userId = userResult[0].id;
            console.log('User ID retrieved: ', userId);

            // Send a welcome message to the user's inbox
            const inboxResult = await MariaDBConnection.query(
                'INSERT INTO inbox (user_id, message, type, timestamp, sender) VALUES (?, ?, ?, NOW(), ?)',
                [userId, 'Welcome to Web Gardening! We are thrilled to have you with us.', 'Welcome!', 'WebGardening']
            );
            console.log('Inbox entry result: ', inboxResult);

            return { message: 'User created successfully', userId: userId };
        } catch (error) {
            console.error('Database error during signup: ' + error.message);
            throw new Error('Database error during signup: ' + error.message);
        }
    }
}

module.exports = Auth;
