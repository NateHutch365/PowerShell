<#
.SYNOPSIS
This script connects to Microsoft Graph, creates a service principal for a specific application, and retrieves its details.

.DESCRIPTION
This PowerShell script uses the Microsoft Graph PowerShell SDK to:
1. Authenticate with Microsoft Graph using specific permissions.
2. Create a service principal for the Microsoft Defender for Endpoint application.
3. Display the details of the created service principal.

.VERSION
1.0

.REQUIRED ROLES
To run this script, the user must have administrative privileges with permissions to manage service principals in Azure AD:
- Application Administrator or higher

.AUTHOR
Nathan Hutchinson

.LINKS
Website: https://natehutchinson.co.uk
GitHub: https://github.com/NateHutch365
#>

# Connect to Microsoft Graph with required scopes
Connect-MgGraph -Scopes Directory.ReadWrite.All, Application.ReadWrite.All

# Create the service principal for the MicrosoftDefenderATP MAM app
$ServicePrincipal = New-MgServicePrincipal -Appid 'c2b688fe-48c0-464b-a89c-67041aa8fcb2'

# Check that the Service Principal exists
Get-MgServicePrincipal -ServicePrincipalId $ServicePrincipal.Id | Format-Table DisplayName, Id, AppId
