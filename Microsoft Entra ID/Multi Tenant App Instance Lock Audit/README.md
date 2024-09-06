# Multi-Tenant App Instance Property Lock Audit Script

This PowerShell script audits multi-tenant application instance property lock configurations in Microsoft Entra ID (formerly Azure AD). It's designed to help administrators and security professionals quickly review and export security settings for multi-tenant applications.

## Features

- Connects to Microsoft Graph API
- Retrieves all multi-tenant applications in your Entra ID environment
- Exports app instance property lock configurations to a CSV file
- Provides a quick overview of security settings for compliance and audit purposes

## Requirements

- PowerShell 5.1 or higher
- Microsoft Graph PowerShell SDK
- Entra ID account with the Application.Read.All permission

## Installation

1. Ensure you have PowerShell 5.1 or higher installed on your system.
2. Install the Microsoft Graph PowerShell SDK by running:
   ```powershell
   Install-Module Microsoft.Graph -Scope CurrentUser
   ```
3. Clone this repository or download the script file.

## Usage

1. Open PowerShell and navigate to the directory containing the script.
2. Update the `$outputCsvLocation` variable in the script to specify your desired output location.
3. Run the script:
   ```powershell
   .\MultiTenantAppInstanceLockAudit.ps1
   ```
4. When prompted, authenticate with your Entra ID account that has the necessary permissions.
5. The script will execute and export the results to the specified CSV file.

## Output

The script generates a CSV file with the following information for each multi-tenant application:

- Application ID
- Display Name
- Sign-in Audience
- App Instance Property Lock Enabled status
- All Properties Locked status
- Credentials Used for Verification Locked status
- Credentials Used for Signing Tokens Locked status
- Token Encryption Key ID Locked status

## Contributing

Contributions to improve the script are welcome. Please feel free to submit a Pull Request.

## License

[MIT License](LICENSE)

## Author

Nathan Hutchinson

- Website: [natehutchinson.co.uk](https://natehutchinson.co.uk)
- GitHub: [@NateHutch365](https://github.com/NateHutch365)

## Disclaimer

This script is provided as-is, and you use it at your own risk. Always review and test scripts thoroughly before using them in a production environment.
