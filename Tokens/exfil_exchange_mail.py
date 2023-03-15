import requests
import json
import base64

# This script requires a token from graph.microsoft.com

# Set up authentication parameters
token = '<your token here>'
headers = {
    'Authorization': 'Bearer ' + token,
    'Content-Type': 'application/json'
}

# Define the endpoint to retrieve emails
endpoint = 'https://graph.microsoft.com/v1.0/me/messages?$select=subject,body'

# Send a GET request to the endpoint to retrieve emails
response = requests.get(endpoint, headers=headers)

# Check if the request was successful (status code 200)
if response.status_code == 200:
    # Parse the JSON response
    data = json.loads(response.text)
    # Iterate through each email in the response
    for email in data['value']:
        # Get the email subject and body
        subject = email['subject']
        body = email['body']['content']
        # Check if the email has an HTML body
        if email['body']['contentType'] == 'html':
            # Save the HTML body to a file
            with open(subject + '.html', 'w') as f:
                f.write(body)
            print('HTML email downloaded:', subject + '.html')
    print('All emails downloaded.')
else:
    print('Error retrieving emails:', response.text)

