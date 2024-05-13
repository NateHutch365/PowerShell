# Exchange Online PowerShell Management Scripts

This repository contains two PowerShell scripts for managing Remote PowerShell access for users in Exchange Online. These scripts allow administrators to audit and disable Remote PowerShell access in bulk.

## Scripts Overview

1. **Audit Remote PowerShell Access**: This script connects to Exchange Online, retrieves the Remote PowerShell enabled status for all users, and exports the data to a CSV file.
2. **Disable Remote PowerShell**: This script disables Remote PowerShell access for a list of users specified in a TXT file.

## Prerequisites

- PowerShell connected to Exchange Online
- Exchange Online Administrator role or equivalent permissions
- CSV file from the audit script for reviewing which users have Remote PowerShell enabled

## Usage Instructions

### 1. Auditing Remote PowerShell Access

- Run the first script to generate a CSV file with details on which users have Remote PowerShell enabled. 
- Script path: `C:\Path\To\Temp\RemotePowerShellAudit.csv`
- Review the CSV and decide which users should have Remote PowerShell disabled.

### 2. Preparing the TXT File

- Open the exported CSV file.
- Delete the rows corresponding to users who should retain Remote PowerShell access.
- Copy the remaining UPNs and paste them into a new TXT file, ensuring only one UPN per line with no headers.
- Save the TXT file as `C:\Path\To\Temp\RemovePowerShell.txt`.

### 3. Disabling Remote PowerShell

- Run the second script, which reads the TXT file and disables Remote PowerShell for each listed UPN.
- Confirm the updates by rerunning the audit script or checking user settings in Exchange Online.

## Author

- **Nathan Hutchinson**
  - Website: [natehutchinson.co.uk](http://natehutchinson.co.uk)
  - GitHub: [NateHutch365](https://github.com/NateHutch365)

## Version

- Version 1.0

## Notes

- Always ensure to back up user data and test scripts in a non-production environment before making bulk changes to user settings.
