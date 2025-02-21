# Shared Mailbox Status Export

## Description
This PowerShell script retrieves a list of shared mailboxes from Exchange Online, checks their account status in Microsoft Entra ID (via Microsoft Graph), and exports the information to a CSV file.

## Version
**1.0**

## Author
**Nathan Hutchinson**  
[Website](https://natehutchinson.co.uk)  
[GitHub](https://github.com/NateHutch365)  

## Requirements
- **PowerShell 7+**
- **Exchange Online Management Module**
- **Microsoft Graph PowerShell Module**

## Required Permissions
The script requires the following permissions:
- **Exchange Online:** `View-Only Recipients` or an equivalent admin role.
- **Microsoft Graph:** `User.Read.All` (requires directory read permissions).

## Installation
Ensure the required PowerShell modules are installed:
```powershell
Install-Module ExchangeOnlineManagement -Scope CurrentUser
Install-Module Microsoft.Graph -Scope CurrentUser
```

## Usage
1. Connect to Exchange Online and Microsoft Graph before running the script:
   ```powershell
   Connect-ExchangeOnline
   Connect-MgGraph -Scopes "User.Read.All"
   ```

2. Run the script:
   ```powershell
   .\SharedMailboxStatusExport.ps1
   ```

3. The output file will be saved to:
   ```
   C:\Temp\SharedMailboxes.csv
   ```

## Script Execution Flow
1. Connects to Exchange Online and Microsoft Graph.
2. Retrieves all shared mailboxes.
3. Checks their account status in Microsoft Entra ID.
4. Saves the results to a CSV file.

## Output Format
The CSV file will contain:
```
DisplayName, Mail, AccountEnabled
```

## Error Handling
- If a mailbox has no `ExternalDirectoryObjectId`, it will be skipped.
- Errors encountered while querying Microsoft Graph will be logged.

## License
This script is licensed under the [MIT License](LICENSE).

## Contributing
Contributions are welcome! Feel free to fork the repository and submit a pull request.
