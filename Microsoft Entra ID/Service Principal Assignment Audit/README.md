# Microsoft Graph Service Principal Assignment Audit

## Overview
This PowerShell script analyzes Microsoft Graph service principals and their role assignments, generating CSV reports of applications with and without role assignments.

## Script Details
- **Version**: 1.0.0
- **Creator**: William Francillette
  - Website: [french365connection.co.uk](https://french365connection.co.uk)
  - GitHub: [github.com/William-Francillette](https://github.com/William-Francillette)
- **Contributor**: Nathan Hutchinson
  - Website: [natehutchinson.co.uk](https://natehutchinson.co.uk)
  - GitHub: [github.com/NateHutch365](https://github.com/NateHutch365)

## Prerequisites
- PowerShell
- Microsoft Graph PowerShell Module
- Global Reader or Security Administrator

## Functionality
The script performs the following operations:
1. Checks and installs the Microsoft Graph PowerShell module
2. Connects to Microsoft Graph
3. Retrieves all service principals
4. Categorizes applications with and without role assignments
5. Generates CSV reports with assignment details

## Output Files
- `C:\Temp\ApplicationsWithAssignments.csv`: Lists applications requiring role assignments
- `C:\Temp\ApplicationsWithoutAssignments.csv`: Lists applications not requiring role assignments

## Required Permissions
- Requires `Application.Read.All` permission
- Must be run by a user with appropriate Azure AD administrative rights

## Usage
1. Ensure you have the necessary permissions
2. Run the script in PowerShell
3. Review the generated CSV files in the `C:\Temp` directory

## Disclaimer
Use this script responsibly and in accordance with your organization's security policies.