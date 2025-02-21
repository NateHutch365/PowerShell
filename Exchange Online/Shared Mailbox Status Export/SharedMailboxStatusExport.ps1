###########################################################################
# Script Name: Shared Mailbox Status Export
# Version: 1.0
# Author: Nathan Hutchinson
# Website: https://natehutchinson.co.uk
# GitHub: https://github.com/NateHutch365
#
# Description:
# This script retrieves a list of shared mailboxes from Exchange Online,
# checks their account status in Microsoft Entra ID (via Microsoft Graph),
# and exports the information to a CSV file.
#
# Requirements:
# - PowerShell 7+
# - Exchange Online Management Module
# - Microsoft Graph PowerShell Module
# - Required Permissions:
#   - Exchange Online: "View-Only Recipients" or equivalent admin role
#   - Microsoft Graph: "User.Read.All" (requires directory read permissions)
###########################################################################

# Ensure you are connected to both Exchange Online and Microsoft Graph with the necessary permissions
Connect-ExchangeOnline
Connect-MgGraph -Scopes "User.Read.All" # Adjusted to the more appropriate permission scope

# Define the recipient types you are interested in
$recipientTypes = @("SharedMailbox") 

# Prepare the CSV file path
$csvPath = "C:\Temp\SharedMailboxes.csv"

# Ensure the CSV file is created/overwritten with headers
"DisplayName,Mail,AccountEnabled" | Set-Content -Path $csvPath

foreach ($type in $recipientTypes) {
    # Fetch mailboxes of the current type
    $mailboxes = Get-EXOMailbox -RecipientTypeDetails $type -ResultSize Unlimited
    
    foreach ($mailbox in $mailboxes) {
        if (-not $mailbox.ExternalDirectoryObjectId) {
            Write-Host "No ExternalDirectoryObjectId for mailbox: $($mailbox.PrimarySmtpAddress)"
            continue
        }
        
        try {
            # Fetch the user information from Microsoft Graph
            $user = Get-MgUser -UserId $mailbox.ExternalDirectoryObjectId -Property AccountEnabled,DisplayName,Mail
            
            if ($user) {
                # Create a custom PSObject to hold the data
                $output = [PSCustomObject]@{
                    DisplayName = $user.DisplayName
                    Mail = $user.Mail
                    AccountEnabled = $user.AccountEnabled
                }
                # Append the data to the CSV file
                $output | Select-Object DisplayName,Mail,AccountEnabled | Export-Csv -Path $csvPath -NoTypeInformation -Append
            } else {
                Write-Host "No user data found for mailbox: $($mailbox.PrimarySmtpAddress)"
            }
        } catch {
            Write-Host "Failed to process mailbox $($mailbox.PrimarySmtpAddress): $($_.Exception.Message)"
            Write-Host "Error Details: $($_.Exception.InnerException)"
        }
    }
}

Write-Host "Script execution completed. The output is saved to $csvPath"
