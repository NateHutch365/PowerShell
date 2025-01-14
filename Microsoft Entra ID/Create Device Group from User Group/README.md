# Populate Device Group from User Group Members

This PowerShell script automatically populates a device group with devices owned by users from a specified user group in Microsoft Entra ID (formerly Azure AD). It's particularly useful for scenarios where you need to manage device groups based on user group membership, such as deploying applications or configurations to specific teams' devices.

## Features

- Automatically adds devices to a target device group based on user group membership
- Filters devices based on specific criteria:
  - Windows operating system
  - Company-owned devices
  - Managed devices
  - Enabled accounts
- Generates a detailed CSV report of processed devices
- Handles duplicate entries (skips devices already in the target group)
- Error handling for group member addition

## Prerequisites

- Microsoft Graph PowerShell SDK
- The following Microsoft Graph API permissions:
  - Group.ReadWrite.All
  - Directory.ReadWrite.All
  - DeviceManagementManagedDevices.ReadWrite.All
- Write access to C:\Temp directory (for CSV output)

## Configuration

Before running the script, you need to modify these variables:
```powershell
$Users_Group = "<USER_GROUP_ID>"  # ID of the source users group
$Devices_Target_Group_Id = "<TARGET_DEVICE_GROUP_ID>"  # ID of the target devices group
```

To find the group IDs:
1. Open the Microsoft Entra admin center
2. Navigate to Groups
3. Select the group
4. Copy the Object ID from the Overview page

## Usage

1. Save the script with a `.ps1` extension
2. Update the group IDs in the script
3. Run the script in PowerShell:
```powershell
.\PopulateDeviceGroup.ps1
```

## Output

The script creates a CSV file at `C:\Temp\TeamName_Devices_Group_new_members.csv` containing:
- Device name
- User name
- User ID
- Device object ID
- Member status

## CSV Format Example

```csv
Device name;User name;User ID;Device object ID;Member status
LAPTOP-001;John Doe;user123;device456;OK
DESKTOP-002;Jane Smith;user789;device012;Already member
```

## Error Handling

- The script will create the output directory if it doesn't exist
- Failed device additions are marked with "KO" status in the object array
- Successful additions are marked with "OK" status
- Existing members are marked as "Already member"

## Credits

This script is forked and adapted from Damien Van Robaeys' original work:
- Blog: [Automatically populate device group based on users group members](https://www.systanddeploy.com/2024/11/automatically-populate-device-group.html)
- GitHub: [Azure Automation Scripts](https://github.com/damienvanrobaeys/Azure_Automation_Scripts/tree/main/Populate%20devices%20group)

## Modifications

This version has been modified from the original to:
- Use Graph API directly instead of Azure Automation
- Add additional error handling
- Include detailed CSV reporting
- Add comprehensive documentation

## Notes

- The script only processes Windows devices
- Only company-owned and managed devices are included
- Disabled devices are excluded from processing
- The script requires appropriate permissions to read user and device information and modify group membership

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is licensed under the MIT License - see the original author's repository for details.