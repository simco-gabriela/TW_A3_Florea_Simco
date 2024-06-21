const http = require('http');
const fs = require('fs');
const path = require('path');
const port = 3000;
const MariaDBConnection = require('./db.js'); 
const Auth = require('./auth.js'); 


// Router functions
function serveCSS(request, response) {
    if (request.url.endsWith('.css')) {
        const cssPath = path.join(__dirname, '..', request.url);
        fs.readFile(cssPath, 'utf8', function(error, data) {
            if (error) {
                response.writeHead(404, {'Content-Type': 'text/html'});
                response.write('Error: CSS File Not Found');
                response.end(); // End response after writing error message
            } else {
                response.writeHead(200, {'Content-Type': 'text/css'});
                response.write(data);
                response.end(); // End response after writing data
            }
        });
    }
}

function serveHome(request, response) {
    if (request.url === '/' || request.url === '/home.html') {
        const homePath = path.join(__dirname, '..', 'home.html');
        fs.readFile(homePath, 'utf8', function(error, data) {
            if (error) {
                response.writeHead(404, {'Content-Type': 'text/html'});
                response.write('Error: Home File Not Found');
                response.end();
            } else {
                // Fetch and embed blog and product data into the HTML
                fetchBlogs((err, blogs) => {
                    if (err) {
                        response.writeHead(500, {'Content-Type': 'text/html'});
                        response.write('Error fetching blogs');
                        response.end();
                    } else {
                        let blogsHtml = blogs.map(blog => `
                            <article>
                                <img src="${blog.image_url}" alt="Blog ${blog.id}">
                                <div class="blog-content">
                                    <div class="blog-info">
                                        <span class="date">${new Date(blog.date).toLocaleDateString()}</span> |
                                        <span class="author">${blog.author_name}</span> |
                                        <span class="tags">${blog.tags}</span>
                                    </div>
                                    <h3>${blog.title}</h3>
                                    <button>Read More</button>
                                </div>
                            </article>`).join('');

                        fetchProducts((err, products) => {
                            if (err) {
                                response.writeHead(500, {'Content-Type': 'text/html'});
                                response.write('Error fetching products');
                                response.end();
                            } else {
                                let productsHtml = products.map(product => `
                                    <article>
                                        <img src="${product.image_url}" alt="${product.name}">
                                        <h3>${product.name}</h3>
                                        <p>$${product.price.toFixed(2)}</p>
                                    </article>`).join('');

                                // Replace placeholder sections in the HTML with real data
                                data = data.replace('<!-- Blogs Placeholder -->', blogsHtml);
                                data = data.replace('<!-- Products Placeholder -->', productsHtml);
                                
                                response.writeHead(200, {'Content-Type': 'text/html'});
                                response.write(data);
                                response.end();
                            }
                        });
                    }
                });
            }
        });
    }
}


function fetchBlogs(callback) {
    const query = `
        SELECT b.id, b.title, b.content, b.date, b.image_url, u.name AS author_name, 
               GROUP_CONCAT(t.name SEPARATOR ', ') AS tags
        FROM blogs b
        JOIN users u ON b.author_id = u.id
        LEFT JOIN blogs_tags bt ON b.id = bt.blog_id
        LEFT JOIN tags t ON bt.tag_id = t.id
        GROUP BY b.id
        ORDER BY b.date DESC
        LIMIT 3`;

    MariaDBConnection.query(query)
        .then(results => {
            callback(null, results);
        })
        .catch(err => {
            callback(err, null);
        });
}

function fetchProducts(callback) {
    const query = `
        SELECT id, name, description, image_url, price
        FROM products
        WHERE available = 1
        LIMIT 3`;

    MariaDBConnection.query(query)
        .then(results => {
            callback(null, results);
        })
        .catch(err => {
            callback(err, null);
        });
}



function serveStaticFiles(request, response) {
    const filePath = path.join(__dirname, '..', request.url);
    const ext = path.extname(filePath);
    let contentType = 'text/html';

    switch (ext) {
        case '.js':
            contentType = 'application/javascript';
            break;
        case '.png':
            contentType = 'image/png';
            break;
        case '.jpg':
        case '.jpeg':
            contentType = 'image/jpeg';
            break;
        case '.ico':
            contentType = 'image/x-icon';
            break;
        default:
            contentType = 'text/html';
    }

    fs.readFile(filePath, function(error, data) {
        if (error) {
            response.writeHead(404, {'Content-Type': 'text/html'});
            response.write('Error: File Not Found');
            response.end(); // End response after writing error message
        } else {
            response.writeHead(200, {'Content-Type': contentType});
            response.write(data);
            response.end(); // End response after writing data
        }
    });
}

const server = http.createServer(function(request, response) {
  
    try {
        console.log(`${request.method} request for ${request.url}`);

        if (request.url.endsWith('.css')) {
            serveCSS(request, response);
        } else if (request.url === '/' || request.url === '/home.html') {
            serveHome(request, response);
         }
        else if (request.method === 'POST' && request.url === '/signin') {
            collectRequestData(request, async (data) => {
                try {
                    const { email, password } = JSON.parse(data);
                    const result = await Auth.signin(email, password);
                    response.writeHead(200, { 'Content-Type': 'application/json' });
                    response.end(JSON.stringify(result));
                } catch (error) {
                    console.error('Sign-in error:', error);
                    response.writeHead(500, { 'Content-Type': 'application/json' });
                    response.end(JSON.stringify({ error: 'Server error' }));
                }
            });
        } else if (request.method === 'POST' && request.url === '/signup') {
            collectRequestData(request, async (data) => {
                try {
                    const { username, name, email, password } = JSON.parse(data);
                    const result = await Auth.signup(username, name, email, password);
                    response.writeHead(201, { 'Content-Type': 'application/json' });
                    response.end(JSON.stringify(result));
                } catch (error) {
                    console.error('Sign-up error:', error.message);
                    response.writeHead(500, { 'Content-Type': 'application/json' });
                    response.end(JSON.stringify({ error: error.message }));
                }
            });
        } else {
            serveStaticFiles(request, response);
        }
    } catch (error) {
        response.writeHead(500);
        response.end('Server error');
    }
});

function collectRequestData(request, callback) {
    console.log('Received data:', data); // Log the received data
    let body = '';
    request.on('data', chunk => {
        body += chunk.toString();
    });
    request.on('end', () => {
        callback(body);
    });
}

server.listen(port, function(error) {
    if (error) {
        console.log('Something went wrong', error);
    } else {
        console.log('Server is listening on port ' + port);
    }
});
