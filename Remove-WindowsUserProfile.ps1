<#
.SYNOPSIS
Delete a windows user profile

.DESCRIPTION
The cmdlet, Remove-WindowsUserProfile deletes a user profile from a local machine by specifying the username. 
It removes both the user profile directory and associated registry keys.

.PARAMETER Username
Specifies the local username (without the domain) whose profile needs to be deleted.

.NOTES
- Use with caution as deleted profiles and registry keys cannot be recovered.
- Tested on Windows operating systems.

.ROLE
User with administrative privileges

.LINK
Remove-LocalUser https://learn.microsoft.com/en-gb/powershell/module/microsoft.powershell.localaccounts/remove-localuser

.LINK
Delprof2  https://helgeklein.com/free-tools/delprof2-user-profile-deletion-tool 
#>

 

class FolderNames : System.Management.Automation.IValidateSetValuesGenerator {
    [string[]] GetValidValues() {
        $folderNames = Get-ChildItem -Path "C:\users" -Directory | Select-Object -ExpandProperty Name
        return $folderNames
    }
}



# Update function,Remove-WindowsUserProfile with argument completion for the parameter, Username
function Remove-WindowsUserProfile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet( [folderNames])]
        [string] $Username
    )

    function Write-Log {
        [CmdletBinding()]
        param(
            [Parameter(Mandatory = $true)]
            [string]$Message
        )

        $LogPath = Join-Path -Path $env:TEMP -ChildPath "Remove-Windows-User-Profile.log"
        Add-content -Path $LogPath -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $Message"
    }

    Write-Log -Message "Starting profile deletion process for user: $Username"

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
        Write-Log -Message "Failed to retrieve SID for user profile, $Username"
    }

    if ($SID) {
        $UserPath = Join-Path -Path "C:\Users" -ChildPath $Username

        # Remove user profile directory
        if (Test-Path($UserPath, "Delete")) {
            try {
                Remove-Item -Path $UserPath -Recurse -Force -ErrorAction Stop
                Write-Log -Message "User profile directory deleted: $UserPath"
            }
            catch {
                Write-Warning "Failed to delete user profile, $UserPath"
                Write-Log -Message "Failed to delete user profile directory: $UserPath"
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
                    Write-Log -Message "Registry key deleted: $RegPath"
                }
                catch {
                    Write-Warning "Failed to delete registry key, $RegPath"
                    Write-Log -Message "Failed to delete registry key: $RegPath"
                }
            }
        }

        Write-Output "Profile for $Username has been deleted."
        Write-Log -Message "Profile for $Username has been deleted."
    }
    else {
        Write-Output "Profile for $Username was not found."
        Write-Log -Message "Profile for $Username was not found."
    }
}
