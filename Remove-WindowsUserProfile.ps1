[CmdletBinding(SupportsShouldProcess=$true)]
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Username
    )
    
    $RegKeyProfileList = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"
    $RegKeyInstaller = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData"
    $RegKeyAppxAllUserStore = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore"
    
    try {
        $SID = (Get-WmiObject -Class Win32_UserProfile -ErrorAction Stop | Where-Object { $_.LocalPath.split('\')[-1] -eq $Username }).SID
    }
    catch {
        Write-Warning "Failed to retrieve SID for user profile: $_"
        return
    }
    
    if ($SID) {
        $UserPath = Join-Path -Path "C:\Users" -ChildPath $Username
        
        if ($PSCmdlet.ShouldProcess($UserPath, "Delete")) {
            try {
                Remove-Item -Path $UserPath -Recurse -Force -ErrorAction Stop
            }
            catch {
                Write-Warning "Failed to delete user profile: $_"
            }
        }
        
        $RegPathProfileList = Join-Path -Path $RegKeyProfileList -ChildPath $SID
        
        if ($PSCmdlet.ShouldProcess($RegPathProfileList, "Delete")) {
            try {
                Remove-Item -Path $RegPathProfileList -Recurse -Force -ErrorAction Stop
            }
            catch {
                Write-Warning "Failed to delete registry key $RegPathProfileList: $_"
            }
        }
        
        $RegPathInstaller = Join-Path -Path $RegKeyInstaller -ChildPath $SID
        
        if ($PSCmdlet.ShouldProcess($RegPathInstaller, "Delete")) {
            try {
                Remove-Item -Path $RegPathInstaller -Recurse -Force -ErrorAction Stop
            }
            catch {
                Write-Warning "Failed to delete registry key $RegPathInstaller: $_"
            }
        }
        
        $RegPathAppxAllUserStore = Join-Path -Path $RegKeyAppxAllUserStore -ChildPath $SID
        
        if ($PSCmdlet.ShouldProcess($RegPathAppxAllUserStore, "Delete")) {
            try {
                Remove-Item -Path $RegPathAppxAllUserStore -Recurse -Force -ErrorAction Stop
            }
            catch {
                Write-Warning "Failed to delete registry key $RegPathAppxAllUserStore: $_"
            }
        }
        
        Write-Output "Profile for $Username has been deleted."
    }
    else {
        Write-Output "Profile for $Username was not found."
    }
