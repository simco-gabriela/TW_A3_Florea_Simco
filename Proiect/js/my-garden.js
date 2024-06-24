let TEMPERATURE_TAG = document.querySelector('#temperature-sensor');
let HUMIDTY_TAG = document.querySelector('#humidity-sensor');
let WEATHER_TAG = document.querySelector('#weather-sensor');
let SOIL_MOISTURE_TAG = document.querySelector('#soil-moisture-sensor');
let DESCRIPTION_TAG = document.querySelector('#garden-description');
let TIP1_TAG = document.querySelector('#tip1');
let TIP2_TAG = document.querySelector('#tip2');
let SHOP_BUTTON_TAG = document.querySelector('#shop-button')

function populateGardenData(data) {
    DESCRIPTION_TAG.textContent = data.description;

    const latitude = data.latitude;
    const longitude = data.longitude;

    if(data.is_shop.data[0] == 1){
        SHOP_BUTTON_TAG.style.display = 'none';
    }
    displayFlowerStage(data.image, data.color);

    const apiUrl = `https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&hourly=temperature_2m,relative_humidity_2m,weathercode,soil_moisture_0_1cm`;

    fetch(apiUrl)
        .then(response => response.json())
        .then(data => {
            displayData(data);
        })
        .catch(error => {
            console.error('Error fetching data:', error);
        });

}

function displayFlowerStage(data, color) {
    getPredominantColor(data, color)
}

function getPredominantColor(imagePath, flowerColor) {
    const canvas = document.getElementById('canvas');
    const ctx = canvas.getContext('2d');
    const img = new Image();

    img.src = imagePath;
    img.crossOrigin = "Anonymous"; // To avoid CORS issues if loading from a different domain
    img.onload = function () {
        canvas.width = img.width;
        canvas.height = img.height;
        ctx.drawImage(img, 0, 0, img.width, img.height);

        const imageData = ctx.getImageData(0, 0, img.width, img.height);
        const data = imageData.data;
        const colorRanges = {
            'red': { minR: 0, maxR: 255, minG: 0, maxG: 50, minB: 0, maxB: 50 },
            'pink': { minR: 200, maxR: 255, minG: 0, maxG: 150, minB: 100, maxB: 200 },
            'yellow': { minR: 200, maxR: 255, minG: 150, maxG: 255, minB: 0, maxB: 100 },
            'orange': { minR: 200, maxR: 255, minG: 50, maxG: 204, minB: 0, maxB: 102 },
            'purple': { minR: 102, maxR: 204, minG: 0, maxG: 102, minB: 102, maxB: 255 },
            'blue': { minR: 0, maxR: 102, minG: 0, maxG: 204, minB: 204, maxB: 255 },
            'green': { minR: 0, maxR: 100, minG: 100, maxG: 255, minB: 0, maxB: 100 }
        };

        let totalCount = 0;
        let matchedCount = 0;
        let greenCount = 0;

        for (let i = 0; i < data.length; i += 4) {
            const r = data[i];
            const g = data[i + 1];
            const b = data[i + 2];
            totalCount++;

            if (
                r >= colorRanges.green.minR && r <= colorRanges.green.maxR &&
                g >= colorRanges.green.minG && g <= colorRanges.green.maxG &&
                b >= colorRanges.green.minB && b <= colorRanges.green.maxB
            ) {
                greenCount++;
            }

            if (flowerColor !== 'green' && isColorShade({ r, g, b }, flowerColor, colorRanges)) {
                matchedCount++;
            }
        }

        if(matchedCount > greenCount){
            TIP1_TAG.textContent = 'Your flower is fully grown!';
        }
        else {
            TIP1_TAG.textContent = 'Your flower is still growing!';
        }
    };
}


function isColorShade(pixelColor, targetColorName, colorRanges) {
    let { r, g, b } = pixelColor;
    let range = colorRanges[targetColorName];

    if (!range) {
        return false; // If targetColorName is not found in colorRanges, return false
    }

    return (
        r >= range.minR && r <= range.maxR &&
        g >= range.minG && g <= range.maxG &&
        b >= range.minB && b <= range.maxB
    );
}



function displayData(data) {

    const weatherDataDiv = document.getElementById('weatherData');
    weatherDataDiv.innerHTML = '';

    if (data && data.hourly) {
        const hourlyData = data.hourly;
        const temperature = hourlyData.temperature_2m[0];
        const humidity = hourlyData.relative_humidity_2m[0];
        const weatherCode = hourlyData.weathercode[0];
        const soilMoisture = hourlyData.soil_moisture_0_1cm[0];
        const weatherDescription = getWeatherDescription(weatherCode);

        weatherDataDiv.innerHTML = `
            <div id="temperature-sensor" class="sensor-panel">
                <h4>Temperature</h4>
                <p>${temperature} °C</p>
            </div>
            <div id="humidity-sensor"  class="sensor-panel">
                <h4>Humidity</h4>
                <p> ${humidity} %</p>
            </div>
            <div id="weather-sensor" class="sensor-panel">
                <h4>Weather</h4>
                <p>${weatherDescription}</p>
            </div>
            <div id="soil-moisture-senso" class="sensor-panel">
                <h4>Soil moisture</h4>
                <p>${soilMoisture} m³/m³</p>
            </div>
        `;
        let result = 'Based on your sensors ';
        if(temperature < 15) {
            result += 'its too cold for your flower, ';
        }
        else if(temperature > 25) {
            result += 'its too hot for your flower, ';
        }
        else  result += 'the temperature is just right, '

        if(humidity > 80) {
            result += 'its too humid for your flower and ';
        }
        else if(humidity < 40) {
            result += 'the air is too dry for your flower and ';
        }
        else  result += 'the air humidity is just right and ';
        
        if (soilMoisture > 0.45) {
            result += 'the moisture in the soil is too high for your flower.';
        }
        else if (soilMoisture < 0.25) {
            result += 'you need to water your flower, the soil is very dry.';
        }
        else {
            result += 'the soil moisture is just right.';
        }
        TIP2_TAG.textContent = result;


    } else {
        weatherDataDiv.innerHTML = '<p>No data available for the provided coordinates.</p>';
    }

}

function getWeatherDescription(weatherCode) {
    const weatherDescriptions = {
        0: "Clear sky",
        1: "Mainly clear",
        2: "Partly cloudy",
        3: "Overcast",
        45: "Fog",
        48: "Depositing rime fog",
        51: "Drizzle: Light intensity",
        53: "Drizzle: Moderate intensity",
        55: "Drizzle: Dense intensity",
        56: "Freezing Drizzle: Light intensity",
        57: "Freezing Drizzle: Dense intensity",
        61: "Rain: Slight intensity",
        63: "Rain: Moderate intensity",
        65: "Rain: Heavy intensity",
        66: "Freezing Rain: Light intensity",
        67: "Freezing Rain: Heavy intensity",
        71: "Snow fall: Slight intensity",
        73: "Snow fall: Moderate intensity",
        75: "Snow fall: Heavy intensity",
        77: "Snow grains",
        80: "Rain showers: Slight intensity",
        81: "Rain showers: Moderate intensity",
        82: "Rain showers: Violent intensity",
        85: "Snow showers: Slight intensity",
        86: "Snow showers: Heavy intensity",
        95: "Thunderstorm: Slight or moderate",
        96: "Thunderstorm with slight hail",
        99: "Thunderstorm with heavy hail"
    };

    return weatherDescriptions[weatherCode] || "Unknown weather code";
}

function setGardenData() {
    fetch('/get-my-garden', {
        method: 'POST',
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
            if(!data) {
                window.location.href = 'garden-create.html';
            }
            if (data.error) {
                console.error('Account error:', data.error);
                // Handle specific error cases if needed
            } else {

                console.log('Get Garden was successful!');
                populateGardenData(data);
            }
        })
        .catch(error => {
            console.error('Error:', error.message);
            // Handle network errors or unexpected server errors
        });
}


document.addEventListener('DOMContentLoaded', function () {
    setGardenData();
});

