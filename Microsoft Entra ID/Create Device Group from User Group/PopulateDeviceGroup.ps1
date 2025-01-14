<#
.SYNOPSIS
    Populates a device group with devices owned by users from a specified user group.

.DESCRIPTION
    This script automatically adds devices to a target device group based on user group membership.
    It processes all devices owned by users in the specified user group and adds them to the target
    device group if they meet the following criteria:
    - Windows operating system
    - Company-owned device
    - Managed device
    - Account enabled
    The script also generates a CSV report of all processed devices and their status.

.NOTES
    Version: 1.0
    Author: Forked and adapted from Damien Van Robaeys
    Original Source: https://www.systanddeploy.com/2024/11/automatically-populate-device-group.html
    GitHub: https://github.com/damienvanrobaeys/Azure_Automation_Scripts/tree/main/Populate%20devices%20group
    
    This version is modified for one-off use with Graph API (not Azure Automation)
    
    Required Permissions:
    - Group.ReadWrite.All
    - Directory.ReadWrite.All
    - DeviceManagementManagedDevices.ReadWrite.All
#>

# Define your target group details
$Users_Group = "<USER_GROUP_ID>"  # ID of the users group for which you want to get devices
$Devices_Target_Group_Id = "<TARGET_DEVICE_GROUP_ID>"

# Authenticate using Connect-MgGraph
Connect-MgGraph -Scopes "Group.ReadWrite.All", "Directory.ReadWrite.All", "DeviceManagementManagedDevices.ReadWrite.All"

# Fetch users from the group
$Get_Users_Group_Member = Get-MgGroupMember -GroupId $Users_Group -All
$Get_Target_Group_Members = Get-MgGroupMember -GroupId $Devices_Target_Group_Id -All

# Process devices
$Devices_Array = @()
ForEach ($user in $Get_Users_Group_Member) {
    $devices = Get-MgUserOwnedDevice -UserId $user.Id | Where-Object {
        ($_.AdditionalProperties.operatingSystem -eq "windows") -and
        ($_.AdditionalProperties.deviceOwnership -eq "company") -and
        ($_.AdditionalProperties.isManaged -eq $true) -and
        ($_.AdditionalProperties.accountEnabled -eq $true) -and
        ($_.AdditionalProperties.isManaged -ne $null)
    }
    ForEach ($device in $devices) {
        $Device_ID = $device.Id
        $Device_Name = $device.AdditionalProperties.displayName
        $Device_Manufacturer = $device.AdditionalProperties.Manufacturer
        If ($Get_Target_Group_Members.id -contains $Device_ID) {
            $Member_Status = "Already member"
        } Else {
            $User_ID = $user.id
            $Get_User_DisplayName = (Get-MgUser -UserId $User_ID).DisplayName
            $Member_Status = "Not member"
            Try {
                New-MgGroupMember -GroupId $Devices_Target_Group_Id -DirectoryObjectId $device.Id
                $Status = "OK"
            } Catch {
                $Status = "KO"
            }
        }
        $Obj = [PSCustomObject]@{
            "Device name"      = $Device_Name
            "Member status"   = $Member_Status
            "Manufacturer"    = $Device_Manufacturer
            "User name"       = $Get_User_DisplayName
            "User ID"         = $user.id
            "Device object ID" = $Device_ID
            "Status"          = $Status
        }
        $Devices_Array += $Obj
    }
}

# Specify output directory
$Output_Directory = "C:\Temp"
If (!(Test-Path -Path $Output_Directory)) {
    New-Item -ItemType Directory -Path $Output_Directory | Out-Null
}

# Output results to a CSV file
$CSV_File = Join-Path -Path $Output_Directory -ChildPath "TeamName_Devices_Group_new_members.csv"
$Devices_Array | Select-Object "Device name", "User name", "User ID", "Device object ID", "Member status" |
    Export-Csv -Path $CSV_File -NoTypeInformation -Delimiter ";"

Write-Host "Processing complete. Results saved to $CSV_File."