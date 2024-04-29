# Create Mail Contacts and Distribution Group Script for Exchange Online

This PowerShell script is designed to automate the creation of mail contacts and a distribution group in Exchange Online from a specified CSV file. It ensures that all necessary fields (DisplayName, ExternalEmailAddress, FirstName, LastName) are filled in before creating a contact and adds these contacts to a specified distribution group. If any required fields are missing, the script logs the issue and skips the creation of that contact.

## Features

- **Validation of Input Fields**: Ensures all required fields are present before attempting contact creation.
- **Error Logging**: Logs detailed information about any entries that fail to process.
- **Distribution Group Management**: Creates a distribution group and adds all new contacts to this group.
- **Flexibility**: Easy to modify for different CSV formats or additional fields.

## Version

1.0

## Author

**Nathan Hutchinson**

- [Website](https://natehutchinson.co.uk)
- [GitHub](https://github.com/NateHutch365)

## Prerequisites

- You must have Exchange Administrator or Global Administrator permissions to run this script.
- PowerShell session connected to Exchange Online.

## Required Files

- **CSV File**: Your CSV should be formatted with headers corresponding to: `DisplayName`, `ExternalEmailAddress`, `FirstName`, `LastName`. Ensure there are no empty fields for these headers in your CSV.

## Additional Configuration

- **Distribution Group Name**: Before running the script, specify the name of the distribution group you wish to create and add contacts to. Modify the `$groupName` variable in the script to set this name. Comme

## Usage

1. **Prepare Your CSV File**: Ensure it is saved at the specified path and correctly formatted.
2. **Update Script Paths and Group Name**: Modify the `$csvPath`, `$logPath`, and `$groupName` variables in the script to point to your CSV file, desired log file location, and the name of the distribution group.
3. **Run the Script**: Execute the script in PowerShell. Ensure you are connected to Exchange Online with appropriate permissions.

### Running the Script

Open your PowerShell window and execute the script like so:

```powershell
.\CreateMailContactsAndGroup.ps1
