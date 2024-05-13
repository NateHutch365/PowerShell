<#
.SYNOPSIS
Audits Remote PowerShell access for all Exchange Online users and exports the results to a CSV file.

.DESCRIPTION
Connects to Exchange Online and retrieves the Remote PowerShell access status for each user, exporting the information to a CSV file. The file includes user name, display name, Remote PowerShell enabled status, and User Principal Name (UPN).

.VERSION
1.0

.REQUIRED ROLE
Requires Exchange Online Administrator role or equivalent permissions.

.AUTHOR
Nathan Hutchinson
Website: natehutchinson.co.uk
GitHub: https://github.com/NateHutch365
#>

# Connect to Exchange Online
Connect-ExchangeOnline

# Retrieve RemotePowerShellEnabled status for all users and export to CSV
Get-User -ResultSize unlimited | Select-Object Name,DisplayName,RemotePowerShellEnabled,UserPrincipalName | Export-Csv -Path "C:\Path\To\Temp\RemotePowerShellAudit.csv" -NoTypeInformation

Write-Output "Export complete. Remote PowerShell audit results saved to C:\Path\To\Temp\RemotePowerShellAudit.csv"
