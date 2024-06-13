
# Microsoft Graph Service Principal Creation Script

I came across an issue when using the zero-trust approach to conditional access **(All Cloud Apps)** when I was unable to target the app **MicrosoftDefenderATP MAM** which is used for MAM deployment of MDE on mobiles. In my case I was targeting app protection policies to all cloud apps and had an app block policy which also targeted all cloud apps, so I needed to exclude this app to restore functionality. The app should have existed in the tenant, but it did not, using the **AppId** from another tenant I was able to manually add it in and resolve my issue.

This PowerShell script connects to Microsoft Graph, creates a service principal for the **MicrosoftDefenderATP MAM** application, and retrieves its details. You can substitute the AppId of other apps and it should work.

## Description

The script performs the following actions:
1. **Authenticate with Microsoft Graph**: Connects to Microsoft Graph using `Directory.ReadWrite.All` and `Application.ReadWrite.All` scopes to ensure full access to directory and application data.
2. **Create a Service Principal**: Generates a service principal for the Microsoft Defender for Endpoint application using a specific application ID.
3. **Retrieve and Display Service Principal Details**: Fetches and displays the details of the created service principal in a formatted table, showing the DisplayName, Id, and AppId.

## Version

1.0

## Required Roles

To successfully run this script, the user must have administrative privileges with specific permissions to manage service principals in Azure AD:
- **Application Administrator** or higher.

## Author

Nathan Hutchinson

## Links

- **Website**: [natehutchinson.co.uk](https://natehutchinson.co.uk)
- **GitHub**: [NateHutch365](https://github.com/NateHutch365)

## Installation

Before running the script, ensure that the Microsoft Graph PowerShell SDK is installed. You can install it using the following PowerShell command:

```powershell
Install-Module -Name Microsoft.Graph -Scope CurrentUser
```
## Usage

To run the script, follow these steps:

1.  Open PowerShell as an administrator.
2.  Navigate to the directory where the script is located.
3.  Run the script using:
```powershell
.\Create-Service-Principal.ps1
```

## Example Output

After running the script, the output will display the details of the newly created service principal as follows:

```sql
DisplayName                 Id                                   AppId
-----------                 --                                   -----
MicrosoftDefenderATP MAM    some-guid                            c2b688fe-48c0-464b-a89c-67041aa8fcb2
```
