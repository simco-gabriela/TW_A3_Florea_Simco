const http = require('http');
const fs = require('fs');
const path = require('path');
const port = 3000;
const MariaDBConnection = require('./db.js'); 
const Auth = require('./auth.js'); 
const url = require('url');
const querystring = require('querystring');



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
                                <img src="${blog.image_url}" alt="${blog.title}">
                                <div class="blog-content">
                                    <div class="blog-info">
                                        <span class="date">${new Date(blog.date).toLocaleDateString()}</span> |
                                        <a href="profile-page.html?userId=${blog.author_id}" class="author">${blog.author_name}</a> |
                                        <span class="tags">${blog.tags}</span>
                                    </div>
                                    <h3>${blog.title}</h3>
                                    <button onclick="location.href='blog-page.html?blogId=${blog.id}'">Read More</button>
                                </div>
                            </article>
                        `).join('');

                        fetchProducts((err, products) => {
                            if (err) {
                                response.writeHead(500, {'Content-Type': 'text/html'});
                                response.write('Error fetching products');
                                response.end();
                            } else {
                                let productsHtml = products.map(product => `
                                    <article onclick="location.href='product-detail.html?id=${product.id}'" style="cursor: pointer;">
                                        <img src="${product.image_url}" alt="${product.name}">
                                        <div class="product-info">
                                            <h3>${product.name}</h3>
                                            <p>$${product.price.toFixed(2)}</p>
                                        </div>
                                    </article>
                                `).join('');

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

function serveShop(request, response) {
    const shopPath = path.join(__dirname, '..', 'shop.html');
    fs.readFile(shopPath, 'utf8', function(error, data) {
        if (error) {
            response.writeHead(404, {'Content-Type': 'text/html'});
            response.write('Error: Shop File Not Found');
            response.end();
        } else {
            // Make sure to pass a proper callback function here
            fetchShopProducts({}, (err, products) => { // Make sure you're passing an empty object for filters
                if (err) {
                    response.writeHead(500, {'Content-Type': 'text/html'});
                    response.write('Error fetching products');
                    response.end();
                } else {
                    let productsHtml = products.map(product => `
                        <div class="col-4">
                            <img src="${product.image_url}" alt="${product.name}">
                            <h4>${product.name}</h4>
                            <p>$${product.price.toFixed(2)}</p>
                            <a href="product-detail.html?id=${product.id}">More details</a>
                        </div>
                    `).join('');

                    // Replace the placeholder in the HTML content with the dynamically created products HTML
                    data = data.replace('<!-- Products Placeholder -->', productsHtml);
                    
                    response.writeHead(200, {'Content-Type': 'text/html'});
                    response.write(data);
                    response.end();
                }
            });
        }
    });
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

function fetchBlogsAll(callback) {
    const query = `
        SELECT b.id, b.title, b.description, b.date, b.image_url, u.id AS author_id, u.name AS author_name, 
               GROUP_CONCAT(t.name SEPARATOR ', ') AS tags
        FROM blogs b
        JOIN users u ON b.author_id = u.id
        LEFT JOIN blogs_tags bt ON b.id = bt.blog_id
        LEFT JOIN tags t ON bt.tag_id = t.id
        GROUP BY b.id
        ORDER BY b.date DESC`;

    MariaDBConnection.query(query)
        .then(results => callback(null, results))
        .catch(err => callback(err, null));
}

function serveBlog(request, response) {
    const parsedUrl = url.parse(request.url, true); // Parse the URL to get query parameters
    const blogPath = path.join(__dirname, '..', 'blog.html');
    const searchQuery = parsedUrl.query.search || '';
    const tagQuery = parsedUrl.query.tag || '';
    const category = parsedUrl.query.category || '';

    fs.readFile(blogPath, 'utf8', function(error, data) {
        if (error) {
            response.writeHead(404, {'Content-Type': 'text/html'});
            response.write('Error: Blog File Not Found');
            response.end();
        } else {
            // Fetch recent posts
            fetchRecentBlogs((err, recentPosts) => {
                if (err) {
                    response.writeHead(500, {'Content-Type': 'text/html'});
                    response.write('Error fetching recent posts');
                    response.end();
                    return;
                }

                let recentPostsHtml = recentPosts.map(post => `
                    <li>
                        <img src="${post.image_url}" alt="Post Thumbnail">
                        <a href="blog-page.html?blogId=${post.id}">${post.title}</a>
                    </li>
                `).join('');
                data = data.replace('<!-- Recent Posts Placeholder -->', recentPostsHtml);

                // Fetch tags
                fetchTags((err, tags) => {
                    if (err) {
                        response.writeHead(500, {'Content-Type': 'text/html'});
                        response.write('Error fetching tags');
                        response.end();
                    } else {
                        let tagsHtml = tags.map(tag => `
                            <li><a href="/blog.html?tag=${encodeURIComponent(tag.name)}" class="tag">${tag.name}</a></li>
                        `).join('');
                        data = data.replace('<!-- Tag List Placeholder -->', tagsHtml);

                        // Determine which blog fetching function to call
                        function handleBlogs(err, blogs) {
                            if (err) {
                                response.writeHead(500, {'Content-Type': 'text/html'});
                                response.write('Error fetching blogs');
                                response.end();
                            } else {
                                let blogsHtml = blogs.length > 0 ? blogs.map(blog => `
                                    <div class="blog-post">
                                        <img src="${blog.image_url}" alt="Blog Image">
                                        <div class="blog-post-content">
                                            <h3 class="blog-post-title">${blog.title}</h3>
                                            <p class="blog-post-meta">
                                                ${new Date(blog.date).toLocaleDateString()} | 
                                                by <a href="profile-page.html?userId=${blog.author_id}">${blog.author_name}</a> |
                                                <p><span class="tags">Tags: ${blog.tags}</span></p>
                                            </p>
                                            <p class="blog-post-desc">${blog.description}</p>
                                            <a href="blog-page.html?blogId=${blog.id}" class="read-more-btn">Read more</a>
                                        </div>
                                    </div>
                                `).join('') : '<p>No results found for your search or tag.</p>';                                

                                data = data.replace('<!-- Blog Posts Placeholder -->', blogsHtml);
                                
                                response.writeHead(200, {'Content-Type': 'text/html'});
                                response.write(data);
                                response.end();
                            }
                        }

                        if (tagQuery) {
                            fetchBlogsByTag(tagQuery, handleBlogs);
                        } else if (searchQuery) {
                            fetchBlogsSearch(searchQuery, handleBlogs);
                        } else if (category) {
                            fetchBlogsByCategory(category, handleBlogs);
                        } else {
                            fetchBlogsAll(handleBlogs);
                        }
                    }
                });
            });
        }
    }); 
}

function fetchBlogsByTag(tag, callback) {
    let query = `
        SELECT b.id, b.title, b.description, b.date, b.image_url, u.id AS author_id, u.name AS author_name,
               GROUP_CONCAT(DISTINCT t.name ORDER BY t.name SEPARATOR ', ') AS tags
        FROM blogs b
        INNER JOIN users u ON b.author_id = u.id
        INNER JOIN blogs_tags bt ON b.id = bt.blog_id
        INNER JOIN tags t ON bt.tag_id = t.id
        WHERE EXISTS (
            SELECT 1 FROM blogs_tags bt2
            INNER JOIN tags t2 ON bt2.tag_id = t2.id
            WHERE bt2.blog_id = b.id AND t2.name = ?
        )
        GROUP BY b.id
        ORDER BY b.date DESC`;

    MariaDBConnection.query(query, [tag])
        .then(results => callback(null, results))
        .catch(err => callback(err, null));
}

function fetchBlogsByCategory(category, callback) {
    let query;
    switch (category) {
        case 'Trending':
            query = `
                SELECT b.id, b.title, b.description, b.date, b.image_url, u.id AS author_id, u.name AS author_name,
                    GROUP_CONCAT(t.name SEPARATOR ', ') AS tags, 
                    (SELECT COUNT(*) FROM blogs_comments WHERE blog_id = b.id) +
                    (SELECT COUNT(*) FROM blogs_likes WHERE blog_id = b.id) AS popularity
                FROM blogs b
                JOIN users u ON b.author_id = u.id
                LEFT JOIN blogs_tags bt ON b.id = bt.blog_id
                LEFT JOIN tags t ON bt.tag_id = t.id
                GROUP BY b.id
                ORDER BY popularity DESC`;
            break;
        case 'HighestRated':
            query = `
                SELECT b.id, b.title, b.description, b.date, b.image_url, u.id AS author_id, u.name AS author_name,
                    GROUP_CONCAT(t.name SEPARATOR ', ') AS tags, 
                    (SELECT COUNT(*) FROM blogs_likes WHERE blog_id = b.id) AS rating
                FROM blogs b
                JOIN users u ON b.author_id = u.id
                LEFT JOIN blogs_tags bt ON b.id = bt.blog_id
                LEFT JOIN tags t ON bt.tag_id = t.id
                GROUP BY b.id
                ORDER BY rating DESC`;
            break;
        case 'OurPosts':
            query = `
                SELECT b.id, b.title, b.description, b.date, b.image_url, u.id AS author_id, u.name AS author_name,
                    GROUP_CONCAT(t.name SEPARATOR ', ') AS tags
                FROM blogs b
                JOIN users u ON b.author_id = u.id
                LEFT JOIN blogs_tags bt ON b.id = bt.blog_id
                LEFT JOIN tags t ON bt.tag_id = t.id
                WHERE u.name = 'Web Gardening' 
                GROUP BY b.id
                ORDER BY b.date DESC`;
            break;
        default:
            return callback(new Error('Unknown category'), null);
    }

    MariaDBConnection.query(query)
        .then(results => callback(null, results))
        .catch(err => callback(err, null));
}

function serveBlogPage(request, response) {
    const parsedUrl = url.parse(request.url, true);
    const blogId = parsedUrl.query.blogId;

    if (!blogId) {
        response.writeHead(404, {'Content-Type': 'text/html'});
        response.write('Blog post not found');
        response.end();
        return;
    }

    const blogQuery = `
        SELECT b.id, b.title, b.content, b.date, b.image_url, u.id AS author_id, u.id AS author_id, u.name AS author_name, u.pfp_url AS author_avatar,
               GROUP_CONCAT(DISTINCT t.name SEPARATOR ', ') AS tags,
               (SELECT COUNT(*) FROM blogs_likes WHERE blog_id = b.id) AS like_count
        FROM blogs b
        JOIN users u ON b.author_id = u.id
        LEFT JOIN blogs_tags bt ON b.id = bt.blog_id
        LEFT JOIN tags t ON bt.tag_id = t.id
        WHERE b.id = ?
        GROUP BY b.id`;

    MariaDBConnection.query(blogQuery, [blogId])
        .then(blogResults => {
            if (blogResults.length === 0) {
                response.writeHead(404, {'Content-Type': 'text/html'});
                response.write('Blog post not found');
                response.end();
                return;
            }

            const blog = blogResults[0];

            fetchRecommendedBlogs(blog.id, blog.author_id, blog.tags, (err, recommendedBlogs) => {
                if (err) {
                    response.writeHead(500, {'Content-Type': 'text/html'});
                    response.write('Error fetching recommended blogs');
                    response.end();
                    return;
                }

                const recommendedBlogsHtml = recommendedBlogs.map(b => `
                    <div class="recommended-blog">
                        <div class="blog-details">
                            <img src="${b.image_url}" alt="Recommended Blog Image">
                            <div class="details">
                                <a href="blog-page.html?blogId=${b.id}" class="title">${b.title}</a>
                                <a href="profile-page.html?userId=${b.author_id}" class="author">by ${b.author_name}</a>
                            </div>
                        </div>
                    </div>
                `).join('');

                const commentsQuery = `
                    SELECT c.content AS comment_content, c.date AS comment_date, u.username AS comment_username, u.pfp_url AS comment_avatar
                    FROM blogs_comments c
                    JOIN users u ON c.user_id = u.id
                    WHERE c.blog_id = ?
                    ORDER BY c.date DESC`;

                MariaDBConnection.query(commentsQuery, [blogId])
                    .then(commentResults => {
                        const commentsHtml = commentResults.map(comment => `
                            <div class="comment">
                                <div class="avatar">
                                    <img src="${comment.comment_avatar || 'images/default-avatar.png'}" alt="Commenter Avatar">
                                </div>
                                <div class="comment-content">
                                    <p class="comment-author">${comment.comment_username}</p>
                                    <p class="comment-text">${comment.comment_content}</p>
                                    <p class="comment-date">${new Date(comment.comment_date).toLocaleDateString()}</p>
                                </div>
                            </div>
                        `).join('');

                        fs.readFile(path.join(__dirname, '..', 'blog-page.html'), 'utf8', function(readError, data) {
                            if (readError) {
                                response.writeHead(404, {'Content-Type': 'text/html'});
                                response.write('Error: Blog Page File Not Found');
                                response.end();
                                return;
                            }

                            let formattedContent = formatContentWithParagraphs(blog.content);

                            let pageContent = data.replace('<!-- Blog Title -->', blog.title)
                                .replace('<!-- Image Placeholder -->', `<img src="${blog.image_url}" alt="Main Blog Image">`)
                                .replace('<!-- Content Placeholder -->', formattedContent)
                                .replace('<!-- Date Placeholder -->', new Date(blog.date).toLocaleDateString())
                                .replace('<!-- Author Placeholder -->', `Written by ${blog.author_name}`)
                                .replace('<!-- Tags Placeholder -->', blog.tags.split(', ').map(tag => `<span>${tag}</span>`).join(' '))
                                .replace('<!-- Likes Placeholder -->', `Likes: ${blog.like_count}`)
                                .replace('<!-- Comments Placeholder -->', commentsHtml)
                                .replace('<!-- Recommended Blogs Placeholder -->', recommendedBlogsHtml);

                            response.writeHead(200, {'Content-Type': 'text/html'});
                            response.write(pageContent);
                            response.end();
                        });
                    })
                    .catch(err => {
                        response.writeHead(500, {'Content-Type': 'text/html'});
                        response.write('Error fetching comments');
                        response.end();
                    });
            });
        })
        .catch(err => {
            response.writeHead(500, {'Content-Type': 'text/html'});
            response.write('Error fetching blog details');
            response.end();
        });
}

function formatContentWithParagraphs(content) {
    return content.split('\n').map(line => `<p>${line}</p>`).join('');
}




function fetchRecommendedBlogs(currentBlogId, authorId, tags, callback) {
    // Split tags to handle multiple tags properly
    const tagsList = tags.split(', ');

    // Query to find blogs by the same author or with shared tags, excluding the current blog
    let query = `
        SELECT b.id, b.title, b.image_url, u.id AS author_id, u.name AS author_name
        FROM blogs b
        JOIN users u ON b.author_id = u.id
        LEFT JOIN blogs_tags bt ON b.id = bt.blog_id
        LEFT JOIN tags t ON bt.tag_id = t.id
        WHERE b.id != ? AND (b.author_id = ? OR t.name IN (?))
        GROUP BY b.id
        ORDER BY b.date DESC
        LIMIT 5`;

    // Execute the query
    MariaDBConnection.query(query, [currentBlogId, authorId, tagsList])
        .then(results => {
            if (results.length < 2) {
                // If not enough related blogs, fetch the most recent ones
                query = `
                    SELECT b.id, b.title, b.image_url, u.name AS author_name
                    FROM blogs b
                    JOIN users u ON b.author_id = u.id
                    WHERE b.id != ?
                    ORDER BY b.date DESC
                    LIMIT 2`;

                MariaDBConnection.query(query, [currentBlogId])
                    .then(fallbackResults => callback(null, fallbackResults))
                    .catch(err => callback(err, null));
            } else {
                callback(null, results);
            }
        })
        .catch(err => callback(err, null));
}



function fetchTags(callback) {
    const query = `
        SELECT DISTINCT name
        FROM tags
        ORDER BY name`;

    MariaDBConnection.query(query)
        .then(results => callback(null, results))
        .catch(err => callback(err, null));
}


function fetchRecentBlogs(callback) {
    const query = `
        SELECT id, title, image_url
        FROM blogs
        ORDER BY date DESC
        LIMIT 3`;  // Limit to the three most recent posts

    MariaDBConnection.query(query)
        .then(results => callback(null, results))
        .catch(err => callback(err, null));
}


function fetchBlogsSearch(searchQuery, callback) {
    let query = `
        SELECT b.id, b.title, b.description, b.date, b.image_url, u.id AS author_id, u.name AS author_name, 
               GROUP_CONCAT(t.name SEPARATOR ', ') AS tags
        FROM blogs b
        JOIN users u ON b.author_id = u.id
        LEFT JOIN blogs_tags bt ON b.id = bt.blog_id
        LEFT JOIN tags t ON bt.tag_id = t.id
        WHERE b.title LIKE ? OR b.description LIKE ? OR u.name LIKE ?
        GROUP BY b.id
        ORDER BY b.date DESC`;

    const likeQuery = `%${searchQuery}%`;
    MariaDBConnection.query(query, [likeQuery, likeQuery, likeQuery])
        .then(results => callback(null, results))
        .catch(err => callback(err, null));
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

function fetchShopProducts(filters, callback) {
    let query = `
        SELECT p.id, p.name, p.image_url, p.price, p.category, p.type, p.color,
               IFNULL(AVG(r.rating), 0) AS avg_rating,
               IFNULL(COUNT(DISTINCT o.id), 0) AS popularity
        FROM products p
        LEFT JOIN reviews r ON p.id = r.product_id
        LEFT JOIN orders_details o ON p.id = o.product_id
        WHERE p.available = 1`;

    const conditions = [];
    const params = [];

    // Handle multiple and single selections for type, category, and color
    ['type', 'category', 'color'].forEach(filter => {
        if (filters[filter]) {
            let values = Array.isArray(filters[filter]) ? filters[filter] : [filters[filter]];
            conditions.push(`${filter} IN (${values.map(() => '?').join(', ')})`);
            params.push(...values);
        }
    });

    if (conditions.length) {
        query += ` AND ${conditions.join(' AND ')}`;
    }

    query += ' GROUP BY p.id';

    // Sorting based on the filter results
    const sort = filters.sort;
    switch (sort) {
        case 'price_asc':
            query += ' ORDER BY p.price ASC';
            break;
        case 'price_desc':
            query += ' ORDER BY p.price DESC';
            break;
        case 'rating':
            query += ' ORDER BY avg_rating DESC';
            break;
        case 'popularity':
            query += ' ORDER BY popularity DESC';
            break;
    }

    console.log("Executing query:", query, "with params:", params);

    MariaDBConnection.query(query, params)
        .then(results => callback(null, results))
        .catch(err => {
            console.error("Database query error:", err);
            callback(err, null);
        });
}




function serveFilteredShop(request, response, queryParams) {
    const shopPath = path.join(__dirname, '..', 'shop.html');
    fs.readFile(shopPath, 'utf8', function(error, data) {
        if (error) {
            response.writeHead(404, {'Content-Type': 'text/html'});
            response.write('Error: Shop File Not Found');
            response.end();
        } else {
            // Filter based on query parameters
            fetchShopProducts(queryParams, (err, products) => {
                if (err) {
                    response.writeHead(500, {'Content-Type': 'text/html'});
                    response.write('Error fetching products');
                    response.end();
                } else {
                    let productsHtml = products.map(product => `
                        <div class="col-4">
                            <img src="${product.image_url}" alt="${product.name}">
                            <h4>${product.name}</h4>
                            <p>$${product.price.toFixed(2)}</p>
                            <a href="product-detail.html?id=${product.id}">More details</a>
                        </div>
                    `).join('');

                    data = data.replace('<!-- Products Placeholder -->', productsHtml);
                    response.writeHead(200, {'Content-Type': 'text/html'});
                    response.write(data);
                    response.end();
                }
            });
        }
    });
}

function fetchRecommendedProducts(productId, sellerId, type, category, color, callback) {
    // Query to find similar products, excluding the current product
    const query = `
        SELECT p.id, p.name, p.image_url, p.price
        FROM products p
        WHERE p.id != ? AND (p.seller_id = ? OR p.type = ? OR p.category = ? OR p.color = ?)
        ORDER BY RAND() 
        LIMIT 4`;

    MariaDBConnection.query(query, [productId, sellerId, type, category, color])
        .then(results => {
            callback(null, results);
        })
        .catch(err => {
            callback(err, null);
        });
}

function serveProductDetailPage(request, response) {
    const parsedUrl = url.parse(request.url, true);
    const productId = parsedUrl.query.id;

    if (!productId) {
        response.writeHead(404, {'Content-Type': 'text/html'});
        response.write('Product not found');
        response.end();
        return;
    }

    const query = `
        SELECT p.*, u.username AS seller_name, u.id AS seller_id
        FROM products p
        JOIN users u ON p.seller_id = u.id
        WHERE p.id = ? AND p.available = 1`;

    MariaDBConnection.query(query, [productId])
        .then(results => {
            if (results.length === 0) {
                response.writeHead(404, {'Content-Type': 'text/html'});
                response.write('Product not found');
                response.end();
                return;
            }

            const product = results[0];
            fs.readFile(path.join(__dirname, '..', 'product-detail.html'), 'utf8', (err, data) => {
                if (err) {
                    response.writeHead(500, {'Content-Type': 'text/html'});
                    response.write('Error loading the product detail page');
                    response.end();
                    return;
                }

                // Fetch recommended products
                fetchRecommendedProducts(product.id, product.seller_id, product.type, product.category, product.color, (recErr, recommendedProducts) => {
                    if (recErr) {
                        response.writeHead(500, {'Content-Type': 'text/html'});
                        response.write('Error fetching recommended products');
                        response.end();
                        return;
                    }

                    // Generate HTML for recommended products
                    const recommendedHtml = recommendedProducts.map(rp => `
                        <div class="col-4">
                            <img src="${rp.image_url}" alt="${rp.name}">
                            <h4>${rp.name}</h4>
                            <p>$${rp.price.toFixed(2)}</p>
                            <a href="product-detail.html?id=${rp.id}">More details</a>
                        </div>
                    `).join('');

                    // Replace the placeholders in the HTML template with actual product data and recommended products
                    let pageContent = data
                        .replace('<!-- Image Placeholder -->', `<img src="${product.image_url}" alt="${product.name}">`)
                        .replace('<!-- Product Name Placeholder -->', product.name)
                        .replace('<!-- Seller Placeholder -->', `<a href="profile-page.html?userId=${product.seller_id}">${product.seller_name}</a>`)
                        .replace('<!-- Type Placeholder -->', `Type: ${product.type}`)
                        .replace('<!-- Category Placeholder -->', `Category: ${product.category}`)
                        .replace('<!-- Color Placeholder -->', `Color: ${product.color}`)
                        .replace('<!-- Price Placeholder -->', `$${product.price.toFixed(2)}`)
                        .replace('<!-- Product Description Placeholder -->', product.description)
                        .replace('<!-- Recommended Products Placeholder -->', recommendedHtml);

                    response.writeHead(200, {'Content-Type': 'text/html'});
                    response.write(pageContent);
                    response.end();
                });
            });
        })
        .catch(err => {
            response.writeHead(500, {'Content-Type': 'text/html'});
            response.write('Error fetching product details');
            response.end();
        });
}


function serveProfilePage(request, response) {
    const parsedUrl = url.parse(request.url, true);
    const userId = parsedUrl.query.userId;

    if (!userId) {
        response.writeHead(404, {'Content-Type': 'text/html'});
        response.write('Profile not found');
        response.end();
        return;
    }

    const userProfileQuery = `
        SELECT id, username, name, email, date_of_birth, address, pfp_url, description,
               email_visibility, date_of_birth_visibility, address_visibility
        FROM users
        WHERE id = ?`;

    // Fetch User Details
    MariaDBConnection.query(userProfileQuery, [userId])
        .then(userResult => {
            if (userResult.length === 0) {
                response.writeHead(404, {'Content-Type': 'text/html'});
                response.write('Profile not found');
                response.end();
                return;
            }

            const user = userResult[0];

            // Prepare to fetch products and blogs simultaneously
            const productsQuery = `SELECT * FROM products WHERE seller_id = ? AND available = 1`;
            const blogsQuery = `
            SELECT b.id, b.title, b.content, b.image_url, b.date, b.description,
                   GROUP_CONCAT(t.name SEPARATOR ', ') AS tags
            FROM blogs b
            LEFT JOIN blogs_tags bt ON b.id = bt.blog_id
            LEFT JOIN tags t ON bt.tag_id = t.id
            WHERE b.author_id = ?
            GROUP BY b.id
            ORDER BY b.date DESC`;

            // Use Promise.all to fetch both products and blogs at once
            Promise.all([
                MariaDBConnection.query(productsQuery, [userId]),
                MariaDBConnection.query(blogsQuery, [userId])
            ]).then(results => {
                const [products, blogs] = results;
                const filePath = path.join(__dirname, '..', 'profile-page.html');

                fs.readFile(filePath, 'utf8', (err, data) => {
                    if (err) {
                        console.error('Error reading HTML file:', err);
                        response.writeHead(500, {'Content-Type': 'text/html'});
                        response.write('Error loading the profile detail page');
                        response.end();
                        return;
                    }

                    let profileContent = data
                        .replace('<!-- Profile Image Placeholder -->', `<img src="${user.pfp_url || 'images/default-avatar.png'}" alt="Profile Image">`)
                        .replace('<!-- Name Placeholder -->', user.name)
                        .replace('<!-- Username Placeholder -->', user.username)
                        .replace('<!-- Email Placeholder -->', user.email_visibility && user.email ? `<strong>Email:</strong> ${user.email}` : '')
                        .replace('<!-- Date of Birth Placeholder -->', user.date_of_birth_visibility && user.date_of_birth ? `<strong>Date of Birth:</strong> ${new Date(user.date_of_birth).toLocaleDateString()}` : '')
                        .replace('<!-- Location Placeholder -->', user.address_visibility && user.address ? `<strong>Location:</strong> ${user.address}` : '')
                        .replace('<!-- Description Placeholder -->', user.description || '')
                        .replace('<!-- Products Placeholder -->', generateProductsHTML(products))
                        .replace('<!-- Blogs Placeholder -->', generateBlogsHTML(blogs));

                    response.writeHead(200, {'Content-Type': 'text/html'});
                    response.write(profileContent);
                    response.end();
                });
            }).catch(err => {
                console.error('Database query error:', err);
                response.writeHead(500, {'Content-Type': 'text/html'});
                response.write('Error fetching profile details');
                response.end();
            });
        })
        .catch(err => {
            console.error('Database query error:', err);
            response.writeHead(500, {'Content-Type': 'text/html'});
            response.write('Error fetching profile details');
            response.end();
        });
}

function generateProductsHTML(products) {
    if (products.length === 0) {
        return '<p>No products found.</p>';
    }
    return products.map(product => `
        <article>
            <img src="${product.image_url}" alt="${product.name}">
            <div class="product-info">
                <h3>${product.name}</h3>
                <p>$${product.price.toFixed(2)}</p>
                <button onclick="location.href='product-detail.html?id=${product.id}'">Details</button>
            </div>
        </article>
    `).join('');
}

function generateBlogsHTML(blogs) {
    if (blogs.length === 0) {
        return '<p>No blog posts found.</p>';
    }
    return blogs.map(blog => `
        <article>
            <img src="${blog.image_url}" alt="${blog.title}">
            <div class="blog-content">
                <div class="blog-info">
                    <span class="date">${new Date(blog.date).toLocaleDateString()}</span> |
                    <span class="tags">${blog.tags}</span>
                </div>
                <h3>${blog.title}</h3>
                <button onclick="location.href='blog-page.html?blogId=${blog.id}'">Read More</button>
            </div>
        </article>
    `).join('');
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
    const parsedUrl = url.parse(request.url, true); // True to parse query as object
    const pathname = parsedUrl.pathname; // Get the path without query string
  
    try {
        console.log(`${request.method} request for ${request.url}`,"Query:", parsedUrl.query);

        if (request.url.endsWith('.css')) {
            serveCSS(request, response);
        } else if (request.url === '/' || request.url === '/home.html') {
            serveHome(request, response);
        } else if (request.url.startsWith('/shop-filter')) {
            serveFilteredShop(request, response, parsedUrl.query);
        } else if (request.url === '/shop.html') {
            serveShop(request, response);
        } else if (pathname === '/blog-page.html') {
            serveBlogPage(request, response);
        } else if (request.url.startsWith('/blog')) {
            serveBlog(request, response);
        } else if (parsedUrl.pathname === '/product-detail.html') {
            serveProductDetailPage(request, response);
        } else if (request.url.startsWith('/profile-page.html')) {
            serveProfilePage(request, response);
        }else if (request.method === 'POST' && request.url === '/signin') {
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
