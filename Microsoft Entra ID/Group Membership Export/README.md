# GetGroupMembership

## Overview
**GetGroupMembership** is a PowerShell script that retrieves the `userPrincipalName` for all user objects in a specified Azure AD (Entra ID) group using Microsoft Graph. The script uses delegated permissions to authenticate, retrieves the group's members, and then extracts and exports each user's `userPrincipalName` to a text file located in `C:\TS-Temp\`. The output file is automatically named based on the provided group name (e.g., `CA-Internals.txt`).

## Features
- **Graph Authentication:** Connects to Microsoft Graph using delegated permissions.
- **Group Lookup:** Retrieves a group by its display name or ObjectId.
- **Member Processing:** Iterates through group members to extract `userPrincipalName` for valid user objects.
- **Automated Export:** Saves the extracted user principal names to a text file in `C:\TS-Temp\`.

## Prerequisites
- **PowerShell:** Windows PowerShell 5.1 or later, or PowerShell Core.
- **Microsoft Graph PowerShell Module:**
```powershell
  Install-Module Microsoft.Graph
```

- **Required Permissions:**  
  The account executing this script must have permissions to read user profiles and group memberships in Azure AD. Typically, a role like **Directory Readers** or equivalent permissions is required.

## Usage
1. **Clone or Download:**  
   Clone this repository or download the script file (`GetGroupMembership.ps1`).

2. **Open PowerShell:**  
   Navigate to the directory containing the script.

3. **Run the Script:**  
   Execute the script by providing the group name:
```
   .\GetGroupMembership.ps1 -GroupName "CA-Internals" -Verbose
```

   - You can also use the `-Display` flag to output the list to the terminal
```
   .\GetGroupMembership.ps1 -GroupName "CA-Internals" -Display
```
   - The `-Verbose` flag provides detailed output for troubleshooting.
   - The script will prompt you to sign in to Microsoft Graph. Use an account with the necessary permissions.

4. **Output:**  
   The script creates an output file at `C:\TS-Temp\CA-Internals.txt` (if you used "CA-Internals" as the group name) containing the list of user principal names.

## Script Details
- **Version:** 1.0.0
- **Author:** Nathan Hutchinson
- **Website:** [natehutchinson.co.uk](https://natehutchinson.co.uk)
- **GitHub:** [https://github.com/NateHutch365](https://github.com/NateHutch365)

## Troubleshooting
- **Empty Output File:**  
  - Use the `-Verbose` flag to display detailed execution logs.
  - Ensure that the authenticated account has the correct permissions to access group and user details.
  
- **Module Issues:**  
  - If the Microsoft.Graph module is not installed, install it using:
```
    Install-Module Microsoft.Graph
```

## Contributing
Contributions, suggestions, and bug reports are welcome! Feel free to fork this repository and submit pull requests with any enhancements or fixes.

## License
This project is licensed under the MIT License.
