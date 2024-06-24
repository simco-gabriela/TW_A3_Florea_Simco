let IMAGE_DISPLAY_TAG = document.querySelector('#profile-image-display');
let NAME_DISPLAY_TAG = document.querySelector('#name-display');
let EMAIL_DISPLAY_TAG = document.querySelector('#email-display');
let USERNAME_DISPLAY_TAG = document.querySelector('#username-display');
let DOB_DISPLAY_TAG = document.querySelector('#dob-display');
let ADDRESS_DISPLAY_TAG = document.querySelector('#address-display');




function populateAccountData(data) {
    IMAGE_DISPLAY_TAG.src = data.pfp_url;
    NAME_DISPLAY_TAG.textContent = data.name;
    EMAIL_DISPLAY_TAG.textContent = data.email;
    USERNAME_DISPLAY_TAG.textContent = data.username;
    DOB_DISPLAY_TAG.textContent = data.date_of_birth.substring(0,10);
    ADDRESS_DISPLAY_TAG = data.address;
}

function generateStarRating(rating) {
    const fullStar = '<span class="star">&#9733;</span>';
    const emptyStar = '<span class="star">&#9734;</span>';
    let starHTML = '';
    for (let i = 1; i <= 5; i++) {
        if (i <= rating) {
            starHTML += fullStar;
        } 
        else {
            starHTML += emptyStar;
        }
    }
    return starHTML;
}

function populateReviewsData(data) {
    const reviewsDiv = document.getElementById('reviews-section');
    reviewsDiv.innerHTML = '';
    console.log(data);

    if (data) {
        const reviewsHTML = data.map(review => `
            <div class="review">
                <img src="${review.image_url}" alt="Flower" class="product-image">
                <div class="review-text">
                    <a href="product-detail.html?id=${review.product_id}"><h3>Flower 1</h3></a>
                    <div class="star-rating">${generateStarRating(review.rating)}</div>
                    <p class="review-comment">${review.comment}</p>
                </div>
            </div>
        `).join('');
        
        reviewsDiv.innerHTML = reviewsHTML;
    }
}



document.addEventListener('DOMContentLoaded', function () {
    toggleSection('account-details');
    setAccountData();
    setReviewsData();
});

function setAccountData(){
    fetch('/get-acc-details', {
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
                console.error('Account error:', data.error);
                // Handle specific error cases if needed
            } else {
                
                console.log('Get Account was successful!');
                populateAccountData(data);
            }
        })
        .catch(error => {
            console.error('Error:', error.message);
            // Handle network errors or unexpected server errors
        });
}


function setReviewsData(){
    fetch('/get-acc-reviews', {
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
                console.error('Reviews error:', data.error);
                // Handle specific error cases if needed
            } else {
                
                console.log('Get Reviews was successful!');
                populateReviewsData(data);
            }
        })
        .catch(error => {
            console.error('Error:', error.message);
            // Handle network errors or unexpected server errors
        });
}

function toggleEdit(displayId, inputId) {
    var displayElement = document.getElementById(displayId);
    var inputElement = document.getElementById(inputId);
    if (inputElement.style.display === 'none') {
        inputElement.style.display = 'block';
        displayElement.style.display = 'none';
    } else {
        inputElement.style.display = 'none';
        displayElement.style.display = 'block';
    }

    document.querySelectorAll('.sidebar nav ul li a').forEach(link => {
        link.addEventListener('click', function (event) {
            event.preventDefault();
            const sectionId = link.getAttribute('onclick').split("'")[1]; // Extract sectionId from onclick attribute
            toggleSection(sectionId);
        });
    });

}

function toggleSection(sectionId) {
    document.querySelectorAll('.content-area').forEach(section => {
        section.style.display = 'none';
    });

    document.querySelectorAll('.sidebar nav ul li').forEach(li => {
        li.classList.remove('active');
    });

    // Display the clicked section and highlight the corresponding sidebar link
    const sectionToShow = document.getElementById(sectionId);
    const sidebarLinkToHighlight = document.querySelector(`.sidebar nav ul li a[onclick="toggleSection('${sectionId}')"]`).parentNode;

    if (sectionToShow) {
        sectionToShow.style.display = 'block';
        sidebarLinkToHighlight.classList.add('active');
    }
}

function updatePrivacySettings() {
    const emailVisibility = document.getElementById('email-visibility').checked;
    const dobVisibility = document.getElementById('dob-visibility').checked;
    const addressVisibility = document.getElementById('address-visibility').checked;

    // Log for demonstration; replace with API call to save settings server-side
    console.log('Privacy settings updated:', {
        emailVisibility,
        dobVisibility,
        addressVisibility
    });

    alert('Privacy settings have been updated.');
}

function changePassword() {
    const currentPassword = document.getElementById('current-password').value;
    const newPassword = document.getElementById('new-password').value;
    const confirmNewPassword = document.getElementById('confirm-new-password').value;

    if (newPassword !== confirmNewPassword) {
        alert('The new passwords do not match. Please try again.');
        return;
    }

    // Simulate password change process
    console.log('Password change requested:', {
        currentPassword,
        newPassword
    });

    // Assuming password change is successful
    alert('Password changed successfully!');
}

function logout() {
    console.log('User logged out.');

    // Redirect to the home page
    window.location.href = 'home.html';
}
