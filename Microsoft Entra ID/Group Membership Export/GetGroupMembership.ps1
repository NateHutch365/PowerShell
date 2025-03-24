<#
.SYNOPSIS
    Retrieves the userPrincipalName for all user objects in a specified Azure AD (Entra ID) group.

.DESCRIPTION
    This script connects to Microsoft Graph using delegated permissions, retrieves the specified group's members,
    and then loops through each member to retrieve user details. If the member is a user and has a userPrincipalName,
    it adds the value to a list. The final list can either be output to a text file located in "C:\TS-Temp" (named
    based on the provided group name, e.g., "CA-Staff.txt") or displayed in the terminal window based on a switch parameter.

.VERSION
    1.0.0

.REQUIRED ROLE
    The account executing this script must have permissions to read user profiles and group memberships in Azure AD,
    such as the "Directory Readers" role or equivalent permissions.

.AUTHOR
    Nathan Hutchinson

.WEBSITE
    natehutchinson.co.uk

.GITHUB
    https://github.com/NateHutch365
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true,
               HelpMessage = "Enter the group's display name or ObjectId.")]
    [string]$GroupName,

    [Parameter(Mandatory = $false,
               HelpMessage = "If specified, displays group membership in the terminal window instead of outputting to a text file.")]
    [switch]$Display
)

# Automatically set the output file using the provided group name.
$OutputFile = "C:\TS-Temp\$GroupName.txt"

# Ensure the output directory exists; if not, create it.
$OutputDir = Split-Path $OutputFile
if (!(Test-Path -Path $OutputDir)) {
    Write-Verbose "Output directory '$OutputDir' not found. Creating directory..."
    New-Item -Path $OutputDir -ItemType Directory -Force | Out-Null
}

Write-Verbose "Connecting to Microsoft Graph..."
# Connect to Microsoft Graph using delegated permissions.
Connect-MgGraph -Scopes "User.Read.All", "GroupMember.Read.All" -Verbose

Write-Verbose "Looking up group '$GroupName'..."
# Determine the group.
if ($GroupName -match "^[0-9a-fA-F\-]{36}$") {
    Write-Verbose "Assuming group identifier is an ObjectId."
    $Group = Get-MgGroup -GroupId $GroupName -Verbose
} else {
    Write-Verbose "Searching group by display name."
    $Group = Get-MgGroup -Filter "displayName eq '$GroupName'" -Verbose | Select-Object -First 1
}

if (-not $Group) {
    Write-Host "Group '$GroupName' not found." -ForegroundColor Red
    exit
} else {
    Write-Verbose "Group '$($Group.DisplayName)' found with ObjectId '$($Group.Id)'."
}

$GroupId = $Group.Id

Write-Verbose "Retrieving all members of the group with ObjectId '$GroupId'..."
# Retrieve all members of the group.
$Members = Get-MgGroupMember -GroupId $GroupId -All -Verbose

if (-not $Members) {
    Write-Verbose "No members found in group '$GroupName'."
    exit
} else {
    Write-Verbose "$($Members.Count) members found."
}

# Initialize an array to hold userPrincipalNames.
$UserPrincipalNames = @()

# Loop through each member and attempt to retrieve user details.
foreach ($member in $Members) {
    try {
        Write-Verbose "Attempting to retrieve user details for member Id '$($member.Id)'."
        $user = Get-MgUser -UserId $member.Id -ErrorAction Stop -Verbose
        if ($user.userPrincipalName) {
            Write-Verbose "User found: $($user.userPrincipalName)"
            $UserPrincipalNames += $user.userPrincipalName
        } else {
            Write-Verbose "User object for Id '$($member.Id)' does not contain a userPrincipalName."
        }
    }
    catch {
        Write-Verbose "Member with Id '$($member.Id)' is not a user or could not be retrieved as a user."
    }
}

if ($UserPrincipalNames.Count -eq 0) {
    Write-Host "No user objects found in group '$GroupName'." -ForegroundColor Yellow
} else {
    if ($Display) {
        Write-Host "User Principal Names for group '$GroupName':" -ForegroundColor Cyan
        $UserPrincipalNames | ForEach-Object { Write-Host $_ }
    }
    else {
        Write-Verbose "Writing userPrincipalNames to file: $OutputFile"
        # Write the list to the output file.
        $UserPrincipalNames | Out-File -FilePath $OutputFile -Verbose
        Write-Host "Export complete. The userPrincipalNames have been saved to: $OutputFile" -ForegroundColor Green
    }
}
