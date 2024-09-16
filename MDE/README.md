# Install MDE sense client via PowerShell

Microsoft recently removed the MDE sense client from Home editions of Windows. This can cause issues with devices that have been upgraded from Home to Pro (known as transmogged) as it will NOT re-install the MSSense service.

Anyone having issues onboarding devices to MDE after upgrading from Home to Pro can manually install the MDE sense client with the following command.

```powershell
    Get-WindowsCapability -Name '*Sense*' -Online | Add-WindowsCapability –Online
    ```

Alternatively, you can use this to deploy via Intune: https://github.com/mtniehaus/AutopilotBranding