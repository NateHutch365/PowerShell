<# 
.SYNOPSIS
    Microsoft Graph Service Principal Assignment Analysis Script

.DESCRIPTION
    Analyzes service principals in Microsoft Graph, identifying applications 
    with and without role assignments, and exports results to CSV.

.VERSION
    1.0.0

.CREATOR
    William Francillette
    - Website: french365connection.co.uk
    - GitHub: https://github.com/William-Francillette

.CONTRIBUTOR
    Nathan Hutchinson
    - Website: natehutchinson.co.uk
    - GitHub: https://github.com/NateHutch365

.REQUIRED_ROLE
    Global Reader or Security Administrator

.PERMISSIONS
    Requires Application.Read.All Microsoft Graph permission
#>

# Ensure the required module is installed
if (!(Get-Module -ListAvailable -Name Microsoft.Graph)) {
    Install-Module -Name Microsoft.Graph -Scope CurrentUser -Force
}
# Import the Graph module
Import-Module Microsoft.Graph
# Connect to Microsoft Graph
Connect-MgGraph -Scopes "Application.Read.All"
# Retrieve all service principals and expand the AppRoleAssignedTo property
$sps = Get-MgServicePrincipal -All -ExpandProperty AppRoleAssignedTo
# Applications that require assignment
$appsWithAssignmentRequired = $sps | Where-Object { $_.AppRoleAssignmentRequired }
# Applications that don't require assignment
$appsWithoutAssignmentRequired = $sps | Where-Object { -not $_.AppRoleAssignmentRequired }
# List applications with assignment required and number of assignments per type
$assignmentSummary = $appsWithAssignmentRequired | Where-Object { $_.AppRoleAssignedTo.Count -gt 0 } | Select-Object `
    DisplayName,
    @{Label = 'nUserAssignment'; Expression = { ($_.AppRoleAssignedTo | Where-Object { $_.PrincipalType -eq 'User' }).Count } },
    @{Label = 'nGroupAssignment'; Expression = { ($_.AppRoleAssignedTo | Where-Object { $_.PrincipalType -eq 'Group' }).Count } },
    @{Label = 'nServicePrincipalAssignment'; Expression = { ($_.AppRoleAssignedTo | Where-Object { $_.PrincipalType -eq 'ServicePrincipal' }).Count } }
# Define output file paths
$outputDirectory = "C:\Temp"
$outputAssignmentRequiredCsv = "$outputDirectory\ApplicationsWithAssignments.csv"
$outputNoAssignmentRequiredCsv = "$outputDirectory\ApplicationsWithoutAssignments.csv"
# Ensure the output directory exists
if (!(Test-Path -Path $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory -Force
}
# Export the results to CSV
$assignmentSummary | Export-Csv -Path $outputAssignmentRequiredCsv -NoTypeInformation -Encoding UTF8
$appsWithoutAssignmentRequired | Select-Object DisplayName | Export-Csv -Path $outputNoAssignmentRequiredCsv -NoTypeInformation -Encoding UTF8
# Output confirmation messages
Write-Output "Applications with assignments exported to: $outputAssignmentRequiredCsv"
Write-Output "Applications without assignments exported to: $outputNoAssignmentRequiredCsv"
# Disconnect from Microsoft Graph
Disconnect-MgGraph