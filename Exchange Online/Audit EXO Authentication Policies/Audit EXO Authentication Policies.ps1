<#
.SYNOPSIS
This script audits and reports on user authentication policies within Exchange Online, specifically for users within specified domains.

.DESCRIPTION
The script lists all existing authentication policies, highlights the default authentication policy, audits users by domain for their assigned authentication policy, and exports the findings to a CSV file.

.VERSION
1.0

.REQUIRED ROLE
To run this script, you must have the Exchange Online Administrator role or equivalent permissions to retrieve authentication policies and user details.

.AUTHOR
Nathan Hutchinson
Website: natehutchinson.co.uk
GitHub: https://github.com/NateHutch365

#>

# List all existing authentication policies in yellow text
Write-Host "Retrieving all existing authentication policies..." -ForegroundColor Yellow
$allAuthPolicies = Get-AuthenticationPolicy
foreach ($policy in $allAuthPolicies) {
    Write-Host "Policy Name: $($policy.Name)" -ForegroundColor Yellow
}

# Retrieve and display the default authentication policy in red text
$defaultAuthPolicy = (Get-OrganizationConfig).DefaultAuthenticationPolicy
if ($defaultAuthPolicy) {
    $defaultPolicyName = (Get-AuthenticationPolicy -Identity $defaultAuthPolicy).Name
    Write-Host "Default Authentication Policy: $defaultPolicyName" -ForegroundColor Red
} else {
    Write-Host "No custom default authentication policy is set, some basic authentication protocols may be enabled. A custom policy should be created and made the default to ensure legacy protocols are disabled." -ForegroundColor Red
}

# Define the domains to search for in UPNs
$domains = @("domain1.com", "domain2.com")

# Prepare an array to hold all results
$results = @()

foreach ($domain in $domains) {
    # Get all users with UPNs ending in the current domain
    $users = Get-User -ResultSize Unlimited | Where-Object { $_.UserPrincipalName -like "*@$domain" }

    foreach ($user in $users) {
        # Get the authentication policy assigned to the user
        $userAuthPolicy = Get-User -Identity $user.UserPrincipalName | Select-Object -ExpandProperty AuthenticationPolicy
        
        # Create a custom object for each user and their authentication policy
        $result = New-Object PSObject -Property @{
            Domain = $domain
            UserPrincipalName = $user.UserPrincipalName
            AuthenticationPolicy = if ($userAuthPolicy) { $userAuthPolicy } else { "None" }
        }
        
        # Add the result to the results array
        $results += $result
    }
}

# Define the path for the CSV export
$csvPath = "C:\Path\To\Output\AuthenticationPoliciesReport.csv"

# Export the results to a CSV file
$results | Export-Csv -Path $csvPath -NoTypeInformation

Write-Output "Export complete. Results saved to $csvPath"
