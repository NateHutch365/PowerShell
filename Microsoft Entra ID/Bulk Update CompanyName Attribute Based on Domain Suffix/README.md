# Update Entra ID User Company Attribute

## Overview
This PowerShell script updates the company attribute for users in Entra ID (formerly Azure AD) based on their email domain suffixes. It connects to Microsoft Graph to perform updates and logs the outcomes to a CSV file for easy tracking of changes and error management.

## Features
- **Automatic Module Management**: Ensures the `Microsoft.Graph.Users` module is installed or updated before execution.
- **Domain Mapping**: Dynamically assigns company names based on the user's email domain.
- **Detailed Logging**: Outputs success and failure logs to a CSV file with comprehensive details.

## Prerequisites
- **PowerShell 5.1 or later**: Ensure that PowerShell is installed on your system.
- **Microsoft.Graph.Users Module**: This script will install or update this module as needed.
- **Microsoft Graph Permissions**: The executing user must have the `User.ReadWrite.All` permission in Microsoft Graph.

## Installation
No installation is required for the script itself, but it does require the `Microsoft.Graph.Users` module which it will install or update upon execution. Make sure you run PowerShell with administrative privileges if you encounter any permissions issues during module installation or updating.

## Usage
To run the script, follow these steps:
1. Open PowerShell.
2. Navigate to the directory containing the script.
3. Execute the script:
   ```powershell
   .\UpdateUserCompanyAttribute.ps1
