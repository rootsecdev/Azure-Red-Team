import requests
import json

# Define your bearer token
bearer_token = "<your MS Graph Token here>"

# Define the endpoint URL for the user's OneDrive files
url = "https://graph.microsoft.com/v1.0/me/drive/root/children"

# Set the Authorization header with the bearer token
headers = {
    "Authorization": f"Bearer {bearer_token}"
}

# Send a GET request to retrieve the list of files
response = requests.get(url, headers=headers)

# If the response status code is OK (200), print the file names
if response.status_code == 200:
    files = response.json()["value"]
    file_names = [file["name"] for file in files]
    print("File names:")
    for file_name in file_names:
        print(file_name)
else:
    # If the response status code is not OK, print the error message
    print(f"Error retrieving files: {response.status_code} - {response.text}")
