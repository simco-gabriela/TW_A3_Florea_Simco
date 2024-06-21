document.addEventListener('DOMContentLoaded', function() {
    toggleSection('account-details'); 
    const hamburger = document.querySelector('.hamburger');
    const menu = document.querySelector('.menu');

    hamburger.addEventListener('click', function() {
        menu.classList.toggle('active');
    });
});
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
link.addEventListener('click', function(event) {
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
