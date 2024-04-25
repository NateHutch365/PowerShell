# SharePoint Online Recursive Upload Script

## Overview
This PowerShell script facilitates the recursive uploading of files and folders from a specified local directory to a designated folder in SharePoint Online. Utilizing the SharePointPnPPowerShellOnline module, it provides efficient handling of both authentication and directory traversal, while maintaining detailed logs of all operations.

## Features
- **Recursive Uploads**: Capable of uploading all content from a specified local directory, including subdirectories and their files, maintaining the original directory structure in SharePoint.
- **Detailed Logging**: Each operation is logged with outcomes, providing a CSV file output that includes details such as success or failure, timestamps, and error messages for troubleshooting.
- **Error Handling**: Implements robust error handling to manage and log any issues that arise during the upload process.

## Prerequisites
- **PowerShell 5.1 or Later**: Ensure PowerShell 5.1 or newer is installed on your machine.
- **SharePointPnPPowerShellOnline Module**: The script checks for this module and installs it if not present.
- **Appropriate Permissions**: Users must have sufficient permissions in SharePoint to create folders and upload files.

## Installation
1. **Download the Script**: Clone or download the PowerShell script to your local system.
2. **Prepare the Environment**:
   - Open a PowerShell prompt with administrative privileges.
   - Navigate to the directory where the script is saved.

## Usage
1. **Set Script Parameters**:
   - `$siteUrl`: Set the site URL (line 28)
   - `$localDirectory`: Set to the path of the local directory you want to upload.
   - `$sharePointFolder`: Set to the SharePoint folder URL where the contents will be uploaded.
   - `$logFile`: Set to the path where the log file should be created.

2. **Run the Script**:
   - Execute the script in PowerShell by running:
     ```powershell
     .\UploadToSharePoint.ps1
     ```

3. **Review the Log**:
   - Check the specified log file after running the script to ensure all files were uploaded successfully and to troubleshoot any errors.

## Configuration
Modify the variables `$siteUrl`, `$localDirectory`, `$sharePointFolder`, and `$logFile` within the script to match your specific requirements before running the script.

## Logging
- **File**: The script outputs a log to a CSV file at the location specified by the `$logFile` parameter.
- **Contents**:
  - `LocalPath`: The local path of the uploaded file or folder.
  - `SharePointPath`: The destination path in SharePoint.
  - `Status`: Indicates whether the upload was successful or failed.
  - `Detail`: Provides error messages if the upload failed.
  - `Timestamp`: The date and time when the upload attempt was made.

## Author
Nathan Hutchinson
- Website: [natehutchinson.co.uk](https://natehutchinson.co.uk)
- GitHub: [NateHutch365](https://github.com/NateHutch365)

## License
This script is distributed under the MIT License. See the LICENSE file in the repository for complete details.
