<# 
.SYNOPSIS
   Retrieves SharePoint Online site authentication context and conditional access settings

.DESCRIPTION
   This script collects detailed authentication and access settings for SharePoint Online sites.
   It can retrieve settings for all sites or a specific list of sites from a text file.
   Primary focus is on capturing authentication context information.

.AUTHOR
   Nathan Hutchinson
   Website: https://natehutchinson.co.uk
   GitHub: https://github.com/NateHutch365

.VERSION
   1.0.0

.REQUIREMENTS
   - PowerShell Module: SharePoint Online Management Shell
   - Role: SharePoint Administrator

.NOTES
   Exports site-level security and access configuration details to a CSV file
#>

# Define input method (all sites or specific sites from file)
# Set $useAllSites to $true to retrieve all sites, or $false to use a site list from a file
$useAllSites = $false
$siteListFile = "C:\TS-Temp\Clients\ClientName\SiteList.txt"  # Path to the file containing site URLs (one per line)

# Retrieve sites
if ($useAllSites) {
    $sites = Get-SPOSite -Limit All
} else {
    if (Test-Path $siteListFile) {
        $sites = Get-Content $siteListFile | ForEach-Object { Get-SPOSite -Identity $_ }
    } else {
        Write-Error "Site list file not found at $siteListFile"
        return
    }
}

# Collect data
$siteData = @()
foreach ($site in $sites) {
    $siteInfo = Get-SPOSite -Identity $site.Url
    $siteData += [PSCustomObject]@{
        Url                             = $siteInfo.Url
        AuthenticationContextName       = $siteInfo.AuthenticationContextName
        ConditionalAccessPolicy         = $siteInfo.ConditionalAccessPolicy
        AllowDownloadingNonWebViewableFiles = $siteInfo.AllowDownloadingNonWebViewableFiles
        LimitedAccessFileType           = $siteInfo.LimitedAccessFileType
        AllowEditing                    = $siteInfo.AllowEditing
        SensitivityLabel                = $siteInfo.SensitivityLabel
        BlockDownloadLinksFileType      = $siteInfo.BlockDownloadLinksFileType
        AuthenticationContextLimitedAccess = $siteInfo.AuthenticationContextLimitedAccess
    }
}

# Export the results to a CSV
$outputFile = "C:\TS-Temp\Clients\ClientName\SPOConditionalAccessSettings.csv"
$siteData | Export-Csv -Path $outputFile -NoTypeInformation -Encoding UTF8

# Output confirmation message
Write-Output "Site conditional access and authentication context settings exported to: $outputFile"