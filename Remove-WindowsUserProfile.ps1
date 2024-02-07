<#
.SYNOPSIS
Delete a user profile

.DESCRIPTION
This PowerShell script deletes a user profile from a local machine by specifying the username. It removes both the user profile directory and associated registry keys.

.PARAMETER Username
Specifies the local username (without the domain) whose profile needs to be deleted.

.NOTES
- Use with caution as deleted profiles and registry keys cannot be recovered.
- Tested on Windows operating systems.

.ROLE
User with administrative privileges
#>

$Username = Read-Host "Enter the local username (without the domain):"

# Define registry keys
$RegKeyProfileList = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"
$RegKeyInstaller = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData"
$RegKeyAppxAllUserStore = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore"

try {
    # Get the SID of the specified user
    $SID = (Get-WmiObject -Class Win32_UserProfile -ErrorAction Stop | Where-Object { $_.LocalPath.split('\')[-1] -eq $Username }).SID
}
catch {
    Write-Warning "Failed to retrieve SID for user profile, $UserPath"
}

if ($SID) {
    $UserPath = Join-Path -Path "C:\Users" -ChildPath $Username

    # Remove user profile directory
    if (Test-Path($UserPath, "Delete")) {
        try {
            Remove-Item -Path $UserPath -Recurse -Force -ErrorAction Stop
        }
        catch {
            Write-Warning "Failed to delete user profile, $UserPath"
        }
    }

    # Remove registry keys associated with the user profile
    $RegPathProfileList = Join-Path -Path $RegKeyProfileList -ChildPath $SID
    $RegPathInstaller = Join-Path -Path $RegKeyInstaller -ChildPath $SID
    $RegPathAppxAllUserStore = Join-Path -Path $RegKeyAppxAllUserStore -ChildPath $SID

    # Remove registry keys
    foreach ($RegPath in @($RegPathProfileList, $RegPathInstaller, $RegPathAppxAllUserStore)) {
        if (Test-Path($RegPath, "Delete")) {
            try {
                Remove-Item -Path $RegPath -Recurse -Force -ErrorAction Stop
            }
            catch {
                Write-Warning "Failed to delete registry key, $RegPath"
            }
        }
    }

    Write-Output "Profile for $Username has been deleted."
}
else {
    Write-Output "Profile for $Username was not found."
}
