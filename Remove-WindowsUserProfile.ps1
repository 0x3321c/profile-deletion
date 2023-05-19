
    [CmdletBinding(SupportsShouldProcess=$true)]
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Username
    )
    
    $RegKeyProfileList = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"
    $RegKeyInstaller = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData"
    $RegKeyAppxAllUserStore = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore"
    
    $SID = (Get-WmiObject -Class Win32_UserProfile | Where-Object { $_.LocalPath.split('\')[-1] -eq $Username }).SID
    
    if ($SID) {
        $UserPath = Join-Path -Path "C:\Users" -ChildPath $Username
        
        if ($PSCmdlet.ShouldProcess($UserPath, "Delete")) {
            Remove-Item -Path $UserPath -Recurse -Force
        }
        
        $RegPathProfileList = Join-Path -Path $RegKeyProfileList -ChildPath $SID
        
        if ($PSCmdlet.ShouldProcess($RegPathProfileList, "Delete")) {
            Remove-Item -Path $RegPathProfileList -Recurse -Force
        }
        
        $RegPathInstaller = Join-Path -Path $RegKeyInstaller -ChildPath $SID
        
        if ($PSCmdlet.ShouldProcess($RegPathInstaller, "Delete")) {
            Remove-Item -Path $RegPathInstaller -Recurse -Force
        }
        
        $RegPathAppxAllUserStore = Join-Path -Path $RegKeyAppxAllUserStore -ChildPath $SID
        
        if ($PSCmdlet.ShouldProcess($RegPathAppxAllUserStore, "Delete")) {
            Remove-Item -Path $RegPathAppxAllUserStore -Recurse -Force
        }
        
        Write-Output "Profile for $Username has been deleted."
    }
    else {
        Write-Output "Profile for $Username was not found."
    }

