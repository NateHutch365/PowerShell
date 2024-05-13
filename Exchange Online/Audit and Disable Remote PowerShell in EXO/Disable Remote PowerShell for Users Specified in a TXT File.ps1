<#
.SYNOPSIS
Disables Remote PowerShell access for a list of users specified in a TXT file.

.DESCRIPTION
Reads a list of User Principal Names (UPNs) from a text file and disables Remote PowerShell access for each user. Intended for bulk updates to user settings based on audit results.

.VERSION
1.0

.REQUIRED ROLE
Requires Exchange Online Administrator role or equivalent permissions.

.AUTHOR
Nathan Hutchinson
Website: natehutchinson.co.uk
GitHub: https://github.com/NateHutch365
#>

$UserList = Get-Content "C:\Path\To\Temp\RemovePowerShell.txt"

$UserList | ForEach-Object {
    Set-User -Identity $_ -RemotePowerShellEnabled $false -Confirm:$false
}
