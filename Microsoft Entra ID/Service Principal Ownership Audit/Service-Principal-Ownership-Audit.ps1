<# 
.SYNOPSIS
Microsoft Graph Service Principal Ownership Audit

.DESCRIPTION
This PowerShell script retrieves all service principals and their owners from Microsoft Entra ID (Azure Active Directory)
using Microsoft Graph PowerShell SDK.

.NOTES
Version: 1.0.0
Created by: William Francillette (https://french365connection.co.uk)
Contributor: Nathan Hutchinson (https://natehutchinson.co.uk)

GitHub:
- William Francillette: https://github.com/William-Francillette
- Nathan Hutchinson: https://github.com/NateHutch365

Required Roles: 
- Global Reader
- Application Reader

.REQUIREMENTS
- Microsoft Graph PowerShell SDK
- PowerShell 5.1 or higher
- Administrative access to retrieve service principal information
#>

# Ensure the required module is installed
if (!(Get-Module -ListAvailable -Name Microsoft.Graph)) {
    Install-Module -Name Microsoft.Graph -Scope CurrentUser -Force
}

# Import the Graph module
Import-Module Microsoft.Graph

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "Application.Read.All", "Directory.Read.All"

# Retrieve all service principals and expand the owners property
$sps = Get-MgServicePrincipal -All -ExpandProperty Owners

# Process applications and their owners
$appOwners = $sps | ForEach-Object {
    $appName = $_.DisplayName
    $appId = $_.AppId
    $owners = @()

    if ($_.Owners) {
        $owners = $_.Owners | ForEach-Object {
            try {
                (Get-MgDirectoryObject -DirectoryObjectId $_.Id).AdditionalProperties.displayName
            } catch {
                Write-Warning "Failed to retrieve owner details for ID: $_.Id"
                $null
            }
        }
    }

    [PSCustomObject]@{
        DisplayName = $appName
        AppId       = $appId
        Owners      = $owners -join "; " # Combine owner names into a single semicolon-separated string
    }
}

# Define the output file path
$outputDirectory = "C:\Temp"
$outputCsv = "$outputDirectory\ApplicationsAndOwners.csv"

# Ensure the output directory exists
if (!(Test-Path -Path $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory -Force
}

# Export the results to a CSV
$appOwners | Export-Csv -Path $outputCsv -NoTypeInformation -Encoding UTF8

# Output confirmation message
Write-Output "Applications and their owners exported to: $outputCsv"

# Disconnect from Microsoft Graph
Disconnect-MgGraph