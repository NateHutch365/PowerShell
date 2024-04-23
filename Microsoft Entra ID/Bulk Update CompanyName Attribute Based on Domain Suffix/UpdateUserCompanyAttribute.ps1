<#
.SYNOPSIS
This script updates the company attribute of Entra ID users based on their email domain suffix and logs the results to a CSV file.

.DESCRIPTION
The script connects to Microsoft Graph, fetches all users, and updates their company attribute if their email domain matches predefined mappings. Successes and failures are logged to a CSV file, making it easy to review and filter results.

.VERSION
1.0.0

.AUTHOR
Nathan Hutchinson
Website: natehutchinson.co.uk
GitHub: https://github.com/NateHutch365

.REQUIRED ROLE
User Administrator or higher permissions are required to update user attributes and read user data.

.EXAMPLE
PS> .\UpdateUserCompanyAttribute.ps1
# This command runs the script, updating user attributes based on their domain and logging the output.
#>

# Check if Microsoft.Graph.Users module is installed and install or update if necessary
$moduleName = "Microsoft.Graph.Users"
$module = Get-Module -ListAvailable -Name $moduleName
if (-not $module) {
    Write-Host "Installing $moduleName module..."
    Install-Module -Name $moduleName -Scope CurrentUser -Force -AllowClobber
} else {
    Write-Host "Updating $moduleName module..."
    Update-Module -Name $moduleName -Force
}

# Import the Microsoft.Graph.Users module
Import-Module $moduleName

# Authenticate to Microsoft Graph
Connect-MgGraph -Scopes "User.ReadWrite.All"

# Define domain to company name mappings
$domainMapping = @{
    "contoso.com" = "Contoso";
    "fabrikam.com" = "Fabrikam";
    "tailspintoys.com" = "Tail Spin Toys"
}

# Prepare log file
$logPath = "C:\path\to\your\userUpdateLog.csv"
$logEntries = @()

# Retrieve all users
$users = Get-MgUser -All

# Loop through each user and update their company attribute based on their email domain
foreach ($user in $users) {
    $suffix = [System.Net.Mail.MailAddress]::new($user.UserPrincipalName).Host
    if ($domainMapping.ContainsKey($suffix)) {
        try {
            $companyName = $domainMapping[$suffix]
            Update-MgUser -UserId $user.Id -AdditionalProperties @{CompanyName = $companyName}
            $logEntries += [PSCustomObject]@{
                UserPrincipalName = $user.UserPrincipalName
                Company = $companyName
                Status = "Success"
                Message = "Updated successfully"
                Timestamp = Get-Date
            }
        } catch {
            $logEntries += [PSCustomObject]@{
                UserPrincipalName = $user.UserPrincipalName
                Company = $companyName
                Status = "Failed"
                Message = $_.Exception.Message
                Timestamp = Get-Date
            }
        }
    }
}

# Output log entries to CSV file
$logEntries | Export-Csv -Path $logPath -NoTypeInformation

# Disconnect from Microsoft Graph
Disconnect-MgGraph
