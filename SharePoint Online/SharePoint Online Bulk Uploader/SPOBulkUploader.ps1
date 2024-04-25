<#
.SYNOPSIS
This PowerShell script recursively uploads files and folders from a specified local directory to a specified folder in SharePoint Online using the SharePointPnPPowerShellOnline module.

.DESCRIPTION
The script handles authentication, recursive directory traversal, and uploads to SharePoint Online. It logs each action to a specified CSV file, detailing the success or failure of each file and folder operation.

.VERSION
1.0.0

.AUTHOR
Nathan Hutchinson
Website: natehutchinson.co.uk
GitHub: https://github.com/NateHutch365
#>

# Check and install the SharePointPnPPowerShellOnline module if not already installed
$moduleName = "SharePointPnPPowerShellOnline"
if (-not (Get-Module -ListAvailable -Name $moduleName)) {
    Write-Host "Installing $moduleName..."
    Install-Module -Name $moduleName -Scope CurrentUser -AllowClobber -Force
} else {
    Write-Host "$moduleName is already installed."
}
Import-Module -Name $moduleName -Force

# Authenticate and connect to the SharePoint site
$siteUrl = "https://yourdomainname.sharepoint.com/sites/SiteNameHere"
$connection = Connect-PnPOnline -Url $siteUrl -UseWebLogin -ReturnConnection
if (-not $connection) {
    Write-Host "Failed to connect to SharePoint site: $siteUrl" -ForegroundColor Red
    exit
}

# Function to recursively upload files and folders
function Upload-Directory {
    param (
        [string]$sourcePath,
        [string]$targetFolderUrl,
        [string]$logFilePath  # Path to the log file
    )
    # Upload files directly in the current directory
    $localFiles = Get-ChildItem -Path $sourcePath -File
    foreach ($file in $localFiles) {
        $localFilePath = $file.FullName
        $targetFilePath = "$targetFolderUrl/" + $file.Name
        try {
            Add-PnPFile -Path $localFilePath -Folder $targetFolderUrl -Connection $connection
            Write-Host "Uploaded: $localFilePath to $targetFilePath" -ForegroundColor Green
            $result = "Success"
            $detail = "File uploaded successfully"
        } catch {
            Write-Host "Failed to upload ${localFilePath}: $($_.Exception.Message)" -ForegroundColor Red
            $result = "Failed"
            $detail = $_.Exception.Message
        }
        [PSCustomObject]@{
            LocalPath = $localFilePath
            SharePointPath = $targetFilePath
            Status = $result
            Detail = $detail
            Timestamp = Get-Date
        } | Export-Csv -Path $logFilePath -NoTypeInformation -Append
    }

    # Recursively handle directories
    $localDirs = Get-ChildItem -Path $sourcePath -Directory
    foreach ($dir in $localDirs) {
        $newFolderPath = "$targetFolderUrl/" + $dir.Name
        # Check if folder exists in SharePoint, if not, create it
        $folderExists = Get-PnPFolder -Url $newFolderPath -ErrorAction SilentlyContinue
        if (-not $folderExists) {
            try {
                Add-PnPFolder -Name $dir.Name -Folder $targetFolderUrl -Connection $connection
                Write-Host "Created folder: $newFolderPath" -ForegroundColor Green
            } catch {
                Write-Host "Failed to create folder ${newFolderPath}: $($_.Exception.Message)" -ForegroundColor Red
                continue
            }
        }
        # Recursive call to upload the contents of the directory
        Upload-Directory -sourcePath $dir.FullName -targetFolderUrl $newFolderPath -logFilePath $logFilePath
    }
}

# Main execution block
$localDirectory = "C:\Temp\SPO-Files"
$sharePointFolder = "Shared Documents/Folder A/Folder B/Folder C" # Specify the folder location here. Do not include URL encoding.
$logFile = "C:\Log\uploadLog.csv"  # Specify the log file location here
Upload-Directory -sourcePath $localDirectory -targetFolderUrl $sharePointFolder -logFilePath $logFile

# Disconnect from SharePoint site
Disconnect-PnPOnline -Connection $connection
Write-Host "Disconnected from SharePoint site" -ForegroundColor Yellow
