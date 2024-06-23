function setupHamburgerMenu() {
    const hamburger = document.querySelector('.hamburger');
    const menu = document.querySelector('.menu');
    if (hamburger && menu) {
        hamburger.addEventListener('click', function () {
            menu.classList.toggle('active');
        });
    }
    
}

function logout(e) {
    localStorage.removeItem('jwtToken');
    window.location.href = 'home.html';
}

function loadHTML(file, elementID, callback) {
    fetch(file)
        .then(response => response.text())
        .then(data => {
            document.getElementById(elementID).innerHTML = data;
            if (callback) callback();
        });
}

function initialize() {
    if (localStorage.getItem('jwtToken')) {
        loadHTML('navbar.html', 'navbar', setupHamburgerMenu);
        console.log("logged in");
    } else {
        loadHTML('navbar-not-logged.html', 'navbar', setupHamburgerMenu);
        console.log("not logged in");
    }
    loadHTML('footer.html', 'footer', setupHamburgerMenu);
}

document.addEventListener('DOMContentLoaded', function () {
    initialize();
});
            
            