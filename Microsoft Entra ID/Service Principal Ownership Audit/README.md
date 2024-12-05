# Microsoft Graph Service Principal Ownership Audit

## Overview
This PowerShell script retrieves all service principals and their owners from Microsoft Entra ID (Azure Active Directory) using the Microsoft Graph PowerShell SDK.

## Authors
- **William Francillette**
  - Website: [french365connection.co.uk](https://french365connection.co.uk)
  - GitHub: [William-Francillette](https://github.com/William-Francillette)

- **Nathan Hutchinson**
  - Website: [natehutchinson.co.uk](https://natehutchinson.co.uk)
  - GitHub: [NateHutch365](https://github.com/NateHutch365)

## Prerequisites
- PowerShell 5.1 or higher
- Microsoft Graph PowerShell SDK
- Administrative access to retrieve service principal information

## Required Roles
- Global Reader
- Application Reader

## Installation
1. Ensure Microsoft Graph PowerShell SDK is installed:
   ```powershell
   Install-Module -Name Microsoft.Graph -Scope CurrentUser -Force
   ```

## Usage
1. Run the script with appropriate permissions
2. The script will:
   - Connect to Microsoft Graph
   - Retrieve all service principals
   - Export owners to a CSV file at `C:\Temp\ApplicationsAndOwners.csv`

## Output
The script generates a CSV file with the following columns:
- `DisplayName`: Name of the service principal
- `AppId`: Application ID of the service principal
- `Owners`: Semicolon-separated list of owner names

## Version
1.0.0

## Disclaimer
Use this script responsibly and in accordance with your organization's security policies.