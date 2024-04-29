<#
    .SYNOPSIS
    This script creates a distribution group and mail contacts in Exchange Online from a specified CSV file and adds the contacts to the distribution group.

    .DESCRIPTION
    This PowerShell script first creates a specified distribution group, then imports contacts from a CSV file, creates mail contacts in Exchange Online, and adds them to the created distribution group.
    It checks that all required fields (DisplayName, ExternalEmailAddress, FirstName, LastName) are filled before creation.
    If any required fields are missing, the creation is skipped and details are logged to a file.

    .NOTES
    Version: 1.0
    Author: Nathan Hutchinson
    Website: https://natehutchinson.co.uk
    GitHub: https://github.com/NateHutch365
    Required Role: Exchange Administrator or Global Administrator

    .EXAMPLE
    PS> .\CreateMailContactsAndGroup.ps1
    This example runs the script to create a distribution group, import contacts, create mail contacts based on the CSV file path provided in the script, and add them to the group.

#>

# Path to the CSV file
$csvPath = "C:\Path\To\contacts.csv"
# Path to the log file
$logPath = "C:\Path\To\error_log.txt"
# Distribution Group Name
$groupName = "YourGroupName"

# Function to write logs
function Write-Log {
    param ([string]$message)
    Add-Content -Value $message -Path $logPath
}

# Create the Distribution Group
$group = New-DistributionGroup -Name $groupName -ErrorAction Stop
Write-Log "Successfully created distribution group $groupName"

# Importing the CSV and processing each contact
Import-Csv $csvPath | ForEach-Object {
    try {
        # Validate all required fields are present
        if (![string]::IsNullOrWhiteSpace($_.DisplayName) -and 
            ![string]::IsNullOrWhiteSpace($_.ExternalEmailAddress) -and
            ![string]::IsNullOrWhiteSpace($_.FirstName) -and
            ![string]::IsNullOrWhiteSpace($_.LastName)) {
            # All fields are valid, create the contact
            $contact = New-MailContact -Name $_.DisplayName -ExternalEmailAddress $_.ExternalEmailAddress -FirstName $_.FirstName -LastName $_.LastName -ErrorAction Stop
            Write-Log "Successfully created contact for $($_.DisplayName)"
            
            # Add contact to the distribution group
            Add-DistributionGroupMember -Identity $groupName -Member $contact.Identity
            Write-Log "Added $($_.DisplayName) to the distribution group $groupName"
        } else {
            # Identify which fields are missing
            $missingFields = @()
            if ([string]::IsNullOrWhiteSpace($_.DisplayName)) { $missingFields += "DisplayName" }
            if ([string]::IsNullOrWhiteSpace($_.ExternalEmailAddress)) { $missingFields += "ExternalEmailAddress" }
            if ([string]::IsNullOrWhiteSpace($_.FirstName)) { $missingFields += "FirstName" }
            if ([string]::IsNullOrWhiteSpace($_.LastName)) { $missingFields += "LastName" }

            Write-Log "Failed to create contact. Missing fields: $($missingFields -join ', ') for record with possible Contact Info: DisplayName: $($_.DisplayName), Email: $($_.ExternalEmailAddress)"
        }
    } catch {
        Write-Log "Error creating contact for $($_.DisplayName): $($_.Exception.Message)"
    }
}

Write-Output "Process completed. Check the log file at $logPath for details of any errors."
