console.log('Script loaded'); // Check if script is loaded

document.addEventListener('DOMContentLoaded', function () {
    console.log('DOM fully loaded and parsed'); // Check if DOM is loaded

    const signinBtn = document.getElementById('signin-btn');
    const signupBtn = document.getElementById('signup-btn');
    const signinForm = document.getElementById('signin-form');
    const signupForm = document.getElementById('signup-form');

    signinBtn.addEventListener('click', function () {
        console.log('Signin button clicked');
        signinForm.style.display = 'block';
        signupForm.style.display = 'none';
    });

    signupBtn.addEventListener('click', function () {
        console.log('Signup button clicked');
        signinForm.style.display = 'none';
        signupForm.style.display = 'block';
    });

    signinForm.addEventListener('submit', function (event) {
        event.preventDefault();
        console.log("Sign-in form submitted");
        console.log("this:", this); // Check the context of `this`
        const emailInput = document.querySelector('[name="email"]');
        console.log(emailInput); // Check if `emailInput` is null or the correct element

        const email = emailInput.value;

        // const email = this.querySelector('[name="email"]').value;
        const password = document.querySelector('[name="password"]').value;
        console.log(email, password);
        performSignIn(email, password);

    });

    signupForm.addEventListener('submit', function (event) {
        event.preventDefault();
        console.log("Sign-up form submitted");
        const firstName = document.querySelector('[name="signupFirstName"]').value;
        const lastName = document.querySelector('[name="signupLastName"]').value;
        const email = document.querySelector('[name="signupEmail"]').value;
        const password = document.querySelector('[name="signupPassword"]').value;
        const confirmPassword = document.querySelector('[name="signupConfirmPassword"]').value;
    
        console.log(firstName, lastName, email, password, confirmPassword);
        performSignUp(firstName, lastName, email, password, confirmPassword);
    });
});

function performSignIn(email, password) {
    console.log("Attempting to sign in", email);
    fetch('/signin', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ email, password }),
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
                console.error('Sign-in error:', data.error);
                // Handle specific error cases if needed
            } else {
                console.log('Sign-in successful!');
                localStorage.setItem('jwtToken', data.token);

                //redirect to home page
                window.location.href = 'home.html';

                // Redirect or perform other actions upon successful sign-in
            }
        })
        .catch(error => {
            console.error('Error:', error.message);
            // Handle network errors or unexpected server errors
        });
}



function performSignUp(firstName, lastName, email, password, confirmPassword) {
    if (password !== confirmPassword) {
        alert("Passwords do not match.");
        return;
    }
    const username = (firstName + lastName).replace(/\s+/g, ''); // Remove all spaces
    console.log(`Generated username: ${username}`);

    fetch('/signup', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({
            username,
            name: firstName + " " + lastName,
            email,
            password
        })
    })
    .then(response => response.json())
    .then(data => {
        if (data.message) {
            alert('Signup successful, please sign in.');
            window.location.href = 'sign.html'; // Redirect to the sign-in page after successful sign-up
        }
    })
    .catch(error => {
        alert('Sign-up error: ' + error.message);
    });
}
