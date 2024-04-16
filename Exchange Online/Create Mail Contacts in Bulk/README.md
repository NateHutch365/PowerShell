# Create Mail Contacts Script for Exchange Online

This PowerShell script is designed to automate the creation of mail contacts in Exchange Online from a specified CSV file. It ensures that all necessary fields (DisplayName, ExternalEmailAddress, FirstName, LastName) are filled in before creating a contact. If any required fields are missing, the script logs the issue and skips the creation of that contact.

## Features

- **Validation of Input Fields**: Ensures all required fields are present before attempting contact creation.
- **Error Logging**: Logs detailed information about any entries that fail to process.
- **Flexibility**: Easy to modify for different CSV formats or additional fields.

## Version

1.0

## Author

**Nathan Hutchinson**

- [Website](https://natehutchinson.co.uk)
- [GitHub](https://github.com/NateHutch365)

## Prerequisites

- You must have Exchange Online Management or Global Administrator permissions to run this script.
- PowerShell session connected to Exchange Online.

## Required Files

- **CSV File**: Your CSV should be formatted with headers corresponding to: `DisplayName`, `ExternalEmailAddress`, `FirstName`, `LastName`. Ensure there are no empty fields for these headers in your CSV.

## Usage

1. **Prepare Your CSV File**: Ensure it is saved at the specified path and correctly formatted.
2. **Update Script Paths**: Modify the `$csvPath` and `$logPath` variables in the script to point to your CSV file and desired log file location.
3. **Run the Script**: Execute the script in PowerShell. Ensure you are connected to Exchange Online with appropriate permissions.

### Running the Script

Open your PowerShell window and execute the script like so:

```powershell
.\CreateMailContacts.ps1
