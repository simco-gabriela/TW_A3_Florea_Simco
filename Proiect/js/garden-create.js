document.getElementById('gardenForm').addEventListener('submit', function(event) {
    event.preventDefault();
    const name = document.getElementById('gardenName').value;
    const latitude = document.getElementById('gardenLatitude').value;
    const longitude = document.getElementById('gardenLongitude').value;
    const flowerType = document.getElementById('gardenFlowerType').value;
    const colorType = document.getElementById('gardenColorType').value;
    const image = document.getElementById('gardenImagePath').value;
    const description = document.getElementById('gardenContent').value;
    const token = localStorage.getItem('jwtToken'); 

    fetch('/create-garden', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            token, name, latitude, longitude, description, image: image, flowerType, colorType
        })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Garden created successfully! Redirecting...');
            window.location.href = '/my-garden.html'; // Adjust as necessary
        } else {
            alert('Failed to create garden: ' + data.message);
        }
    })
    .catch(error => {
        alert('Error creating garden: ' + error.message);
    });
});