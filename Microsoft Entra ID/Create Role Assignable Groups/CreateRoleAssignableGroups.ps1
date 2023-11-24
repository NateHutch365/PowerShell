<#
.SYNOPSIS
This script creates role-assignable security groups in Microsoft Entra ID using Microsoft Graph.

.DESCRIPTION
The script uses the Microsoft Graph API to create multiple security groups that are enabled for role assignment. 
Each group is created with the property 'IsAssignableToRole' set to true, making them suitable for role assignments.

.VERSION
1.0

.AUTHOR
Nathan Hutchinson
Website: https://natehutchinson.co.uk
GitHub: https://github.com/NateHutch365

.NOTES
Requires the Microsoft.Graph.Groups module.
Requires Global Administrator or Privileged Administrator role for execution due to the necessary permissions for group creation and role assignment.

.EXAMPLE
PS> .\CreateRoleAssignableGroups.ps1

# This will execute the script to create the specified security groups.
#>

# Install the Microsoft Graph PowerShell SDK if not already installed
Install-Module Microsoft.Graph -Scope CurrentUser -Force

# Import the required module
Import-Module Microsoft.Graph.Groups

# Authenticate with Microsoft Graph using additional scopes
Connect-MgGraph -Scopes "Group.ReadWrite.All", "Directory.ReadWrite.All", "RoleManagement.ReadWrite.Directory"

# Define the security groups to be created
$securityGroups = @(
    @{
        DisplayName = "Role Assignable Security Group 1"
        MailNickname = "rasg1"
        Description = "Description of Role Assignable Security Group 1"
        MailEnabled = $false
        SecurityEnabled = $true
        IsAssignableToRole = $true
    },
    @{
        DisplayName = "Role Assignable Security Group 2"
        MailNickname = "rasg2"
        Description = "Description of Role Assignable Security Group 2"
        MailEnabled = $false
        SecurityEnabled = $true
        IsAssignableToRole = $true
    }
    # Add more groups as needed
)

# Function to create each security group
function CreateSecurityGroup($group) {
    # Create the group with role assignment capabilities
    $newGroup = New-MgGroup -AdditionalProperties @{
        DisplayName = $group.DisplayName
        MailNickname = $group.MailNickname
        Description = $group.Description
        MailEnabled = $group.MailEnabled
        SecurityEnabled = $group.SecurityEnabled
        IsAssignableToRole = $group.IsAssignableToRole
    }
    Write-Host "Created role-assignable security group: $($group.DisplayName)"
}

# Iterate through each group and create them
foreach ($group in $securityGroups) {
    CreateSecurityGroup -group $group
}

# Disconnect from Microsoft Graph
Disconnect-MgGraph
