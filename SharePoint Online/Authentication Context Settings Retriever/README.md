# SharePoint Online Authentication Context Settings Retriever

## Overview

This PowerShell script retrieves detailed authentication context and conditional access settings for SharePoint Online sites. It provides administrators with a comprehensive view of site-level security configurations.

## Features

- Retrieve authentication context settings for all SharePoint Online sites
- Optionally use a custom list of sites from a text file
- Export detailed site security settings to a CSV file
- Capture key security parameters including:
  - Authentication Context Name
  - Conditional Access Policy
  - File Download Restrictions
  - Editing Permissions
  - Sensitivity Labels

## Prerequisites

### Software Requirements
- PowerShell
- SharePoint Online Management Shell Module

### Administrative Permissions
- Global Administrator OR
- SharePoint Service Administrator role in Microsoft 365

## Installation

1. Ensure you have the SharePoint Online Management Shell installed:
   ```powershell
   Install-Module -Name Microsoft.Online.SharePoint.PowerShell
   ```

2. Connect to SharePoint Online:
   ```powershell
   Connect-SPOService -Url https://yourtenant-admin.sharepoint.com
   ```

## Usage

### Retrieving All Sites
Set `$useAllSites = $true` to retrieve settings for all sites in your tenant.

### Using a Custom Site List
1. Create a text file (e.g., `SiteList.txt`) with site URLs, one per line
2. Set `$useAllSites = $false`
3. Update `$siteListFile` with the path to your site list

### Running the Script
```powershell
.\Get-SPOAuthContextSettings.ps1
```

## Output

The script generates a CSV file at `C:\TS-Temp\Clients\ClientName\SPOConditionalAccessSettings.csv` with the following columns:
- Url
- AuthenticationContextName
- ConditionalAccessPolicy
- AllowDownloadingNonWebViewableFiles
- LimitedAccessFileType
- AllowEditing
- SensitivityLabel
- BlockDownloadLinksFileType
- AuthenticationContextLimitedAccess

## Configuration Options

- `$useAllSites`: Toggle between all sites or custom site list
- `$siteListFile`: Path to custom site list text file
- `$outputFile`: Destination for the exported CSV

## Author

**Nathan Hutchinson**
- Website: [natehutchinson.co.uk](https://natehutchinson.co.uk)
- GitHub: [NateHutch365](https://github.com/NateHutch365)

## Version

1.0.0

## License

[Specify your license here, e.g., MIT, Apache 2.0]

## Disclaimer

This script is provided as-is. Always test in a non-production environment first and ensure you have appropriate backups.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.