document.addEventListener('DOMContentLoaded', function () {
    setInboxData();
});

function setInboxData(){
    fetch('/get-acc-inbox', {
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
                populateAccountInbox(data);
            }
        })
        .catch(error => {
            console.error('Error:', error.message);
            // Handle network errors or unexpected server errors
        });
}

function populateAccountInbox(data) {
    const ordersDiv = document.getElementById('inbox-messages');
    ordersDiv.innerHTML = '';

    if (data) {
        const ordersHTML = data.map(message => `
            <tr>
                <td>${message.sender}</td>
                <td>${message.type}</td>
                <td>${message.date.substring(0,10)}</td>
            </tr>
        `).join('');
        
        ordersDiv.innerHTML = ordersHTML;
    }
}