<#
.SYNOPSIS
This PowerShell script checks for inactive Microsoft 365 users who have not logged in within a specified number of days and exports the details to a CSV file.

.DESCRIPTION
The script retrieves user accounts from Microsoft 365, checks for users who haven't logged in for a specified number of days, and exports a list of these inactive users to a CSV file. It only includes users whose accounts are enabled.

.VERSION
1.0

.AUTHOR
Nathan Hutchinson
Website: natehutchinson.co.uk
GitHub: https://github.com/NateHutch365

.NOTES
Requires Microsoft Graph PowerShell SDK and Global Administrator permissions to run.

.EXAMPLE
PS> .\CheckInactiveUsers.ps1
# This will execute the script using the default parameters set within the script.
#>

# User-defined variables
$daysInactive = 90  # Number of days to check for inactivity
$outputCsvLocation = "C:\Path\To\Output\inactive_users.csv"  # Output CSV file path

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "User.Read.All", "AuditLog.Read.All" -NoWelcome

# Get the date from X days ago
$dateCutoff = (Get-Date).AddDays(-$daysInactive)

# Retrieve users and check their sign-in activity and account status
$users = Get-MgUser -All:$true -Property "Id,DisplayName,UserPrincipalName,SignInActivity,AccountEnabled"
$inactiveUsers = @()

foreach ($user in $users) {
    if ($user.AccountEnabled -eq $true) {
        if ($user.SignInActivity) {
            try {
                $lastSignIn = [DateTime]::Parse($user.SignInActivity.LastSignInDateTime)
                if ($lastSignIn -lt $dateCutoff) {
                    $inactiveUsers += $user | Select-Object Id, DisplayName, UserPrincipalName, @{Name="LastSignIn"; Expression={$lastSignIn}}, AccountEnabled
                }
            } catch {
                Write-Host "Unable to parse LastSignInDateTime for user: $($user.DisplayName)"
            }
        } else {
            Write-Host "No SignInActivity found for user: $($user.DisplayName)"
        }
    } else {
        Write-Host "Account is disabled for user: $($user.DisplayName)"
    }
}

# Export the results to a CSV file
$inactiveUsers | Export-Csv -Path $outputCsvLocation -NoTypeInformation

# Disconnect from Microsoft Graph
Disconnect-MgGraph