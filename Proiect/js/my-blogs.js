document.addEventListener('DOMContentLoaded', function () {
    setInboxData();
});

function setInboxData(){
    fetch('/get-my-blogs', {
        method : 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ token: localStorage.getItem('jwtToken') }),
    })
        .then(response => {
            console.log('Response status:', response.status);
            console.log('Response headers:', response.headers);
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            console.log('Server response:', data);
            if (data.error) {
                console.error('Blogs error:', data.error);
                // Handle specific error cases if needed
            } else {
                console.log('Get Blogs was successful!');
                populateAccountBlogs(data);
            }
        })
        .catch(error => {
            console.error('Error:', error.message);
            // Handle network errors or unexpected server errors
        });
}

function populateAccountBlogs(data) {
    const blogsDiv = document.getElementById('blogs');
    blogsDiv.innerHTML = '';
    if (data) {
        if(data.lenght > 1){
            const ordersHTML = data.map(blog => `
                <div class="blog-post">
                    <img src="${blog.image}" alt="Floral Arrangement">
                    <div class="blog-post-content">
                        <h3 class="blog-post-title">${blog.title}</h3>
                        <p class="blog-post-desc">${blog.description}</p>
                        <a href="blog-page.html?blogId=${blog.id}" class="read-more-btn">Read more</a>
                    </div>
                </div>
            `).join('');
            
            blogsDiv.innerHTML = ordersHTML;
        }
        else{
            blogsDiv.innerHTML = `
                <div class="blog-post">
                    <img src="${data.image}" alt="Floral Arrangement">
                    <div class="blog-post-content">
                        <h3 class="blog-post-title">${data.title}</h3>
                        <p class="blog-post-desc">${data.description}</p>
                        <a href="blog-page.html?blogId=${data.id}" class="read-more-btn">Read more</a>
                    </div>
                </div>
            `;
        }
    }
}