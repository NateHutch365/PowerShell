<#
.SYNOPSIS
    Audits multi-tenant application instance property lock configurations in Microsoft Entra ID.

.DESCRIPTION
    This script connects to Microsoft Graph, retrieves all multi-tenant applications,
    and exports their app instance property lock configurations to a CSV file.
    It's useful for security audits and compliance checks of multi-tenant applications.

.NOTES
    Version:        1.0
    Author:         Nathan Hutchinson
    Website:        https://natehutchinson.co.uk
    GitHub:         https://github.com/NateHutch365
    Required Role:  Application.Read.All
#>

# Get app instance property lock values for multi-tenant Entra ID app objects

Connect-MgGraph -NoWelcome -Scopes Application.Read.All

# User-defined variable for the CSV export location
$outputCsvLocation = "C:\Path\To\Export\multiTenantApps.csv"

# Get the list of multi-tenant applications
$multiTenantApps = Get-MgApplication -All | Where-Object SignInAudience -in @('AzureADMultipleOrgs', 'AzureADandPersonalMicrosoftAccount')

# Check if any applications were retrieved
if ($multiTenantApps.Count -eq 0) {
    Write-Host "No multi-tenant application objects found" -ForegroundColor Red
} else {
    # Prepare the data and export to CSV
    $multiTenantApps | Select-Object Id,
        @{Name="DisplayName"; Expression={if ($_.DisplayName.Length -gt 35) { $_.DisplayName.Substring(0, 35) + "..." } else { $_.DisplayName }}}, 
        SignInAudience,
        @{Name="AppInstancePropertyLockEnabled"; Expression={$_.ServicePrincipalLockConfiguration.isEnabled}}, 
        @{Name="AllPropertiesLocked"; Expression={$_.ServicePrincipalLockConfiguration.allProperties}},
        @{Name="CredsUsedForVerificationLocked"; Expression={$_.ServicePrincipalLockConfiguration.credentialsWithUsageSign}},
        @{Name="CredsUsedForSigningTokensLocked"; Expression={$_.ServicePrincipalLockConfiguration.credentialsWithUsageVerify}},
        @{Name="TokenEncryptionKeyIdLocked"; Expression={$_.ServicePrincipalLockConfiguration.tokenEncryptionKeyId}}
    | Export-Csv -Path $outputCsvLocation -NoTypeInformation

    Write-Host "Exported multi-tenant applications to $outputCsvLocation" -ForegroundColor Green
}

# Disconnect from Microsoft Graph
Disconnect-MgGraph