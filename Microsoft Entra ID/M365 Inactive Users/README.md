# Microsoft 365 Inactive User Check Script

This PowerShell script identifies Microsoft 365 users who have not logged in for a specified number of days and exports a list of these inactive users to a CSV file. It is useful for administrators looking to manage user activity and ensure security compliance by tracking inactive accounts.

## Features

- **User Activity Check**: Identifies users who haven't logged in within a customizable number of days.
- **Active Account Filter**: Excludes disabled accounts to focus on active users.
- **Export to CSV**: Outputs the data to a CSV file for further analysis or record-keeping.

## Requirements

- **Microsoft Graph PowerShell SDK**: The script requires the Microsoft Graph PowerShell SDK. Install it using PowerShell with the command:
    ```powershell
    Install-Module -Name Microsoft.Graph -Scope CurrentUser
    ```
- **Permissions**: You must have Global Administrator permissions to run this script, as it accesses sensitive user sign-in data.
- **Microsoft 365**: A valid Microsoft 365 subscription and administrative credentials.

## Installation

1. Clone the repository or download the script file directly:
   ```bash
   git clone https://github.com/NateHutch365/m365-inactive-user-script.git

2. Navigate to the directory containing the script.

## Usage

To run the script, open PowerShell and navigate to the script's directory. Modify the script parameters `$daysInactive` and `$outputCsvLocation` as needed to fit your requirements:

1. **Set the number of inactive days**:
   - Modify the `$daysInactive` variable to set the number of days to check for inactivity.

2. **Set the CSV output location**:
   - Change `$outputCsvLocation` to specify the path and filename where the CSV output should be saved.

Execute the script by running:
   ```powershell
   .\CheckInactiveUsers.ps1

## Example

Running the script with 30 days of inactivity threshold and exporting to "C:\Reports\inactive_users.csv":
   ```powershell
   $daysInactive = 30
   $outputCsvLocation = "C:\Reports\inactive_users.csv"
   .\CheckInactiveUsers.ps1

## Author

**Nathan Hutchinson**

- Website: [natehutchinson.co.uk](http://natehutchinson.co.uk)
- GitHub: [NateHutch365](https://github.com/NateHutch365)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
