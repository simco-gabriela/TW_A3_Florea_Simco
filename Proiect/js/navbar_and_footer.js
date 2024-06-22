document.addEventListener('DOMContentLoaded', function () {
    function setupHamburgerMenu() {
        const hamburger = document.querySelector('.hamburger');
        const menu = document.querySelector('.menu');

        if (hamburger && menu) {
            hamburger.addEventListener('click', function () {
                menu.classList.toggle('active');
            });
        }
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
        loadHTML('footer.html', 'footer', setupHamburgerMenu);
        loadHTML('navbar.html', 'navbar', setupHamburgerMenu);
    }
    
    initialize();
});

